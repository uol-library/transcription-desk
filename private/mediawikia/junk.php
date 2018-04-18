<?php
$x = shell_exec('/usr/bin/php junk2.php');
print $x;
$x = shell_exec('/usr/bin/php /var/www/html/w/maintenance/importDump.php --debug /var/www/html/cbp-data/export/xml/1.xml');
//$x = shell_exec('cat /var/www/html/w/maintenance/importDump.php');
print $x;


?>
