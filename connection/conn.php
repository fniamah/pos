<?php
session_start();
date_default_timezone_set('Africa/Accra');
$test="";
$msg="";
//DATABASE CONNECTION CLASS DECLARATION
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


$error = "no";

$currDateTime=date("YmdHis");
$currDate=date("Ymd");
$ddate=date("Y-m-d");
$dtime=(strtotime(date("H:i:s"))-3600);//getting the strtotime of the current time
$timereal=date("H:i:s",$dtime);
$dateTime=date("Y-m-d H:i:s");
$sdate=date("Y-m-d 00:00:00");
$edate=date("Y-m-d 23:59:59");
$Currmonth=date("m");
$Curryear=date("Y");


//USER LOG IN
if (isset($_POST['login']) || isset($_POST['signin'])) {
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
	$username = mysqli_real_escape_string($dbconnection, $_POST['username']);
	$password = mysqli_real_escape_string($dbconnection, $_POST['password']);
	$branch="";
	///GET THE DEFAULT BRANCH
    $br = "SELECT branch FROM usr_branch WHERE userid = '$username' ORDER BY branch ASC LIMIT 1";
    $brrun = $conn->query($dbconnection,$br);
    if($conn->sqlnum($brrun) > 0){
        $brdata = $conn->fetch($brrun);
        $branch = $brdata['branch'];
    }
    $_SESSION['userid'] = $username;
    $_SESSION['branch'] = $branch;
    if(isset($_POST['signin'])){
        $qry = "SELECT last_page FROM users WHERE userid='$username'";
        $qryRun = $conn->query($dbconnection, $qry);
        $qryData =$conn->fetch($qryRun);
        $lastpage = $qryData['last_page'];
        header("location: $lastpage");
    }else{
        print("I am done ooooooo");
        header("location: dashboard.php");
    }
    exit(0);
	$conn->close($dbconnection);
}
function getCollectionData($ddate,$stfid){
    $conn=new Db_connect;
    $dbcon=$conn->conn();
    //TOTAL REGISTERED BUSINESSES
    //$sel="SELECT SUM(qty * sprice) AS totsprice FROM pos_sales WHERE userid = '$stfid' AND CAST(sales_date AS DATE) = '$ddate'";
    $sel="SELECT SUM(tot_sales) AS totsprice FROM sales_summary WHERE userid = '$stfid' AND CAST(transdate AS DATE) = '$ddate'";
    $selrun = $conn->query($dbcon,$sel);
    $data = $conn->fetch($selrun);
    $totsprice = $data['totsprice'];

    //GET THE INVOICE
    $sel2="SELECT SUM(p.amount) AS totpaid FROM customer_invoice c INNER JOIN invoice_payment p ON p.invoiceid = c.invoiceid WHERE p.userid = '$stfid' AND CAST(p.paydate AS DATE) = '$ddate'";
    $selrun2 = $conn->query($dbcon,$sel2);
    $data2 = $conn->fetch($selrun2);
    $totinvoice = $data2['totpaid'];

    $response['sprice'] = $totsprice;
    $response['invoice'] = $totinvoice;

    return json_encode($response);
    $conn->close($dbcon);
}

