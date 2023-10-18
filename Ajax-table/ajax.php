<?php
include("../connection/conn.php");
//LOGIN VALIDATION
if(isset($_GET['validateUser'])){
    $conn=new Db_connect;
    $dbcon=$conn->conn();

    $uname = mysqli_real_escape_string($dbcon,$_GET['validateUser']);
    $pword = mysqli_real_escape_string($dbcon,$_GET['pword']);
    $response =array();

    if($pword == "" || $uname == ""){
        $response['erroCode'] = "1";
        $response['errorMsg'] = "Please Supply All Fields";
    }else{
        //CHECK IF USER RECORDS EXISTS
        $chk = "SELECT status, pword FROM users WHERE userid = '$uname'";
        $chkrun = $conn->query($dbcon,$chk);
        if($conn->sqlnum($chkrun) == 0){
            $response['errorCode'] = "1";
            $response['errorMsg'] = "Username does not exist";
        }else{
            //GET THE STATUS
            $data = $conn->fetch($chkrun);
            $status = $data['status'];
            $hash = $data['pword'];

            //CHECK IF PASSWORDS MATCH
            if(password_verify($pword, $hash)){
                $response['errorCode'] = "0";
                $response['errorMsg'] = "Account validated successfully";
            }else{
                $response['errorCode'] = "1";
                $response['errorMsg'] = "Wrong Password Supplied";
            }
        }
    }
    print json_encode($response);
    $conn->close($dbcon);
}

