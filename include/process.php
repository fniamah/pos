<?php
//CHANGE PASSWORDS
if(isset($_POST['chvoka'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $stfid=$_POST['chvoka'];
    $currPass=$_POST['old_password'];
    $newPass=$_POST['new_password'];
    $repPass=$_POST['new_password_repeat'];

    $newhash = password_hash($newPass, PASSWORD_ARGON2I);
    //Check If the current password entered is correct
    $chk="SELECT pword FROM users WHERE userid='$stfid'";
    $chkrun=$conn->query($dbconnection,$chk);
    if($conn->sqlnum($chkrun) > 0){
        $chkdata = $conn->fetch($chkrun);
        $hash = $chkdata['pword'];
        if(password_verify($currPass, $hash)){
            $update = "UPDATE users SET pword = '$newhash' WHERE userid='$stfid'";
            $conn->query($dbconnection,$update);

            $test="yes";
            $msg="Password Has Been Changed";
        }else{
            $test="no";
            $msg="Password not verified";
        }
    }else{
        $test="no";
        $msg="Password Could Not Be Changed. This is because the old password you entered is wrong";
    }
    $conn->close($dbconnection);
}


if(isset($_FILES['img']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['img']['tmp_name'];
    $newname="assets/data/users/avatar.png";//URL of the image location

    $fname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['fname']));
    $lname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['lname']));
    $access=mysqli_real_escape_string($dbconnection,strtoupper($_POST['access']));
    $gender=mysqli_real_escape_string($dbconnection,strtoupper($_POST['gender']));
    $contact=mysqli_real_escape_string($dbconnection,strtoupper($_POST['contact']));
    $address=mysqli_real_escape_string($dbconnection,strtoupper($_POST['address']));

    //GENERATING THE SYSTEM AND EMPLOYEE ID
    $getNum="SELECT COUNT(fname) AS totstf FROM users";
    $getNumRun=$conn->query($dbconnection,$getNum);
    $roledata=$conn->fetch($getNumRun);
    $rolenum = $roledata['totstf'];
    $username="SP".date("Y").str_pad(($rolenum + 1),3,"0",STR_PAD_LEFT);

    if(!empty($img)){
        $newname="assets/data/users/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $newname, file_get_contents($img));
    }
    $reclist= $_POST['reclist'];
    $count= COUNT($reclist);
    for($i=0;$i < $count; $i++){
        $branch=$reclist[$i];
        $msgqry="INSERT INTO usr_branch SET userid='$username', branch='$branch', status='ACTIVE'";
        $conn->query($dbconnection,$msgqry);
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

    $test="yes";
    $msg = "Staff Has Been Added Successfully. \n"."<b>STAFF NAME:</b> ".$fname." ".$lname."\n <b>STAFF ID:</b> ".$username;
    $conn->close($dbconnection);
}

