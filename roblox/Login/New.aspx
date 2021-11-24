<?php
chdir("../");
include('lib/common.php');

//moved the register code to fix cookie issue. -gr 11/24/2021

$twig = twigloader();
echo $twig->render('register.twig', ['error' => $error]);
