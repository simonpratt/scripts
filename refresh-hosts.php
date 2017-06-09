<?php

error_reporting(-1);

$hostBasePath = getenv("HOME") . "/hosts/";
$cacheFile    = $hostBasePath."foreman-cache.json";
$fileExt      = ".dyn";

$hosts = array(
		"all-hosts" => [
			"requiredAND" => [],
			"childOR"  => []
		],
		"all-postgres" => [
			"requiredAND" => ["-pgsql"],
			"childOR"  => []
		],
		"all-maharaweb" => [
			"requiredAND" => ["-mhrweb-"],
			"childOR"  => []
		],
		"production-load-balancers" => [
			"requiredAND" => ["-prod-"],
			"childOR"  => ["-lb-"]
		],
		"production-webservers" => [
			"requiredAND"  => ["-prod-"],
			"childOR"   => ["-mdlweb-","-mdlutil"]
		],
		"production-mahara-webservers" => [
			"requiredAND"  => ["-mhrweb-","-prod-"],
			"childOR"   => []
		],
		"production-reverse-proxy" => [
			"requiredAND"  => ["-rp-prod-"],
			"childOR"   => []
		],
		"production-cloudstore" => [
			"requiredAND"  => ["-prod-"],
			"childOR"   => ["-cloudstore-"]
		],
		"production-postgres" => [
			"requiredAND"  => ["-prod-"],
			"childOR"   => ["-pgsql-"]
		],
		"production-riak" => [
			"requiredAND"  => ["-prod-","-stor-","-ame1-"],
			"childOR"   => []
		],
		"stage-webservers" => [
			"requiredAND"  => ["-stage-"],
			"childOR"   => ["-mdlweb-","-mdlutil"]
		],
		"loadtest-cloudstore" => [
			"requiredAND"  => ["-test-","-adl"],
			"childOR"   => ["-cloudstore-"]
		],
		"loadtest-reverse-proxy" => [
			"requiredAND"  => ["int-rp-test"],
			"childOR"   => ["-rp-"]
		],
		"test-cloudstore" => [
			"requiredAND"  => ["-test-","-ame"],
			"childOR"   => ["-cloudstore-"]
		],
		"test-load-balancers" => [
			"requiredAND"  => ["-test-"],
			"childOR"   => ["-lb-"]
		],
		"test-reverse-proxy" => [
			"requiredAND"  => ["shr-rp-test-"],
			"childOR"   => ["-rp-"]
		],
		"test-riak" => [
			"requiredAND"  => ["-test-"],
			"childOR"   => ["-riak-"]
		],
		"loadtest-webservers" => [
			"requiredAND" => ["-perf-"],
			"childOR"  => ["-mdlweb-","-mdlutil"]
		],
		"loadtest-load-balancers" => [
			"requiredAND" => ["-lb-",],
			"childOR"  => ["-nsdev-","-test-"]
		],
);


$credentials = PromptUsrPwd();


// create host file path
if (!file_exists($hostBasePath)) {
    mkdir($hostBasePath, 0777, true);
}


if(! isCacheValid($cacheFile)) {
	cacheForemanData($cacheFile, $credentials);
}


$foremanData    = getForemanData($cacheFile);
$foremanResults = $foremanData["results"];

usort($foremanResults, function ($item1, $item2) {
    if ($item1['name'] == $item2['name']) return 0;
    return $item1['name'] < $item2['name'] ? -1 : 1;
});

generateAnsibleHostFiles($fileExt, $hostBasePath, $foremanResults, $hosts);
generateFlatHostFiles($fileExt, $hostBasePath, $foremanResults, $hosts);


function formatHostBlock($foremanData, $blockName, $filterConditionsAND = array(), $filterConditionsOR = array(), $withHeader = true){

	$blockText = array();

	if($withHeader) {
		$blockText[] = "[$blockName]";
	}

	$stringAND = "";
	foreach($filterConditionsAND as $filter) {
		$stringAND .= "(?=.*$filter)" ;
	}
	$stringOR = "";
	foreach($filterConditionsOR as $filter) {
		$stringOR .= $filter . "|";
	}
	$stringAND =  "/" . rtrim($stringAND,"|") ."/";
	$stringOR  =  "/" . rtrim($stringOR,"|")  ."/";

	foreach ($foremanData as $server) {

		if ( preg_match($stringAND, $server["name"]) ) {

			if ( preg_match($stringOR, $server["name"]) ) {
				$blockText[] = $server["name"];
			}
		}
	}

	return $blockText;

}

