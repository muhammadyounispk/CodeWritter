<?php
include_once '../common/database.php';
include_once 'codeWriter.php'; 

function prt($data)
{
	echo "<pre>" . print_r($data) . "</pre>";
}
function fileReplaceContent($path, $oldContent, $newContent)
{
	$str = file_get_contents($path);
	$str = str_replace($oldContent, $newContent, $str);
	file_put_contents($path, $str);
}
function generate_jwt($headers, $payload, $secret = 'secret')
{
	$headers_encoded = base64url_encode(json_encode($headers));
	$payload_encoded = base64url_encode(json_encode($payload));
	$signature = hash_hmac('SHA256', "$headers_encoded.$payload_encoded", $secret, true);
	$signature_encoded = base64url_encode($signature);
	$jwt = "$headers_encoded.$payload_encoded.$signature_encoded";
	return $jwt;
}
function is_jwt_valid($jwt, $secret = 'secret')
{
	// split the jwt
	$tokenParts = explode('.', $jwt);
	$header = base64_decode($tokenParts[0]);
	@$payload = base64_decode($tokenParts[1]);
	@$signature_provided = $tokenParts[2];
	// check the expiration time - note this will cause an error if there is no 'exp' claim in the jwt
	@$expiration = json_decode($payload)->exp;
	$is_token_expired = ($expiration - time()) < 0;
	// build a signature based on the header and payload using the secret
	$base64_url_header = base64url_encode($header);
	$base64_url_payload = base64url_encode($payload);
	$signature = hash_hmac('SHA256', $base64_url_header . "." . $base64_url_payload, $secret, true);
	$base64_url_signature = base64url_encode($signature);
	// verify it matches the signature provided in the jwt
	$is_signature_valid = ($base64_url_signature === $signature_provided);
	if ($is_token_expired || !$is_signature_valid) {
		return FALSE;
	} else {
		return TRUE;
	}
}
function base64url_encode($data)
{
	return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}
function get_authorization_header()
{
	$headers = null;
	if (isset($_SERVER['Authorization'])) {
		$headers = trim($_SERVER["Authorization"]);
	} else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { //Nginx or fast CGI
		$headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
	} else if (function_exists('apache_request_headers')) {
		$requestHeaders = apache_request_headers();
		// Server-side fix for bug in old Android versions (a nice side-effect of this fi
		$requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
		//print_r($requestHeaders);
		if (isset($requestHeaders['Authorization'])) {
			$headers = trim($requestHeaders['Authorization']);
		}
	}
	return $headers;
}
function get_bearer_token()
{
	$headers = get_authorization_header();
	// HEADER: Get the access token from the header
	if (!empty($headers)) {
		if (preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
			return $matches[1];
		}
	}
	return null;
}
function error($code, $message)
{
	echo json_encode(array("response" => $code, "description" => $message));
	die();
}
function login()
{
	// get posted data
	$data = $_POST;
	define("EMAIL", @$data['email']);
	define("PASSWORD", @$data['parental_password']);
	if (EMAIL && PASSWORD) {
		$sql = "SELECT email FROM users u WHERE email = '" . db::escape_String(EMAIL) . "' 
		AND parental_password = '" . md5(db::escape_String(PASSWORD)) . "' ";
		$result = db::getCell($sql);
		if ($result) {
			$headers = array('alg' => 'HS256', 'typ' => 'JWT');
			$payload = array('email' => $result, 'exp' => (time() + TOKEN_EXPIRY_TIME));
			$jwt = generate_jwt($headers, $payload);
			echo json_encode(array('response' => 200, 'token' => $jwt));
		} else {
			echo json_encode(array('response' => 401, 'description' => 'Email or parental_password is inccorect'));
		}
	} else {
		echo json_encode(array('response' => 402, 'description' => 'You have missing Email or parental_password '));
	}
}

function display_stories(){
//preparing Database Query
$query="SELECT * from stories ";
//getting records in Assosiative Array
$records=db::getRecords($query);
//extracting Information 
foreach($records as $record){ 
//preparing custom Variables Assosiative Array
$obj[]=array(
'id'=> $record['id'],

'video_id'=> $record['video_id'],

'title'=> $record['title'],

'description'=> $record['description'],

'video_url'=> $record['video_url'],

'image_name'=> $record['image_name'],

'length'=> $record['length'],

'owner_id'=> $record['owner_id'],

'created_date'=> $record['created_date'],

'modified_date'=> $record['modified_date'],

'genre'=> $record['genre'],

'topic'=> $record['topic'],

'upvotes'=> $record['upvotes'],

'downvotes'=> $record['downvotes'],

'is_paid'=> $record['is_paid'],

'display_order'=> $record['display_order'],

);
}
//returning json 
return json_encode($obj);
}


function display_categories(){
//preparing Database Query
$query="SELECT * from categories ";
//getting records in Assosiative Array
$records=db::getRecords($query);
//extracting Information 
foreach($records as $record){ 
//preparing custom Variables Assosiative Array
$obj[]=array(
'id'=> $record['id'],

'title'=> $record['title'],

'parent_id'=> $record['parent_id'],

);
}
//returning json 
return json_encode($obj);
}


function display_genre(){
//preparing Database Query
$query="SELECT * from genre ";
//getting records in Assosiative Array
$records=db::getRecords($query);
//extracting Information 
foreach($records as $record){ 
//preparing custom Variables Assosiative Array
$obj[]=array(
'id'=> $record['id'],

'title'=> $record['title'],

);
}
//returning json 
return json_encode($obj);
}





