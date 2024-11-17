<?php

$ini = '/usr/local/php/lib/php.ini';

$result = file_put_contents(
    $ini,
    preg_replace([
        '/^;extension=memcached$/m',
        '/^;extension=phpy$/m',
    ], [
        'extension=memcached',
        'extension=phpy',
    ], file_get_contents($ini))
);

if ($result === false) {
    throw new RuntimeException('Error: Unable to write ini file');
}

if (!extension_loaded('memcached')) {
    throw new RuntimeException('Error: The memcached extension is not loaded');
}

echo "OK: The memcached extension is loaded!";

if (!extension_loaded('phpy')) {
    throw new RuntimeException('Error: The phpy extension is not loaded');
}

echo "OK: The phpy extension is loaded!";
