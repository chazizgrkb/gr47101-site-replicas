<?php
require('lib/common.php');

$error = '';

if (isset($_POST['register'])) {
	
	$username = (isset($_POST['_ctl0:UserName']) ? $_POST['_ctl0:UserName'] : null);
	$email = (isset($_POST['_ctl0:TextBoxEMail']) ? $_POST['_ctl0:TextBoxEMail'] : null);
	$pass = (isset($_POST['_ctl0:UserPass']) ? $_POST['_ctl0:UserPass'] : null);
	$pass2 = (isset($_POST['_ctl0:TextBoxPasswordConfirm']) ? $_POST['_ctl0:TextBoxPasswordConfirm'] : null);
	
	if (!isset($username)) $error .= "blank name";
	if (!isset($email)) $error .= "blank mail";
	if (!isset($pass) || strlen($pass) < 6) $error .= "short pw";
	if (!isset($pass2) || $pass != $pass2) $error .= "unmatch pw";
	if (result("SELECT COUNT(*) FROM users WHERE name = ?", [$username])) $error .= "already taken name"; //ashley2012 bypassed this -gr 7/26/2021
	if (!preg_match('/[a-zA-Z0-9_]+$/', $username)) $error .= "invalid name"; //ashley2012 bypassed this with the long-ass arabic character. -gr 7/26/2021

	if ($error == '') {
		$token = bin2hex(random_bytes(32));
			query("INSERT INTO users (name, password, token, email) VALUES (?,?,?,?)",
			[$username,password_hash($pass, PASSWORD_DEFAULT), $token, $email]);

		setcookie('RBXTOKEN', $token, 2147483647);
	} else {
	echo $error;
	}
}