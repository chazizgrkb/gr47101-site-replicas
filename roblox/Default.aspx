<?php
require('lib/common.php');

// currently selects all uploaded videos, should turn it into all featured only
$userData = query("SELECT name, id FROM users ORDER BY id DESC LIMIT 9");

$twig = twigloader();

echo $twig->render('index.twig', [
	'users' => $userData,
]);