function getCollectionDataGeneral($ddate){
    $conn=new Db_connect;
    $dbcon=$conn->conn();
    //TOTAL REGISTERED BUSINESSES
    $sel="SELECT SUM(tot_sales) AS totsprice, SUM(tot_cost) AS totcprice, SUM(tot_tax) AS tottax FROM sales_summary WHERE CAST(transdate AS DATE) = '$ddate'";

    $selrun = $conn->query($dbcon,$sel);
    $data = $conn->fetch($selrun);
    $totalsprice = $data['totsprice'];
    $totalcprice = $data['totcprice'];
    $totaltax = $data['tottax'];
    $totalprofit = $totalsprice - $totalcprice - $totaltax;

    $response['sprice'] = $totalsprice;
    $response['profit'] = $totalprofit;
    $conn->close($dbcon);
    return json_encode($response);
}
function barGraph($stfid){
    require_once('jpgraph/src/jpgraph.php');
    require_once('jpgraph/src/jpgraph_bar.php');
    $filename="";
    $conn=new Db_connect;
    $dbcon=$conn->conn();
    $datechk = "SELECT DISTINCT(CAST(sales_date AS DATE)) AS ddate FROM pos_sales WHERE userid = '$stfid' ORDER BY sales_date DESC LIMIT 10";
    $datechkrun = $conn->query($dbcon,$datechk);
    $datenum = $conn->sqlnum($datechkrun);
    if($datenum > 0){
        while($data = $conn->fetch($datechkrun)){
            $ddate = $data['ddate'];
            $dateArray[] = date("d M,Y", strtotime($ddate));
            $getCollection = getCollectionData($ddate,$stfid);
            $obj = json_decode($getCollection);
            $totalsprice[] = $obj->sprice;
            $totalinvoice[] = $obj->invoice;
        }
        $graph = new Graph(1000,350,"auto");
        $graph->SetScale("textint");
        $graph->title->set("DAILY POS SALES ");
        $graph->img->SetMargin(50,30,50,50);

        $graph->SetShadow();

        $graph->xaxis->SetTickLabels($dateArray);
        $graph->xaxis->title->Set('Sales Dates');
        $graph->legend->SetPos(0.5,0.98,'center','bottom');

        $busplot = new BarPlot($totalsprice);
        $invplot = new BarPlot($totalinvoice);

        $busplot->SetFillColor("lightgreen");
        $busplot->value->Show();
        $busplot->value->SetFont(FF_ARIAL,FS_BOLD);
        $busplot->value->SetAngle(45);
        $busplot->value->SetColor("black","navy");
        $busplot->SetLegend('Total Sales');

        $invplot->SetFillColor("lightgreen");
        $invplot->value->Show();
        $invplot->value->SetFont(FF_ARIAL,FS_BOLD);
        $invplot->value->SetAngle(45);
        $invplot->value->SetColor("black","navy");
        $invplot->SetLegend('Total Invoice');


        //////
        $gbplot = new  GroupBarPlot (array($busplot, $invplot));
        //$graph->ClearTheme();

        $graph->Add($gbplot);
        $busplot->value->Show();
        $invplot->value->Show();
        //FILE NAME
        $filename = "graphs/".date("YmdHis").".jpg";
        $graph->Stroke($filename);
    }
    $conn->close($dbcon);
    return $filename;
}

function generalBarGraph(){
    require_once('jpgraph/src/jpgraph.php');
    require_once('jpgraph/src/jpgraph_bar.php');
    $filename="";
    $conn=new Db_connect;
    $dbcon=$conn->conn();
    $datechk = "SELECT DISTINCT(CAST(sales_date AS DATE)) AS ddate FROM pos_sales ORDER BY sales_date DESC LIMIT 10";
    $datechkrun = $conn->query($dbcon,$datechk);
    $datenum = $conn->sqlnum($datechkrun);
    if($datenum > 0){
        while($data = $conn->fetch($datechkrun)){
            $ddate = $data['ddate'];
            $dateArray[] = date("d M,Y", strtotime($ddate));
            $getCollection = getCollectionDataGeneral($ddate);
            $obj = json_decode($getCollection);
            $totalsprice[] = $obj->sprice;
            $totalprofit[] = $obj->profit;
        }
        $graph = new Graph(1200,450,"auto");
        $graph->SetScale("textint");
        $graph->title->set("DAILY TOTAL SALES AND PROFIT CHART");
        $graph->img->SetMargin(50,30,50,50);

        $graph->SetShadow();

        $graph->xaxis->SetTickLabels($dateArray);
        $graph->xaxis->title->Set('Sales Dates');
        $graph->legend->SetPos(0.5,0.98,'center','bottom');

        $spriceplot = new BarPlot($totalsprice);
        $profitplot = new BarPlot($totalprofit);;

        $spriceplot->SetFillColor("lightgreen");
        $spriceplot->value->Show();
        $spriceplot->value->SetFont(FF_ARIAL,FS_BOLD);
        $spriceplot->value->SetAngle(45);
        $spriceplot->value->SetColor("black","navy");
        $spriceplot->SetLegend('Total Sales');

        $profitplot->SetFillColor("red");
        $profitplot->value->Show();
        $profitplot->value->SetFont(FF_ARIAL,FS_BOLD);
        $profitplot->value->SetAngle(45);
        $profitplot->value->SetColor("black","orange");
        $profitplot->SetLegend('Total Profit');


        //////
        $gbplot = new  GroupBarPlot (array( $spriceplot , $profitplot ));

        $graph->Add($gbplot);
        $spriceplot->value->Show();
        $profitplot->value->Show();
        //FILE NAME
        $filename = "graphs/gen_".date("YmdHis").".jpg";
        $graph->Stroke($filename);
    }
    $conn->close($dbcon);
    return $filename;
}