//CREATE NEW USER
if(isset($_FILES['userimg']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['userimg']['tmp_name'];
    $newname="assets/data/users/avatar.png";//URL of the image location

    $fname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['fname']));
    $lname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['lname']));
    $access=mysqli_real_escape_string($dbconnection,strtoupper($_POST['access']));
    $gender=mysqli_real_escape_string($dbconnection,strtoupper($_POST['gender']));
    $contact=mysqli_real_escape_string($dbconnection,strtoupper($_POST['contact']));
    $address=mysqli_real_escape_string($dbconnection,strtoupper($_POST['address']));
    $stfID=mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));

    //GENERATING THE SYSTEM AND EMPLOYEE ID
    $getNum="SELECT COUNT(fname) AS totstf FROM users";
    $getNumRun=$conn->query($dbconnection,$getNum);
    $roledata=$conn->fetch($getNumRun);
    $rolenum = $roledata['totstf'];
    $username="SP".date("Y").str_pad(($rolenum + 1),3,"0",STR_PAD_LEFT);

    if(!empty($img)){
        $newname="assets/data/users/".$currDateTime.".jpg";//URL of the image location
        $locname="../assets/data/users/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $locname, file_get_contents($img));
    }
    if(isset($_POST['reclist'])){
        $reclist= $_POST['reclist'];
        $count= COUNT($reclist);
        for($i=0;$i < $count; $i++){
            $branch=$reclist[$i];
            $msgqry="INSERT INTO usr_branch SET userid='$username', branch='$branch', status='ACTIVE'";
            $conn->query($dbconnection,$msgqry);
        }
    }

    $hash = password_hash("admin123", PASSWORD_ARGON2I);
    $sql="INSERT INTO users (access,userid, fname, lname, img, pword, status, gender, contact, address) VALUES ('$access','$username','$fname','$lname','$newname','$hash','ACTIVE','$gender','$contact','$address')";
    $conn->query($dbconnection,$sql);

    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"New User ".$fname." ".$lname." Has Been Added By ".getstaff($stfID),"User Creation");
    }

    $response['errorCode'] = "0";
    $response['errorMsg'] = "Staff Has Been Added Successfully. \n"."<b>STAFF NAME:</b> ".$fname." ".$lname."\n <b>STAFF ID:</b> ".$username;
    print json_encode($response);

    $conn->close($dbconnection);
}
//EDIT USER
if(isset($_FILES['userimgedit']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['userimgedit']['tmp_name'];
    $newname="assets/data/users/avatar.png";//URL of the image location

    $fname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['fname']));
    $lname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['lname']));
    $access=mysqli_real_escape_string($dbconnection,strtoupper($_POST['access']));
    $uid=mysqli_real_escape_string($dbconnection,strtoupper($_POST['userid']));
    $stfID=mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));
    $status=mysqli_real_escape_string($dbconnection,strtoupper($_POST['status']));

    if(!empty($img)){
        $newname="assets/data/users/".$currDateTime.".jpg";//URL of the image location
        $locname="../assets/data/users/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $locname, file_get_contents($img));
    }
    //DELETE EVERY USWER BRANCH FROM THE USR_BRANCH TABLE
    $del = "DELETE FROM usr_branch WHERE userid = '$uid'";
    $conn->query($dbconnection,$del);

    $reclist= $_POST['reclist'];
    $count= COUNT($reclist);
    for($i=0;$i < $count; $i++){
        $branch=$reclist[$i];
        $msgqry="INSERT INTO usr_branch SET userid='$uid', branch='$branch', status='Active'";
        $conn->query($dbconnection,$msgqry);
    }
    $sql = "UPDATE users SET access = '$access', fname = '$fname', lname = '$lname', img = '$newname', status = '$status' WHERE userid = '$uid'";
    $conn->query($dbconnection,$sql);

    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"User Details Of ".$fname." ".$lname." Has Been Updated By ".getstaff($stfID),"User Account Update");
    }
    $response['errorCode'] = "0";
    $response['errorMsg'] = "User Account Updated Successfully";
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['brancheditid'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $bid = mysqli_real_escape_string($dbconnection,strtoupper($_POST['brancheditid']));
    $bname = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bname']));
    $loc = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bloc']));
    $email = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bemail']));
    $contact = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bcontact']));
    $status = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bstatus']));
    $stfID = mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));
    if(empty($bid)) {
        //CHECK IF CATEGORY EXISTS
        $chk = "SELECT * FROM branches WHERE bname='$bname'";
        $chkrun = $conn->query($dbconnection, $chk);
        if ($conn->sqlnum($chkrun) == 0) {
            $ins = "INSERT INTO branches (bname, bloc, status, email, contact) VALUES ('$bname','$loc','Active','$email','$contact')";
            $conn->query($dbconnection, $ins);

            $response['errorCode'] = "0";
            $response['errorMsg'] = "Branch, <b>" . $bname . "</b> created successfully";
            print json_encode($response);
            //SEND MEMO TO ALL THE ADMINISTRATORS
            $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
            $getadminrun=$conn->query($dbconnection,$getadmin);
            while($data = $conn->fetch($getadminrun)){
                $userid = $data['userid'];
                sendmessage($userid,"New Branch ".$bname." Has Been Created By ".getstaff($stfID),"Branch Creation");
            }
        } else {
            $response['errorCode'] = "1";
            $response['errorMsg'] = "Branch, <b>" . $bname . "</b> exists";
            print json_encode($response);
        }
    }else{
        $upd = "UPDATE branches SET bname='$bname', bloc='$loc', status = '$status', email='$email', contact='$contact' WHERE id=$bid";
        $conn->query($dbconnection, $upd);

        $upd2 = "UPDATE usr_branch SET status = '$status' WHERE branch = '$bid'";
        $conn->query($dbconnection,$upd2);

        //SEND MEMO TO ALL THE ADMINISTRATORS
        $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
        $getadminrun=$conn->query($dbconnection,$getadmin);
        while($data = $conn->fetch($getadminrun)){
            $userid = $data['userid'];
            sendmessage($userid,"Branch ".$bname." Has Been Updated By ".getstaff($stfID),"Branch Edit");
        }

        $response['errorCode'] = "0";
        $response['errorMsg'] = "Branch, <b>" . $bname . "</b> updated successfully";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

if(isset($_FILES['clogo']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['clogo']['tmp_name'];
    $newname="assets/data/logo/noimage.png";//URL of the image location

    $cname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['cname']));
    $ccont=mysqli_real_escape_string($dbconnection,strtoupper($_POST['ccont']));
    $cmail=mysqli_real_escape_string($dbconnection,strtoupper($_POST['cmail']));
    $cloc=mysqli_real_escape_string($dbconnection,$_POST['cloc']);
    $caddr=mysqli_real_escape_string($dbconnection,strtoupper($_POST['caddr']));
    $tag=mysqli_real_escape_string($dbconnection,$_POST['tag']);
    $stfID=mysqli_real_escape_string($dbconnection,$_POST['duserid']);

    if(!empty($img)){
        $newname="assets/data/logo/".$currDateTime.".jpg";//URL of the image location
        $locname="../assets/data/logo/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $locname, file_get_contents($img));
    }

    //CHECK IF COMPANY DETAILS EXISTS
    $chk = "SELECT cname FROM company";
    $chkrun = $conn->query($dbconnection,$chk);
    if($conn->sqlnum($chkrun) == 0){
        $ins = "INSERT INTO company(cname, ccont, cmail, cloc, caddr, clogo, tag) VALUES ('$cname','$ccont','$cmail','$cloc','$caddr','$newname','$tag')";
        $conn->query($dbconnection,$ins);
    }else{
        $sql="UPDATE company SET tag = '$tag', cname = '$cname', ccont = '$ccont', cmail = '$cmail', cloc = '$cloc', caddr = '$caddr', clogo = '$newname'";
        $conn->query($dbconnection,$sql);
    }
    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Company Details Have Been Updated By ".getstaff($stfID),"Company Details");
    }
    $response['errorCode'] = "0";
    $response['errorMsg'] = "Company Details Updated Successfully";
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['taxname'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $name=mysqli_real_escape_string($dbconnection,strtoupper($_POST['taxname']));
    $taxid=mysqli_real_escape_string($dbconnection,strtoupper($_POST['taxid']));
    $val=mysqli_real_escape_string($dbconnection,$_POST['percentage']);
    $optin=mysqli_real_escape_string($dbconnection,strtoupper($_POST['opt']));

    $selchk="SELECT name FROM taxconfig WHERE taxid='$taxid'";
    $selRun=$conn->query($dbconnection,$selchk);
    if($conn->sqlnum($selRun) == 0){
        $ins="INSERT INTO taxconfig SET taxid='$taxid', name='$name', val=$val, status='Active', optin='$optin'";
        $conn->query($dbconnection,$ins);
        $response['errorCode'] = "0";
        $response['errorMsg'] = "Tax Created Successfully";
        print json_encode($response);
    }else{
        $response['errorCode'] = "1";
        $response['errorMsg'] = "Taxid, <b>$taxid</b> , Exists Already";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

if(isset($_POST['taxstatus'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $taxid=mysqli_real_escape_string($dbconnection,$_POST['taxid']);
    $taxname=mysqli_real_escape_string($dbconnection,$_POST['taxnamee']);
    $val=mysqli_real_escape_string($dbconnection,$_POST['percentage']);
    $status=mysqli_real_escape_string($dbconnection,$_POST['taxstatus']);
    $optin=mysqli_real_escape_string($dbconnection,strtoupper($_POST['opt']));

    $upd = "UPDATE taxconfig SET name='$taxname', val=$val, optin='$optin', status='$status' WHERE taxid = '$taxid'";
    $conn->query($dbconnection,$upd);
    $response['errorCode'] = "0";
    $response['errorMsg'] = "Tax Updated Successfully";
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['cgname'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cgname = mysqli_real_escape_string($dbconnection,strtoupper($_POST['cgname']));
    $stfID = mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));
    //CHECK IF CATEGORY EXISTS
    $chk = "SELECT * FROM category WHERE cname='$cgname'";
    $chkrun = $conn->query($dbconnection,$chk);
    if($conn->sqlnum($chkrun) == 0){
        $ins= "INSERT INTO category (cname, status) VALUES ('$cgname','Active')";
        $conn->query($dbconnection,$ins);

        //SEND MEMO TO ALL THE ADMINISTRATORS
        $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
        $getadminrun=$conn->query($dbconnection,$getadmin);
        while($data = $conn->fetch($getadminrun)){
            $userid = $data['userid'];
            sendmessage($userid,"New Product Category, ".$cgname." Has Been Created By ".getstaff($stfID),"Category Creation");
        }

        $test = "yes";
        $msg =
        $response['errorCode'] = "0";
        $response['errorMsg'] = "Product Category, ".$cgname." created successfully";;
        print json_encode($response);
    }else{
        $response['errorCode'] = "1";
        $response['errorMsg'] = "Product Category, ".$cgname." exists";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

if(isset($_POST['catedit'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cid = $_POST['catid'];
    $cname = mysqli_real_escape_string($dbconnection,strtoupper($_POST['catedit']));
    $stfID = mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));
    $status = mysqli_real_escape_string($dbconnection,$_POST['catstatus']);
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE category SET cname = '$cname', status = '$status' WHERE id=$cid";
    $chkrun = $conn->query($dbconnection,$chk);
    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Branch ".$cname." Has Been Edited By ".getstaff($stfID),"Branch Edit");
    }
    $response['errorCode'] = "0";
    $response['errorMsg'] = "Product Category, ".$cname." updated";
    print json_encode($response);
    $conn->close($dbconnection);
}


if(isset($_FILES['pimg']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['pimg']['tmp_name'];
    $newname="assets/data/products/noimage.png";//URL of the image location
    $pid = $currDateTime;

    $pname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['pname']));
    $sprice=mysqli_real_escape_string($dbconnection,strtoupper($_POST['sprice']));
    $cprice=mysqli_real_escape_string($dbconnection,strtoupper($_POST['cprice']));
    $qty=mysqli_real_escape_string($dbconnection,$_POST['qty']);
    $cat=mysqli_real_escape_string($dbconnection,strtoupper($_POST['cat']));
    $bcode=mysqli_real_escape_string($dbconnection,strtoupper($_POST['barcode']));
    $stfID=mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));
    $dbcode = "";

    //CHECK IF BARCODE ALREADY EXISTS
    $chk = "SELECT pname FROM products_master WHERE barcode = '$bcode'";
    $chkrun = $conn->query($dbconnection,$chk);
    $chkdata = $conn->fetch($chkrun);
    if($conn->sqlnum($chkrun) != 0 && !empty($bcode)){
        $dbcode = $chkdata['pname'];

        $response['errorCode'] = "1";
        $response['errorMsg'] = "Barcode Already Exists For Product, $dbcode";
        print json_encode($response);
    }
    else{
        if($conn->sqlnum($chkrun) == 0)
            if(!empty($img)){
                $newname="assets/data/products/".$currDateTime.".jpg";//URL of the image location
                $locname="../assets/data/products/".$currDateTime.".jpg";//URL of the image location
                $file = file_put_contents( $locname, file_get_contents($img));
            }

        $sql="INSERT INTO products_master (pid,pname, sprice, cprice, cat, pimg, status,qty,barcode) VALUES ('$pid','$pname',$sprice,$cprice,'$cat','$newname','Active',$qty,'$bcode')";
        $conn->query($dbconnection,$sql);

        //SEND MEMO TO ALL THE ADMINISTRATORS
        $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
        $getadminrun=$conn->query($dbconnection,$getadmin);
        while($data = $conn->fetch($getadminrun)){
            $userid = $data['userid'];
            sendmessage($userid,"New Product ".$pname." Has Been Added By ".getstaff($stfID),"Product Creation");
        }
        $response['errorCode'] = "0";
        $response['errorMsg'] = "Product, <b>$pname</b> Added Successfully";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

if(isset($_FILES['updpimg']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['updpimg']['tmp_name'];
    $newname="assets/data/products/noimage.png";//URL of the image location
    $pid = $currDateTime;

    $pname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['pname']));
    $pid=mysqli_real_escape_string($dbconnection,strtoupper($_POST['updpid']));
    $sprice=mysqli_real_escape_string($dbconnection,strtoupper($_POST['sprice']));
    $cprice=mysqli_real_escape_string($dbconnection,strtoupper($_POST['cprice']));
    $qty=mysqli_real_escape_string($dbconnection,$_POST['qty']);
    $cat=mysqli_real_escape_string($dbconnection,strtoupper($_POST['cat']));
    $bcode=mysqli_real_escape_string($dbconnection,strtoupper($_POST['bcode']));
    $status=mysqli_real_escape_string($dbconnection,strtoupper($_POST['prodstat']));
    $stfID=mysqli_real_escape_string($dbconnection,strtoupper($_POST['duserid']));

    $sql="";
    if(!empty($img)){
        $newname="assets/data/products/".$currDateTime.".jpg";//URL of the image location
        $locname="../assets/data/products/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $locname, file_get_contents($img));
        $sql="UPDATE products_master SET status = '$status', barcode = '$bcode', pname = '$pname', sprice = $sprice, cprice = $cprice, cat = '$cat', pimg = '$newname', qty = $qty WHERE pid = '$pid'";
    }else{
        $sql="UPDATE products_master SET status = '$status', barcode = '$bcode', pname = '$pname', sprice = $sprice, cprice = $cprice, cat = '$cat', qty = $qty WHERE pid = '$pid'";
    }

    $move = "INSERT INTO products_master_history (pid, pnameo, spriceo, cpriceo, cato, qtyo, pname, sprice, cprice, cat, pimg, qty, status) SELECT pid, pname,sprice,cprice,cat,qty,'$pname',$sprice,$cprice,'$cat',pimg,$qty, '$status' FROM products_master WHERE pid = '$pid'";
    $conn->query($dbconnection,$move);
    $conn->query($dbconnection,$sql);

    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Product ".$pname." Has Been Updated By ".getstaff($stfID),"Product Edit");
    }

    $response['errorCode'] = "0";
    $response['errorMsg'] = "Product, <b>$pname</b> Updated Successfully";
    print json_encode($response);
    $conn->close($dbconnection);
}


//WAREHOUSE PRODUCT TRANSFER
if(isset($_POST['tshopwh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $toshop=mysqli_real_escape_string($dbconnection,$_POST['tshopwh']);
    $ddate=mysqli_real_escape_string($dbconnection,$_POST['whdate']);
    $stfID=mysqli_real_escape_string($dbconnection,$_POST['duserid']);

    $pid=$_POST['tprodwh'];
    $qty=$_POST['qtywh'];

    $transid="TRNS/".date("Y")."/".date("mdHis");

    $count=COUNT($pid);
    $failed=0;
    $success=0;
    $totAmount=0;
    $qtyExistsCount = 0;
    $prodExistsCount = 0;
    $qtyInserted = 0;
    $qtyExistsMsg = "<table class='table table-responsive'><thead><tr><td colspan='3'>Following Products Do Not Have The Requested Quantity In Stock</td></tr><tr align='center'><th>Product</th><th>Quantity</th><th>Requested</th></tr></thead><tbody>";
    $prodExistsMsg = "<table class='table table-responsive'><thead><tr><td colspan='2'>Following Products Have Been Added Multiple Times</td></tr><tr align='center'><th>Product</th><th>Requested</th></tr></thead><tbody>";
    $msg="Products Transferred Pending Acceptance.";
    for($i=0; $i < $count; $i++){
        //INSERT PRODUCTS INTO TEMP TABLE
        $dpid = $pid[$i];
        $dqty = $qty[$i];
        //CHECK IF PRODUCT ALREADY ADDED
        $chkprod = "SELECT t.qty, p.pname FROM products_temp t INNER JOIN products_master p ON t.pid = p.pid WHERE t.pid = '$dpid' AND t.transid = '$transid'";
        $chkprodrun = $conn->query($dbconnection,$chkprod);
        if($conn->sqlnum($chkprodrun) == 0){
            //CHECK IF QUANTITY EXISTS ION STOCK
            $chk = "SELECT qty, pname FROM products_master WHERE pid = '$dpid'";
            $chkrun = $conn->query($dbconnection,$chk);
            $chkdata = $conn->fetch($chkrun);
            $oldQty = $chkdata['qty'];
            $pname = $chkdata['pname'];
            if($dqty > $oldQty){
                $qtyExistsCount++;
                $qtyExistsMsg.="<tr align='center'><td>$pname</td><td>$oldQty</td><td>$dqty</td></tr>";
            }else{
                $qtyInserted++;
                $ins = "INSERT INTO products_temp(pid, qty, transid, shop) VALUES ($dpid,$dqty,'$transid','$toshop')";
                $conn->query($dbconnection,$ins);
            }
        }else{
            $chkproddata = $conn->fetch($chkprodrun);
            $prodExistsMsg.="<tr align='center'><td>".$chkproddata['pname']."</td><td>$dqty</td></tr>";
            $prodExistsCount++;
        }

    }

    if($qtyInserted > 0 && $qtyExistsCount == 0 && $prodExistsCount == 0){
        $success = 0;
        $qry2="INSERT INTO transfer_details SET transid='$transid',transdate='$ddate',shop='$toshop',fromshop='WH', status = 'Pending', transferby='$stfID'";
        $conn->query($dbconnection,$qry2);

        //SEND MEMO TO ALL THE ADMINISTRATORS AT THE BRANCH
        $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid IN (SELECT userid FROM usr_branch WHERE branch = '$toshop')";
        $getadminrun=$conn->query($dbconnection,$getadmin);
        while($data = $conn->fetch($getadminrun)){
            $userid = $data['userid'];
            sendmessage($userid,"Products Have Been Transferred From Warehouse To ".getbranch($toshop)." By ".getstaff($stfID),"Product Transfer");
        }
    }else{
        $success = 1;
        $qtyExistsMsg.="</tbody></table>";
        $prodExistsMsg.="</tbody></table>";
        if($prodExistsCount > 0 && $qtyExistsCount > 0){
            $msg = $qtyExistsMsg.$prodExistsMsg;
        }elseif($prodExistsCount == 0 && $qtyExistsCount > 0){
            $msg = $qtyExistsMsg;
        }else{
            $msg = $prodExistsMsg;
        }


        //DELETE ENTRIES INTO products_temp
        $del = "DELETE FROM products_temp WHERE transid = '$transid'";
        $conn->query($dbconnection,$del);
    }

    $response['errorCode'] = $success;
    $response['errorMsg'] = $msg;
    print json_encode($response);
    $conn->close($dbconnection);
}

//BACKUP
if(isset($_POST['backup'])){
    // Database configuration
    $host = "localhost";
    $username = "root";
    $password = "";
    $database_name = "nasoo_2";

// Get connection object and set the charset
    $conn = mysqli_connect($host, $username, $password, $database_name);
    $conn->set_charset("utf8");


// Get All Table Names From the Database
    $tables = array();
    $sql = "SHOW TABLES";
    $result = mysqli_query($conn, $sql);

    while ($row = mysqli_fetch_row($result)) {
        $tables[] = $row[0];
    }

    $sqlScript = "";
    foreach ($tables as $table) {

        // Prepare SQLscript for creating table structure
        $query = "SHOW CREATE TABLE $table";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_row($result);

        $sqlScript .= "\n\n" . $row[1] . ";\n\n";


        $query = "SELECT * FROM $table";
        $result = mysqli_query($conn, $query);

        $columnCount = mysqli_num_fields($result);

        // Prepare SQLscript for dumping data for each table
        for ($i = 0; $i < $columnCount; $i ++) {
            while ($row = mysqli_fetch_row($result)) {
                $sqlScript .= "INSERT INTO $table VALUES(";
                for ($j = 0; $j < $columnCount; $j ++) {
                    $row[$j] = $row[$j];

                    if (isset($row[$j])) {
                        $sqlScript .= '"' . $row[$j] . '"';
                    } else {
                        $sqlScript .= '""';
                    }
                    if ($j < ($columnCount - 1)) {
                        $sqlScript .= ',';
                    }
                }
                $sqlScript .= ");\n";
            }
        }

        $sqlScript .= "\n";
    }

    if(!empty($sqlScript))
    {
        // Save the SQL script to a backup file
        $fname = date('YmdHis').".sql";
        $backup_file_name = '../assets/data/backup/'.date('YmdHis').'.sql';
        //$backup_file_name = 'C:/Users/felix/Documents/Backup/'.date('YmdHis').'.sql';
        $fileHandler = fopen($backup_file_name, 'w+');
        $number_of_lines = fwrite($fileHandler, $sqlScript);
        fclose($fileHandler);

        // Download the SQL backup file to the browser
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename=' . basename($backup_file_name));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($backup_file_name));
        ob_clean();
        flush();
        readfile($backup_file_name);
        exec('rm ' . $backup_file_name);

        //SAVE THE BACKUP RECORDS
        $ins = "INSERT INTO backup (fname, userid) VALUES('$fname','')";
        mysqli_query($conn, $ins);

        print "Successful";
    }

    mysqli_close($conn);
}


if(isset($_POST['checkoutpay'])) {
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['sid'];
    $tender = $_POST['tender'];
    $bal = $_POST['bal'];
    $total = $_POST['total'];
    $stfID = $_POST['userid'];
    $branch = $_POST['branch'];
    $cnamee = mysqli_real_escape_string($dbconnection, $_POST['cname']);
    $ccontact = mysqli_real_escape_string($dbconnection, $_POST['ccontact']);
    $clocation = mysqli_real_escape_string($dbconnection, $_POST['clocation']);
    $cid = mysqli_real_escape_string($dbconnection, $_POST['cid']);
    $seltype = mysqli_real_escape_string($dbconnection, $_POST['selecttype']);
    $custid = "";

    //CHECK IF THERE ARE PRODUCTS IN THE POS_TEMP TABLE AND DELETE
    $chk = "SELECT COUNT(*) AS totcount FROM pos_temp WHERE sid='$sid'";
    $chkrun = $conn->query($dbconnection, $chk);
    $chkdata = $conn->fetch($chkrun);
    $dcount = $chkdata['totcount'];
    if ($dcount != 0) {

        //HANDLES CUSTOMER INFORMATION
        if ($seltype == "no") {
            $custid = "";
        } elseif ($seltype == "new") {
            $custid = $currDateTime;
            //CREATE NEW CUSTOMER RECORD
            $ins = "INSERT INTO customers (cid, cname, contact, location, shop) VALUES ('$custid','$cnamee','$ccontact','$clocation','$branch')";
            $conn->query($dbconnection, $ins);
        } else {
            $custid = $cid;
        }

        //INSERT PAYMENT DETAILS
        $ins = "INSERT INTO pos_payment (sid, tend, dtotal, dbal) VALUES ('$sid',$tender, $total, $bal)";
        $conn->query($dbconnection, $ins);

        //GET THE TOTAL SALES AND PROFIT MARGIN
        $totsprice = 0;
        $totcprice = 0;
        $profit = 0;

        //REDUCE THE PRODUCT QUANTITY
        $sel = "SELECT pid, userid, qty, shop, cprice, sprice FROM pos_temp WHERE sid = '$sid'";
        $selrun = $conn->query($dbconnection, $sel);
        while ($data = $conn->fetch($selrun)) {
            $pid = $data['pid'];
            $userid = $data['userid'];
            $qty = $data['qty'];
            $shop = $data['shop'];
            $cprice = $data['cprice'];
            $sprice = $data['sprice'];
            $dprofit = $sprice - $cprice;


            $totsprice+=($sprice * $qty);
            $totcprice+=($cprice * $qty);

            //MOVE POS RECORDS
            $move = "INSERT INTO pos_sales (pid, userid, sid, qty, shop, cprice, sprice, cid) VALUES ('$pid','$userid','$sid',$qty,'$shop',$cprice,$sprice,'$custid')";
            $conn->query($dbconnection, $move);

            $upd = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop = '$branch'";
            $conn->query($dbconnection, $upd);
        }

        //DELETE THE RECORDS FROM THE TEMP TABLE
        $del = "DELETE FROM pos_temp WHERE sid = '$sid'";
        $conn->query($dbconnection, $del);

        //GET THE COMPANY DETAILS
        //GET THE COMPANY INFORMATION / DETAILS
        $cname="COMPANY NAME";
        $ctag="";
        $cmail="";
        $caddr="";
        $ccont="";
        $cloc="";

        $msg = "";

        $getcomp = "SELECT cname, ccont, cmail, cloc, caddr, tag FROM company";
        $getcomprun = $conn->query($dbconnection,$getcomp);
        if($conn->sqlnum($getcomprun) != 0){
            $getcompdata = $conn->fetch($getcomprun);
            $cname = $getcompdata['cname'];
            $ccont = $getcompdata['ccont'];
            $cmail = $getcompdata['cmail'];
            $cloc = $getcompdata['cloc'];
            $caddr = $getcompdata['caddr'];
            $ctag = $getcompdata['tag'];
        }

        $msg=$msg."<div id='content'>
                    <div class='container'>
                        <div class='row' style='font-family: monospace, serif' id='ptable'>
                            <div class='well col-xs-10 col-sm-10 col-md-6 col-xs-offset-1 col-sm-offset-1 col-md-offset-3'>
                                <div class='row'>
                                    <div class='col-xs-6 col-sm-6 col-md-6'>
                                        <address>
                                            <strong>".$cname."</strong>
                                            <br>".$caddr." <br>".$cloc."<br>
                                            <abbr title='Phone'>P:</abbr> ".$ccont."
                                        </address>
                                    </div>
                                    <div class='col-xs-6 col-sm-6 col-md-6 text-right'>
                                        <p>
                                            <em>Date: ".date("Y-m-d H:i:s")."</em>
                                        </p>
                                        <p>
                                            <em>Officer:".getstaff($stfID)."</em>
                                        </p>
                                    </div>
                                </div>
                                <div class='row'>
                                    <div class='text-center'>
                                        <h3>Receipt</h3>
                                    </div>
                                    </span>
                                    <table class='table table-hover'>
                                        <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Quantity</th>
                                            <th class='text-center'>Price</th>
                                            <th class='text-center'>Total</th>
                                        </tr>
                                        </thead>
                                        <tbody>";
                                            $sel = "SELECT pid, qty, sprice FROM pos_sales WHERE sid = '$sid'";
                                            $selrun = $conn->query($dbconnection,$sel);
                                            $overalltotal = 0;
                                            while($saledata = $conn->fetch($selrun)){
                                                $overalltotal+=($saledata['qty'] * $saledata['sprice']);
                                        $msg=$msg."<tr>
                                            <td class='col-md-9'><em>".getproduct($saledata['pid'])."</em></h4></td>
                                            <td class='col-md-1' style='text-align: center'>".$saledata['qty']." </td>
                                            <td class='col-md-1 text-center'>".$saledata['sprice']."</td>
                                            <td class='col-md-1 text-center'>".($saledata['qty'] * $saledata['sprice'])."</td>
                                            </tr>";
                                        }

                                        /////HANDLES THE TAX PART
                                        //GET THE APPLICABLE SALES TAXES
                                        $totaltax=0;
                                        $gettax = "SELECT taxid, val, name FROM taxconfig WHERE status = 'ACTIVE' AND optin = 'YES'";
                                        $gettaxrun = $conn->query($dbconnection,$gettax);
                                        if($conn->sqlnum($gettaxrun) != 0){
                                            while($taxdata = $conn->fetch($gettaxrun)){
                                                $taxid = $taxdata['taxid'];
                                                $taxname = $taxdata['name'];
                                                $dval = $taxdata['val'];
                                                $taxcalc = ($overalltotal * $dval)/100;
                                                $totaltax+=$taxcalc;

                                                $instax = "INSERT INTO pos_tax(sid, taxid, dval) VALUES('$sid','$taxid',$dval)";
                                                $conn->query($dbconnection,$instax);
                                                $msg=$msg."<tr>
                                                <td>&nbsp;</td>
                                                <td colspan='2'>".strtolower($taxdata['name'])."[".$dval."%] </td>
                                                <td>".number_format($taxcalc,2)."</td>
                                                </tr>";
                                            }
                                        }

                                        $msg=$msg."<tr>
                                            <td>   </td>
                                            <td>   </td>
                                            <td class='text-right'>
                                                <p>
                                                    <strong>Subtotal: </strong>
                                                </p>
                                                <p>
                                                    <strong>Tender: </strong>
                                                </p>
                                                <p>
                                                    <strong>Change: </strong>
                                                </p>
                                            </td>
                                            <td class='text-center'>
                                                <p>
                                                    <strong>".number_format($overalltotal + $totaltax,2)."</strong>
                                                </p>
                                                <p>
                                                    <strong>".number_format($tender,2)."</strong>
                                                </p>
                                                <p>
                                                    <strong>".number_format($bal,2)."</strong>
                                                </p>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class='row'>
                                    <div class='col-md-12' style='font-style: italic; font-size: small; text-align: center'>Receipt #: ".strtoupper($sid)."</div>
                                </div>
                            </div>
                        </div>
                        <div class='row' id='bottomprint'>
                            <div class='col-md-12' align='center'>
                                <div class='buttons'>
                                    <a class='btn btn-default btn-lg' href='javascript:void(0);' onclick='javascript:window.print();'><i class='icon-print'></i> Print</a>
                                    <a class='btn btn-success btn-lg'  onclick='resetpos()'>Next Order <i class='icon-angle-right'></i></a>
                                </div>
                            </div>
                        </div>
                    <!-- /.container -->
                    </div>
                </div>";

                //INSERT SUMMARY SALES DETAILS
                $ins2 = "INSERT INTO sales_summary(sid, tot_sales, tot_cost, profit, userid, shop, cid, tot_tax) VALUES ('$sid',($totsprice + $totaltax),$totcprice,($totsprice - $totcprice),'$stfID','$branch','$custid',$totaltax)";
                $conn->query($dbconnection, $ins2);

                $ddate = date("Y-m-d");
                //GET THE TOTAL SALES FOR TODAY
                $get="SELECT SUM(tot_sales) AS totprice FROM sales_summary WHERE userid = '$stfID' AND shop='$branch' AND CAST(transdate AS DATE) = '$ddate'";
                $getrun=$conn->query($dbconnection,$get);
                $getdata=$conn->fetch($getrun);
                $response['msg']=$msg;
                $response['newsprice']=$getdata['totprice'];
                $response['newsid'] = $stfID.date("YmdHis");
                print json_encode($response);
    }else{
        print "NO RECORDS FOUND IN POS_SALES";
    }
    $conn->close($dbconnection);
}


if(isset($_POST['getNotify'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $staffid=$_POST['getNotify'];
    $getimg = "SELECT img FROM users WHERE userid='$staffid'";
    $getrun = $conn->query($dbconnection, $getimg);
    $getdata = $conn->fetch($getrun);

    //GET THE TIME DIFFERENCE
    $seltime = "SELECT last_login FROM users WHERE userid = '$staffid'";
    $seltimerun = $conn->query($dbconnection,$seltime);
    $seltimedata = $conn->fetch($seltimerun);
    $lasttime = $seltimedata['last_login'];

    $tdiff = strtotime(date($dateTime)) - strtotime(date($lasttime));
    //UPDATE WITH THE CURRENT ACTIVITY COUNT
    $ct="SELECT COUNT(caption) AS totmsgs FROM message WHERE userid='$staffid' AND caption NOT LIKE '%MEMO%'";
    $ctrun=$conn->query($dbconnection,$ct);
    $ctdata=$conn->fetch($ctrun);
    $actCount= $ctdata['totmsgs'];

    $stfmsg="SELECT message, date FROM message WHERE userid='$staffid' AND caption NOT LIKE '%MEMO%' ORDER BY date DESC LIMIT 10";
    $stfrun=$conn->query($dbconnection,$stfmsg);
    $actmsg="";
    if($conn->sqlnum($stfrun) == 0){
        $actmsg = "<li><div align='center'>No Activity Available</div></li>";
    }else {
        while ($items = $conn->fetch($stfrun)) {
            /*$actmsg=$actmsg."<li class='media'>
                <div class='media-left'>
                    <a href='#' class='btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm'><i class='icon-git-pull-request'></i></a>
                </div>
                <div class='media-body'>".$items['message']."
                    <div class='media-annotation'>".date('d M, Y H:i:s A',strtotime(date($items['date'])))."</div>
                </div>
            </li>
            <hr/>";*/
            $actmsg = $actmsg . "<li>
                        <a href='javascript:void(0);'>
                            <span class='message'>
                                <div class='row'>
                                    <div class='col-md-12'>".$items['message']."</div>
                                    <div class='col-md-12 time' align='right'>".date('d M, Y H:i:s A', strtotime(date($items['date'])))."</div>
                                </div>
                            </span>
                        </a>
                    </li>";
        }
    }



    //UPDATE THE CURRENT MEMO
    $msgc="SELECT COUNT(title) AS totmemo FROM memo WHERE userid='$staffid' AND status='Active'";
    $msgRun=$conn->query($dbconnection,$msgc);
    $msgData=$conn->fetch($msgRun);
    $memocount= $msgData['totmemo'];

    $memqry="SELECT title, tstamp, msg, usr FROM memo WHERE userid='$staffid' AND status='Active' ORDER BY tstamp DESC LIMIT 20";
    $memqryrun=$conn->query($dbconnection,$memqry);
    $memomsg="";
    if($conn->sqlnum($memqryrun) == 0){
        $memomsg = "<li><div align='center'>No Memo Available</div></li>";
    }else{
        while($data=$conn->fetch($memqryrun)) {
            $usr = $data['usr'];
            $dimg="";
            if($getdata['img'] !=""){
                $dimg=$getdata['img'];
            }else{
                $dimg="assets/images/noimage.png";
            }
            /*$memomsg=$memomsg."<li class='media'>
                <div class='media-left'>
                    <img src='".$dimg."' class='img-circle img-sm' alt=''>
                </div>

                <div class='media-body'>
                    
                <a class='media-heading'>
                <span class='text-semibold'>".$data['title']."</span>
                <span class='media-annotation pull-right'>".date('Y-m-d H:i:s A',strtotime(date($data['tstamp'])))."</span>
                </a>
                <span class='text-muted'>".substr($data['msg'],0,100)."</span>
                </div>
               </li>";*/
            $memomsg=$memomsg."<li>
                            <a href='javascript:void(0);'>
                                <span class='photo'><img src='".$dimg."' alt='' /></span>
                                <span class='subject'>
									<span class='from'>".$data['title']."</span>
									<span class='time'>".date('Y-m-d H:i:s A',strtotime(date($data['tstamp'])))."</span>
								</span>
                                <span class='text'>
									".substr($data['msg'],0,100)."
								</span>
                            </a>
                        </li>";
        }
    }

    //GET THE CURRENT MESSAGE AND DISPLAY TO THE USER

    $get="SELECT message, caption, id, date FROM message WHERE userid='$staffid' AND status='Active' ORDER BY date ASC LIMIT 1";
    $getrun=$conn->query($dbconnection,$get);
    if($conn->sqlnum($getrun) != 0){
        $getData=$conn->fetch($getrun);
        $id=$getData['id'];
        $respond['title']=$getData['caption'];
        $respond['msg']=$getData['message'];
        $respond['date']=date("Y-m-d",strtotime($getData['date']));

        //DEACTIVATE THAT MESSAGE
        $upd="UPDATE message SET status='Inactive' WHERE id=$id";
        $conn->query($dbconnection,$upd);
    }else{
        $id=0;
        $respond['title']="";
        $respond['msg']="";
        $respond['date']="";
    }

    $respond['actcount']=$actCount;
    $respond['actmsg']=$actmsg;
    $respond['memcount']=$memocount;
    $respond['memmsg']=$memomsg;
    $respond['lastlogin']=$tdiff;

    print json_encode($respond);
    $conn->close($dbconnection);

}

if(isset($_POST['usercheck'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
      $username = $_POST['usercheck'];
      $check = "SELECT * FROM users WHERE userid = '$username'";
      $checkrun = $conn->query($dbconnection,$check);
      if($conn->sqlnum($checkrun) <> 0){
          $response['msg']= "duplicate";
          $response['errorcode']= "001";
          print json_encode($response);
      }else{
          $response['msg']= "allowed";
          $response['errorcode']= "000";
          print json_encode($response);
      }
      $conn->close($dbconnection);
}

if(isset($_POST['getstock'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['getstock'];
    $branch = $_POST['branch'];
    $check = "SELECT qty FROM products WHERE pid = '$pid' AND shop='$branch'";
    $checkrun = $conn->query($dbconnection,$check);
    $chkdata = $conn->fetch($checkrun);
    print $chkdata['qty'];
    $conn->close($dbconnection);
}

if(isset($_POST['getprod'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['getprod'];
    $check = "SELECT * FROM products_master WHERE pid = '$pid'";
    $checkrun = $conn->query($dbconnection,$check);
    $checkdata = $conn->fetch($checkrun);
    $response['pid']= $checkdata['pid'];
    $response['pname']= $checkdata['pname'];
    $response['sprice']= $checkdata['sprice'];
    $response['cprice']= $checkdata['cprice'];
    $response['qty']= $checkdata['qty'];
    $response['pimg']= $checkdata['pimg'];
    $response['status']= $checkdata['status'];
    $response['cat']= $checkdata['cat'];
    $response['barcode']= $checkdata['barcode'];
    //GET THE CATEGORY NAME
    $cname = "";
    $cat = $checkdata['cat'];
    $sel = "SELECT cname FROM category WHERE id = $cat";
    $selrun = $conn->query($dbconnection,$sel);
    if($conn->sqlnum($selrun) !=0){
        $seldata = $conn->fetch($selrun);
        $cname = $seldata['cname'];
    }

    $response['cname']= $cname;

    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['catcheck'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cgname = $_POST['catcheck'];
    $check = "SELECT * FROM category WHERE cname = '$cgname'";
    $checkrun = $conn->query($dbconnection,$check);
    if($conn->sqlnum($checkrun) <> 0){
        $response['msg']= "duplicate";
        $response['errorcode']= "001";
        print json_encode($response);
    }else{
        $response['msg']= "allowed";
        $response['errorcode']= "000";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

if(isset($_POST['getreceipt'])){
    $receiptnum = $_POST['getreceipt'];
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $check = "SELECT shop FROM sales_summary WHERE sid = '$receiptnum'";
    $checkrun = $conn->query($dbconnection,$check);
    if($conn->sqlnum($checkrun) <> 0){
        print "OK";
    }else{
        print "NOT";
    }
    $conn->close($dbconnection);
}
if(isset($_POST['activateInvoice'])){
    $invid = $_POST['activateInvoice'];
    $shop = $_POST['shop'];

    $conn=new Db_connect;
    $dbconnection=$conn->conn();

    $check = "SELECT pid, qty FROM invoice_details WHERE invoiceid = '$invid'";
    $checkrun = $conn->query($dbconnection,$check);
    while($data = $conn->fetch($checkrun)){
        $pid = $data['pid'];
        $qty = $data['qty'];
        $upd = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop = '$shop'";
        $conn->query($dbconnection,$upd);
    }
    //GET THE TOTAL TAX
    $taxamount=0.0;
    $gettax = "SELECT SUM(damount) AS total FROM invoice_tax WHERE invid = '$invid'";
    $gettaxrun = $conn->query($dbconnection,$gettax);
    $gettaxdata = $conn->fetch($gettaxrun);
    if($gettaxdata['total'] == NULL){
        $taxamount = 0.00;
    }else{
        $taxamount = $gettaxdata['total'];
    }

    //ACTIVATE THE INVOICE
    $act="UPDATE customer_invoice SET status = 'Pending', totaltax = $taxamount WHERE invoiceid = '$invid'";
    $conn->query($dbconnection,$act);
    $conn->close($dbconnection);
}

if(isset($_POST['activateQuote'])){
    $invid = $_POST['activateQuote'];
    $shop = $_POST['shop'];

    $conn=new Db_connect;
    $dbconnection=$conn->conn();

    //GET THE TOTAL TAX
    $taxamount=0.0;
    $gettax = "SELECT SUM(damount) AS total FROM quote_tax WHERE invid = '$invid'";
    $gettaxrun = $conn->query($dbconnection,$gettax);
    $gettaxdata = $conn->fetch($gettaxrun);
    if($gettaxdata['total'] == NULL){
        $taxamount = 0.00;
    }else{
        $taxamount = $gettaxdata['total'];
    }
    //ACTIVATE THE INVOICE
    $act="UPDATE customer_quotation SET status = 'Pending', totaltax = $taxamount WHERE invoiceid = '$invid'";
    $conn->query($dbconnection,$act);
    $conn->close($dbconnection);
}

if(isset($_POST['possales'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['possales'];
    $user = $_POST['user'];
    $sid = $_POST['sid'];
    $qty = $_POST['qty'];
    $branch = $_POST['branch'];

    //CHECK IF PRODUCT HAS ALREADY BEEN ADDED
    $chkpro = "SELECT * FROM pos_temp WHERE pid = $pid AND sid='$sid' AND shop = '$branch'";
    $chkprorun = $conn->query($dbconnection,$chkpro);
    if($conn->sqlnum($chkprorun) > 0){
        $response['msg']= "Product Selected Has Already Been Added To Your List";
        $response['errorcode']= "001";
        print json_encode($response);
    }else{
        //CHECK QUANTITY
        //$chk = "SELECT qty, sprice, cprice FROM products WHERE id = $pid";
        $chk = "SELECT l.qty, p.sprice, p.cprice,p.pname FROM products l INNER JOIN products_master p ON l.pid = p.pid WHERE l.pid = '$pid' AND shop = '$branch'";
        $chkrun = $conn->query($dbconnection,$chk);
        $chkdata = $conn->fetch($chkrun);
        $realqty = $chkdata['qty'];
        $sprice = $chkdata['sprice'];
        $cprice = $chkdata['cprice'];
        $pname = $chkdata['pname'];
        if($qty > $realqty){
            $response['msg']= "Quantity Specified Is More Than The Stock Value. Current Stock Value Is ".$realqty;
            $response['errorcode']= "001";
            $response['total']= "000";
            print json_encode($response);
        }else{
            $ins = "INSERT INTO pos_temp (pid, userid,sid,qty,shop,sprice,cprice) VALUES ($pid,'$user','$sid',$qty,'$branch',$sprice,$cprice)";
            $conn->query($dbconnection,$ins);
            //SELECT the entries
            $sel = "SELECT p.pimg, p.pname, p.sprice, s.qty, s.pid, s.id  FROM pos_temp s INNER JOIN products_master p ON p.pid = s.pid WHERE s.sid = '$sid'";
            $selrun = $conn->query($dbconnection, $sel);
            $msg = "<table class='table table-striped'><thead><tr><th>Image</th><th>Product Name</th><th>Unit Cost</th><th>Qty</th><th>Total</th></tr></thead><tbody>";
            $overalltotal = 0 ;
            while($data = $conn->fetch($selrun)){
                $total = ($data['sprice'] * $data['qty']);
                $overalltotal = $overalltotal + $total;
                $id = $data['id'];
                $msg = $msg . "<tr><td><img src='".$data['pimg']."' class='img-responsive' width='50' height='50' /></td><td>".$data['pname']."</td><td>".$data['sprice']."</td><td>".$data['qty']."</td><td>".number_format($total, 2, '.', ',')."</td><td><a class='btn btn-sm btn-danger' onclick='remsales(".$id.")'><span class='icon icon-trash'></span></a> </td></tr>";
            }
            //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
            $msg = $msg . "<tr><td colspan='5'><p style='text-align: right; font-weight: bold;'>Total = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr>";

            //GET THE APPLICABLE SALES TAXES
            $totaltax=0;
            $gettax = "SELECT name, val FROM taxconfig WHERE status = 'ACTIVE' AND optin = 'YES'";
            $gettaxrun = $conn->query($dbconnection,$gettax);
            if($conn->sqlnum($gettaxrun) != 0){
                while($taxdata = $conn->fetch($gettaxrun)){
                    $taxcalc = ($overalltotal * $taxdata['val'])/100;
                    $totaltax+=$taxcalc;
                    $msg = $msg . "<tr><td colspan='5'><p style='text-align: right;'>".strtolower($taxdata['name'])." [".$taxdata['val']." %] = ".number_format($taxcalc, 2, '.', ',')." </p></td></tr>";
                }
                $msg = $msg . "<tr><td colspan='5'><p style='text-align: right; font-weight: bold;'>Tax Amount = ".number_format($totaltax, 2, '.', ',')." </p></td></tr>";
                $msg = $msg . "<tr><td colspan='5'><p style='text-align: right; font-weight: bold; font-size: medium; color: #7b0415;'>Payment Amount = ".number_format($overalltotal + $totaltax, 2, '.', ',')." </p></td></tr>";
            }
            $msg = $msg."<tr><td colspan='6'><div align='center'><a class='btn btn-lg btn-success' onclick='checkout()'><span class='icon icon-shopping-cart'></span>CHECK OUT</a></div></td></tr></tbody></table>";
            $response['msg']= $msg;
            $response['errorcode']= "000";
            $response['total']= number_format($overalltotal + $totaltax, 2, '.', ',');
            print json_encode($response);
        }
    }
    $conn->close($dbconnection);
}

if(isset($_POST['possales2'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['possales2'];
    $user = $_POST['user'];
    $sid = $_POST['sid'];
    $qty = $_POST['qty'];
    $branch = $_POST['branch'];

    //CHECK IF PRODUCT HAS ALREADY BEEN ADDED
    $chkpro = "SELECT * FROM pos_temp WHERE pid = $pid AND sid='$sid' AND shop = '$branch'";
    $chkprorun = $conn->query($dbconnection,$chkpro);
    if($conn->sqlnum($chkprorun) > 0){
        $response['msg']= "Product Selectd Has Already Been Added To Your List";
        $response['errorcode']= "001";
        print json_encode($response);
    }else{
        //CHECK QUANTITY
        //$chk = "SELECT qty, sprice, cprice FROM products WHERE id = $pid";
        $chk = "SELECT qty, sprice, cprice,pname FROM products_master WHERE pid = '$pid'";
        $chkrun = $conn->query($dbconnection,$chk);
        $chkdata = $conn->fetch($chkrun);
        $realqty = $chkdata['qty'];
        $sprice = $chkdata['sprice'];
        $cprice = $chkdata['cprice'];
        $pname = $chkdata['pname'];
        if($qty > $realqty){
            $response['msg']= "Quantity Specified Is More Than The Stock Value. Current Stock Value Is ".$realqty;
            $response['errorcode']= "001";
            $response['total']= "000";
            print json_encode($response);
        }else{
            $ins = "INSERT INTO pos_temp (pid, userid,sid,qty,shop,sprice,cprice) VALUES ($pid,'$user','$sid',$qty,'$branch',$sprice,$cprice)";
            $conn->query($dbconnection,$ins);
            //SELECT the entries
            $sel = "SELECT p.pname, p.sprice, s.qty, s.pid, s.id  FROM pos_temp s INNER JOIN products_master p ON p.pid = s.pid WHERE s.sid = '$sid'";
            $selrun = $conn->query($dbconnection, $sel);
            $msg = "<table class='table table-striped'><thead><tr><th>Product Name</th><th>Unit Cost</th><th>Qty</th><th>Total</th></tr></thead><tbody>";
            $overalltotal = 0 ;
            while($data = $conn->fetch($selrun)){
                $total = ($data['sprice'] * $data['qty']);
                $overalltotal = $overalltotal + $total;
                $id = $data['id'];
                $msg = $msg . "<tr><td>".$data['pname']."</td><td>".$data['sprice']."</td><td>".$data['qty']."</td><td>".number_format($total, 2, '.', ',')."</td><td><a class='btn btn-sm btn-danger' onclick='remsales2(".$id.")'><span class='icon icon-remove'></span></a> </td></tr>";
            }
            //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
            $msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr><tr><td colspan='5'><div align='center'><a class='btn btn-lg btn-success' onclick='checkout2()'><span class='icon icon-shopping-cart'></span>CHECK OUT</a></div></td></tr></tbody></table>";
            $response['msg']= $msg;
            $response['errorcode']= "000";
            $response['total']= $overalltotal;
            print json_encode($response);
        }
    }
    $conn->close($dbconnection);
}

if(isset($_POST['getcategoryproducts'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cid = $_POST['getcategoryproducts'];

    $count=0;
    //SELECT the entries
    $sel = "SELECT pid, pname, sprice, cprice, qty FROM products_master WHERE cat='$cid'";
    $selrun = $conn->query($dbconnection, $sel);
    $msg = "<table class='table table-striped table-bordered table-hover table-checkable table-responsive datatable'><thead><tr><th>#</th><th>Product ID</th><th>Product Name</th><th>Selling Price</th><th>Cost Price</th><th>Qty</th></tr></thead><tbody>";
    while($data = $conn->fetch($selrun)){
        $count++;
        $msg = $msg . "<tr><td>".$count."</td><td>".$data['pid']."</td><td>".$data['pname']."</td><td>".$data['sprice']."</td><td>".$data['cprice']."</td><td>".$data['qty']."</td></tr>";
    }
    print $msg."</tbody></table>";
    $conn->close($dbconnection);
}


if(isset($_POST['remsales'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['remsales'];
    //GETBTHE SESSION ID
    $getsess = "SELECT sid FROM pos_temp WHERE id = $pid";
    $getsessrun = $conn->query($dbconnection,$getsess);
    $getsessdata = $conn->fetch($getsessrun);
    $sid = $getsessdata['sid'];
    //CHECK IF PRODUCT HAS ALREADY BEEN ADDED
    $chkpro = "DELETE FROM pos_temp WHERE id = $pid";
    $chkprorun = $conn->query($dbconnection,$chkpro);
    //SELECT the entries
    $sel = "SELECT p.pimg, p.pname, p.sprice, s.qty, s.pid, s.id  FROM pos_temp s INNER JOIN products_master p ON p.pid = s.pid WHERE s.sid = '$sid'";
    $selrun = $conn->query($dbconnection, $sel);
    $selnum = $conn->sqlnum($selrun);
    $msg = "";
    //CHECK IF CART IS EMPTY
    if($selnum == 0){
       $msg = "CART IS EMPTY";
        $response['msg']= $msg;
        $response['total']= "000";
    }
    else{
        $msg = "<table class='table table-striped'><thead><tr><th>Image</th><th>Product Name</th><th>Unit Cost</th><th>Qty</th><th>Total</th></tr></thead><tbody>";
        $overalltotal = 0 ;
        while($data = $conn->fetch($selrun)){
            $total = ($data['sprice'] * $data['qty']);
            $overalltotal = $overalltotal + $total;
            $id = $data['id'];
            $msg = $msg . "<tr><td><img src='".$data['pimg']."' class='img-responsive' width='50' height='50' /></td><td>".$data['pname']."</td><td>".$data['sprice']."</td><td>".$data['qty']."</td><td>".number_format($total, 2, '.', ',')."</td><td><a class='btn btn-sm btn-danger' onclick='remsales(".$id.")'><span class='icon icon-trash'></span></a> </td></tr>";
        }
        //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
        $msg = $msg . "<tr><td colspan='5'><p style='text-align: right; font-weight: bold;'>Total = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr>";

        //GET THE APPLICABLE SALES TAXES
        $totaltax=0;
        $gettax = "SELECT name, val FROM taxconfig WHERE status = 'ACTIVE' AND optin = 'YES'";
        $gettaxrun = $conn->query($dbconnection,$gettax);
        if($conn->sqlnum($gettaxrun) != 0){
            while($taxdata = $conn->fetch($gettaxrun)){
                $taxcalc = ($overalltotal * $taxdata['val'])/100;
                $totaltax+=$taxcalc;
                $msg = $msg . "<tr><td colspan='5'><p style='text-align: right;'>".strtolower($taxdata['name'])." [".$taxdata['val']." %] = ".number_format($taxcalc, 2, '.', ',')." </p></td></tr>";
            }
            $msg = $msg . "<tr><td colspan='5'><p style='text-align: right; font-weight: bold;'>Tax Amount = ".number_format($totaltax, 2, '.', ',')." </p></td></tr>";
            $msg = $msg . "<tr><td colspan='5'><p style='text-align: right; font-weight: bold; font-size: medium; color: #7b0415;'>Payment Amount = ".number_format($overalltotal + $totaltax, 2, '.', ',')." </p></td></tr>";
        }
        $msg = $msg."<tr><td colspan='6'><div align='center'><a class='btn btn-lg btn-success' onclick='checkout()'><span class='icon icon-shopping-cart'></span>CHECK OUT</a></div></td></tr></tbody></table>";
        $response['msg']= $msg;
        $response['total']= number_format($overalltotal + $totaltax, 2, '.', ',');

    }

    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['loadshopproducts'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $branch = $_POST['loadshopproducts'];
    $stfid = $_POST['stfid'];
    $sel = "SELECT m.pimg, m.pname, m.cat, m.sprice, m.pid, p.qty FROM products_master m INNER JOIN products p ON m.pid = p.pid WHERE m.status = 'ACTIVE' AND p.shop = '$branch' AND p.qty > 0";
    $selrun = $conn->query($dbconnection,$sel);

    $msg="";
    while($data = $conn->fetch($selrun)){
        $msg=$msg."<option value='".$data['pid'].':'.getproduct($data['pid'])."'>".getproduct($data['pid'])."</option>";
    }
    $msg=$msg."</select>";
    print $msg;
    $conn->close($dbconnection);
}

if(isset($_POST['remsales2'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['remsales2'];
    //GETBTHE SESSION ID
    $getsess = "SELECT sid FROM pos_temp WHERE id = $pid";
    $getsessrun = $conn->query($dbconnection,$getsess);
    $getsessdata = $conn->fetch($getsessrun);
    $sid = $getsessdata['sid'];
    //CHECK IF PRODUCT HAS ALREADY BEEN ADDED
    $chkpro = "DELETE FROM pos_temp WHERE id = $pid";
    $chkprorun = $conn->query($dbconnection,$chkpro);
    //SELECT the entries
    $sel = "SELECT p.pname, p.sprice, s.qty, s.pid, s.id  FROM pos_temp s INNER JOIN products_master p ON p.pid = s.pid WHERE s.sid = '$sid'";
    $selrun = $conn->query($dbconnection, $sel);
    $selnum = $conn->sqlnum($selrun);

    //CHECK IF CART IS EMPTY
    if($selnum == 0){
        print "CART IS EMPTY";
    }
    else{
        $msg = "<table class='table table-striped'><thead><tr><th>Product Name</th><th>Unit Cost</th><th>Qty</th><th>Total</th></tr></thead><tbody>";
        $overalltotal = 0 ;
        while($data = $conn->fetch($selrun)){
            $total = ($data['sprice'] * $data['qty']);
            $overalltotal = $overalltotal + $total;
            $id = $data['id'];
            $msg = $msg . "<tr><td>".$data['pname']."</td><td>".$data['sprice']."</td><td>".$data['qty']."</td><td>".number_format($total, 2, '.', ',')."</td><td><a class='btn btn-sm btn-danger' onclick='remsales2(".$id.")'><span class='icon icon-remove'></span></a> </td></tr>";
        }
        //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
        $msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr><tr><td colspan='5'><div align='center'><a class='btn btn-lg btn-success' onclick='checkout()'><span class='icon icon-shopping-cart'></span>CHECK OUT</a></div></td></tr></tbody></table>";

        print $msg;
    }
    $conn->close($dbconnection);
}

if(isset($_POST['submit_category'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cgname = strtoupper(mysqli_real_escape_string($dbconnection,$_POST['submit_category']));
    $check = "SELECT * FROM category WHERE cname = '$cgname'";
    $checkrun = $conn->query($dbconnection,$check);
    if($conn->sqlnum($checkrun) <> 0){
        $response = "duplicate";
        print $response;
    }else{
        $response = "allowed";
        print $response;
    }
    $conn->close($dbconnection);
}

if(isset($_POST['getprodid'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $bcode = $_POST['getprodid'];
    $check = "SELECT pid FROM products_master WHERE barcode = '$bcode'";
    $checkrun = $conn->query($dbconnection,$check);
    $response = "";
    if($conn->sqlnum($checkrun) <> 0){
        $checkdata = $conn->fetch($checkrun);
        $response = $checkdata['pid'];
    }else{
        $response = "nope";
    }

    print $response;
    $conn->close($dbconnection);
}

if(isset($_POST['getprodid2'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $bcode = $_POST['getprodid2'];
    $branch = $_POST['branch'];
    //print $check = "SELECT a.pid FROM products a INNER JOIN products_master b ON a.pid = b.pid WHERE b.barcode = '$bcode'";
    $check = "SELECT p.pid, p.qty, m.pname FROM products p INNER JOIN products_master m ON p.pid = m.pid WHERE m.barcode = '$bcode'";
    //print $check = "SELECT pid, pname FROM  products_master WHERE barcode = '$bcode' AND pid IN (SELECT pid FROM products WHERE shop='$branch')";
    $checkrun = $conn->query($dbconnection,$check);

    if($conn->sqlnum($checkrun) <> 0){
        $checkdata = $conn->fetch($checkrun);
        $pid=$checkdata['pid'];
        $pname=$checkdata['pname'];
        $qty=$checkdata['qty'];

        $response['pid'] = $pid;
        $response['pname'] = $pname;
        $response['qty'] = $qty;
        $response['msg'] = "OK";
        print json_encode($response);
    }else{
        $response['pid'] = "";
        $response['pname'] = "";
        $response['qty'] = "";
        $response['msg'] = "nope";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

if(isset($_POST['salesdetails'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['salesdetails'];
    //GETBTHE SESSION ID
    $getsess = "SELECT s.pid, s.cid, s.qty, s.cprice, s.sprice, p.pname  FROM pos_sales s INNER JOIN products_master p ON p.pid = s.pid WHERE s.sid = '$sid'";
    $getsessrun = $conn->query($dbconnection,$getsess);

    $msg = "<table class='table table-striped'><thead><tr><th>Product Name</th><th>Unit Cost</th><th>Qty</th><th>Total</th><th>Customer Name</th></tr></thead><tbody>";
    $overalltotal = 0 ;
    while($data = $conn->fetch($getsessrun)){
        $total = ($data['sprice'] * $data['qty']);
        $overalltotal = $overalltotal + $total;
        $msg = $msg . "<tr><td>".$data['pname']."</td><td>".$data['sprice']."</td><td>".$data['qty']."</td><td>".number_format($total, 2, '.', ',')."</td><td>".getCustomer($data['cid'])." </td></tr>";
    }    //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
    $msg = $msg . "<tr><td colspan='5'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";

    print $msg;
    $conn->close($dbconnection);
}

if(isset($_POST['transferdetails'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['transferdetails'];
    //GETBTHE SESSION ID
    $getsess = "SELECT * FROM transfers WHERE transid = '$sid'";
    $getsessrun = $conn->query($dbconnection,$getsess);

    $msg = "<table class='table table-striped'><thead><tr><th>#</th><th>Product Name</th><th>Previous Stock</th><th>Qty</th><th>Total Stock</th></tr></thead><tbody>";
    $overalltotal = 0 ;
    $count = 0;
    while($data = $conn->fetch($getsessrun)){
        $count++;
        $total = $data['cur'] + $data['prev'];
        $msg = $msg . "<tr><td>".$count."</td><td>".getproduct($data['pid'])."</td><td>".$data['prev']."</td><td>".$data['cur']."</td><td>".$total."</td></tr>";
    }    //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
    //$msg = $msg . "<tr><td colspan='5'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";

    print $msg;
    $conn->close($dbconnection);
}

if(isset($_POST['transferdetails2'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['transferdetails2'];
    //GETBTHE SESSION ID
    $getsess = "SELECT * FROM shop_to_shop WHERE transid = '$sid'";
    $getsessrun = $conn->query($dbconnection,$getsess);

    $msg = "<table class='table table-striped'><thead><tr><th>#</th><th>Product Name</th><th>Previous Stock</th><th>Qty</th><th>Total Stock</th></tr></thead><tbody>";
    $overalltotal = 0 ;
    $count = 0;
    while($data = $conn->fetch($getsessrun)){
        $count++;
        $total = $data['cur'] + $data['prev'];
        $msg = $msg . "<tr><td>".$count."</td><td>".getproduct($data['pid'])."</td><td>".$data['prev']."</td><td>".$data['cur']."</td><td>".$total."</td></tr>";
    }    //$msg = $msg . "<tr><td colspan='4'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";
    //$msg = $msg . "<tr><td colspan='5'><p style='color: #ff630d; font-weight: bold; text-align: center; font-size: xx-large'>TOTAL = ".number_format($overalltotal, 2, '.', ',')." </p></td></tr></tbody></table>";

    print $msg;
    $conn->close($dbconnection);
}

if(isset($_POST['checktransfers'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['checktransfers'];
    $qty = $_POST['qty'];
    $check = "SELECT qty FROM products_master WHERE pid = '$pid'";
    $checkrun = $conn->query($dbconnection,$check);
    $checkdata = $conn->fetch($checkrun);
    $realqty = $checkdata['qty'];
    if($qty <= $realqty){
        $response['code'] = 0;
        $response['qtyin'] = $realqty;
        print json_encode($response);
    }else{
        $response['code'] = 1;
        $response['qtyin'] = $realqty;
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

//shop to shop transfer
if(isset($_POST['shoptransfers'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['shoptransfers'];
    $qty = $_POST['qty'];
    $branch = $_POST['branch'];
    $check = "SELECT qty FROM products WHERE pid = '$pid' AND shop = '$branch'";
    $checkrun = $conn->query($dbconnection,$check);
    $checkdata = $conn->fetch($checkrun);
    $realqty = $checkdata['qty'];
    if($qty <= $realqty){
        print "Allowed";
    }else{
        print "Not";
    }
    $conn->close($dbconnection);
}

if(isset($_POST['getcompany'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    //GET THE COMPANY INFORMATION / DETAILS
    $getcomp = "SELECT * FROM company";
    $getcomprun = $conn->query($dbconnection,$getcomp);
    $getcompdata = $conn->fetch($getcomprun);
    $response['cname'] = $getcompdata['cname'];
    $response['ccont'] = $getcompdata['ccont'];
    $response['cmail'] = $getcompdata['cmail'];
    $response['cloc'] = $getcompdata['cloc'];
    $response['caddr'] = $getcompdata['caddr'];
    $response['clogo'] = $getcompdata['clogo'];
    $response['tag'] = $getcompdata['tag'];
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['getTax'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $taxid = $_POST['getTax'];
    $getcomp = "SELECT * FROM taxconfig WHERE id=$taxid";
    $getcomprun = $conn->query($dbconnection,$getcomp);
    $getcompdata = $conn->fetch($getcomprun);
    $response['taxid'] = $getcompdata['taxid'];
    $response['name'] = $getcompdata['name'];
    $response['dval'] = $getcompdata['val'];
    $response['optin'] = $getcompdata['optin'];
    $response['status'] = $getcompdata['status'];
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['getbranch'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $bid = $_POST['getbranch'];
    //GET THE COMPANY INFORMATION / DETAILS
    $getcomp = "SELECT * FROM branches WHERE id=$bid";
    $getcomprun = $conn->query($dbconnection,$getcomp);
    $getcompdata = $conn->fetch($getcomprun);
    $response['bname'] = $getcompdata['bname'];
    $response['bcont'] = $getcompdata['contact'];
    $response['bmail'] = $getcompdata['email'];
    $response['bloc'] = $getcompdata['bloc'];
    $response['bstatus'] = $getcompdata['status'];
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['getproductselect'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $branch = $_POST['getproductselect'];
    $count = $_POST['count'];
    $invtype = $_POST['invtype'];
    //GET THE COMPANY INFORMATION / DETAILS
    $getcomp="";
    if($invtype == "invoice"){
        $getcomp = "SELECT a.pid, a.qty, b.pname FROM products a INNER JOIN products_master b ON a.pid = b.pid WHERE a.qty > 0 AND b.status = 'ACTIVE' AND a.shop = '$branch' ORDER BY b.pname ASC";
    }else{
        $getcomp = "SELECT a.pid, a.qty, b.pname FROM products a INNER JOIN products_master b ON a.pid = b.pid WHERE b.status = 'ACTIVE' AND a.shop = '$branch' ORDER BY b.pname ASC";
    }

    $getcomprun = $conn->query($dbconnection,$getcomp);
    $selresult = "<select class='form-control' onchange ='calcprod(".$count.")' id='selprod".$count."' name='selprod[]' required><option></option>";
    while($getcompdata = $conn->fetch($getcomprun)){
        $pid = $getcompdata['pid'];
        $pname = $getcompdata['pname'];
        $qty = $getcompdata['qty'];
        $selresult = $selresult."<option value='".$pid."'>".$pname."   [".$qty."]</option>";
    }
    $selresult = $selresult."</select>";
    print $selresult;
    $conn->close($dbconnection);
}

if(isset($_POST['getuserinfo'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $userid = $_POST['getuserinfo'];
    $regbranches = "";
    //GET THE COMPANY INFORMATION / DETAILS
    $getcomp = "SELECT fname, lname, img, access, status FROM users WHERE userid = '$userid'";
    $getcomprun = $conn->query($dbconnection,$getcomp);
    $getcompdata = $conn->fetch($getcomprun);

    $response['fname'] = $getcompdata['fname'];
    $response['lname'] = $getcompdata['lname'];
    $response['img'] = "<img src='".$getcompdata['img']."' style='width: 100px; height: 100px;' id='blahuimg'/>";
    $response['access'] = $getcompdata['access'];
    $response['status'] = $getcompdata['status'];

    $sel = "SELECT bname, id FROM branches WHERE status = 'Active'";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $bname = $data['bname'];
        $bid = $data['id'];
        //CHECK IF USER IS REGISTERED TO THE BRANCH
        $breg = checkIfRegistered($bid,$userid);
        if($breg == "0"){
            $regbranches = $regbranches."<tr><td><input type='checkbox' class='checkbox' name='reclist[]' value='$bid' checked='checked' id='<?php echo $bid; ?>'/></td><td><label for='<?php echo $bid ?>'>$bname</label></td></tr>";
        }
        else{
            $regbranches = $regbranches."<tr><td><input type='checkbox' class='checkbox' name='reclist[]' value='$bid'  id='<?php echo $bid; ?>' /></td><td><label for='<?php echo $bid; ?>'>$bname</label></td></tr>";
        }
    }
    $response['branches'] = $regbranches;
    print json_encode($response);
    $conn->close($dbconnection);
}

if(isset($_POST['getproductselectwh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $msg = "<select class='select2-active form-control' name='tprodwh[]' id='tprod' required><option value=''>--SELECT PRODUCT --</option>";
                $sel = "SELECT pid,pname, qty FROM products_master WHERE status = 'Active' AND qty > 0 ORDER BY pname ASC";
                $selrun = $conn->query($dbconnection,$sel);
                while($data = $conn->fetch($selrun)){
                    $msg = $msg."<option value='".$data['pid']."'>".$data['pname']."&nbsp;&nbsp;<span style='font-weight: bold;'>(".$data['qty'].")</span></option>";
                }
            $msg=$msg."</select>";
            print $msg;
            $conn->close($dbconnection);
}

if(isset($_POST['getproductselectsh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $branch = $_POST['branch'];
    $msg = "<select class='select2-active form-control' name='tprodsh[]' id='tprod' required><option value=''>--SELECT PRODUCT --</option>";
    $sel = "SELECT pid, qty FROM products WHERE shop='$branch' AND status = 'Active' AND qty > 0";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $msg = $msg."<option value='".$data['pid']."'>".getproduct($data['pid'])."&nbsp;&nbsp;<span style='font-weight: bold;'>(".$data['qty'].")</span></option>";
    }
    $msg=$msg."</select>";
    print $msg;
    $conn->close($dbconnection);
}

if(isset($_POST['transferops'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $transid = $_POST['transferops'];
    $action = $_POST['action'];
    $shop = $_POST['shop'];
    $userid = $_POST['userid'];
    $sender = $_POST['sender'];
    $sendershop = $_POST['sendershop'];
    if($action == "reject"){
        $upddetails = "UPDATE transfer_details SET receiveby='$userid', receivedate='$dateTime', status='Rejected' WHERE transid = '$transid'";
        $conn->query($dbconnection,$upddetails);
        sendmessage($sender,"Products Transferred To ".getbranch($shop)." Has Been Rejected By ".getstaff($sender),"Product Transfer Rejected");
        print "Product Transfer Has Been Rejected Successfully";
    }else{
        //SELECT PRODUCTS FROM THE TEMP TABLE
        $sel = "SELECT * FROM products_temp WHERE transid = '$transid'";
        $selrun = $conn->query($dbconnection,$sel);
        while($seldata = $conn->fetch($selrun)){
            $pid = $seldata['pid'];
            $qty = $seldata['qty'];
            $shop = $seldata['shop'];
            //GET THE CURRENT QUANTITY
            $getwh="";

            //UPDATING THE QUANTITY IN THE SHOP
            //TRANSFERRING PRODUCTS INTO THE SHOP
            if($shop == "WH"){
                $getwh = "SELECT qty FROM products_master WHERE pid = '$pid'";
                $getwhrun = $conn->query($dbconnection,$getwh);
                $getdata = $conn->fetch($getwhrun);
                $prevqty = $getdata['qty'];

                //UPDATE product quantity
                $upd = "UPDATE products_master SET qty = (qty + $qty) WHERE pid = '$pid'";
                $conn->query($dbconnection,$upd);

                $ins = "INSERT INTO transfers (transid,pid, prev, cur) VALUES ('$transid','$pid', $prevqty,$qty)";
                $conn->query($dbconnection,$ins);
            }else{
                $getwh = "SELECT qty FROM products WHERE pid = '$pid' AND shop = '$shop'";
                $getwhrun = $conn->query($dbconnection,$getwh);

                //CHECK IF PRODUCT exists
                if($conn->sqlnum($getwhrun) == 0){
                    $ins = "INSERT INTO products(pid, qty, status, shop) VALUES ($pid,$qty,'Active','$shop')";
                    $conn->query($dbconnection,$ins);

                    $ins2 = "INSERT INTO transfers (transid,pid, prev, cur) VALUES ('$transid','$pid', 0,$qty)";
                    $conn->query($dbconnection,$ins2);
                }else{
                    //UPDATE product quantity
                    $upd = "UPDATE products SET qty = (qty + $qty) WHERE pid = '$pid' AND shop = '$shop'";
                    $conn->query($dbconnection,$upd);

                    $getdata = $conn->fetch($getwhrun);
                    $prevqty = $getdata['qty'];
                    $ins = "INSERT INTO transfers (transid,pid, prev, cur) VALUES ('$transid','$pid', $prevqty,$qty)";
                    $conn->query($dbconnection,$ins);
                }
            }

            //DEDUCTING TRANSFERRED PRODUCTS FROM THE SENDERSHOP
            if($sendershop == "WH"){
                $upd = "UPDATE products_master SET qty = (qty - $qty) WHERE pid = '$pid'";
                $conn->query($dbconnection,$upd);
            }else{
                $upd = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop='$sendershop'";
                $conn->query($dbconnection,$upd);
            }

        }
        $upddetails = "UPDATE transfer_details SET receiveby='$userid', receivedate='$dateTime', status='Accepted' WHERE transid = '$transid'";
        $conn->query($dbconnection,$upddetails);

        //SEND MEMO TO SENDER
        sendmessage($sender,"Products Transferred To ".getbranch($shop)." Has Been Received By ".getstaff($sender),"Product Transfer Received");

        print "Products Transfer Has Been Completed Successfully";
    }

    $conn->close($dbconnection);
}

if(isset($_POST['getproductselectshop'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $branch = $_POST['getproductselectshop'];
    $msg = "<select class='select2-active form-control' name='stprod' id='stprod' required><option value=''>--SELECT PRODUCT --</option>";
    $sel = "SELECT p.pid, p.qty FROM products p INNER JOIN products_master m ON p.pid = m.pid  WHERE p.qty > 0 AND m.status = 'ACTIVE' AND p.shop = '$branch' ORDER BY m.pname ASC";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $color = '#000';
        if($data['qty'] <= 0){
            $color = '#F00';
        }
        $msg = $msg."<option value='".$data['pid']."' style='color: ".$color."'>".getproduct($data['pid'])."&nbsp;&nbsp;<span style='font-weight: bold;'>(".$data['qty'].")</span></option>";
    }
    $msg=$msg."</select>";
    print $msg;
    $conn->close($dbconnection);
}

if(isset($_POST['getproductprice'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['getproductprice'];
    $qty = $_POST['qty'];
    $branch = $_POST['branch'];
    $invtype = $_POST['invtype'];
    //CHECK IF QTY IS NULL
    if(empty($qty)){
        $response['sprice'] = "";
        $response['subtotal'] = "";
        $response['msg'] = "NOQTY";
        print json_encode($response);
    }else{
        //GET THE COMPANY INFORMATION / DETAILS
        $getcomp = "SELECT a.sprice, b.qty FROM products_master a INNER JOIN products b ON a.pid = b.pid WHERE b.pid = '$pid' AND b.shop='$branch'";
        $getcomprun = $conn->query($dbconnection,$getcomp);
        $getcompdata = $conn->fetch($getcomprun);
        if($getcompdata['qty'] >= $qty){
            $response['sprice'] = number_format($getcompdata['sprice'],2);
            $response['subtotal'] = ($getcompdata['sprice'] * $qty);
            $response['msg'] = "OK";
            $response['qty'] = $getcompdata['qty'];
            $response['invtype'] = $invtype;
            print json_encode($response);
        }elseif(($getcompdata['qty'] < $qty) & $invtype == "quotation"){
            $response['sprice'] = $getcompdata['sprice'];
            $response['subtotal'] = ($getcompdata['sprice'] * $qty);
            $response['msg'] = "OK";
            $response['qty'] = $getcompdata['qty'];
            $response['invtype'] = $invtype;
            print json_encode($response);
        }

        else{
            $response['sprice'] = number_format($getcompdata['sprice'],2);
            $response['subtotal'] = ($getcompdata['sprice'] * $qty);
            $response['msg'] = "NO";
            $response['qty'] = $getcompdata['qty'];
            $response['invtype'] = $invtype;
            print json_encode($response);
        }

    }
    $conn->close($dbconnection);
}

if(isset($_POST['validatequotation'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $invid = $_POST['validatequotation'];
    $branch = $_POST['branch'];
    //GET ALL THE PRODUCT IDS IN THE QUOTATION
    $sel = "SELECT pid, qty FROM quotation_details WHERE invoiceid = '$invid'";
    $selrun = $conn->query($dbconnection,$sel);

    $instock = 0;
    $outstock = 0;
    $outmessage = "Some Products In Your Quotation Are Out Of Stock Hence Cannot Generate The Invoice n Find The Details Below n";
    while($data = $conn->fetch($selrun)){
        $pid = $data['pid'];
        $qty = $data['qty'];

        //CHECK THE PRODUCTS TABLE TO SEE IF QUANTITY EXISTS
        echo $chk = "SELECT qty FROM products WHERE pid = '$pid' AND shop = '$branch'";
        $chkrun = $conn->query($dbconnection,$chk);
        $chkdata = $conn->fetch($chkrun);
        $realqty = $chkdata['qty'];
        if($realqty < $qty){
            $outstock = $outstock + 1;
            $outmessage = $outmessage.getproduct($pid)." (Qty In Stock Is: ".$realqty." And Requested Quantity Is ".$qty." )";
        }
    }

    if($outstock != 0){
        print $outmessage;
    }else{
        print "OK";
    }
    $conn->close($dbconnection);
}


if(isset($_POST['getproductpricewh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['getproductpricewh'];
    $qty = $_POST['qty'];
    //GET THE COMPANY INFORMATION / DETAILS
    echo $getcomp = "SELECT qty FROM products_master WHERE pid = '$pid'";
    $getcomprun = $conn->query($dbconnection,$getcomp);
    $getcompdata = $conn->fetch($getcomprun);
    if($getcompdata['qty'] >= $qty){
        $response['msg'] = "OK";
        print json_encode($response);
    }else{
        $response['msg'] = "NO";
        print json_encode($response);
    }
    $conn->close($dbconnection);
}

?>