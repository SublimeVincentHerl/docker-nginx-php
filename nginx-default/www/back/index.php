PHP
<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL);
echo "OK <hr>";

$user = 'root';
$pass = 'wp';
$server = 'mydb';

$dbh = new PDO( "mysql:host=$server", $user, $pass );
$dbs = $dbh->query( 'SHOW DATABASES' );

while( ( $db = $dbs->fetchColumn( 0 ) ) !== false )
{
    echo $db.'<br>';
}

?>

<br />
* <a href="/">Index front</a><br />
* <a href="/test.html">Simple file front</a><br />
* <a href="/api/">Index back</a><br />
* <a href="/api/test.html">Simple file back</a><br />