function getcat($id){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sel="SELECT cname FROM category WHERE id=$id";
    $selRun=$conn->query($dbconnection,$sel);
    if($conn->sqlnum($selRun) == 0){
        return "";
    }else{
        $selData=$conn->fetch($selRun);
        $name=$selData['cname'];
        return $name;
    }
    $conn->close($dbconnection);
}

function getCustomer($id){
    $name = "";
    if(!empty($id)){
        $conn=new Db_connect;
        $dbconnection=$conn->conn();
        $sel="SELECT cname FROM customers WHERE cid='$id'";
        $selRun=$conn->query($dbconnection,$sel);
        $selData=$conn->fetch($selRun);
        $name=$selData['cname'];
        $conn->close($dbconnection);
    }

    return $name;
}

function getproduct($id){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sel="SELECT pname FROM products_master WHERE pid='$id'";
    $selRun=$conn->query($dbconnection,$sel);
    if($conn->sqlnum($selRun) == 0){
        return "";
    }else{
        $selData=$conn->fetch($selRun);
        $name=$selData['pname'];
        return preg_replace("/['^@\"]/","",$name);
    }
    $conn->close($dbconnection);
}

function gettax($id){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sel="SELECT name FROM taxconfig WHERE taxid='$id'";
    $selRun=$conn->query($dbconnection,$sel);
    if($conn->sqlnum($selRun) == 0){
        return "";
    }else{
        $selData=$conn->fetch($selRun);
        $name=$selData['name'];
        return $name;
    }
    $conn->close($dbconnection);
}

function getbranch($id){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();

    if($id == "WH"){
        return "WAREHOUSE";
    }else{
        $sel="SELECT bname FROM branches WHERE id=$id";
        $selRun=$conn->query($dbconnection,$sel);
        if($conn->sqlnum($selRun) == 0){
            return "";
        }else{
            $selData=$conn->fetch($selRun);
            $name=$selData['bname'];
            return $name;
        }
    }
    $conn->close($dbconnection);
}

function getstaff($id){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sel="SELECT fname, lname FROM users WHERE userid='$id'";
    $selRun=$conn->query($dbconnection,$sel);
    if($conn->sqlnum($selRun) == 0){
        return "";
    }else{
        $selData=$conn->fetch($selRun);
        $name=$selData['fname']." ".$selData['lname'];
        return $name;
    }
    $conn->close($dbconnection);
}

function checkIfRegistered($bname,$stf){
    //CHECK IF THE USER IS REGISTERED TO THE BRANCH
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $chk = "SELECT id FROM usr_branch WHERE userid = '$stf' AND branch = '$bname'";
    $chkrun = $conn->query($dbconnection,$chk);
    if($conn->sqlnum($chkrun) == 0){
        return "1";
    }else{
        return "0";
    }
    $conn->close($dbconnection);
}

function sendmessage($user,$msg,$caption){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $msgqry="INSERT INTO message SET userid='$user', message='$msg', caption='$caption', status='Active'";
    $conn->query($dbconnection,$msgqry);
    $conn->close($dbconnection);
}
?>