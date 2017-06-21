#!/usr/bin/env php
<?php


ini_set('allow_url_fopen', 'On');
error_reporting(E_ALL);
ini_set('display_errors', 1);

$date     = new DateTime();
$runtime  = 10; //default to 10 seconds


foreach($argv as $argLine) {

    //skip junk in list
    if (preg_match('/=/',$argLine)) {
        $argLine = strtolower($argLine);
        list($param, $value) = explode('=', $argLine);
    } else {
        continue;
    }
    
    if( preg_match('/runtime/',$param) && is_numeric($value)) {
        $runtime = $value;
    } else {
        echo "Either not an int or invalid param: $param => $value\n";
        echo "Usage: ${argv[0]} runtime=600\n";
        exit;
    }

}

//barf if the role does not exist.. prob means there is no redis
$redisRole = exec("redis-cli info | grep role");
$redisRole = isset(explode(":", $redisRole)[1]) ? explode(":", $redisRole)[1] : '';
if(! in_array("$redisRole", ['master', 'slave'] ) ) {
    exit("Error: could not determine redis role : $redisRole");
}

$filename      = $redisRole . "_" . gethostname() . "__" . $date->getTimestamp() . "__$runtime" . ".gz"; 
$redisDumpFile = $filename;

echo "Capture redis logs : length : $runtime sec, filename : $filename\n";

$monitor = exec("redis-cli monitor | gzip > ${redisDumpFile} &");


$monitorProcessId = exec("pgrep -f 'redis-cli monitor'");
$phpProcessId     = getmypid();

$phpProcessStats  = "ps -p $phpProcessId -o %cpu,%mem";



$start = microtime(true); 
for ($i = 1; $i <= $runtime; $i ++) {
	clearstatcache();
    $filesize  = round(filesize($redisDumpFile)/1024/1024); //size in MB
    $filesize  = str_pad($filesize, 4, "0", STR_PAD_LEFT);
	$phpStats  = exec($phpProcessStats);

	@time_sleep_until($start + $i);
	$processMessage = "$filesize mb, $phpStats cpu/mem";

	echo progress_bar($i, $runtime, $processMessage, 100);
} 

$pkill = exec('pkill -f --signal=HUP "redis-cli monitor"'); //find and kill the redis-cli process 

function progress_bar($done, $total, $info="", $width=50) {
    $perc = round(($done * 100) / $total);
    $bar = round(($width * $perc) / 100);
    return sprintf("%s%%[%s>%s]%s\r", $perc, str_repeat("=", $bar), str_repeat("-", $width-$bar), "\t$info");
}

