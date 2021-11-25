<?php
require('lib/common.php');

$error = '';

if (isset($_POST["_ctl0:ContentPlaceHolder1:Login1:LoginBtn"])) {
	$username = (isset($_POST['_ctl0:ContentPlaceHolder1:Login1:UserName']) ? $_POST['_ctl0:ContentPlaceHolder1:Login1:UserName'] : null);
	$password = (isset($_POST['_ctl0:ContentPlaceHolder1:Login1:UserPass']) ? $_POST['_ctl0:ContentPlaceHolder1:Login1:UserPass'] : null);

	// Check to see if the user actually has entered anything.
	if (!$username)	$error = "wtf is name";
	if (!$password) $error = "wtf is passwodr";

	if (empty($error)) {
		$logindata = fetch("SELECT password,token FROM users WHERE name = ?", [$username]);
		if ($logindata && password_verify($password, $logindata['password'])) {
			setcookie('RBXTOKEN', $logindata['token'], 2147483647);

			redirect('../');
		} else {
			$error = "wtf is everything";
			echo $error;
		}
	}
}