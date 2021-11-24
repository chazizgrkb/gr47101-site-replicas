<?php
require('lib/common.php');

if (isset($_GET['id'])) {
	$userData = fetch("SELECT * FROM users WHERE id = ?", [$_GET['id']]);
} else {
	$userData = fetch("SELECT * FROM users WHERE id = ?", [$id]);
}

$twig = twigloader();

echo $twig->render('user.twig', [
	'user' => $userData,
]);