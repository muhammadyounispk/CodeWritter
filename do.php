<?php
include_once 'codeWriter.php';
include_once '../common/database.php';
$codeWriter=new codeWriter("stories");
$codeWriter->set_output("do.php");
$codeWriter->obj_col_vars();
$codeWriter->write();

$obj[]=$record["id"]; 
$obj[]=$record["video_id"]; 
$obj[]=$record["title"]; 
$obj[]=$record["description"]; 
$obj[]=$record["video_url"]; 
$obj[]=$record["image_name"]; 
$obj[]=$record["length"]; 
$obj[]=$record["owner_id"]; 
$obj[]=$record["created_date"]; 
$obj[]=$record["modified_date"]; 
$obj[]=$record["genre"]; 
$obj[]=$record["topic"]; 
$obj[]=$record["upvotes"]; 
$obj[]=$record["downvotes"]; 
$obj[]=$record["is_paid"]; 
$obj[]=$record["display_order"]; 