function generateAnsibleHostFiles($fileExt, $hostBasePath, $foremanResults, $hosts ) {

	$filename = $hostBasePath . "ansible" . $fileExt;

	$fileHandle = fopen($filename, "w+") or die("Unable to open file!");

	echo "ansible processing\n";
	foreach ($hosts as $key => $value) {

		if ($key === reset($hosts)) {
			echo ".. $key\n" ;
			fwrite($fileHandle, "[$key]" . "\n");

		}


		$block = formatHostBlock($foremanResults, $key, $value["requiredAND"], $value["childOR"] );
		foreach ($block as $line) {
			fwrite($fileHandle, $line . "\n");
		}
		fwrite($fileHandle, "\n");

	}

	fclose($fileHandle);

}

function generateFlatHostFiles($fileExt, $hostBasePath, $foremanResults, $hosts) {

	echo "pssh processing\n";
	foreach ($hosts as $key => $value) {

		echo ".. $key\n" ;
		$filename = $hostBasePath . $key . $fileExt;

		$fileHandle = fopen($filename, "w+") or die("Unable to open file!");
		$block = formatHostBlock($foremanResults, $key, $value["requiredAND"], $value["childOR"], false);
		foreach ($block as $line) {
			fwrite($fileHandle, $line . "\n");
		}
		fclose($fileHandle);
	}

}

function getForemanData($cacheFile) {
	$string = file_get_contents($cacheFile);
	$json_a = json_decode($string, true);
	return $json_a;
}


function isCacheValid($cacheFile) {

	if (file_exists($cacheFile)) {
		$ftime = filemtime($cacheFile);
		$cacheTime = time() - (60 * 30); //30 min cache

	    echo "$cacheFile was last modified: " . date ("F d Y H:i:s.", $ftime) . "\n";

	    if( $cacheTime >= filemtime($cacheFile) ) {
	    	return false;
	    } else {
	    	return true;
	    }

	    // echo date("F d Y H:i:s.", $ftime) . "\n";

	} else {
		return false;
	}

}

function cacheForemanData($cacheFile, $credentials) {

	echo "Refreshing cache from foreman..";
	$foremanJson = curlForemanHosts($credentials);

	$fileHandle = fopen($cacheFile, "w") or die("Unable to open file!");

	fwrite($fileHandle, $foremanJson);
	fclose($fileHandle);

}

function curlForemanHosts($credentials) {

	$url = "https://foreman.netspot.com.au/api/hosts";
	$username = $credentials->usr;
	$password = $credentials->pwd;

	$data = array(
		"per_page" => "9999999",
		// "search" => "status.enabled"
	);

	$params = '';
	foreach($data as $key=>$value)
	       $params .= $key.'='.$value.'&';

	$params = trim($params, '&');

	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url.'?'.$params ); //Url together with parameters
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //Return data instead printing directly in Browser
	// curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Content-Length: ' . strlen($data_json)));

	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT , 7); //Timeout after 7 seconds
	// curl_setopt($ch, CURLOPT_USERAGENT , "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)");
	curl_setopt($ch, CURLOPT_HEADER, 0);

	curl_setopt($ch, CURLOPT_USERPWD, "$username:$password");
	curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);


	$result = curl_exec($ch);

	if(curl_errno($ch))  //catch if curl error exists and show it
	  echo 'Curl error: ' . curl_error($ch);
	else
	curl_close($ch);

	return $result;
}



function PromptUsrPwd() {
	$usr = get_current_user();

	$command = "/usr/bin/env bash -c 'read -s -p \"".
		addslashes("Password for $usr:").
		"\" mypassword && echo \$mypassword'";
	$pwd = rtrim(shell_exec($command));
	echo "\n";
	return (object)array('usr' => $usr, 'pwd' => $pwd);
}
