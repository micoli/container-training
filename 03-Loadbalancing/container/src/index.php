<?php
$tagFilename = '/tmp/id';
if (!file_exists($tagFilename)) {
    file_put_contents($tagFilename, uniqid());
}
ksort($_GET);
ksort($_POST);
ksort($_SERVER);
$env = getenv();
ksort($env);
print json_encode([
    'GET' => $_GET,
    'POST' => $_POST,
    'SERVER' => $_SERVER,
    'ENV' => $env,
    'TIME' => date('Y-m-d H:i:s'),
    'ID' => file_get_contents($tagFilename),
    'APP_TYPE' => getenv('APP_TYPE'),
]);