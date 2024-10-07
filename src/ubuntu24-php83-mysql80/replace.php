<?php

if (str_contains($_SERVER['GIT_MSG'] ?? '', ' --lite')) {
    $dockerfile = file_get_contents(__DIR__ . '/Dockerfile');

    $dockerfile = preg_replace(
        [
            '#^imagemagick #',
            '#^libvips42t64 #',
            '#^libvips-dev #',
            '#^nodejs #',
            '#^npm #',
        ],
        ' ',
        $dockerfile
    );

    var_dump($dockerfile);

    file_put_contents(__DIR__ . '/Dockerfile', $dockerfile, LOCK_EX);
}
