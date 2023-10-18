<?php
class Db_connect{
    private $lhost="localhost";
    private $user="root";
    private $pword="";
    private $db="nasoo_2";

    public function conn(){
        try{
            $conn=mysqli_connect($this->lhost,$this->user,$this->pword,$this->db);
            if(!$conn){
                throw new Exception("Database Connection Error");
            }
            else{
                return $conn;
            }
        }
        catch(Exception $ex){
            echo $ex->getMessage();
        }
    }

    //QUERY STRING
    public function query($con,$queryString){
        try{
            if(!empty($queryString)){
                return mysqli_query($con,$queryString);
            }
            else{
                throw new Exception("You Are Submitting An Empty Query");
            }

        }
        catch(Exception $ex){
            echo $ex->getMessage();
        }

    }
    //FETCHING FROM DATABASE
    public function fetch($mysqli_num_rowsqry){
        return mysqli_fetch_assoc($mysqli_num_rowsqry);
    }
    //SQL NUM
    public function sqlnum($num){
        return mysqli_num_rows($num);
    }

    public function close($con){
        mysqli_close($con);
    }
}

$conn=new Db_connect;
$dbconnection=$conn->conn();

$data=file_get_contents("php://input");
$decodeJson = @json_decode($data, true);
$username = ($decodeJson['username']);
$password = ($decodeJson['password']);

//VALIDATE THE USER
$qry = "SELECT img, pword FROM users WHERE userid='$username' AND status='Active'";
$qryRun = $conn->query($dbconnection, $qry);


if ($conn->sqlnum($qryRun) == 1) {
	$qrydata = $conn->fetch($qryRun);
	$hash = $qrydata['pword'];
	$image = $qrydata['img'];
	if(password_verify($password, $hash)){
		//GET THE DEFAULT BRANCH
		$br = "SELECT branch FROM usr_branch WHERE userid = '$username' ORDER BY branch ASC LIMIT 1";
		$brrun = $conn->query($dbconnection,$br);
		if($conn->sqlnum($brrun) > 0){
			$brdata = $conn->fetch($brrun);
			$branch = $brdata['branch'];
		}
		$response['errorCode'] = 0;
		$response['branch'] = $branch;
		$response['img'] = $image;
		print json_encode($response);
		exit(0);
	}else{
		$response['errorCode'] = 1;
		$response['branch'] = "";
		$response['img'] = "";
		print json_encode($response);
	}

} else {
		$response['errorCode'] = 2;
		$response['branch'] = "";
		$response['img'] = "";
		print json_encode($response);
}
$conn->close($dbconnection);
?>