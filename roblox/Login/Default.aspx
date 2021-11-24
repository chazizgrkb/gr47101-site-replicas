<?php
chdir("../");
require('lib/common.php');
$twig = twigloader();

echo $twig->render('login.twig');
