<?php
if (!file_exists('conf/config.php')) {
	die('Please read the installing instructions in the README file.');
}

require('conf/config.php');
require('vendor/autoload.php');
foreach (glob("lib/*.php") as $file) {
	require_once($file);
}

$userfields = userfields();

if (isset($_COOKIE['RBXTOKEN'])) {
	$id = result("SELECT id FROM users WHERE token = ?", [$_COOKIE['RBXTOKEN']]);

	if ($id) {
		// Valid cookie, logged in
		$loggedIn = true;
	} else {
		// Invalid cookie, not logged in
		$loggedIn = false;
	}
} else {
	// No cookie, not logged in
	$loggedIn = false;
}

if ($loggedIn) {
	$currentUser = fetch("SELECT * FROM users WHERE id = ?", [$id]);
	query("UPDATE users SET lastview = ? WHERE id = ?", [time(), $id]);
} else {
	// put any default settings here as they get added
}