<?php
include_once '../common/database.php';
 class codeWriter{
	public  $table_name="null";
	public $where=null;
	public $schema =null;
	public $query=null;
	public $cols="*";
	public $arr_selection=array();
	public $str_selection=null;
	public $function_name=null; 
	public $params =null;
	public $return_type =null;
	public $data=null;
	public $file_name="null";
	public  $code=null;
	function __construct($table_name=null) {
		if($table_name){
			$this->table_name = $table_name;
			$this->query="show  COLUMNS from  $table_name ";
			$this->schema = db::getRecords($this->query);}
	
	  }
	  public function Where($where=null){
		$this->where = $where;
		
	  }
	  public function set_output($file_name=null){
        $this->file_name=$file_name;
	  }
	public  function cols($cols_name=null) {
	$this->arr_selection=explode(",",chop($cols_name,","));
	foreach ($this->schema as $key => $value) {
		$col = $value['Field'];
	
		if(in_array($col,$this->arr_selection)){
			$newSchema[]=array('Field'=>$col);
		}
		$this->schema=@$newSchema;
	}

	  }
public function write_function($function_name = "display",$params=null,$return_type=null){

	 $this->return_type=$return_type;
     $params?  $this->params='$'.str_replace(',',',$',$params): '';
     $this->function_name=$function_name;
    $code='function '.$this->function_name.'('.$this->params.'){
';
switch($return_type){
	case 'api':
foreach ($this->schema as $key => $value) {
	$col_name = $value['Field'];
	$this->data .= '\'' . $col_name . '\'=> $record[\'' . $col_name . '\'],
';
}

		$code .= '
//preparing Database Query
$query="SELECT ' . $this->cols . ' from ' . $this->table_name . ' '.$this->where.' ";
//getting records in Assosiative Array
$records=db::getRecords($query);
//extracting Information 
foreach($records as $record){ 
//preparing custom Variables Assosiative Array
$obj[]=array('
. $this->data . '
);
}
//returning json 
return json_encode($obj);
		
		';


		break;
		case 'fetch';

		foreach ($this->schema as $key => $value) {
			$col_name = $value['Field'];
			$this->data .= '$' . $col_name . '= $record[\'' . $col_name . '\'];
';
		}
		
		
				$code .= '
//preparing Database Query
$query="SELECT ' . $this->cols . ' from ' . $this->table_name . ' '.$this->where.' ";
//getting records in Assosiative Array
$records=db::getRecords($query);
//extracting Information 
foreach($records as $record){ 
//preparing custom Variables Assosiative Array
'
. $this->data . '

		}
		
				
				';

		break;
		case 'insert_POST';
		//post vars
		$postVar='
//checking
$error=null;
';
		foreach ($this->schema as $key => $value) {
			$col_name = $value['Field'];
			$postVar.= '$'.$col_name.'=$_POST[\'' . $col_name . '\'];
if(!$'.$col_name.'){ $error.= \'The Field '.$col_name.' is missing \' ;}
';
}

//cols values
$obj_arr="";
foreach ($this->schema as $key => $value) {
	$col_name = $value['Field'];
$obj_arr.='$obj[\''.$col_name.'\']=$_POST[\''.$col_name.'\'];
';
}
$code.=$obj_arr;
$code.='$query=db::prepInsertQuery($obj,\''.$this->table_name .'\');
';
$code.='$result=db::insertRecord($obj);
return $result;
';

$this->data=$code;






		break;
		default:
		$code.=$this->data;

       }
$code.= '

}';

codeWriter::write($code);

	  }

	  public function write_col_vars()
	  {
		if(isset($this->schema )){
foreach ($this->schema as $key => $value) {
$col_name=$value['Field'];
$this->data.='$'.$col_name.'=$record["'.$col_name.'"]; 
';
}
$this->write($this->data);
		}else{
			codeWriter::show("You have no table Selected to write code ");
		}
		 }	  

	  /**
	   * Method obj_col_vars
	   *
	   * @return void
	   */
	  public function obj_col_vars()
	  {
		if(isset($this->schema )){
foreach ($this->schema as $key => $value) {
$col_name=$value['Field'];
$this->data.='$obj[]=$record["'.$col_name.'"]; 
';
}
		}else{
			codeWriter::show("You have no table Selected to write code or Column Name(s) not found in  " .$this->table_name );
			die();
		}
		 }
	  public function col_vars()
	  {
		if(isset($this->schema )){
foreach ($this->schema as $key => $value) {
$col_name=$value['Field'];
$this->data.='$'.$col_name.'=$record["'.$col_name.'"]; 
';
}
		}else{
			codeWriter::show("You have no table Selected to write code or Column Name(s) not found in  " .$this->table_name);
			die();
		}
		 }
		 

		 function http_vars($vars=null,$type=null){
			if($type=='1'){
				$type='$_GET';
			}else if($type=='2'){
				$type='$_POST';
				
			}else if($type=='3'){
				$type='$_REQUEST';
			}else{
				$type='$record';
			}
			if(isset($vars)){
				$arr_vars=explode(',',$vars);
				foreach ($arr_vars as $key => $var_name) {
if($type){
	$this->data.='$'.$var_name.'='.$type.'["'.$var_name.'"]; 
';

}				
				}
				
						}else{
							codeWriter::show("You have No any var ");
						}
		 }

	  
public function write($data=null){
	if(isset($data)){
		file_put_contents($this->file_name, $data, FILE_APPEND);
		codeWriter::show("$data<br>records  been added into ".$this->file_name);
	}else if(isset($this->data)){
		file_put_contents($this->file_name, $this->data, FILE_APPEND);
		codeWriter::show($this->data."<br>records  been added into ".$this->file_name);


	}
}	  
public function show($data=null){
	if($data){
	echo "<pre>";
	print_r($data);
	echo "</pre>";
		
	}
  }	  	
}
