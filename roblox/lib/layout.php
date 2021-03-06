<?php

/**
 * Twig loader, initializes Twig with standard configurations and extensions.
 *
 * @param string $subfolder Subdirectory to use in the templates/ directory.
 * @return \Twig\Environment Twig object.
 */
function twigloader($subfolder = '') {
	global $tplCache, $tplNoCache, $loggedIn, $currentUser;

	$doCache = ($tplNoCache ? false : $tplCache);

	$loader = new \Twig\Loader\FilesystemLoader('templates/' . $subfolder);
	$twig = new \Twig\Environment($loader, [
		'cache' => $doCache,
	]);
	// Add squareBracket specific extension
	$twig->addExtension(new SBExtension());
	
	$twig->addGlobal('logged_in', $loggedIn);
	$twig->addGlobal('current_user', $currentUser);

	return $twig;
}

function redirect($url) {
	header(sprintf('Location: %s', $url));
	die();
}