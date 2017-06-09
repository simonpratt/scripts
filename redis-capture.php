#!/usr/bin/env php
<?php


ini_set('allow_url_fopen', 'On');
error_reporting(E_ALL);
ini_set('display_errors', 1);

$date     = new DateTime();
$runtime  = 10; //seconds
$filename = gethostname() . "__" . $date->getTimestamp() . "__$runtime" . ".gz"; 


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

echo "Capture redis logs : length : $runtime sec, filename : $filename\n";




$redisDumpFile = $filename;

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

