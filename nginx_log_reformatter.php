<?php

declare(strict_types=1);

/*

example nginx conf:

    map $time_iso8601 $tt_yyyy {
        volatile;

        default "9999";

        "~^(\d{4})-(\d{2})-(\d{2})" $1;
    }

    map $time_iso8601 $tt_mm {
        volatile;

        default "99";

        "~^(\d{4})-(\d{2})-(\d{2})" $2;
    }

    map $time_iso8601 $tt_dd {
        volatile;

        default "99";

        "~^(\d{4})-(\d{2})-(\d{2})" $3;
    }

    # list of nginx variables: http://nginx.org/en/docs/varindex.html
    # about $bytes_received variable: https://github.com/openresty/openresty/issues/566
    log_format fmtv3  '$remote_addr ,,, $http_x_forwarded_for ,,, $time_iso8601 ,,, '
                      '$server_name ,,, $content_type ,,, $content_length ,,, $bytes_received ,,, $request_completion ,,, '
                      '$request_method ,,, $request_uri ,,, $query_string ,,, '
                      '$request_time ,,, $status ,,, $body_bytes_sent ,,, $http_referer ,,, $http_user_agent';

    access_log  /usr/local/nginx/logs/fmtv3.$tt_yyyy.$tt_mm.$tt_dd.log  fmtv3;

 */

$handle = @fopen('/path-to-file', 'rb');

if (is_resource($handle)) {
  while (($buffer = fgets($handle, 4096)) !== false) {
    echo $buffer;
  }
  if (!feof($handle)) {
    echo "Error: unexpected fgets() fail\n";
  }
  fclose($handle);
}