if(isset($_FILES['userimg']['tmp_name'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $img=$_FILES['userimg']['tmp_name'];
    $newname="assets/data/users/avatar.png";//URL of the image location

    $fname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['fname']));
    $lname=mysqli_real_escape_string($dbconnection,strtoupper($_POST['lname']));
    $access=mysqli_real_escape_string($dbconnection,strtoupper($_POST['access']));
    $uid=mysqli_real_escape_string($dbconnection,strtoupper($_POST['userid']));
    $status=mysqli_real_escape_string($dbconnection,strtoupper($_POST['status']));


    if(!empty($img)){
        $newname="assets/data/users/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $newname, file_get_contents($img));
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

    $test = "yes";
    $msg = "User Account Updated Successfully";
    $conn->close($dbconnection);
}
//CUSTOMER INVOICES
if(isset($_POST['generateinvoice'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $custname=mysqli_real_escape_string($dbconnection,$_POST['custname']);
    $cont=mysqli_real_escape_string($dbconnection,$_POST['cont']);
    $invdate=mysqli_real_escape_string($dbconnection,$_POST['invdate']);
    $duedate=mysqli_real_escape_string($dbconnection,$_POST['duedate']);
    $organ=mysqli_real_escape_string($dbconnection,$_POST['organ']);
    $orgcont=mysqli_real_escape_string($dbconnection,$_POST['orgcont']);
    $orgloc=mysqli_real_escape_string($dbconnection,$_POST['orgloc']);

    $pid=$_POST['selprod'];
    $qty=$_POST['qty'];
    $price=$_POST['price'];

    $invid="INV/".date("Y")."/".date("mdHis");

    $count=COUNT($price);
    $failed=0;
    $success=0;
    $totAmount=0;
    for($i=0; $i < $count; $i++){
        if(!empty($price[$i]) || !empty($qty[$i])){
            $totAmount+=($price[$i] * $qty[$i]);
            $qry="INSERT INTO invoice_details SET invoiceid = '$invid', pid='$pid[$i]', qty=$qty[$i], sprice=$price[$i]";
            $conn->query($dbconnection,$qry);

            //REDUCE THE STOCK QUANTITY FOR THE PRODUCT
            //$upd = "UPDATE products SET qty = (qty - $qty[$i]) WHERE pid = '$pid[$i]' AND shop = '$branch'";
            //$conn->query($dbconnection,$upd);
            $success++;
        }
        else{
            $failed++;
        }
    }
    if($success > 0){
        $qry2="INSERT INTO customer_invoice SET organ='$organ',orgcont='$orgcont',orgloc='$orgloc',invoiceid='$invid', custname='$custname', cont='$cont', invdate = '$invdate', duedate='$duedate',salesperson = '$stfID', totalamount = $totAmount, paid = 0.00, status = 'Inactive', shop = '$branch'";
        $conn->query($dbconnection,$qry2);
        $authentic="yes";
        $msg="Customer Invoice Generated Successfully.";
        header("Location: dashboard.php?viewinvoice=$invid");
    }
    $conn->close($dbconnection);
}

//CTREATING TAXES
if(isset($_POST['updatetax'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $taxid=mysqli_real_escape_string($dbconnection,$_POST['taxid']);
    $taxname=mysqli_real_escape_string($dbconnection,$_POST['taxnamee']);
    $val=mysqli_real_escape_string($dbconnection,$_POST['percentage']);
    $status=mysqli_real_escape_string($dbconnection,$_POST['status']);
    $optin=mysqli_real_escape_string($dbconnection,strtoupper($_POST['opt']));

    $upd = "UPDATE taxconfig SET name='$taxname', val=$val, optin='$optin', status='$status' WHERE taxid = '$taxid'";
    $conn->query($dbconnection,$upd);
    $test="yes";
    $msg="Tax Updated Successfully";
    $conn->close($dbconnection);
}

if(isset($_POST['addtaxtoinvoice'])){
    $taxid = $_POST['addtaxtoinvoice'];
    $invoiceid = $_POST['invoiceid'];
    $totinvoice = $_POST['totalinvoice'];
    $obj = explode("/",$taxid);
    $tax=$obj[0];
    $val=$obj[1];

    $conn=new Db_connect;
    $dbconnection=$conn->conn();

    $ins="INSERT INTO invoice_tax(invid, taxid, dval, damount) VALUES ('$invoiceid','$tax',$val,($val * $totinvoice)/100)";
    $conn->query($dbconnection,$ins);
    $test="yes";
    $msg="Tax Added Successfully";
    $conn->close($dbconnection);
}


if(isset($_POST['addtaxtoquote'])){
    $taxid = $_POST['addtaxtoquote'];
    $invoiceid = $_POST['invoiceid'];
    $totinvoice = $_POST['totalinvoice'];
    $obj = explode("/",$taxid);
    $tax=$obj[0];
    $val=$obj[1];

    $conn=new Db_connect;
    $dbconnection=$conn->conn();

    $ins="INSERT INTO quote_tax(invid, taxid, dval, damount) VALUES ('$invoiceid','$tax',$val,($val * $totinvoice)/100)";
    $conn->query($dbconnection,$ins);
    $test="yes";
    $msg="Tax Added Successfully";
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
        $test="yes";
        $msg="Tax Created Successfully";
    }else{
        $test="no";
        $msg="Taxid, <b>$taxid</b> , Exists Already";
    }
    $conn->close($dbconnection);
}
/*if(isset($_POST['taxnameedit'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $taxid=mysqli_real_escape_string($dbcon,$_POST['taxid']);
    $taxname=mysqli_real_escape_string($dbcon,$_POST['taxnameedit']);
    $val=mysqli_real_escape_string($dbcon,$_POST['percentage']);
    $status=mysqli_real_escape_string($dbcon,$_POST['status']);

    echo $ins="UPDATE taxconfig SET name='$taxname', val=$val, status='$status', status = '$status' WHERE taxid='$taxid'";
    $conn->query($dbconnection,$ins);
    $test="yes";
    $msg="Tax Updateddd Successfully";
    $conn->close($dbconnection);
}*/

if(isset($_POST['generatequotes'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $custname=mysqli_real_escape_string($dbconnection,$_POST['custname']);
    $cont=mysqli_real_escape_string($dbconnection,$_POST['cont']);
    $invdate=mysqli_real_escape_string($dbconnection,$_POST['invdate']);
    $duedate=mysqli_real_escape_string($dbconnection,$_POST['duedate']);
    $organ=mysqli_real_escape_string($dbconnection,$_POST['organ']);
    $orgcont=mysqli_real_escape_string($dbconnection,$_POST['orgcont']);
    $orgloc=mysqli_real_escape_string($dbconnection,$_POST['orgloc']);

    $pid=$_POST['selprod'];
    $qty=$_POST['qty'];
    $price=$_POST['price'];

    $invid="QOT/".date("Y")."/".date("mdHis");

    $count=COUNT($price);
    $failed=0;
    $success=0;
    $totAmount=0;
    for($i=0; $i < $count; $i++){
        if(!empty($price[$i]) || !empty($qty[$i])){
            $totAmount+=($price[$i] * $qty[$i]);
            $qry="INSERT INTO quotation_details SET invoiceid = '$invid', pid='$pid[$i]', qty=$qty[$i], sprice=$price[$i]";
            $conn->query($dbconnection,$qry);
            $success++;
        }
        else{
            $failed++;
        }
    }
    if($success > 0){
        $qry2="INSERT INTO customer_quotation SET organ='$organ',orgcont='$orgcont',orgloc='$orgloc',invoiceid='$invid', custname='$custname', cont='$cont', invdate = '$invdate', duedate='$duedate',salesperson = '$stfID', totalamount = $totAmount, paid = 0.00, status = 'Inactive', shop = '$branch'";
        $conn->query($dbconnection,$qry2);
        $authentic="yes";
        $msg="Customer Invoice Generated Successfully.";
        header("Location: dashboard.php?viewquotation=$invid");
    }
    $conn->close($dbconnection);
}

//WAREHOUSE PRODUCT TRANSFER
if(isset($_POST['tshopwh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $toshop=mysqli_real_escape_string($dbconnection,$_POST['tshopwh']);
    $ddate=mysqli_real_escape_string($dbconnection,$_POST['whdate']);

    $pid=$_POST['tprodwh'];
    $qty=$_POST['qtywh'];

    $transid="TRNS/".date("Y")."/".date("mdHis");

    $count=COUNT($pid);
    $failed=0;
    $success=0;
    $totAmount=0;
    $qtyExistsCount = 0;
    $qtyInserted = 0;
    $qtyExistsMsg = "<table class='table table-responsive'><thead><tr><td colspan='3'>Following Products Do Not Have The Requested Quantity In Stock</td></tr><tr><th>Product</th><th>Quantity</th><th>Requested</th></tr></thead><tbody>";
    $msg="Products Transferred In Progress.";
    for($i=0; $i < $count; $i++){
        //INSERT PRODUCTS INTO TEMP TABLE
        $dpid = $pid[$i];
        $dqty = $qty[$i];
        //CHECK IF QUANTITY EXISTS ION STOCK
        $chk = "SELECT qty, pname FROM products_master WHERE pid = '$dpid'";
        $chkrun = $conn->query($dbconnection,$chk);
        $chkdata = $conn->fetch($chkrun);
        $oldQty = $chkdata['qty'];
        $pname = $chkdata['pname'];
        if($dqty > $oldQty){
            $qtyExistsCount++;
            $qtyExistsMsg.="<tr><td>$pname</td><td>$oldQty</td><td>$dqty</td></tr>";
        }else{
            $qtyInserted++;
            $ins = "INSERT INTO products_temp(pid, qty, transid, shop) VALUES ($dpid,$dqty,'$transid','$toshop')";
            $conn->query($dbconnection,$ins);
        }
    }

    if($qtyInserted > 0 && $qtyExistsCount == 0){
        $qry2="INSERT INTO transfer_details SET transid='$transid',transdate='$ddate',shop='$toshop',fromshop='WH', status = 'Pending', transferby='$stfID'";
        $conn->query($dbconnection,$qry2);
    }else{
        $qtyExistsMsg.="</tbody></table>";
        $msg = $qtyExistsMsg;

        //DELETE ENTRIES INTO products_temp
        $del = "DELETE FROM products_temp WHERE transid = '$transid'";
        $conn->query($dbconnection,$del);
    }




    //SEND MEMO TO ALL THE ADMINISTRATORS AT THE BRANCH
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid IN (SELECT userid FROM usr_branch WHERE branch = '$toshop')";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Products Have Been Transferred From Warehouse To ".getbranch($toshop)." By ".getstaff($stfID),"Product Transfer");
    }

    $test="yes";
    $conn->close($dbconnection);
}

if(isset($_POST['tshopsh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $toshop=mysqli_real_escape_string($dbconnection,$_POST['tshopsh']);
    $ddate=mysqli_real_escape_string($dbconnection,$_POST['shdate']);

    $pid=$_POST['tprodsh'];
    $qty=$_POST['qtysh'];

    $transid="TRNS/".date("Y")."/".date("mdHis");

    $count=COUNT($pid);
    $failed=0;
    $success=0;
    $totAmount=0;
    $qtyExistsCount = 0;
    $qtyExistsMsg = "";
    for($i=0; $i < $count; $i++){
        //INSERT PRODUCTS INTO TEMP TABLE
        $ins = "INSERT INTO products_temp(pid, qty, transid, shop) VALUES ($pid[$i],$qty[$i],'$transid','$toshop')";
        $conn->query($dbconnection,$ins);

    }
    $qry2="INSERT INTO transfer_details SET transid='$transid',transdate='$ddate',shop='$toshop',fromshop='$branch', status = 'Pending', transferby='$stfID'";
    $conn->query($dbconnection,$qry2);

    //SEND MEMO TO ALL THE ADMINISTRATORS AT THE BRANCH
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid IN (SELECT userid FROM usr_branch WHERE branch = '$toshop')";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Products Have Been Transferred From ".getbranch($branch)." To ".getbranch($toshop)." By ".getstaff($stfID),"Product Transfer");
    }

    $test="yes";
    $msg="Products Transfer In Progress.";
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
    $dbcode = "";

    //CHECK IF BARCODE ALREADY EXISTS
    $chk = "SELECT pname FROM products_master WHERE barcode = '$bcode'";
    $chkrun = $conn->query($dbconnection,$chk);
    $chkdata = $conn->fetch($chkrun);
    if($conn->sqlnum($chkrun) != 0 && !empty($bcode)){
        $dbcode = $chkdata['pname'];
        $test = "no";
        $msg = "Barcode Already Exists For Product, $dbcode";
    }
    else{
        if($conn->sqlnum($chkrun) == 0)
            if(!empty($img)){
                $newname="assets/data/products/".$currDateTime.".jpg";//URL of the image location
                $file = file_put_contents( $newname, file_get_contents($img));
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
        $test = "yes";
        $msg = "Product Added successfully";
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

    if(!empty($img)){
        $newname="assets/data/logo/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $newname, file_get_contents($img));
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
    $test = "yes";
    $msg = "Company Information Updated Successfully";
    $conn->close($dbconnection);
}

if(isset($_POST['cgname'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cgname = mysqli_real_escape_string($dbconnection,strtoupper($_POST['cgname']));
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
        $msg = "Product Category, ".$cgname." created successfully";
    }else{
        $test = "no";
        $msg = "Product Category, ".$cgname." exists";
    }
    $conn->close($dbconnection);
}

if(isset($_POST['adjustprice'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $percentage = mysqli_real_escape_string($dbconnection,strtoupper($_POST['adjustprice']));
    $ptype = mysqli_real_escape_string($dbconnection,strtoupper($_POST['ptype']));
    //$checklist = $_POST['check_list'];
    $decimal = $percentage / 100;

    if(isset($_POST['check_list'])){
        $count=0;
        foreach ($_POST['check_list'] as $selected) {
            $count++;
            $pid = $selected;
            $upd="";
            if($ptype == "ALL"){
                $upd = "UPDATE products_master SET sprice = ((sprice * $decimal)+sprice), cprice = ((cprice * $decimal)+cprice) WHERE pid='$pid'";
            }elseif($ptype == "SPRICE"){
                $upd = "UPDATE products_master SET sprice = ((sprice * $decimal)+sprice) WHERE pid='$pid'";
            }else{
                $upd = "UPDATE products_master SET cprice = ((cprice * $decimal)+cprice) WHERE pid='$pid'";
            }
            $conn->query($dbconnection,$upd);
        }

        if($count > 0){
            //SEND MEMO TO ALL THE ADMINISTRATORS
            $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
            $getadminrun=$conn->query($dbconnection,$getadmin);
            while($data = $conn->fetch($getadminrun)){
                $userid = $data['userid'];
                sendmessage($userid,$ptype." Values Of Products Have Been Updated By ".$percentage." By ".getstaff($stfID),"General Price Adjustments");
            }
        }


        $test = "yes";
        $msg = "Price Adjustment Completed";
    }else{
        $test = "no";
        $msg = "No Products Selected From The List";
    }


    //CHECK IF CATEGORY EXISTS
$conn->close($dbconnection);
}

if(isset($_POST['adjustpriceOLD'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $percentage = mysqli_real_escape_string($dbconnection,strtoupper($_POST['adjustprice']));
    $ptype = mysqli_real_escape_string($dbconnection,strtoupper($_POST['ptype']));
    $decimal = $percentage / 100;
    $upd="";
    if($ptype == "ALL"){
        $upd = "UPDATE products_master SET sprice = ((sprice * $decimal)+sprice), cprice = ((cprice * $decimal)+cprice)";
    }elseif($ptype == "SPRICE"){
        $upd = "UPDATE products_master SET sprice = ((sprice * $decimal)+sprice)";
    }else{
        $upd = "UPDATE products_master SET cprice = ((cprice * $decimal)+cprice)";
    }
    $conn->query($dbconnection,$upd);

    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,$ptype." Values Of Products Have Been Updated By ".$percentage." By ".getstaff($stfID),"General Price Adjustments");
    }

    $test = "yes";
    $msg = "Price Adjustment Completed";

    //CHECK IF CATEGORY EXISTS
$conn->close($dbconnection);
}

//INVOICE PAYMENT
if(isset($_POST['makepayment'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $payamount = mysqli_real_escape_string($dbconnection,strtoupper($_POST['payamount']));
    $paydate = mysqli_real_escape_string($dbconnection,strtoupper($_POST['paydate']));
    $invid = mysqli_real_escape_string($dbconnection,strtoupper($_POST['viewinvoice']));
    //CHECK IF CATEGORY EXISTS

    //GET THE BALANCE
    $bal = "SELECT ((totalamount + totaltax) - paid) AS balance FROM customer_invoice WHERE invoiceid = '$invid'";
    $balrun = $conn->query($dbconnection,$bal);
    $baldata =$conn->fetch($balrun);
    $balance = $baldata['balance'];

    $ins = "INSERT INTO invoice_payment (invoiceid, amount, balance, userid) VALUE ('$invid',$payamount,$balance,'$stfID')";
    $conn->query($dbconnection,$ins);
    if(($balance - $payamount) <= 0){
        $chk = "UPDATE customer_invoice SET paid = (paid + $payamount), status='PAID' WHERE invoiceid='$invid'";
        $chkrun = $conn->query($dbconnection,$chk);
        $test = "yes";
        $msg = "Payment Has Been Completed";
    }else{
        $chk = "UPDATE customer_invoice SET paid = (paid + $payamount) WHERE invoiceid='$invid'";
        $chkrun = $conn->query($dbconnection,$chk);
        $test = "yes";
        $msg = "Part Payment Has Been Completed";
    }
    $conn->close($dbconnection);
}
//BRANCH CREATION
if(isset($_POST['branchcreate']) || isset($_POST['branchedit'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $bid = mysqli_real_escape_string($dbconnection,strtoupper($_POST['branchid']));
    $bname = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bname']));
    $loc = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bloc']));
    $email = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bemail']));
    $contact = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bcontact']));
    $status = mysqli_real_escape_string($dbconnection,strtoupper($_POST['bstatus']));
    if(isset($_POST['branchcreate'])) {
        //CHECK IF CATEGORY EXISTS
        $chk = "SELECT * FROM branches WHERE bname='$bname'";
        $chkrun = $conn->query($dbconnection, $chk);
        if ($conn->sqlnum($chkrun) == 0) {
            $ins = "INSERT INTO branches (bname, bloc, status, email, contact) VALUES ('$bname','$loc','Active','$email','$contact')";
            $conn->query($dbconnection, $ins);

            $test = "yes";
            $msg = "Branch, <b>" . $bname . "</b> created successfully";
            //SEND MEMO TO ALL THE ADMINISTRATORS
            $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
            $getadminrun=$conn->query($dbconnection,$getadmin);
            while($data = $conn->fetch($getadminrun)){
                $userid = $data['userid'];
                sendmessage($userid,"New Branch ".$bname." Has Been Created By ".getstaff($stfID),"Branch Creation");
            }
        } else {
            $test = "no";
            $msg = "Branch, <b>" . $bname . "</b> exists";
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

        $test = "yes";
        $msg = "Branch, <b>" . $bname . "</b> Updated successfully";
    }
    $conn->close($dbconnection);
}

if(isset($_GET['deactcat'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['deactcat'];
    $branch = $_GET['branch'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE category SET status = 'Inactive' WHERE id=$pid";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "Product Category Deactivated";
    $conn->close($dbconnection);
}

if(isset($_GET['catedit'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $cid = $_GET['catid'];
    $cname = mysqli_real_escape_string($dbconnection,strtoupper($_GET['catedit']));
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE category SET cname = '$cname' WHERE id=$cid";
    $chkrun = $conn->query($dbconnection,$chk);
    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Branch ".$cname." Has Been Edited By ".getstaff($stfID),"Branch Edit");
    }
    $test = "yes";
    $msg = "Product Category Updated Successfully";
    $conn->close($dbconnection);
}

if(isset($_GET['actcat'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['actcat'];
    $branch = $_GET['branch'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE category SET status = 'Active' WHERE id=$pid";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "Product Category Activated";
    $conn->close($dbconnection);
}

if(isset($_GET['deactpro'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['deactpro'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE products SET status = 'Inactive' WHERE id=$pid";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "Product Category Deactivated";
    $conn->close($dbconnection);
}
if(isset($_GET['actpro'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['actpro'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE products SET status = 'Active' WHERE id=$pid";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "Product Activated";
    $conn->close($dbconnection);
}
if(isset($_GET['actusers'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['actusers'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE users SET status = 'Active' WHERE userid='$pid'";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "User Activated";
    $conn->close($dbconnection);
}

if(isset($_GET['deactusers'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['deactusers'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE users SET status = 'Inactive' WHERE userid='$pid'";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "User Deactivated";
    $conn->close($dbconnection);
}

if(isset($_GET['actbranch'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['actbranch'];
    $branch = $_GET['curbranch'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE branches SET status = 'Active' WHERE id=$pid";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "Branch, $branch, Has Been Activated";
    $conn->close($dbconnection);
}

if(isset($_GET['deactbranch'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_GET['deactbranch'];
    $branch = $_GET['curbranch'];
    //CHECK IF CATEGORY EXISTS
    $chk = "UPDATE branches SET status = 'Inactive' WHERE id=$pid";
    $chkrun = $conn->query($dbconnection,$chk);

    $test = "yes";
    $msg = "Branch, $branch,  Has Been Deactivated";
    $conn->close($dbconnection);
}

if(isset($_POST['checkoutnew'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['sessionid'];
    $pid = $_POST['productid'];
    $cname = $_POST['cname'];
    $ccont = $_POST['ccontact'];
    $cloc = $_POST['clocation'];

    //CREATE NEW CUSTOMER RECORD
    $ins = "INSERT INTO customers (cid, cname, contact, location, shop) VALUES ('$currDateTime','$cname','$ccont','$cloc','$branch')";
    $conn->query($dbconnection,$ins);

    //MOVE POS RECORDS
    $move = "INSERT INTO pos_sales (pid, cid, userid, sid, qty, shop, cprice, sprice) SELECT pid, '$currDateTime',userid,sid,qty,shop, cprice, sprice FROM pos_temp WHERE sid = '$sid'";
    $conn->query($dbconnection,$move);

    //GET THE TOTAL SALES AND PROFIT MARGIN
    $gettot = "SELECT SUM(sprice * qty) AS totsprice, SUM(cprice * qty) AS totcprice FROM pos_temp WHERE sid = '$sid'";
    $gettotrun = $conn->query($dbconnection,$gettot);
    $gettotdata = $conn->fetch($gettotrun);
    $totsprice = $gettotdata['totsprice'];
    $totcprice = $gettotdata['totcprice'];
    $profit = $totsprice - $totcprice;

    $ins2 = "INSERT INTO sales_summary(sid, tot_sales, tot_cost, profit, userid, shop, cid) VALUES ('$sid',$totsprice,$totcprice,$profit,'$stfID','$branch','$currDateTime')";
    $conn->query($dbconnection,$ins2);

    //REDUCE THE PRODUCT QUANTITY
    $sel = "SELECT pid, qty FROM pos_temp WHERE sid = '$sid'";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $pid = $data['pid'];
        $qty = $data['qty'];

        $upd = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop = '$branch'";
        $conn->query($dbconnection,$upd);
    }

    $test = "yes";
    $msg = "Sales Completed";
    $conn->close($dbconnection);
}

if(isset($_POST['checkoutexist'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['sessionid'];
    $cid = $_POST['cid'];

    //MOVE POS RECORDS
    $move = "INSERT INTO pos_sales (pid, cid, userid, sid, qty, shop, cprice, sprice) SELECT pid, '$cid',userid,sid,qty,shop, cprice, sprice FROM pos_temp WHERE sid = '$sid'";
    $conn->query($dbconnection,$move);

    //GET THE TOTAL SALES AND PROFIT MARGIN
    $gettot = "SELECT SUM(sprice * qty) AS totsprice, SUM(cprice * qty) AS totcprice FROM pos_temp WHERE sid = '$sid'";
    $gettotrun = $conn->query($dbconnection,$gettot);
    $gettotdata = $conn->fetch($gettotrun);
    $totsprice = $gettotdata['totsprice'];
    $totcprice = $gettotdata['totcprice'];
    $profit = $totsprice - $totcprice;

    $ins2 = "INSERT INTO sales_summary(sid, tot_sales, tot_cost, profit, userid, shop, cid) VALUES ('$sid',$totsprice,$totcprice,$profit,'$stfID','$branch','$cid')";
    $conn->query($dbconnection,$ins2);

    //REDUCE THE PRODUCT QUANTITY
    $sel = "SELECT pid, qty FROM pos_temp WHERE sid = '$sid'";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $pid = $data['pid'];
        $qty = $data['qty'];

        $upd = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop = '$branch'";
        $conn->query($dbconnection,$upd);
    }

    $test = "yes";
    $msg = "Sales Completed";
    $conn->close($dbconnection);
}

if(isset($_POST['checkoutskip'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['sessionid'];
    //MOVE POS RECORDS
    $move = "INSERT INTO pos_sales (pid, userid, sid, qty, shop, cprice, sprice) SELECT pid,userid,sid,qty,shop, cprice, sprice FROM pos_temp WHERE sid = '$sid'";
    $conn->query($dbconnection,$move);

    //GET THE TOTAL SALES AND PROFIT MARGIN
    $gettot = "SELECT SUM(sprice * qty) AS totsprice, SUM(cprice * qty) AS totcprice FROM pos_temp WHERE sid = '$sid'";
    $gettotrun = $conn->query($dbconnection,$gettot);
    $gettotdata = $conn->fetch($gettotrun);
    $totsprice = $gettotdata['totsprice'];
    $totcprice = $gettotdata['totcprice'];
    $profit = $totsprice - $totcprice;

    $ins2 = "INSERT INTO sales_summary(sid, tot_sales, tot_cost, profit, userid, shop, cid) VALUES ('$sid',$totsprice,$totcprice,$profit,'$stfID','$branch','$cid')";
    $conn->query($dbconnection,$ins2);

    //REDUCE THE PRODUCT QUANTITY
    $sel = "SELECT pid, qty FROM pos_temp WHERE sid = '$sid'";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $pid = $data['pid'];
        $qty = $data['qty'];

        $upd = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop = '$branch'";
        $conn->query($dbconnection,$upd);
    }

    $test = "yes";
    $msg = "Sales Completed";
    $conn->close($dbconnection);
}

if(isset($_POST['checkoutwh'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $sid = $_POST['sessionid'];
    //MOVE POS RECORDS
    $move = "INSERT INTO pos_sales (pid, userid, sid, qty, shop, cprice, sprice) SELECT pid,userid,sid,qty,shop, cprice, sprice FROM pos_temp WHERE sid = '$sid'";
    $conn->query($dbconnection,$move);

    //GET THE TOTAL SALES AND PROFIT MARGIN
    $gettot = "SELECT SUM(sprice * qty) AS totsprice, SUM(cprice * qty) AS totcprice FROM pos_temp WHERE sid = '$sid'";
    $gettotrun = $conn->query($dbconnection,$gettot);
    $gettotdata = $conn->fetch($gettotrun);
    $totsprice = $gettotdata['totsprice'];
    $totcprice = $gettotdata['totcprice'];
    $profit = $totsprice - $totcprice;

    $ins2 = "INSERT INTO sales_summary(sid, tot_sales, tot_cost, profit, userid, shop, cid) VALUES ('$sid',$totsprice,$totcprice,$profit,'$stfID','WH','')";
    $conn->query($dbconnection,$ins2);

    //REDUCE THE PRODUCT QUANTITY
    $sel = "SELECT pid, qty FROM pos_temp WHERE sid = '$sid'";
    $selrun = $conn->query($dbconnection,$sel);
    while($data = $conn->fetch($selrun)){
        $pid = $data['pid'];
        $qty = $data['qty'];

        $upd = "UPDATE products_master SET qty = (qty - $qty) WHERE pid = '$pid'";
        $conn->query($dbconnection,$upd);

        //INSERT INTO transfer
        //GET PREVIOUS STOCK OF THE PRODUCT
        $get = "SELECT qty FROM products_master WHERE pid = '$pid'";
        $getrun = $conn->query($dbconnection,$get);
        $getdata = $conn->fetch($getrun);
        $prevqty = $getdata['qty'];

        $ins = "INSERT INTO transfers (pid, prev, cur, shop) VALUES ('$pid', $prevqty,$qty,'WH')";
        $conn->query($dbconnection,$ins);
    }

    $test = "yes";
    $msg = "Sales Completed";
    $conn->close($dbconnection);
}

//SHOP TO SHOP TRANSFER
//SHOP TO SHOP TRANSFER
if(isset($_POST['stprod'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['stprod'];
    $toshop = $_POST['toshop'];
    $qty = $_POST['stqty'];
    $shop = $_POST['branch'];

    //THE TRANSFER ID
    $transid="TRNS/".date("Y")."/".date("mdHis");

    //CHECK IF PRODUCT exists
    if($toshop != "WH"){
        //GET PREVIOUS STOCK OF THE PRODUCT
        $get = "SELECT qty FROM products WHERE pid = '$pid' AND shop = '$toshop'";
        $getrun = $conn->query($dbconnection,$get);
        if($conn->sqlnum($getrun) == 0){
            $ins = "INSERT INTO products(pid, qty, status, shop) VALUES ($pid,$qty,'Active','$toshop')";
            $conn->query($dbconnection,$ins);

            $ins2 = "INSERT INTO shop_to_shop(pid, prev, cur, from_shop, to_shop, transid) VALUES ('$pid', 0,$qty,'$shop','$toshop','$transid')";
            $conn->query($dbconnection,$ins2);
        }else{
            $getdata = $conn->fetch($getrun);
            $prevqty = $getdata['qty'];
            //UPDATE product quantity
            $upd = "UPDATE products SET qty = (qty + $qty) WHERE pid = '$pid' AND shop = '$toshop'";
            $conn->query($dbconnection,$upd);

            $ins3 = "INSERT INTO shop_to_shop(pid, prev, cur, from_shop, to_shop, transid) VALUES ('$pid', $prevqty,$qty,'$shop','$toshop','$transid')";
            $conn->query($dbconnection,$ins3);
        }
    }else{
        //GET PREVIOUS STOCK OF THE PRODUCT
        $get = "SELECT qty FROM products_master WHERE pid = '$pid'";
        $getrun = $conn->query($dbconnection,$get);
        $getdata = $conn->fetch($getrun);
        $prevqty = $getdata['qty'];
        //UPDATE product_master quantity
        $upd = "UPDATE products_master SET qty = (qty + $qty) WHERE pid = '$pid'";
        $conn->query($dbconnection,$upd);

        $ins3 = "INSERT INTO shop_to_shop(pid, prev, cur, from_shop, to_shop, transid) VALUES ('$pid', $prevqty,$qty,'$shop','$toshop','$transid')";
        $conn->query($dbconnection,$ins3);
    }


    $upd2 = "UPDATE products SET qty = (qty - $qty) WHERE pid = '$pid' AND shop = '$shop'";
    $conn->query($dbconnection,$upd2);

    $qry2="INSERT INTO shop_transfer_details SET transid='$transid',transdate='$ddate',shop='$toshop'";
    $conn->query($dbconnection,$qry2);

    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Product, ".getproduct($pid)." Has Been Trasnferred To ".getbranch($toshop)." By ".getstaff($stfID),"Shop To Shop Product Transfer");
    }
    $test = "yes";
    $msg = "Product Transfer Successfully To ".$toshop;
    $conn->close($dbconnection);
}

if(isset($_POST['tprod'])){
    $conn=new Db_connect;
    $dbconnection=$conn->conn();
    $pid = $_POST['tprod'];
    $shop = $_POST['tshop'];
    $qty = $_POST['tqty'];
    $whqty = $_POST['drealqty'];
    $whbal = $whqty - $qty;

    //THE TRANSFER ID
    $transid="TRNS/".date("Y")."/".date("mdHis");

    //GET PREVIOUS STOCK OF THE PRODUCT
    $get = "SELECT qty FROM products WHERE pid = '$pid' AND shop = '$shop'";
    $getrun = $conn->query($dbconnection,$get);

    //CHECK IF PRODUCT exists
    if($conn->sqlnum($getrun) == 0){
        $ins = "INSERT INTO products(pid, qty, status, shop) VALUES ($pid,$qty,'Active','$shop')";
        $conn->query($dbconnection,$ins);

        $ins = "INSERT INTO transfers (pid, prev, cur, shop, whqty, whbal, transid) VALUES ('$pid', 0,$qty,'$shop', $whqty, $whbal,'$transid')";
        $conn->query($dbconnection,$ins);
    }else{
        //UPDATE product quantity
        $upd = "UPDATE products SET qty = (qty + $qty) WHERE pid = '$pid' AND shop = '$shop'";
        $conn->query($dbconnection,$upd);

        $getdata = $conn->fetch($getrun);
        $prevqty = $getdata['qty'];
        $ins = "INSERT INTO transfers (pid, prev, cur, shop, whqty, whbal, transid) VALUES ('$pid', $prevqty,$qty,'$shop', $whqty, $whbal,'$transid')";
        $conn->query($dbconnection,$ins);
    }
    //REDUCE THE QUANTITY IN THE STOCK
    $upd2 = "UPDATE products_master SET qty = (qty - $qty) WHERE pid = '$pid'";
    $conn->query($dbconnection,$upd2);


    $qry2="INSERT INTO transfer_details SET transid='$transid',transdate='$ddate',shop='$shop'";
    $conn->query($dbconnection,$qry2);

    //SEND MEMO TO ALL THE ADMINISTRATORS
    $getadmin = "SELECT userid FROM users WHERE access='ADMINISTRATOR' AND userid <> '$stfID'";
    $getadminrun=$conn->query($dbconnection,$getadmin);
    while($data = $conn->fetch($getadminrun)){
        $userid = $data['userid'];
        sendmessage($userid,"Product, ".getproduct($pid)." Has Been Trasnferred To ".getbranch($shop)." By ".getstaff($stfID),"Product Transfer");
    }

    $test = "yes";
    $msg = "Product Transfer Completed";
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

    $sql="";
    if(!empty($img)){
        $newname="assets/data/products/".$currDateTime.".jpg";//URL of the image location
        $file = file_put_contents( $newname, file_get_contents($img));
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

    $test = "yes";
    $msg = "Product Details Have Been Updated";
    $conn->close($dbconnection);
}
?>