<?php

/*
  Generic functions for DB operations
 */

class db {

    public static function open() { // opens the db connection. Specify different databases for local and live server and it will automatically select the correct one
        $servers = array('localhost', '127.0.0.1', 'warrior');
        if (in_array($_SERVER['HTTP_HOST'], $servers)) { //for localhost
            $dbuser = 'root';
            $dbpwd = '';
            $dbname = 'hikaya';
            $dbserver = 'localhost';
        } else { //for live server
            $dbuser = 'orangeho_db3';
            $dbpwd = 'Nzgd[)[$X_ZT';
            $dbname = 'orangeho_db3';
            $dbserver = 'localhost';
        }
        $db = mysqli_connect($dbserver, $dbuser, $dbpwd, $dbname);
        if ($db->connect_errno > 0) {
            echo "Failed to connect to MySQL: " . $db->connect_error;
        }
        return $db;
    }

    public static function close(&$db) {
        $db->close();
    }

    public static function getRecords($query, $cursor = NULL, $pageSize = NULL) {  // Gets multiple records and returns associative array
        $db = db::open();
        if (!is_null($cursor) && !is_null($pageSize)) {
            $query .= " LIMIT " . $cursor . ", " . $pageSize;
        }
        $result = $db->query($query);
        if (!$result) {
            die('There was an error running the query [' . $db->error . ']');
        }
        if ($result->num_rows > 0) {
            $i = 0;
            while ($row = $result->fetch_assoc()) {
                $recordset[$i] = $row;
                $i++;
            }
        } else {
            $recordset = false;
        }
        db::close($db);
        return ($recordset);
    }

    public static function getRecord($query) { // Gets single record and returns single associative array
        $db = db::open();
        $result = $db->query($query);
        if ($result->num_rows > 0) {
            $recordset = $result->fetch_assoc();
        } else {
            $recordset = false;
        }
        db::close($db);
        return ($recordset);
    }

    public static function getCell($query) { // Returns single value
        $db = db::open();
        $result = $db->query($query);
        if ($result->num_rows > 0) {
            $cell = $result->fetch_array();
            return $cell[0];
        } else {
            $cell = false;
        }
        return $cell;
    }

    public static function updateRecord($query) {  // Gets a formatted query and returns the true/false
        $db = db::open();
        $result = $db->query($query);
        db::close($db);
        return ($result);
    }

    public static function insertRecord($query) { // Gets a formatted query to insert a row and returns the ID of last added record
        $db = db::open();
        $db->query($query);
        $result = $db->insert_id;
        if(!$result){
            echo 'There was an error running the query [' . $db->error . ']';

        }
        db::close($db);
        return ($result);
    }

    public static function deleteRecord($table, $pk, $id) { // Gets the Id of row to be deleted and table name
        $db = db::open();
        $query = "delete from " . $table . " where " . $pk . "=" . $id;
        $result = $db->query($query);
        db::close($db);
        return ($result);
    }

    public static function deleteRecordarry($table, $pk, $id) { // Gets the Id of row to be deleted and table name
        $db = db::open();
        $query = "delete from " . $table . " where " . $pk . " in(" . $id . ")";
        $result = $db->query($query);
        db::close($db);
        return ($result);
    }

    public static function query($query) {  // Executes any query
        $db = db::open();
        $result = $db->query($query);
        db::close($db);
        return ($result);
    }

    public static function prepUpdateQuery(&$obj, $table, $pk, $id) { // Gets the associative array of field-name=>value, table name and id and returns the formatted update query
        $db = db::open();
        $query = "update " . $table . " set ";
        $total = count($obj);
        $current = 1;
        foreach ($obj as $key => $value) {
            $query = $query . " `" . $key . "`='" . $db->real_escape_string($value) . "' ";
            if ($current < $total) {
                $query = $query . ", ";
            }
            $current++;
        }
        $query = $query . " where " . $pk . "=" . $id;
        db::close($db);
        return $query;
    }

    public static function prepInsertQuery(&$obj, $table) { // Gets the associative array of field-name=>value and table name and returns the formatted insert query
        $db = db::open();
        $values= $fields =null;
        $query = "Insert into " . $table;
        $total = count($obj);
        $current = 1;
        foreach ($obj as $key => $value) {
            $fields = $fields . " `" . $key . "`";
            $values = $values . " '" . $db->real_escape_string($value) . "'";
            if ($current < $total) {
                $fields = $fields . ", ";
                $values = $values . ", ";
            }
            $current++;
        }
        $query = $query . " (" . $fields . ") VALUES (" . $values . ")";
        db::close($db);
        return $query;
    }

    public static function markAsRead($table, $pk, $id, $field) {
        $db = db::open();
        $query = "update " . $table . " set " . $field . "=1 where " . $pk . "=" . $id;
        $result = $db->query($query);
        db::close($db);
        return ($result);
    }
    
     public static function escape_String($string) {
        $db = db::open();
      $data=$db -> real_escape_string($string);
      return $data;
    }
    
    
}

 
?>