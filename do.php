<?php
include_once 'codeWriter.php';
include_once 'database.php';
$codeWriter=new codeWriter("stories");
$codeWriter->set_output("do.php");
$codeWriter->write_function("insert_Data",null,'insert_POST');


