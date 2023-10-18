<?php
//error_reporting(0);
/*$curdate = date("Y-m-d H:i:s");
$olddate = new DateTime("2022-10-11 9:08:10");
$datediff = $olddate->diff(new DateTime($curdate));
print $datediff->m;*/

include("plugins/phpexcel/PHPExcel/IOFactory.php");
include("connection/conn.php");
if (!isset($_SESSION['userid'])) {
    header("location: index.php");
    exit(0);
} else {
    $conn=new Db_connect;
    $dbconnection=$conn->conn();

    $stfID = $_SESSION['userid'];
    $branch = $_SESSION['branch'];

    $fname = "";
    $lname = "";
    $mimg = "";
    $access = "";
    //GET THE STAFF DETAILS
    $getstf = "SELECT img, fname, lname, access from users WHERE userid = '$stfID'";
    $getstfrun = $conn->query($dbconnection,$getstf);
    if($conn->sqlnum($getstfrun) != 0){
        $getstfdata = $conn->fetch($getstfrun);
        $fname = $getstfdata['fname'];
        $lname = $getstfdata['lname'];
        $mimg = $getstfdata['img'];
        $access = $getstfdata['access'];
    }

    //CONTROLS THE SHOP BRANCHES
    if(isset($_GET['branch'])){
        $branch = $_GET['branch'];
    }elseif(isset($_POST['branch'])){
        $branch = $_POST['branch'];
    }

    //GET THE COMPANY INFORMATION / DETAILS
    $cname="COMPANY NAME";
    $clogo="assets/images/noimage.png";
    $ctag="";
    $cmail="";
    $caddr="";
    $ccont="";
    $cloc="";

    $getcomp = "SELECT * FROM company";
    $getcomprun = $conn->query($dbconnection,$getcomp);
    if($conn->sqlnum($getcomprun) != 0){
        $getcompdata = $conn->fetch($getcomprun);
        $cname = $getcompdata['cname'];
        $clogo = $getcompdata['clogo'];
        $ccont = $getcompdata['ccont'];
        $cmail = $getcompdata['cmail'];
        $cloc = $getcompdata['cloc'];
        $caddr = $getcompdata['caddr'];
        $ctag = $getcompdata['tag'];
    }
    //GET THE CURRENT URL PAGE
    $URL = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
//UPDATE THE LOG IN
    $updtime = "UPDATE users SET last_login = '$dateTime', last_page = '$URL' WHERE userid = '$stfID'";
    $conn->query($dbconnection,$updtime);

    $conn->close($dbconnection);
}

//PRODUCTS UPLOAD
if(isset($_FILES['contentdoc']['tmp_name'])){
    $file=$_FILES['contentdoc']['tmp_name'];
    //if there was an error uploading the file
    $storagename = date("ymdHis").".txt";
    $newname="assets/data/productsdata/".$storagename;//URL of the image location
    $file = file_put_contents($newname, file_get_contents($file));
    $ddate = date("Y-m-d H:i:s");
    if ($filee = fopen($newname, "r")) {
        while(!feof($filee)) {
            $line = fgets($filee);
            $obj = explode(",",$line);
            //$pid = "20221007".$obj[0];
            $pid = "20221028".str_pad($obj[0],4,"0",STR_PAD_LEFT);
            $pname = $obj[1];
            $qty = $obj[2];
            $cprice = $obj[3];
            $sprice = $obj[4];

            $pid.",".$pname.",".$cprice.",".$sprice;
            print $ins="INSERT INTO products_master(pid,pname,sprice,cprice,qty,pimg,status) VALUES ('$pid','$pname',$sprice,$cprice,$qty,'assets/data/products/noimage.png','ACTIVE')";
            $conn->query($dbconnection,$ins);

        }
        fclose($filee);
    }
}

include("include/process.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<title>Dashboard | <?php echo $cname; ?></title>

	<!--=== CSS ===-->

	<!-- Bootstrap -->
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

	<!-- jQuery UI -->
	<!--<link href="plugins/jquery-ui/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />-->
	<!--[if lt IE 9]>
    <link rel="stylesheet" type="text/css" href="plugins/jquery-ui/jquery.ui.1.10.2.ie.css"/>
	<![endif]-->

	<!-- Theme -->
	<link href="assets/css/main.css" rel="stylesheet" type="text/css" />
	<link href="assets/css/plugins.css" rel="stylesheet" type="text/css" />
	<link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />
	<link href="assets/css/icons.css" rel="stylesheet" type="text/css" />

	<link rel="stylesheet" href="assets/css/fontawesome/font-awesome.min.css">
	<!--[if IE 7]>
    <link rel="stylesheet" href="assets/css/fontawesome/font-awesome-ie7.min.css">
	<![endif]-->
	<!--[if IE 8]>
    <link href="assets/css/ie8.css" rel="stylesheet" type="text/css" />
	<![endif]-->
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>

	<!--=== JavaScript ===-->
	<script type="text/javascript" src="assets/js/libs/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="plugins/jquery-ui/jquery-ui-1.10.2.custom.min.js"></script>

	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="assets/js/libs/lodash.compat.min.js"></script>

	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
		<script src="assets/js/libs/html5shiv.js"></script>
	<![endif]-->

	<!-- Smartphone Touch Events -->
	<script type="text/javascript" src="plugins/touchpunch/jquery.ui.touch-punch.min.js"></script>
	<script type="text/javascript" src="plugins/event.swipe/jquery.event.move.js"></script>
	<script type="text/javascript" src="plugins/event.swipe/jquery.event.swipe.js"></script>

	<!-- General -->
	<script type="text/javascript" src="assets/js/libs/breakpoints.js"></script>
	<script type="text/javascript" src="plugins/respond/respond.min.js"></script> <!-- Polyfill for min/max-width CSS3 Media Queries (only for IE8) -->
	<script type="text/javascript" src="plugins/cookie/jquery.cookie.min.js"></script>
	<script type="text/javascript" src="plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script type="text/javascript" src="plugins/slimscroll/jquery.slimscroll.horizontal.min.js"></script>

	<!-- Page specific plugins -->
	<!-- Charts -->
	<!--[if lt IE 9]>
    <script type="text/javascript" src="plugins/flot/excanvas.min.js"></script>
	<![endif]-->
	<script type="text/javascript" src="plugins/sparkline/jquery.sparkline.min.js"></script>
	<script type="text/javascript" src="plugins/flot/jquery.flot.min.js"></script>
	<script type="text/javascript" src="plugins/flot/jquery.flot.tooltip.min.js"></script>
	<script type="text/javascript" src="plugins/flot/jquery.flot.resize.min.js"></script>
	<script type="text/javascript" src="plugins/flot/jquery.flot.time.min.js"></script>
	<script type="text/javascript" src="plugins/flot/jquery.flot.growraf.min.js"></script>
	<script type="text/javascript" src="plugins/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

	<script type="text/javascript" src="plugins/daterangepicker/moment.min.js"></script>
	<script type="text/javascript" src="plugins/daterangepicker/daterangepicker.js"></script>
	<script type="text/javascript" src="plugins/blockui/jquery.blockUI.min.js"></script>

	<script type="text/javascript" src="plugins/fullcalendar/fullcalendar.min.js"></script>

	<!-- Noty -->
	<script type="text/javascript" src="plugins/noty/jquery.noty.js"></script>
	<script type="text/javascript" src="plugins/noty/layouts/top.js"></script>
	<script type="text/javascript" src="plugins/noty/themes/default.js"></script>

    <!-- Bootbox -->
    <script type="text/javascript" src="plugins/bootbox/bootbox.js"></script>
	<!-- Forms -->
	<script type="text/javascript" src="plugins/uniform/jquery.uniform.min.js"></script>
	<script type="text/javascript" src="plugins/select2/select2.min.js"></script>

	<!-- App -->
	<script type="text/javascript" src="assets/js/app.js"></script>
	<script type="text/javascript" src="assets/js/plugins.js"></script>
	<script type="text/javascript" src="assets/js/plugins.form-components.js"></script>

	<script>
	$(document).ready(function(){
		"use strict";

		App.init(); // Init layout and core plugins
		Plugins.init(); // Init all plugins
		FormComponents.init(); // Init all form-specific plugins
	});
	</script>

	<!-- Demo JS -->
	<script type="text/javascript" src="assets/js/custom.js"></script>
    <script type="text/javascript" src="assets/js/demo/ui_general.js"></script>
	<!--<script type="text/javascript" src="assets/js/demo/pages_calendar.js"></script>
	<script type="text/javascript" src="assets/js/demo/charts/chart_filled_blue.js"></script>
	<script type="text/javascript" src="assets/js/demo/charts/chart_simple.js"></script>-->
    <!-- DataTables -->
    <script type="text/javascript" src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="plugins/datatables/DT_bootstrap.js"></script>
    <script type="text/javascript" src="plugins/datatables/responsive/datatables.responsive.js"></script> <!-- optional -->

    <script type="text/css">
        .modal-backdrop,
        .modal-backdrop.fade.in{
            opacity: 1 !important;
            filter: alpha(opacity=100) !important;
            background: #fff;
            }
        @media print {
            body * {
                visibility: hidden;
            }

            #ptable * {
                visibility: visible;
            }

            #ptable {
                position: absolute;
                width: 100%;
                font-size: small;
                left: 0;
                top: -2%;
            }
            #bottomprint{
                visibility: unset;
            }
        }

        b{
        color: #FF0000;
        }
    </script>
</head>

<body onload="showfeedback('<?php echo getbranch($branch); ?>')">
<input type="hidden"  value="<?php echo $test; ?>" id="test"/>
<input type="hidden"  value="<?php echo $msg; ?>" id="testmsg"/>
<input type="hidden"  value="<?php echo $branch; ?>" id="branch"/>
<input type="hidden"  value="<?php echo $stfID; ?>" id="duserid"/>
	<!-- Header -->
	<header class="header navbar navbar-fixed-top" role="banner">
		<!-- Top Navigation Bar -->
		<div class="container">

			<!-- Only visible on smartphones, menu toggle -->
			<ul class="nav navbar-nav">
				<li class="nav-toggle"><a href="javascript:void(0);" title=""><i class="icon-reorder"></i></a></li>
			</ul>

			<!-- Logo -->
			<a class="navbar-brand" id="dboard1">
				Adwuma<img src="assets/img/logo.png" alt="logo" />
				<strong>Wura</strong>
			</a>
			<!-- /logo -->

			<!-- Sidebar Toggler -->
			<a href="#" class="toggle-sidebar bs-tooltip" data-placement="bottom" data-original-title="Toggle navigation">
				<i class="icon-reorder"></i>
			</a>

			<!-- /Sidebar Toggler -->

			<!-- Top Left Menu -->

			<!-- /Top Left Menu -->

			<!-- Top Right Menu -->
            <ul class="nav navbar-nav navbar-right">
                <!--<li style="padding: 10.0px;"><p style="font-size: xx-large; font-weight: bold; color: #ffffff;" id="selloc"></p></li>-->
                <!-- Notifications -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-warning-sign"></i>
                        <span class="badge" id="activityCount"></span>
                    </a>
                    <ul class="dropdown-menu extended notification" id="activityalert"></ul>
                </li>

                <!-- Messages -->
                <li class="dropdown hidden-xs hidden-sm">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-envelope"></i>
                        <span class="badge" id="memoCount"></span>
                    </a>
                    <ul class="dropdown-menu extended notification" id="memoalert"></ul>
                </li>


                <!-- Project Switcher Button -->
                <li class="dropdown">
                    <a href="#" class="project-switcher-btn dropdown-toggle">
                        <i class="icon-shopping-cart"></i>
                        <span>SHOPS</span>
                    </a>
                </li>

                <!-- User Login Dropdown -->
                <li class="dropdown user">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-male"></i>
                        <span class="username"><?php echo $fname." ".$lname; ?></span>
                        <i class="icon-caret-down small"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="dashboard.php?user_profile&branch=<?php echo $branch; ?>"><i class="icon-user"></i> My Profile</a></li>
                        <li class="divider"></li>
                        <li><a href="index.php"><i class="icon-key"></i> Log Out</a></li>
                    </ul>
                </li>
                <!-- /user login dropdown -->
            </ul>
			<!-- /Top Right Menu -->
		</div>
		<!-- /top navigation bar -->

		<!--=== Project Switcher ===-->
        <div id="project-switcher" class="container project-switcher">
            <div id="scrollbar">
                <div class="handle"></div>
            </div>

            <div id="frame">
                <ul class="project-list">
                    <?php
                        $conn=new Db_connect;
                        $dbconnection=$conn->conn();
                        $getb = "SELECT branch FROM usr_branch WHERE userid = '$stfID' AND status = 'ACTIVE'";
                        $getbrun = $conn->query($dbconnection,$getb);
                        while($data = $conn->fetch($getbrun)){
                            $bch = $data['branch'];
                    ?>
                    <li>
                        <a href="javascript:void(0);" onclick="changebranch('<?php echo $bch; ?>')">
                            <span class="image"><i class="icon-shopping-cart"></i></span>
                            <span class="title"><?php echo getbranch($bch); ?></span>
                        </a>
                    </li>
                    <?php }$conn->close($dbconnection); ?>
                </ul>
            </div> <!-- /#frame -->
        </div>
		 <!-- /#project-switcher -->
	</header> <!-- /.header -->

	<div id="container">
        <?php include("include/sidemenu.php") ?>
		<!-- /Sidebar -->

        <?php
            if(isset($_GET['product_category'])){
            $conn=new Db_connect;
            $dbconnection=$conn->conn();
                $sel = "SELECT * FROM category ORDER BY cname ASC";
                $selrun = $conn->query($dbconnection,$sel);
                $totcount = $conn->sqlnum($selrun);
        ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Products</a>
                                </li>
                                <li class="current">
                                    <a title="">Category</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Product Categories</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Categories</span>
                                        <h3><?php echo $totcount; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <div class="row">
                            <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#category" class="btn btn-danger btn-lg">CREATE CATEGORY </a></div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th data-class="expand">Category Name</th>
                                            <th>Number Of Products</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                            $count = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $count ++;
                                                $cid = $data['id'];
                                                $chk = "SELECT * FROM products_master WHERE cat = '$cid'";
                                                $chkrun = $conn->query($dbconnection,$chk);
                                                $status = $data['status'];
                                                $cname = $data['cname'];

                                        ?>
                                        <tr>
                                            <td><?php echo $count; ?></td>
                                            <td><a class="btn-link" onclick="editcategory(<?php echo $cid; ?>,'<?php echo $cname; ?>')"><?php echo $data['cname']; ?></a></td>
                                            <td><a class="btn-link" onclick="categoryProducts(<?php echo $cid; ?>,'<?php echo $cname; ?>')"><?php echo $conn->sqlnum($chkrun); ?></a></td>
                                            <td><?php echo $data['status']; ?></td>
                                            <td><?php if($status == 'Active'){ ?> <a href="dashboard.php?branch=<?php echo $branch; ?>&product_category&deactcat=<?php echo $cid; ?>" class="btn btn-sm btn-danger">Deactivate</a><?php }else{ ?> <a href="dashboard.php?branch=<?php echo $branch; ?>&product_category&actcat=<?php echo $cid; ?>" class="btn btn-sm btn-success">Activate</a> <?php } ?></td>
                                        </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>
        <?php $conn->close($dbconnection);}elseif(isset($_GET['items_list'])){
                //$sel = "SELECT * FROM products WHERE shop='$branch'";
                $conn=new Db_connect;
                $dbconnection=$conn->conn();
                $sel = "SELECT p.pid, p.status, p.qty, m.pimg, m.pname, m.cat, m.sprice, m.status FROM products p INNER JOIN products_master m ON p.pid = m.pid WHERE p.shop='$branch'";
                $selrun = $conn->query($dbconnection,$sel);
                $totcount = $conn->sqlnum($selrun);
        ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Products</a>
                                </li>
                                <li class="current">
                                    <a title="">Items List</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Products List</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Products</span>
                                        <h3><?php echo $totcount; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <!--<div class="row">
                            <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#product_create" class="btn btn-danger btn-lg">CREATE PRODUCT </a></div>
                        </div>-->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Image</th>
                                            <th data-class="expand">Product Name</th>
                                            <th>Category</th>
                                            <th data-hide="phone">Selling Price</th>
                                            <th data-hide="phone">Quantity</th>
                                            <th data-hide="phone,tablet">Status</th>
                                            <!--<th data-hide="phone,tablet">Action</th>-->
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                        $count = 0;
                                        $totalsprice = 0;
                                        while($data = $conn->fetch($selrun)){
                                            $count++;
                                            $status = $data['status'];
                                            $pid = $data['pid'];
                                            $qty = $data['qty'];
                                            $totalsprice+=$data['sprice'];

                                            $color = "#000000";
                                            if($qty <= 0){
                                                $color = "#F00";
                                            }

                                            if($status == "INACTIVE"){
                                                $color = "#99B3AE";
                                            }
                                            ?>
                                            <tr style="color: <?php echo $color; ?>;">
                                                <td><?php echo $count; ?></td>
                                                <td><img src="<?php echo $data['pimg']; ?>" class="img-responsive img-rounded" style="width: 50px; height: 50px" /></td>
                                                <td><?php echo $data['pname']; ?></td>
                                                <td><?php echo getcat($data['cat']); ?></td>
                                                <td><?php echo $data['sprice']; ?></td>
                                                <td><?php echo $qty; ?></td>
                                                <td><span class="label label-success"><?php echo $data['status']; ?></span></td>
                                                <!--<td><?php if($status == 'Active'){ ?> <a href="dashboard.php?items_list&deactpro=<?php echo $pid; ?>" class="btn btn-sm btn-danger">Deactivate</a><?php }else{ ?> <a href="dashboard.php?items_list&actpro=<?php echo $pid; ?>" class="btn btn-sm btn-success">Activate</a> <?php } ?></td>-->
                                            </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Selling Price</span>
                                            <h3>GHS <?php echo $totalsprice; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>
        <?php $conn->close($dbconnection);}elseif(isset($_GET['salesreport'])){
            $conn=new Db_connect;
            $dbconnection=$conn->conn();
                $shop = $_GET['salesreport'];
                $user = $_GET['salesofficer'];
                $sdate = $_GET['sdate'];
                $startdate = $sdate." 00:00:00";
                $edate = $_GET['edate'];
                $enddate = $edate." 23:59:59";
                $sel = "";
                if($shop == "All" && $user == "All"){
                    $sel = "SELECT s.tot_tax, s.sid, s.tot_sales, s.tot_cost, s.profit, s.shop, s.transdate, s.cid, u.fname, u.lname FROM sales_summary s INNER JOIN users u ON s.userid = u.userid WHERE transdate BETWEEN '$startdate' AND '$enddate' ORDER BY transdate DESC";
                }elseif($shop == "All" && $user != "All"){
                    $sel = "SELECT s.tot_tax, s.sid, s.tot_sales, s.tot_cost, s.profit, s.shop, s.transdate, s.cid, u.fname, u.lname FROM sales_summary s INNER JOIN users u ON s.userid = u.userid WHERE s.userid ='$user' AND transdate BETWEEN '$startdate' AND '$enddate' ORDER BY transdate DESC";
                }elseif($shop != "All" && $user == "All"){
                    $sel = "SELECT s.tot_tax, s.sid, s.tot_sales, s.tot_cost, s.profit, s.shop, s.transdate, s.cid, u.fname, u.lname FROM sales_summary s INNER JOIN users u ON s.userid = u.userid WHERE s.shop ='$shop' AND transdate BETWEEN '$startdate' AND '$enddate' ORDER BY transdate DESC";
                }else{
                    $sel = "SELECT s.tot_tax, s.sid, s.tot_sales, s.tot_cost, s.profit, s.shop, s.transdate, s.cid, u.fname, u.lname FROM sales_summary s INNER JOIN users u ON s.userid = u.userid WHERE s.shop ='$shop' AND s.userid = '$user' AND transdate BETWEEN '$startdate' AND '$enddate' ORDER BY transdate DESC";
                }
                $selrun = $conn->query($dbconnection,$sel);
                $totcount = $conn->sqlnum($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Point Of Sale</a>
                                </li>
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Report</a>
                                </li>
                                <li class="current">
                                    <a title="">Sales Report</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <!--<div class="row">
                            <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#product_create" class="btn btn-danger btn-lg">CREATE PRODUCT </a></div>
                        </div>-->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-3">
                                        <table>
                                            <tr>
                                                <th>USER:</th>
                                                <td><?php echo $user; ?></td>
                                            </tr>
                                            <tr>
                                                <th>SHOP:</th>
                                                <td><?php echo $shop; ?></td>
                                            </tr>
                                            <tr>
                                                <th>START DATE:</th>
                                                <td><?php echo $sdate; ?></td>
                                            </tr>
                                            <tr>
                                                <th>END DATE:</th>
                                                <td><?php echo $edate; ?></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive">
                                        <thead>
                                        <tr><th colspan="9"><p style="color: #ff630d; font-weight: bold; font-size: large; text-align: center">SALES REPORT</p></th></tr>
                                        <tr>
                                            <th>#</th>
                                            <th data-class="expand">Session ID</th>
                                            <th>Sales Officer</th>
                                            <th data-hide="phone">Total Sales <b>(S)</b></th>
                                            <th data-hide="phone">Total Tax<b>(T)</b></th>
                                            <?php if($access == "ADMINISTRATOR"){ ?><th data-hide="phone">Total Cost Price<b>(C)</b></th>
                                            <th data-hide="phone">Total Profit<b>(P = [ S-C-T ])</b></th><?php } ?>
                                            <th data-hide="phone">Shop</th>
                                            <th data-hide="phone">Transaction Date</th>
                                            <th data-hide="phone">View Slip</th>
                                            <!--<th data-hide="phone,tablet">Action</th>-->
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                        $count = 0;
                                        $overallsprice = 0;
                                        $overallcprice = 0;
                                        $overallprofit = 0;
                                        $overalltax = 0;
                                        if($totcount == 0){
                                            ?>
                                            <tr>
                                                <td colspan="7">NO RECORDS FOUND</td>
                                            </tr>
                                        <?php }else{
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                                $overallsprice = $overallsprice + $data['tot_sales'];
                                                $overallcprice = $overallcprice + $data['tot_cost'];
                                                $overallprofit = $overallprofit + $data['profit'];
                                                $overalltax = $overalltax + $data['tot_tax'];
                                                $sid = $data['sid'];
                                                ?>
                                                <tr>
                                                    <td><?php echo $count; ?></td>
                                                    <td><a onclick="getsalesdetails('<?php echo $sid; ?>')"><?php echo $sid; ?></a></td>
                                                    <td><?php echo $data['fname']." ".$data['lname']; ?></td>
                                                    <td><?php echo $data['tot_sales']; ?></td>
                                                    <td><?php echo $data['tot_tax']; ?></td>
                                                    <?php if($access == "ADMINISTRATOR"){ ?><td><?php echo $data['tot_cost']; ?></td>
                                                    <td><?php echo $data['profit']; ?></td><?php } ?>
                                                    <td><?php echo getbranch($data['shop']); ?></td>
                                                    <td><?php echo date("d M, Y H:i:s", strtotime(date($data['transdate']))); ?></td>
                                                    <td><a href="dashboard.php?viewslip=<?php echo $sid; ?>">View Slip</a></td>
                                                </tr>
                                            <?php }} ?>
                                            <tr style="color: #ff630d; font-weight: bold; font-size: medium">
                                                <?php if($access == "ADMINISTRATOR"){ ?><td>&nbsp;</td><td>&nbsp;</td><td>TOTAL (GHS)</td><td><?php echo number_format($overallsprice, 2, '.', ','); ?></td><td><?php echo number_format($overalltax, 2, '.', ','); ?></td><td><?php echo number_format($overallcprice, 2, '.', ','); ?></td><td><?php echo number_format($overallprofit, 2, '.', ','); ?></td><?php }else{ ?>
                                                <td>&nbsp;</td><td>&nbsp;</td><td>TOTAL (GHS)</td><td><?php echo number_format($overallsprice + $overalltax, 2, '.', ','); ?></td><td><?php echo number_format($overalltax, 2, '.', ','); ?></td><td>&nbsp;</td><td>&nbsp;</td><?php } ?>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>

            <?php $conn->close($dbconnection);}elseif(isset($_GET['user_sales_report'])){
            $conn=new Db_connect;
            $dbconnection=$conn->conn();
            $user = $_GET['user_sales_report'];
            $sdate = $_GET['sdate'];
            $startdate = $sdate." 00:00:00";
            $edate = $_GET['edate'];
            $enddate = $edate." 23:59:59";
            $sel = "";
            if($user == "All") {
                $sel = "SELECT SUM(tot_sales) AS tsprice, SUM(tot_cost) AS tcprice, SUM(tot_tax) AS ttax, SUM(profit) AS tprofit, CAST(transdate AS DATE) AS ddate FROM sales_summary WHERE transdate BETWEEN '$startdate' AND '$enddate' GROUP BY ddate";
            }else{
                $sel = "SELECT SUM(tot_sales) AS tsprice, SUM(tot_cost) AS tcprice, SUM(tot_tax) AS ttax, SUM(profit) AS tprofit, CAST(transdate AS DATE) AS ddate FROM sales_summary WHERE userid = '$user' AND transdate BETWEEN '$startdate' AND '$enddate' GROUP BY ddate";
            }
            $selrun = $conn->query($dbconnection,$sel);
            ?>
            <div id="content">
                <div class="container">
                    <!-- Breadcrumbs line -->
                    <div class="crumbs">
                        <ul id="breadcrumbs" class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a>Point Of Sale</a>
                            </li>
                            <li>
                                <i class="icon-home"></i>
                                <a>Report</a>
                            </li>
                            <li class="current">
                                <a title="">User Sales Summary Report</a>
                            </li>
                        </ul>
                    </div>
                    <!-- /Breadcrumbs line -->

                    <!--=== Page Header ===-->
                    <!-- /Page Header -->

                    <!--=== Page Content ===-->
                    <!--=== Statboxes ===-->
                    <div class="row row-bg"></div> <!-- /.row -->
                    <!--<div class="row">
                        <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#product_create" class="btn btn-danger btn-lg">CREATE PRODUCT </a></div>
                    </div>-->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-3">
                                    <table>
                                        <tr>
                                            <th>USER:</th>
                                            <td><?php if($user != "All"){echo getstaff($user);}else{echo "All";} ?></td>
                                        </tr>
                                        <tr>
                                            <th>START DATE:</th>
                                            <td><?php echo $sdate; ?></td>
                                        </tr>
                                        <tr>
                                            <th>END DATE:</th>
                                            <td><?php echo $edate; ?></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="widget-content no-padding">
                                <table class="table table-striped table-bordered table-hover table-checkable table-responsive">
                                    <thead>
                                    <tr><th colspan="9"><p style="color: #ff630d; font-weight: bold; font-size: large; text-align: center">USER SALES SUMMARY REPORT</p></th></tr>
                                    <tr>
                                        <th>#</th>
                                        <th data-class="expand">Date</th>
                                        <th>Total Sales</th>
                                        <th>Total Taxes</th>
                                        <th>Total Cost</th>
                                        <th>Profit</th>
                                        <!--<th data-hide="phone,tablet">Action</th>-->
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php
                                    $count = 0;
                                    $overallsprice = 0;
                                    $overallcprice = 0;
                                    $overallprofit = 0;
                                    $overalltax = 0;
                                    while($data = $conn->fetch($selrun)){
                                        $count++;
                                        $overallcprice+=$data['tcprice'];
                                        $overallsprice+=$data['tsprice'];
                                        $overallprofit+=$data['tprofit'];
                                        $overalltax+=$data['ttax'];
                                        ?>

                                        <tr>
                                            <td><?php echo $count; ?></td>
                                            <td><?php echo $data['ddate']; ?></td>
                                            <td><?php echo $data['tsprice']; ?></td>
                                            <td><?php echo $data['ttax']; ?></td>
                                            <td><?php echo $data['tcprice']; ?></td>
                                            <td><?php echo $data['tprofit']; ?></td>
                                        </tr>
                                    <?php } ?>
                                    <tr style="color: #ff630d; font-weight: bold; font-size: medium">
                                        <td>&nbsp;</td><td>TOTAL (GHS)</td><td><?php echo number_format($overallsprice, 2, '.', ','); ?></td><td><?php echo number_format($overalltax, 2, '.', ','); ?></td><td><?php echo number_format($overallcprice, 2, '.', ','); ?></td><td><?php echo number_format($overallprofit, 2, '.', ','); ?></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /Page Content -->
                </div>
                <!-- /.container -->

            </div>

        <?php $conn->close($dbconnection);}elseif(isset($_GET['salesummaryreport'])){
            $conn=new Db_connect;
            $dbconnection=$conn->conn();
            $shop = $_GET['salesummaryreport'];
            $sdate = $_GET['sdate'];
            $startdate = $sdate." 00:00:00";
            $edate = $_GET['edate'];
            $enddate = $edate." 23:59:59";
            $sel = "";
            if($shop == "All") {
                $sel = "SELECT SUM(tot_sales) AS tsprice, SUM(tot_cost) AS tcprice, SUM(profit) AS tprofit, SUM(tot_tax) AS ttax, CAST(transdate AS DATE) AS ddate FROM sales_summary WHERE transdate BETWEEN '$startdate' AND '$enddate' GROUP BY ddate";
            }else{
                $sel = "SELECT SUM(tot_sales) AS tsprice, SUM(tot_cost) AS tcprice, SUM(profit) AS tprofit, SUM(tot_tax) AS ttax, CAST(transdate AS DATE) AS ddate FROM sales_summary WHERE shop = '$shop' AND transdate BETWEEN '$startdate' AND '$enddate' GROUP BY ddate";
            }
            $selrun = $conn->query($dbconnection,$sel);
            ?>
            <div id="content">
                <div class="container">
                    <!-- Breadcrumbs line -->
                    <div class="crumbs">
                        <ul id="breadcrumbs" class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a>Point Of Sale</a>
                            </li>
                            <li>
                                <i class="icon-home"></i>
                                <a>Report</a>
                            </li>
                            <li class="current">
                                <a title="">Sales Summary Report</a>
                            </li>
                        </ul>
                    </div>
                    <!-- /Breadcrumbs line -->

                    <!--=== Page Header ===-->
                    <!-- /Page Header -->

                    <!--=== Page Content ===-->
                    <!--=== Statboxes ===-->
                    <div class="row row-bg"></div> <!-- /.row -->
                    <!--<div class="row">
                        <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#product_create" class="btn btn-danger btn-lg">CREATE PRODUCT </a></div>
                    </div>-->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-3">
                                    <table>
                                        <tr>
                                            <th>SHOP:</th>
                                            <td><?php if($shop != "All"){echo getbranch($shop);}else{echo "All";} ?></td>
                                        </tr>
                                        <tr>
                                            <th>START DATE:</th>
                                            <td><?php echo $sdate; ?></td>
                                        </tr>
                                        <tr>
                                            <th>END DATE:</th>
                                            <td><?php echo $edate; ?></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="widget-content no-padding">
                                <table class="table table-striped table-bordered table-hover table-checkable table-responsive">
                                    <thead>
                                    <tr><th colspan="9"><p style="color: #ff630d; font-weight: bold; font-size: large; text-align: center">SALES SUMMARY REPORT</p></th></tr>
                                    <tr>
                                        <th>#</th>
                                        <th data-class="expand">Date</th>
                                        <th>Total Sales <b>(S)</b></th>
                                        <th>Total Taxes <b>(T)</b></th>
                                        <th>Total Costs <b>(C)</b></th>
                                        <th>Total Profit <b>(P = [ S - T - C])</b></th>
                                        <!--<th data-hide="phone,tablet">Action</th>-->
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php
                                    $count = 0;
                                    $overallsprice = 0;
                                    $overallcprice = 0;
                                    $overallprofit = 0;
                                    $overalltax = 0;
                                    while($data = $conn->fetch($selrun)){
                                        $count++;
                                        $overallcprice+=$data['tcprice'];
                                        $overallprofit+=$data['tprofit'];
                                        $overalltax+=$data['ttax'];
                                        $overallsprice+=$data['tsprice'];
                                    ?>

                                        <tr>
                                            <td><?php echo $count; ?></td>
                                            <td><?php echo $data['ddate']; ?></td>
                                            <td><?php echo $data['tsprice']; ?></td>
                                            <td><?php echo $data['ttax']; ?></td>
                                            <td><?php echo $data['tcprice']; ?></td>
                                            <td><?php echo $data['tprofit']; ?></td>
                                        </tr>
                                        <?php } ?>
                                    <tr style="color: #ff630d; font-weight: bold; font-size: medium">
                                        <td>&nbsp;</td><td>TOTAL (GHS)</td><td><?php echo number_format($overallsprice, 2, '.', ','); ?></td><td><?php echo number_format($overalltax, 2, '.', ','); ?></td><td><?php echo number_format($overallcprice, 2, '.', ','); ?></td><td><?php echo number_format($overallprofit, 2, '.', ','); ?></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /Page Content -->
                </div>
                <!-- /.container -->

            </div>

        <?php $conn->close($dbconnection);}elseif(isset($_GET['viewslip'])){
            $conn=new Db_connect;
            $dbconnection=$conn->conn();
                    $sid = $_GET['viewslip'];
                    $sel = "SELECT userid FROM sales_summary WHERE sid = '$sid'";
                    $selrun = $conn->query($dbconnection,$sel);
                    $seldata = $conn->fetch($selrun);

            ?>
            <div id="content">
                <div class="container" style="margin: 20px;">
                    <div class="row" style="font-family: monospace, serif" id="ptable">
                        <div class="well col-xs-10 col-sm-10 col-md-6 col-xs-offset-1 col-sm-offset-1 col-md-offset-3">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <address>
                                        <strong><?php echo $cname; ?></strong>
                                        <br>
                                        <?php echo $caddr; ?>
                                        <br>
                                        <?php echo $cloc; ?>
                                        <br>
                                        <abbr title="Phone">P:</abbr> <?php echo $ccont; ?>
                                    </address>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6 text-left">
                                    <p>
                                        <em>Date: <?php echo date("d M, Y"); ?></em>
                                    </p>
                                    <p>
                                        <em>#:<?php echo strtoupper($sid); ?></em>
                                    </p>
                                    <p>
                                        <em>Officer:<?php echo getstaff($seldata['userid']); ?></em>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="text-center">
                                    <h1>Receipt</h1>
                                </div>
                                </span>
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Quantity</th>
                                        <th class="text-center">Price</th>
                                        <th class="text-center">Total</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php
                                    $sel = "SELECT pid, qty, sprice FROM pos_sales WHERE sid = '$sid'";
                                    $selrun = $conn->query($dbconnection,$sel);
                                    $overalltotal = 0;
                                    while($saledata = $conn->fetch($selrun)){
                                        $overalltotal+=($saledata['qty'] * $saledata['sprice']);
                                        ?>
                                        <tr>
                                            <td class="col-md-9"><em><?php echo getproduct($saledata['pid']); ?></em></h4></td>
                                            <td class="col-md-1" style="text-align: center"> <?php echo $saledata['qty'] ?> </td>
                                            <td class="col-md-1 text-center"><?php echo $saledata['sprice'] ?></td>
                                            <td class="col-md-1 text-center"><?php echo ($saledata['qty'] * $saledata['sprice']) ?></td>
                                        </tr>
                                    <?php } ?>
                                    <tr style="font-weight: bold;">
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>TOTAL</td>
                                        <td class="col-md-1 text-center"><?php echo number_format($overalltotal,2); ?></td>
                                    </tr>

                                    <!--TAX COMPONENT -->
                                    <?php
                                    $seltax = "SELECT taxid, dval FROM pos_tax WHERE sid = '$sid'";
                                    $seltaxrun = $conn->query($dbconnection,$seltax);
                                    $overalltax = 0;
                                    while($saletaxdata = $conn->fetch($seltaxrun)){
                                        $dtax=($overalltotal * $saletaxdata['dval']) / 100;
                                        $overalltax+=$dtax;
                                        ?>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="2"><?php echo gettax($saletaxdata['taxid'])." [".$saletaxdata['dval']."%]"; ?></td>
                                            <td><?php echo number_format($dtax,2) ?></td>
                                        </tr>
                                    <?php } ?>
                                    <tr>
                                        <td>   </td>
                                        <td>   </td>
                                        <td class="text-right">
                                            <p>
                                                <strong>Subtotal: </strong>
                                            </p>
                                        </td>
                                        <td class="text-center">
                                            <p>
                                                <strong><?php echo number_format($overalltotal + $overalltax,2); ?></strong>
                                            </p>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-md-12" style="font-style: italic; font-size: small; text-align: center"><?php echo $ctag; ?></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" align="center">
                            <button type="button" class="btn btn-default btn-lg heading-btn" href="javascript:void(0);" onclick="javascript:window.print();"><i class="icon-print position-left"></i> Print</button>
                        </div>
                    </div>
                    <!-- /.container -->
                </div>
            </div>

        <?php $conn->close($dbconnection); }elseif(isset($_GET['customers'])){
            $conn=new Db_connect;
            $dbconnection=$conn->conn();
                $sel = "";
                if($access == "ADMINISTRATOR"){
                    $sel = "SELECT * FROM customers ORDER BY cname ASC";
                }else{
                    $sel = "SELECT * FROM customers WHERE shop='$branch' ORDER BY cname ASC";
                }

                $selrun = $conn->query($dbconnection,$sel);
                $totcount = $conn->sqlnum($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Customers</a>
                                </li>
                                <li class="current">
                                    <a title="">Customers</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Customers List</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Customers</span>
                                        <h3><?php echo $totcount; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <!--<div class="row">
                            <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#product_create" class="btn btn-danger btn-lg">CREATE PRODUCT </a></div>
                        </div>-->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th data-class="expand">Contact</th>
                                            <th>Location</th>
                                            <th>Branch</th>
                                            <!--<th data-hide="phone,tablet">Action</th>-->
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                            $count = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                        ?>
                                            <tr>
                                                <td><?php echo $count; ?></td>
                                                <td><?php echo $data['cname']; ?></td>
                                                <td><?php echo $data['contact']; ?></td>
                                                <td><?php echo $data['location']; ?></td>
                                                <td><?php echo $data['shop']; ?></td>
                                              </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>

            <?php $conn->close($dbconnection);}elseif(isset($_GET['user_profile'])){?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">
                                <div class="page-title">
                                    <h3><?php echo $fname." ".$lname; ?></h3>
                                </div>

                                <!-- Page Stats -->
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Inline Tabs ===-->
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- Tabs-->
                                    <div class="tabbable tabbable-custom tabbable-full-width">
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a href="#tab_overview" data-toggle="tab">Account Management</a></li>
                                        </ul>
                                        <div class="tab-content row">
                                            <!--=== Overview ===-->
                                            <div class="tab-pane active" id="tab_overview">
                                                <div class="col-md-3">
                                                    <div class="list-group">
                                                        <li class="list-group-item no-padding">
                                                            <div align="center"><img src="<?php echo $mimg; ?>" alt="user image" class="img-responsive" /></div>
                                                        </li>
                                                        <a href="javascript:void(0);" class="list-group-item">First Name: <?php echo $fname; ?></a>
                                                        <a href="javascript:void(0);" class="list-group-item">Last Name: <?php echo $lname; ?></a>
                                                        <a href="javascript:void(0);" class="list-group-item">Access: <?php echo $access; ?></a>
                                                        <a href="javascript:void(0);" class="list-group-item">Branch: <?php echo getbranch($branch); ?></a>
                                                    </div>
                                                </div>

                                                <div class="col-md-9">
                                                    <form class="form-horizontal" method="post">

                                                        <div class="col-md-12 form-vertical no-margin">
                                                            <div class="widget">
                                                                <div class="widget-header">
                                                                    <h4>Settings</h4>
                                                                </div>
                                                                <div class="widget-content">
                                                                    <div class="row">
                                                                        <div class="col-md-4 col-lg-2">
                                                                            <strong class="subtitle padding-top-10px">Permanent UserID</strong>
                                                                        </div>

                                                                        <div class="col-md-8 col-lg-10">
                                                                            <div class="form-group">
                                                                                <label class="control-label padding-top-10px">User ID:</label>
                                                                                <input type="text" name="chvoka" class="form-control" value="<?php echo $stfID; ?>" readonly="readonly">
                                                                            </div>
                                                                        </div>
                                                                    </div> <!-- /.row -->
                                                                    <div class="row">
                                                                        <div class="col-md-4 col-lg-2">
                                                                            <strong class="subtitle">Change password</strong>
                                                                            <p class="text-muted">Generate new password</p>
                                                                        </div>

                                                                        <div class="col-md-8 col-lg-10">
                                                                            <div class="form-group">
                                                                                <label class="control-label">Old password:</label>
                                                                                <input type="password" name="old_password" class="form-control" placeholder="Leave empty for no password-change">
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <label class="control-label">New password:</label>
                                                                                <input type="password" name="new_password" class="form-control" name="newPass" onkeyup="checkpass(this.value)" id="npass" placeholder="Leave empty for no password-change">
                                                                                <div class="hidden" id="simg"><img src="assets/images/pnotify/success.png" /></div>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <label class="control-label">Repeat new password:</label>
                                                                                <input type="password" name="new_password_repeat" id="rpass" onkeyup="confpass()" class="form-control" placeholder="Leave empty for no password-change">
                                                                                <div class="hidden" id="ssimg"><img src="assets/images/pnotify/success.png" /></div>
                                                                            </div>
                                                                        </div>
                                                                    </div> <!-- /.row -->
                                                                </div> <!-- /.widget-content -->
                                                            </div> <!-- /.widget -->

                                                            <div class="form-actions hidden"  id="chsub">
                                                                <input type="submit" value="Update Account" class="btn btn-primary pull-right">
                                                            </div>
                                                        </div> <!-- /.col-md-12 -->
                                                    </form>
                                                </div> <!-- /.col-md-9 -->
                                            </div>
                                            <!-- /Overview -->
                                            <!-- /Edit Account -->
                                        </div> <!-- /.tab-content -->
                                    </div>
                                    <!--END TABS-->
                                </div>
                            </div>

                <?php }elseif(isset($_GET['items_master'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                $sel = "SELECT * FROM products_master ORDER BY pname ASC";
                $selrun = $conn->query($dbconnection,$sel);
                $totcount = $conn->sqlnum($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Products</a>
                                </li>
                                <li class="current">
                                    <a title="">Items List</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Products List</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Products</span>
                                        <h3><?php echo $totcount; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <div class="row">
                            <div class="col-md-2" style="padding: 10px;"><a data-toggle="modal" href="#product_create" class="btn btn-danger btn-lg"><span class="icon icon-plus-sign-alt"></span>&nbsp;CREATE</a></div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Image</th>
                                            <th data-class="expand">Product Name</th>
                                            <th data-hide="phone">Category</th>
                                            <th>Selling Price</th>
                                            <th>Cost Price</th>
                                            <th>Quantity</th>
                                            <th data-hide="phone">Barcode</th>
                                            <th data-hide="phone">Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                        $count = 0;
                                        $totalsprice = 0;
                                        $totalcprice = 0;
                                        while($data = $conn->fetch($selrun)){
                                            $count++;
                                            $status = $data['status'];
                                            $pid = $data['pid'];
                                            $qty = $data['qty'];
                                            $totalsprice+= ($data['sprice'] * $data['qty']);
                                            $totalcprice+= ($data['cprice'] * $data['qty']);
                                            $color = "#000";
                                            if($qty <= 0){
                                                $color = "#F00";
                                            }

                                            if($status == "INACTIVE"){
                                                $color = "#99B3AE";
                                            }
                                            ?>
                                            <tr style="color: <?php echo $color; ?>">
                                                <td><?php echo $count; ?></td>
                                                <td><img src="<?php echo $data['pimg']; ?>" class="img-responsive img-rounded" style="width: 50px; height: 50px" /></td>
                                                <td><?php echo $data['pname']; ?></td>
                                                <td><?php echo getcat($data['cat']); ?></td>
                                                <td><?php echo $data['sprice']; ?></td>
                                                <td><?php echo $data['cprice']; ?></td>
                                                <td><?php echo $qty; ?></td>
                                                <td><?php echo $data['barcode']; ?></td>
                                                <td><?php echo $data['status']; ?></td>
                                                <td><a onclick="updateprod('<?php echo $pid; ?>')" class="btn btn-lg btn-primary icon icon-upload-alt">&nbsp;Update</a></td>
                                            </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                        <div class="row">
                            <div class="col-md-12">
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Selling Price</span>
                                            <h3>GHS <?php echo number_format($totalsprice,2); ?></h3>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="summary">
                                            <span>Total Cost Price</span>
                                            <h3>GHS <?php echo number_format($totalcprice,2); ?></h3>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- /.container -->

                </div>

            <?php $conn->close($dbconnection);}elseif(isset($_GET['invoices'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                $sel = "SELECT invoiceid, invdate, salesperson, totalamount, totaltax, paid, status FROM customer_invoice WHERE shop = '$branch' ORDER BY created_date DESC";
                $selrun = $conn->query($dbconnection,$sel);
                $selnum = $conn->sqlnum($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Customer Invoices</a>
                                </li>
                                <li class="current">
                                    <a title="">Invoices</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <div class="row">
                                    <div class="col-md-12" style="padding: 10px;"><a onclick="invoicetype('invoice')" class="btn btn-danger btn-lg">CREATE INVOICE </a></div>
                                </div>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Invoices</span>
                                        <h3 align="center"><?php echo $selnum; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <!--<th>Image</th>-->
                                            <th>Invoice #</th>
                                            <th>Invoice Date</th>
                                            <th>Sales Amount</th>
                                            <th>Tax Amount</th>
                                            <th>Paid</th>
                                            <th>Balance</th>
                                            <th>Status</th>
                                            <th>Sales Person</th>


                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                        $count = 0;
                                        $totalamount = 0;
                                        $totalpaid = 0;
                                        $totaltax=0;
                                        while($data = $conn->fetch($selrun)){
                                            $count++;
                                            $totalamount+=$data['totalamount']+$data['totaltax'];
                                            $totalpaid+=$data['paid'];
                                            $totaltax+=$data['totaltax'];
                                            ?>
                                            <tr>
                                                <td><?php echo $count; ?></td>
                                                <td><a href="dashboard.php?viewinvoice=<?php echo $data['invoiceid']; ?>&branch=<?php echo $branch; ?>"><?php echo $data['invoiceid']; ?></a></td>
                                                <td><?php echo $data['invdate']; ?></td>
                                                <td><?php echo number_format($data['totalamount'] + $data['totaltax'],2); ?></td>
                                                <td><?php echo number_format($data['totaltax'],2); ?></td>
                                                <td><?php echo number_format($data['paid'],2); ?></td>
                                                <td><?php echo number_format((($data['totalamount'] + $data['totaltax']) - $data['paid']),2); ?></td>
                                                <td><?php echo $data['status']; ?></td>
                                                <td><?php echo getstaff($data['salesperson']); ?></td>
                                            </tr>
                                        <?php } ?>
                                        <tr style="font-weight: bold; font-size: medium;">
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>TOTAL</td>
                                            <td><?php echo number_format($totalamount,2); ?></td>
                                            <td><?php echo number_format($totaltax,2); ?></td>
                                            <td><?php echo number_format($totalpaid,2); ?></td>
                                            <td><?php echo number_format(($totalamount - $totalpaid),2); ?></td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>

            <?php $conn->close($dbconnection);}elseif(isset($_GET['quotations'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $sel = "SELECT * FROM customer_quotation WHERE salesperson = '$stfID' ORDER BY created_date DESC";
                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Customer Invoices</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Quotations</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">
                                <div class="page-title">
                                    <div class="row">
                                        <div class="col-md-12" style="padding: 10px;"><a onclick="invoicetype('quotation')" class="btn btn-danger btn-lg">CREATE QUOTE </a></div>
                                    </div>
                                </div>

                                <!-- Page Stats -->
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Quotations</span>
                                            <h3 align="center"><?php echo $selnum; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="widget-content no-padding">
                                        <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <!--<th>Image</th>-->
                                                <th>Quotation #</th>
                                                <th>Customer</th>
                                                <th>Contact</th>
                                                <th>Invoice Date</th>
                                                <th>Due Date</th>
                                                <th>Sales Person</th>
                                                <th>Total Amount</th>
                                                <th>Paid</th>
                                                <th>Balance</th>
                                                <th>Status</th>


                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php
                                            $count = 0;
                                            $totalamount = 0;
                                            $totalpaid = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                                $totalamount+=$data['totalamount'];
                                                $totalpaid+=$data['paid'];
                                                ?>
                                                <tr>
                                                    <td><?php echo $count; ?></td>
                                                    <td><a href="dashboard.php?viewquotation=<?php echo $data['invoiceid']; ?>"><?php echo $data['invoiceid']; ?></a></td>
                                                    <td><?php echo $data['custname']; ?></td>
                                                    <td><?php echo $data['cont']; ?></td>
                                                    <td><?php echo $data['invdate']; ?></td>
                                                    <td><?php echo $data['duedate']; ?></td>
                                                    <td><?php echo $data['salesperson']; ?></td>
                                                    <td><?php echo number_format($data['totalamount'],2); ?></td>
                                                    <td><?php echo number_format($data['paid'],2); ?></td>
                                                    <td><?php echo number_format(($data['totalamount'] - $data['paid']),2); ?></td>
                                                    <td><?php echo $data['status']; ?></td>
                                                </tr>
                                            <?php } ?>
                                            <tr style="font-weight: bold; font-size: medium;">
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>TOTAL</td>
                                                <td><?php echo number_format($totalamount,2); ?></td>
                                                <td><?php echo number_format($totalpaid,2); ?></td>
                                                <td><?php echo number_format(($totalamount - $totalpaid),2); ?></td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>

                <?php $conn->close($dbconnection);}elseif(isset($_GET['shop_transfer'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $sel = "SELECT * FROM shop_transfer_details ORDER BY tstamp DESC";
                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Products</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Shop Transfers</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">

                                <!-- Page Stats -->
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Transfers</span>
                                            <h3 align="center"><?php echo $selnum; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <div class="col-md-12" style="padding: 10px;" align="right"><a onclick="shopproduct()" class="btn btn-danger btn-lg">Transfer Product </a></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="widget-content no-padding">
                                        <table class="table table-striped table-bordered table-hover table-checkable table-responsive dataTable">
                                            <thead>
                                            <tr><th colspan="4"><p style="text-align: center; font-weight: bold; font-size: large;">Shop Transfers</p></th></tr>
                                            <tr>
                                                <th>#</th>
                                                <!--<th>Image</th>-->
                                                <th>Transfer #</th>
                                                <th>Shop</th>
                                                <th>Date</th>


                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php
                                            $count = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                                $transid = $data['transid'];
                                                ?>
                                                <tr>
                                                    <td><?php echo $count; ?></td>
                                                    <td><a onclick="gettransdetails2('<?php echo $transid; ?>')"><?php echo $transid; ?></a></td>
                                                    <td><?php echo getbranch($data['shop']); ?></td>
                                                    <td><?php echo $data['tstamp']; ?></td>
                                                </tr>
                                            <?php } ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>
                    <div class="modal fade" id="shop_transfer">
                        <div class="modal-dialog">
                            <form method="post" id="shoptrans">
                                <input type="hidden" name="branch" value="<?php echo $branch ?>" />`
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">SHOP PRODUCTS TRANSFER</h4>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td align="right"><p style="font-weight: bold;">Product</p></td>
                                                <td id="shoptransfer"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><p style="font-weight: bold;">Shop</p></td>
                                                <td>
                                                    <select class="select2-active form-control" name="toshop">
                                                        <?php
                                                        $selb = "SELECT id, bname FROM branches WHERE id <> $branch ORDER BY bname ASC";
                                                        $selbrun = $conn->query($dbconnection,$selb);
                                                        while($data = $conn->fetch($selbrun)){
                                                            ?>
                                                            <option value="<?php echo $data['id']; ?>"><?php echo $data['bname']; ?></option>
                                                        <?php } ?>
                                                        <option value="WH">WAREHOUSE</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><p style="font-weight: bold;">Quantity</p></td>
                                                <td><input type="number" class="form-control" name="stqty" id="stqty"  min="0" placeholder="0"/></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary" onclick="checktransfer2()">Transfer Product</button>
                                    </div>
                                </div>
                            </form><!-- /.modal-content -->
                        </div><!-- /.modal-dialog -->
                    </div>
                <?php $conn->close($dbconnection);}elseif(isset($_GET['warehouse_transfer'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $shop = $_GET['transreport'];
                    $sdate = $_GET['sdate'];
                    $edate = $_GET['edate'];
                    $sel = "";
                    $desc = "";
                    if($shop == "All"){
                        $sel = "SELECT * FROM transfer_details WHERE transdate BETWEEN '$sdate' AND '$edate'";
                        $desc = "Product Transfers To All Shops From ".$sdate." To ".$edate;
                    }else{
                        $sel = "SELECT * FROM transfer_details WHERE shop = '$shop' AND transdate BETWEEN '$sdate' AND '$edate'";
                        $desc = "Products Transfer To ".getbranch($shop)." From ".$sdate." To ".$edate;

                    }

                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Warehouse</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Products Transfer</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">

                                <!-- Page Stats -->
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Transfers</span>
                                            <h3 align="center"><?php echo $selnum; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="widget-content no-padding">
                                        <table class="table table-striped table-bordered table-hover table-checkable table-responsive dataTable">
                                            <thead>
                                            <tr><th colspan="4"><p style="text-align: center; font-weight: bold; font-size: large;"><?php echo $desc; ?></p></th></tr>
                                            <tr>
                                                <th>#</th>
                                                <!--<th>Image</th>-->
                                                <th>Transfer #</th>
                                                <th>Shop</th>
                                                <th>Date</th>


                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php
                                            $count = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                                $transid = $data['transid'];
                                                ?>
                                                <tr>
                                                    <td><?php echo $count; ?></td>
                                                    <td><a onclick="gettransdetails('<?php echo $transid; ?>')"><?php echo $transid; ?></a></td>
                                                    <td><?php echo getbranch($data['shop']); ?></td>
                                                    <td><?php echo $data['tstamp']; ?></td>
                                                </tr>
                                            <?php } ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>

                <?php $conn->close($dbconnection); }elseif(isset($_GET['viewinvoice'])){
                $conn=new Db_connect;
                $dbconnection=$conn->conn();
                $invid = $_GET['viewinvoice'];
                $sel = "SELECT * FROM customer_invoice WHERE invoiceid = '$invid'";
                $selrun = $conn->query($dbconnection,$sel);
                $seldata = $conn->fetch($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Customer Invoices</a>
                                </li>
                                <li class="current">
                                    <a title="">Invoices</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <div class="row">
                            <!--=== Invoice ===-->
                            <div class="col-md-12">
                                <div class="widget invoice">
                                    <div class="widget-header">
                                        <div class="pull-left">
                                            <h2><?php echo $cname; ?></h2>
                                        </div>
                                        <div class="pull-right">
                                            <p class="invoice-nr"><strong>Invoice:</strong> <?php echo $invid; ?></h3></p>
                                            <p class="invoice-date"><?php ?></p>
                                        </div>
                                    </div>
                                    <div class="widget-content">
                                        <div class="row">
                                            <!--=== Adresses ===-->
                                            <div class="col-md-8 col-sm-8 col-xs-6 col-lg-8">
                                                <h3>Company Information</h3>

                                                <address>
                                                    <strong><?php echo $cmail; ?></strong><br>
                                                    <?php echo $caddr; ?><br>
                                                    <?php echo $cloc; ?><br>
                                                    <abbr title="Phone">P:</abbr> <?php echo $ccont; ?>
                                                </address>
                                            </div>
                                            <div class="col-md-4 col-sm-4 col-xs-4 col-lg-4 align-left">
                                                <h3>Client Information</h3>

                                                <address>
                                                    <strong><?php echo $seldata['custname']; ?></strong><br>
                                                    <abbr title="Phone">P:</abbr> <?php echo $seldata['cont']; ?><br>
                                                    <abbr><b>Organization:</b></abbr> <?php echo $seldata['organ']; ?><br>
                                                    <abbr><b>Org. Contact:</b></abbr> <?php echo $seldata['orgcont']; ?><br>
                                                    <abbr><b>Org. Location:</b></abbr> <?php echo $seldata['orgloc']; ?><br>
                                                    <abbr><b>Org. Type:</b></abbr> <?php echo $seldata['orgtype']; ?>
                                                </address>
                                            </div>
                                            <!-- /Adresses -->

                                            <!--=== Table ===-->
                                            <div class="col-md-12">
                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Item</th>
                                                        <th class="hidden-xs">Quantity</th>
                                                        <th class="hidden-xs">Unit Cost</th>
                                                        <th>Total</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <?php
                                                        $seldet = "SELECT * FROM invoice_details WHERE invoiceid = '$invid'";
                                                        $seldetrun = $conn->query($dbconnection,$seldet);
                                                        $count = 0;
                                                        $subtotal = 0;
                                                        while($ddata = $conn->fetch($seldetrun)){
                                                            $count++;
                                                            $subtotal+=($ddata['qty'] * $ddata['sprice']);
                                                    ?>
                                                    <tr>
                                                        <td><?php echo $count; ?></td>
                                                        <td><?php echo getproduct($ddata['pid']); ?></td>
                                                        <td class="hidden-xs"><?php echo $ddata['qty']; ?></td>
                                                        <td class="hidden-xs"><?php echo $ddata['sprice']; ?></td>
                                                        <td class="hidden-xs"><?php echo number_format(($ddata['qty'] * $ddata['sprice']),2); ?></td>
                                                    </tr>
                                                    <?php } ?>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- /Table -->
                                        </div>
                                        <div class="row padding-top-10px">
                                            <div class="col-md-4 col-sm-4 col-xs-4">
                                                <?php
                                                $selpay = "SELECT * FROM invoice_payment WHERE invoiceid = '$invid' ORDER BY paydate ASC";
                                                $selpayrun = $conn->query($dbconnection,$selpay);
                                                if($seldata['status'] != "Inactive" && $conn->sqlnum($selpayrun) != 0){ ?>
                                                <div class="well">
                                                    <p><strong>DUE DATE: </strong> <?php echo date("d M, Y", strtotime(date($seldata['duedate']))); ?></p>
                                                    <p>
                                                        <table class="table table-bordered table-striped">
                                                            <thead><tr style="font-weight: bold;"><td align="center" colspan="2">PAYMENTS</td></tr><tr><th>Payment Date</th><th>Amount</th><th>Paid To</th></tr></thead>
                                                            <tbody>
                                                                <?php

                                                                    $tot=0;
                                                                    while($paydata = $conn->fetch($selpayrun)){
                                                                        $tot+=$paydata['amount'];
                                                                ?>
                                                                <tr><td><?php echo date("d M, Y h:i:s A",strtotime(date($paydata['paydate']))); ?></td><td><?php echo $paydata['amount']; ?></td><td><?php echo strtolower(getstaff($paydata['userid'])); ?></td></tr>
                                                                <?php } ?>
                                                                <tr style="font-weight: bold"><td>TOTAL</td><td>&cent;<?php echo number_format($tot,2); ?></td></tr>
                                                            </tbody>
                                                        </table>
                                                    </p>
                                                </div>
                                                <?php } ?>
                                            </div>

                                            <div class="col-md-4 col-sm-4 col-xs-4">
                                                <?php
                                                    $tottax=0;
                                                    $gettax = "SELECT taxid, dval, damount FROM invoice_tax WHERE invid = '$invid'";
                                                    $gettaxrun = $conn->query($dbconnection,$gettax);
                                                    if($conn->sqlnum($gettaxrun)  != 0){
                                                ?>
                                                        <table class="table table-bordered table-striped">
                                                            <thead><tr style="font-weight: bold;"><td align="center" colspan="3">TAXES APPLIED</td></tr><tr><th>Tax</th><th>%</th><th>Amount</th></tr></thead>
                                                            <tbody>
                                                            <?php
                                                            while($paydata = $conn->fetch($gettaxrun)){
                                                                $taxcalc = $paydata['damount'];
                                                                $tottax+=$taxcalc;
                                                                ?>
                                                                <tr><td><?php echo gettax($paydata['taxid']); ?></td><td><?php echo $paydata['dval']; ?></td><td><?php echo number_format($taxcalc,2); ?></td></tr>
                                                            <?php } ?>
                                                            <tr style="font-weight: bold"><td colspan="2" align="right">TOTAL TAX</td><td>&cent;<?php echo number_format($tottax,2); ?></td></tr>
                                                            </tbody>
                                                        </table>
                                                <?php } ?>
                                            </div>

                                            <div class="col-md-4 col-sm-4 col-xs-4 align-right">
                                                <ul class="list-unstyled amount padding-bottom-5px">
                                                    <li><strong>Subtotal:</strong> &cent;<?php echo number_format($subtotal,2); ?></li>
                                                    <li><strong>Tax:</strong> &cent;<?php echo number_format($tottax,2); ?></li>
                                                    <li><strong>Net Amount:</strong> &cent;<?php echo number_format($subtotal + $tottax,2); ?></li>
                                                    <li>&nbsp;</li>
                                                    <li><strong>Paid:</strong>&cent; <?php echo number_format($seldata['paid'],2); ?></li>
                                                    <li><strong>Balance:</strong>&cent; <?php echo number_format(($subtotal + $tottax) - $seldata['paid'],2); ?></li>
                                                    <!--<li class="total"><strong>Total:</strong> $12,181.40</li>-->
                                                </ul>

                                                <div class="buttons">
                                                    <a class="btn btn-default btn-lg" href="javascript:void(0);" onclick="javascript:window.print();"><i class="icon-print"></i> Print</a>
                                                    <?php if(($subtotal - $seldata['paid']) > 0 && $seldata['status'] == "Pending"){ ?><a class="btn btn-success btn-lg"  data-toggle="modal" href="#payinvoice">Proceed to Payment <i class="icon-angle-right"></i></a><?php } ?>
                                                    <?php if($seldata['status'] == "Inactive"){ ?>
                                                        &nbsp;&nbsp;<a class="btn btn-warning btn-lg"  onclick="activateInvoice('<?php echo $invid; ?>')">Activate Invoice <i class="icon-angle-right"></i></a>
                                                        &nbsp;&nbsp;<a class="btn btn-primary btn-lg"  data-toggle="modal" href="#addtax">Add Tax <i class="icon-angle-right"></i></a>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div> <!-- /.row -->
                                    </div>
                                </div> <!-- /.widget box -->
                            </div> <!-- /.col-md-12 -->
                            <!-- /Invoice -->
                        </div> <!-- /.row -->
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>
                    <div class="modal fade" id="addtax">
                        <div class="modal-dialog">
                            <form method="post" enctype="multipart/form-data">
                                <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                                <input type="hidden" name="invoiceid" value="<?php echo $invid; ?>" />
                                <input type="hidden" name="totalinvoice" value="<?php echo $subtotal; ?>" />
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">ADD TAX</h4>
                                    </div>
                                    <div class="modal-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td align="right"><p style="font-weight: bold;">Tax <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                                                <td>
                                                    <select class="select2-active form-control" name="addtaxtoinvoice" required>
                                                        <option value="">--SELECT TAX--</option>
                                                        <?php
                                                        $sel = "SELECT taxid, val, name FROM taxconfig WHERE status = 'Active' AND taxid NOT IN( SELECT taxid FROM invoice_tax WHERE invid='$invid') ORDER BY name ASC";
                                                        $selrun = $conn->query($dbconnection,$sel);
                                                        while($data = $conn->fetch($selrun)){
                                                            ?>
                                                            <option value="<?php echo $data['taxid'].'/'.$data['val']; ?>"><?php echo $data['name']."  [".$data['val']."%]"; ?></option>
                                                        <?php } ?>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Add Tax</button>
                                    </div>
                                </div>
                            </form><!-- /.modal-content -->
                        </div><!-- /.modal-dialog -->
                    </div>
                <div class="modal fade" id="payinvoice">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">REGISTER PAYMENT</h4>
                            </div>
                            <div class="modal-body">
                                <form method="post">
                                    <input type="hidden" name="viewinvoice" value="<?php echo $invid; ?>" />
                                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                                    <table class="table table-striped">
                                        <tr>
                                            <td align="right"><p style="font-weight: bold;">Payment Amount</p></td>
                                            <td>
                                                <input type="number" class="form-control" name="payamount" min="0.1" step="any" value="<?php echo ($subtotal + $tottax) - $seldata['paid']; ?>" max="<?php echo ($subtotal + $tottax) - $seldata['paid']; ?>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right"><p style="font-weight: bold;">Payment Date</p></td>
                                            <td>
                                                <input type="date" class="form-control" name="paydate" value="<?php echo date('Y-m-d') ?>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center"><button type="submit" name="makepayment" class="btn btn-sm btn-success" ><span class="icon icon-next">Make Payment</span></button></td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div><!-- /.modal-dialog -->
                </div>
            <?php $conn->close($dbconnection);}elseif(isset($_GET['viewquotation'])){
                    $invid = $_GET['viewquotation'];
                    $sel = "SELECT * FROM customer_quotation WHERE invoiceid = '$invid'";
                    $selrun = $conn->query($dbconnection,$sel);
                    $seldata = $conn->fetch($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Customer Quotations</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Quotation</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <!--=== Invoice ===-->
                                <div class="col-md-12">
                                    <div class="widget invoice">
                                        <div class="widget-header">
                                            <div class="pull-left">
                                                <h2><?php echo $cname; ?></h2>
                                            </div>
                                            <div class="pull-right">
                                                <p class="invoice-nr"><strong>Quotation ID:</strong> <?php echo $invid; ?></h3></p>
                                                <p class="invoice-date"><?php ?></p>
                                            </div>
                                        </div>
                                        <div class="widget-content">
                                            <div class="row">
                                                <!--=== Adresses ===-->
                                                <div class="col-md-8 col-sm-8 col-xs-8">
                                                    <h3>Company Information</h3>

                                                    <address>
                                                        <strong><?php echo $cmail; ?></strong><br>
                                                        <?php echo $caddr; ?><br>
                                                        <?php echo $cloc; ?><br>
                                                        <abbr title="Phone">P:</abbr> <?php echo $ccont; ?>
                                                    </address>
                                                </div>
                                                <div class="col-md-4 col-sm-4 col-xs-4 align-left">
                                                    <h3>Client Information</h3>

                                                    <address>
                                                        <strong><?php echo $seldata['custname']; ?></strong><br>
                                                        <abbr title="Phone">P:</abbr> <?php echo $seldata['cont']; ?><br>
                                                        <abbr><b>Organization:</b></abbr> <?php echo $seldata['organ']; ?><br>
                                                        <abbr><b>Org. Contact:</b></abbr> <?php echo $seldata['orgcont']; ?><br>
                                                        <abbr><b>Org. Location:</b></abbr> <?php echo $seldata['orgloc']; ?><br>
                                                        <abbr><b>Org. Type:</b></abbr> <?php echo $seldata['orgtype']; ?>
                                                    </address>
                                                </div>
                                                <!-- /Adresses -->

                                                <!--=== Table ===-->
                                                <div class="col-md-12">
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Item</th>
                                                            <th class="hidden-xs">Quantity</th>
                                                            <th class="hidden-xs">Unit Cost</th>
                                                            <th>Total</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <?php
                                                        $seldet = "SELECT * FROM quotation_details WHERE invoiceid = '$invid'";
                                                        $seldetrun = $conn->query($dbconnection,$seldet);
                                                        $count = 0;
                                                        $subtotal = 0;
                                                        while($ddata = $conn->fetch($seldetrun)){
                                                            $count++;
                                                            $subtotal+=($ddata['qty'] * $ddata['sprice']);
                                                            ?>
                                                            <tr>
                                                                <td><?php echo $count; ?></td>
                                                                <td><?php echo getproduct($ddata['pid']); ?></td>
                                                                <td class="hidden-xs"><?php echo $ddata['qty']; ?></td>
                                                                <td class="hidden-xs"><?php echo $ddata['sprice']; ?></td>
                                                                <td class="hidden-xs"><?php echo number_format(($ddata['qty'] * $ddata['sprice']),2); ?></td>
                                                            </tr>
                                                        <?php } ?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <!-- /Table -->
                                            </div>

                                            <div class="row padding-top-10px">
                                                <div class="col-md-4">&nbsp; </div>

                                                <div class="col-md-8 align-right">
                                                    <ul class="list-unstyled amount padding-bottom-5px">
                                                        <li><strong>Subtotal:</strong> &cent;<?php echo number_format($subtotal,2); ?></li>
                                                        <li><strong>Paid:</strong>&cent; <?php echo number_format($seldata['paid'],2); ?></li>
                                                        <li><strong>Balance:</strong>&cent; <?php echo number_format(($subtotal - $seldata['paid']),2); ?></li>
                                                        <!--<li class="total"><strong>Total:</strong> $12,181.40</li>-->
                                                    </ul>

                                                    <div class="buttons">
                                                        <a class="btn btn-default btn-lg" href="javascript:void(0);" onclick="javascript:window.print();"><i class="icon-print"></i> Print</a>
                                                        <!--<a class="btn btn-success btn-lg" href="dashboard.php?invoicegenerate=<?php echo $invid; ?>">Generate Invoice <i class="icon-angle-right"></i></a>-->
                                                        <a class="btn btn-success btn-lg" onclick="validatequotation('<?php echo $invid; ?>')">Generate Invoice <i class="icon-angle-right"></i></a>
                                                    </div>
                                                </div>
                                            </div> <!-- /.row -->
                                        </div>
                                    </div> <!-- /.widget box -->
                                </div> <!-- /.col-md-12 -->
                                <!-- /Invoice -->
                            </div> <!-- /.row -->
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>
                <?php }elseif(isset($_GET['invoicegenerate'])){
                    $qid = $_GET['invoicegenerate'];

                    //CHECK IF QUOTATION HAS BEEN REMOVED
                    $chk = "SELECT invoiceid FROM customer_quotation WHERE invoiceid = '$qid'";
                    $chkrun = $conn->query($dbconnection,$chk);
                    $quotenum = $conn->sqlnum($chkrun);

                    $invid = str_replace("QOT","INV",$qid);
                    //MOVE RECORDS INTO THE INVOICE TABLE AND DELETE FROM THE QUOTATIONS TABLE
                    $mov = "INSERT INTO customer_invoice (invoiceid, custname, cont, invdate, duedate, salesperson, totalamount, paid, status, shop, organ, orgcont, orgloc, orgtype)
                            SELECT '$invid', custname, cont, invdate, duedate, salesperson, totalamount, paid, status, shop, organ, orgcont, orgloc, orgtype FROM  customer_quotation WHERE invoiceid = '$qid'";
                    $conn->query($dbconnection,$mov);

                    $movdet = "INSERT INTO invoice_details (invoiceid, pid, qty, sprice) SELECT '$invid', pid, qty, sprice FROM quotation_details WHERE invoiceid = '$qid'";
                    $conn->query($dbconnection,$movdet);

                    $sel = "SELECT * FROM customer_invoice WHERE invoiceid = '$invid'";
                    $selrun = $conn->query($dbconnection,$sel);
                    $seldata = $conn->fetch($selrun);
                    $dshop = $seldata['shop'];

                    //DELETE RECORDS FROM THE
                    $del1 = "DELETE FROM customer_quotation WHERE invoiceid = '$qid'";
                    $conn->query($dbconnection,$del1);

                    $del2 = "DELETE FROM quotation_details WHERE invoiceid = '$qid'";
                    $conn->query($dbconnection,$del2);

                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <div class="alert alert-success fade in" style="text-align: center;">
                                    <i class="icon-remove close" data-dismiss="alert"></i>
                                    <strong>Success!</strong> Quotation Has Been Converted To Invoice
                                </div>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <!--=== Invoice ===-->
                                <div class="col-md-12">
                                    <div class="widget invoice">
                                        <div class="widget-header">
                                            <div class="pull-left">
                                                <h2><?php echo $cname; ?></h2>
                                            </div>
                                            <div class="pull-right">
                                                <p class="invoice-nr"><strong>Invoice:</strong> <?php echo $invid; ?></h3></p>
                                                <p class="invoice-date"><?php ?></p>
                                            </div>
                                        </div>
                                        <div class="widget-content">
                                            <div class="row">
                                                <!--=== Adresses ===-->
                                                <div class="col-md-8">
                                                    <h3>Company Information</h3>

                                                    <address>
                                                        <strong><?php echo $cmail; ?></strong><br>
                                                        <?php echo $caddr; ?><br>
                                                        <?php echo $cloc; ?><br>
                                                        <abbr title="Phone">P:</abbr> <?php echo $ccont; ?>
                                                    </address>
                                                </div>
                                                <div class="col-md-4 align-left">
                                                    <h3>Client Information</h3>

                                                    <address>
                                                        <strong><?php echo $seldata['custname']; ?></strong><br>
                                                        <abbr title="Phone">P:</abbr> <?php echo $seldata['cont']; ?><br>
                                                        <abbr><b>Organization:</b></abbr> <?php echo $seldata['organ']; ?><br>
                                                        <abbr><b>Org. Contact:</b></abbr> <?php echo $seldata['orgcont']; ?><br>
                                                        <abbr><b>Org. Location:</b></abbr> <?php echo $seldata['orgloc']; ?><br>
                                                        <abbr><b>Org. Type:</b></abbr> <?php echo $seldata['orgtype']; ?>
                                                    </address>
                                                </div>
                                                <!-- /Adresses -->

                                                <!--=== Table ===-->
                                                <div class="col-md-12">
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Item</th>
                                                            <th class="hidden-xs">Quantity</th>
                                                            <th class="hidden-xs">Unit Cost</th>
                                                            <th>Total</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <?php
                                                        $seldet = "SELECT * FROM invoice_details WHERE invoiceid = '$invid'";
                                                        $seldetrun = $conn->query($dbconnection,$seldet);
                                                        $count = 0;
                                                        $subtotal = 0;
                                                        while($ddata = $conn->fetch($seldetrun)){
                                                            $count++;
                                                            $subtotal+=($ddata['qty'] * $ddata['sprice']);
                                                            $dqty = $ddata['qty'];
                                                            $pid = $ddata['pid'];

                                                            if($quotenum != 0){
                                                                //REDUCE THE PRODUCT QUANTITY
                                                                $upd = "UPDATE products SET qty=(qty - $dqty) WHERE pid = '$pid' AND shop = '$dshop'";
                                                                $conn->query($dbconnection,$upd);
                                                            }

                                                            ?>
                                                            <tr>
                                                                <td><?php echo $count; ?></td>
                                                                <td><?php echo getproduct($ddata['pid']); ?></td>
                                                                <td class="hidden-xs"><?php echo $ddata['qty']; ?></td>
                                                                <td class="hidden-xs"><?php echo $ddata['sprice']; ?></td>
                                                                <td class="hidden-xs"><?php echo number_format(($ddata['qty'] * $ddata['sprice']),2); ?></td>
                                                            </tr>
                                                        <?php } ?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <!-- /Table -->
                                            </div>

                                            <div class="row padding-top-10px">
                                                <div class="col-md-4">
                                                    <div class="well">
                                                        <p><strong>DUE DATE: </strong> <?php echo date("d M, Y", strtotime(date($seldata['duedate']))); ?></p>
                                                        <p>
                                                        <table class="table table-bordered table-striped">
                                                            <thead><tr style="font-weight: bold;"><td align="center" colspan="2">PAYMENTS</td></tr><tr><th>Payment Date</th><th>Amount</th></tr></thead>
                                                            <tbody>
                                                            <?php
                                                            $selpay = "SELECT * FROM invoice_payment WHERE invoiceid = '$invid' ORDER BY paydate ASC";
                                                            $selpayrun = $conn->query($dbconnection,$selpay);
                                                            $tot=0;
                                                            while($paydata = $conn->fetch($selpayrun)){
                                                                $tot+=$paydata['amount'];
                                                                ?>
                                                                <tr><td><?php echo date("d M, Y h:i:s A",strtotime(date($paydata['paydate']))); ?></td><td><?php echo $paydata['amount']; ?></td></tr>
                                                            <?php } ?>
                                                            <tr style="font-weight: bold"><td>TOTAL</td><td>&cent;<?php echo number_format($tot,2); ?></td></tr>
                                                            </tbody>
                                                        </table>
                                                        </p>
                                                    </div>
                                                </div>

                                                <div class="col-md-8 align-right">
                                                    <ul class="list-unstyled amount padding-bottom-5px">
                                                        <li><strong>Subtotal:</strong> &cent;<?php echo number_format($subtotal,2); ?></li>
                                                        <li><strong>Paid:</strong>&cent; <?php echo number_format($seldata['paid'],2); ?></li>
                                                        <li><strong>Balance:</strong>&cent; <?php echo number_format(($subtotal - $seldata['paid']),2); ?></li>
                                                        <!--<li class="total"><strong>Total:</strong> $12,181.40</li>-->
                                                    </ul>

                                                    <div class="buttons">
                                                        <a class="btn btn-default btn-lg" href="javascript:void(0);" onclick="javascript:window.print();"><i class="icon-print"></i> Print</a>
                                                        <?php if(($subtotal - $seldata['paid']) > 0){ ?><a class="btn btn-success btn-lg"  data-toggle="modal" href="#payinvoice2">Proceed to Payment <i class="icon-angle-right"></i></a><?php } ?>
                                                    </div>
                                                </div>
                                            </div> <!-- /.row -->
                                        </div>
                                    </div> <!-- /.widget box -->
                                </div> <!-- /.col-md-12 -->
                                <!-- /Invoice -->
                            </div> <!-- /.row -->
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>
                    <div class="modal fade" id="payinvoice2">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">REGISTER PAYMENT</h4>
                                </div>
                                <div class="modal-body">
                                    <form method="post">
                                        <input type="hidden" name="viewinvoice" value="<?php echo $invid; ?>" />
                                        <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                                        <table class="table table-striped">
                                            <tr>
                                                <td align="right"><p style="font-weight: bold;">Payment Amount</p></td>
                                                <td>
                                                    <input type="number" class="form-control" name="payamount" min="0.1" step="any"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><p style="font-weight: bold;">Payment Date</p></td>
                                                <td>
                                                    <input type="date" class="form-control" name="paydate" value="<?php echo date('Y-m-d') ?>"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center"><button type="submit" name="makepayment" class="btn btn-sm btn-success" ><span class="icon icon-next">Make Payment</span></button></td>
                                            </tr>
                                        </table>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div><!-- /.modal-dialog -->
                    </div>
                <?php }elseif(isset($_GET['users'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $sel = "SELECT * FROM users";
                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Administration</a>
                                </li>
                                <li class="current">
                                    <a title="">Users</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Users</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Users</span>
                                        <h3 align="center"><?php echo $selnum; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <div class="row">
                            <div class="col-md-12" style="padding: 10px;"><a data-toggle="modal" href="#user_create" class="btn btn-danger btn-lg">ADD USER </a></div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                        <thead>
                                        <tr>
                                            <!--<th>Image</th>-->
                                            <th>User ID</th>
                                            <th>Staff Name</th>
                                            <th>Access</th>
                                            <th>Gender</th>
                                            <th>Contact</th>
                                            <th>Address</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                            $count = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $userid = $data['userid'];
                                        ?>
                                        <tr>
                                            <td><?php echo $data['userid']; ?></td>
                                            <td><?php echo $data['fname']." ".$data['lname']; ?></td>
                                            <td><?php echo $data['access']; ?></td>
                                            <td><?php echo $data['gender']; ?></td>
                                            <td><?php echo $data['contact']; ?></td>
                                            <td><?php echo $data['address']; ?></td>
                                            <td><?php echo $data['status']; ?></td>
                                            <td><a onclick="updateuser('<?php echo $userid; ?>')" class="btn btn-sm btn-primary"><span class="icon icon-user-md"></span>Update</a></td>
                                        </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->
                </div>

            <?php $conn->close($dbconnection);}elseif(isset($_GET['branches'])){
                $conn=new Db_connect;
                $dbconnection=$conn->conn();
                $sel = "SELECT * FROM branches";
                $selrun = $conn->query($dbconnection,$sel);
                $selnum = $conn->sqlnum($selrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Administration</a>
                                </li>
                                <li class="current">
                                    <a title="">Branches</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Branches</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Branches</span>
                                        <h3 align="center"><?php echo $selnum; ?></h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===-->
                        <div class="row row-bg"></div> <!-- /.row -->
                        <div class="row">
                            <div class="col-md-12" style="padding: 10px;" align="right"><a onclick="getbranch('','create')" class="btn btn-danger btn-lg">ADD BRANCH </a></div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="widget-content no-padding">
                                    <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <!--<th>Image</th>-->
                                            <th>Branch Name</th>
                                            <th>Contact</th>
                                            <th>E-Mail</th>
                                            <th>Location</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                                        $count = 0;
                                        while($data = $conn->fetch($selrun)){
                                            $count++;
                                            $dbname = $data['bname'];
                                            $bid = $data['id'];
                                            ?>
                                            <tr>
                                                <td><?php echo $count; ?></td>
                                                <td><?php echo $dbname; ?></td>
                                                <td><?php echo $data['contact']; ?></td>
                                                <td><?php echo $data['email']; ?></td>
                                                <td><?php echo $data['bloc']; ?></td>
                                                <td><?php echo $data['status']; ?></td>
                                                <td><a class="btn btn-sm btn-primary" onclick="getbranch(<?php echo $bid; ?>,'update')">Edit Branch</a></td>
                                            </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>

            <?php $conn->close($dbconnection);}elseif(isset($_GET['taxes'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $sel = "SELECT * FROM taxconfig";
                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Administration</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Sales Tax</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">
                                <div class="page-title">
                                    <h3>Taxes</h3>
                                </div>

                                <!-- Page Stats -->
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Taxes</span>
                                            <h3 align="center"><?php echo $selnum; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <div class="col-md-12" style="padding: 10px;" align="right"><a data-toggle="modal" href="#taxconfig" class="btn btn-danger btn-lg">ADD TAX COMPONENT </a></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="widget-content no-padding">
                                        <table class="table table-striped table-bordered table-hover table-checkable table-responsive">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <!--<th>Image</th>-->
                                                <th>Tax ID</th>
                                                <th>Tax Name</th>
                                                <th>Percentage</th>
                                                <th>Add In Sales</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php
                                            $count = 0;
                                            if($selnum != 0){
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                                $taxid = $data['id'];
                                                ?>
                                                <tr>
                                                    <td><?php echo $count; ?></td>
                                                    <td><?php echo $data['taxid']; ?></td>
                                                    <td><?php echo $data['name']; ?></td>
                                                    <td><?php echo $data['val']; ?></td>
                                                    <td><?php echo $data['optin']; ?></td>
                                                    <td><?php echo $data['status']; ?></td>
                                                    <td><a class="btn btn-sm btn-primary" onclick="getTax(<?php echo $taxid; ?>)">Update Tax</a></td>
                                                </tr>
                                            <?php }}else{ ?>
                                                <tr><td colspan="7">No Tax Records Found</td></tr>
                                            <?php } ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>

                <?php $conn->close($dbconnection);}elseif(isset($_GET['backups'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $sel = "SELECT * FROM backup ORDER BY tstamp DESC";
                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Administration</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Backups</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">
                                <div class="page-title">
                                    <h3>Backups</h3>
                                </div>

                                <!-- Page Stats -->
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Backups</span>
                                            <h3 align="center"><?php echo $selnum; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <div class="row">
                                <div class="col-md-12" style="padding: 10px;" align="right"><a onclick="getbackup()" class="btn btn-danger btn-lg">Create BackUp </a></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="widget-content no-padding">
                                        <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <!--<th>Image</th>-->
                                                <th>File Name</th>
                                                <th>Backup Timestamp</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php
                                            $count = 0;
                                            while($data = $conn->fetch($selrun)){
                                                $count++;
                                                $fname = $data['fname'];
                                                ?>
                                                <tr>
                                                    <td><?php echo $count; ?></td>
                                                    <td><?php echo $fname; ?></td>
                                                    <td><?php echo $data['tstamp']; ?></td>
                                                    <td><a class="btn btn-sm btn-primary" href="assets/data/backup/<?php echo $fname; ?>">Download</a></td>
                                                </tr>
                                            <?php } ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>

                <?php $conn->close($dbconnection);}elseif(isset($_GET['price_adjustment'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                    $sel = "SELECT pid, pname, cprice, sprice FROM products_master WHERE status = 'ACTIVE' ORDER BY pname ASC";
                    $selrun = $conn->query($dbconnection,$sel);
                    $selnum = $conn->sqlnum($selrun);
                    ?>
                    <div id="content">
                        <div class="container">
                            <!-- Breadcrumbs line -->
                            <div class="crumbs">
                                <ul id="breadcrumbs" class="breadcrumb">
                                    <li>
                                        <i class="icon-home"></i>
                                        <a>Warehouse</a>
                                    </li>
                                    <li class="current">
                                        <a title="">Price Adjustments</a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /Breadcrumbs line -->

                            <!--=== Page Header ===-->
                            <div class="page-header">
                                <div class="page-title">
                                    <h3>Price Of Products Adjustments</h3>
                                </div>

                                <!-- Page Stats -->
                                <ul class="page-stats">
                                    <li>
                                        <div class="summary">
                                            <span>Total Products</span>
                                            <h3 align="center"><?php echo $selnum; ?></h3>
                                        </div>
                                    </li>
                                </ul>
                                <!-- /Page Stats -->
                            </div>
                            <!-- /Page Header -->

                            <!--=== Page Content ===-->
                            <!--=== Statboxes ===-->
                            <div class="row row-bg"></div> <!-- /.row -->
                            <form method="post">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-striped">
                                            <tr><td colspan="3"><p style="text-align: center;font-weight: bold;">Enter positive(+) value for increments and negative(-) value for reductions</p></td></tr>
                                            <tr>
                                                <td><label>Percentage Change</label><input type="number" class="form-control" name="adjustprice"  min="-100" max="100" placeholder="0" required /></td>
                                                <td>
                                                    <label>Price Type:</label>
                                                    <select class="form-control" name="ptype" required>
                                                        <option value="All">All Price Types</option>
                                                        <option value="sprice">Selling Price</option>
                                                        <option value="cprice">Cost Price</option>
                                                    </select>
                                                </td>
                                                <td><label>&nbsp;</label><button type="submit" class="btn btn-lg btn-primary">Update Prices</button></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="widget-content no-padding">
                                            <table class="table table-striped table-bordered table-hover table-checkable table-responsive">
                                                <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th><input type="checkbox" name="select-all" id="select-all" />  Select All </th>
                                                    <!--<th>Image</th>-->
                                                    <th>Product ID</th>
                                                    <th>Cost Price</th>
                                                    <th>Selling Price</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php
                                                $count = 0;
                                                while($data = $conn->fetch($selrun)){
                                                    $count++;
                                                    $pname = $data['pname'];
                                                    $pid = $data['pid'];
                                                    $cprice = $data['cprice'];
                                                    $sprice = $data['sprice'];
                                                    ?>
                                                    <tr>
                                                        <td><?php echo $count; ?></td>
                                                        <td><input type="checkbox" name="check_list[]" value="<?php echo $pid; ?>" id="<?php echo $count; ?>"/>&nbsp;&nbsp;<label for="<?php echo $count; ?>"><?php echo $pname; ?></label></td>
                                                        <td><?php echo $pid; ?></td>
                                                        <td><?php echo $cprice; ?></td>
                                                        <td><?php echo $sprice; ?></td>
                                                     </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <!-- /Page Content -->
                        </div>
                        <!-- /.container -->

                    </div>

                <?php $conn->close($dbconnection);}elseif(isset($_GET['pos'])){
                    $conn=new Db_connect;
                    $dbconnection=$conn->conn();
                $sel = "SELECT m.pimg, m.pname, m.cat, m.sprice, m.pid, p.qty FROM products_master m INNER JOIN products p ON m.pid = p.pid WHERE m.status = 'ACTIVE' AND p.shop = '$branch' AND p.qty > 0";
                $selrun = $conn->query($dbconnection,$sel);
                //GENERATE SESSION ID
                $sessionid = $stfID.$currDateTime;
                //DELETE UNPROCESSED TRANSACTIONS
                $del = "DELETE FROM pos_temp WHERE userid = '$stfID'";
                $conn->query($dbconnection,$del);

                $seltot = "SELECT SUM(tot_sales) AS totalsales FROM sales_summary WHERE transdate BETWEEN '$sdate' AND '$edate' AND userid = '$stfID' AND shop = '$branch'";
                $seltotrun = $conn->query($dbconnection,$seltot);
                $seltotdata = $conn->fetch($seltotrun);
                ?>
                <div id="content">
                    <div class="container">
                        <!-- Breadcrumbs line -->
                        <div class="crumbs">
                            <ul id="breadcrumbs" class="breadcrumb">
                                <li>
                                    <i class="icon-home"></i>
                                    <a>Point Of Sale</a>
                                </li>
                                <li class="current">
                                    <a title="">Sales</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /Breadcrumbs line -->

                        <!--=== Page Header ===-->
                        <div class="page-header">
                            <div class="page-title">
                                <h3>Market Place</h3>
                            </div>

                            <!-- Page Stats -->
                            <ul class="page-stats">
                                <li>
                                    <div class="summary">
                                        <span>Total Sales</span>
                                        <h3 align="center" id="psalestot">
                                            <?php
                                                $tot = $seltotdata['totalsales'];
                                                if($tot != 0){ echo "GHS ".$tot;}
                                                else{ echo "GHS 0.00"; }
                                            ?>
                                        </h3>
                                    </div>
                                </li>
                            </ul>
                            <!-- /Page Stats -->
                        </div>
                        <!-- /Page Header -->

                        <!--=== Page Content ===-->
                        <!--=== Statboxes ===--><!-- /.row -->
                        <!-- PAYMENTS RECEIPT -->
                            <input type="hidden" name="sessionid" id="sessionid3" value="<?php echo $sessionid; ?>" />
                            <input type="hidden" value="<?php echo $branch; ?>" name="branch" />
                        <div class="row hidden" style="margin-top: 20px; background-color: #e8e7e3" id="paymentcheckout">
                                <div class="col-md-8" style="margin-bottom: 20px;">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p style="text-align: center; color: #000; font-weight: bold; font-size: x-large">PAYMENT</p>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <p style="font-weight: bold; text-align: center; font-size: large">Total Cost</p>
                                                    <input type="hidden" class="form-control" readonly style="background-color: #b3e891" id="pos_total" value="0.00" name="paytotal"/>
                                                    <div style="color: #00e247; font-weight: bolder; font-size: xx-large; text-align: center;" id="pos_totaldisp"></div>
                                                </div>
                                                <div class="col-md-4">
                                                    <p style="font-weight: bold; text-align: center; font-size: large">Tendered</p>
                                                    <input type="number" class="form-control" min="0" step="any" onkeyup="calculatebalance(this.value)" id="paytender"/><br>
                                                    <div align="center"><button type="button" class="btn btn-lg btn-primary" onclick="continuesales()"><< CONTINUE SELLING</button></div>
                                                </div>
                                                <div class="col-md-4">
                                                    <p style="font-weight: bold; text-align: center; font-size: large">Change</p>
                                                    <input type="hidden" class="form-control" readonly style="background-color: #b3e891" id="pos_bal" name="paybal"/>
                                                    <div style="color: #00e247; font-weight: bolder; font-size: xx-large; text-align: center;" id="pos_baldisp">0.00</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-12" style="margin-top: 20px;">
                                            <input type="hidden" id="custselect" value="no" name="selecttype"/>
                                            <div class="row" id="custdecide">
                                                <div class="col-md-4" align="right">
                                                    <a href="#" onclick="showcustomer('new')"><img src="assets/images/new_cust.png" class="img-responsive" style="width: 100px; height: 100px" /></a>
                                                </div>
                                                <div class="col-md-4" align="left">
                                                    <a href="#" onclick="showcustomer('exist')"><img src="assets/images/exist_cust.jpg" class="img-responsive" style="width: 100px; height: 100px" /></a>
                                                </div>
                                                <div class="col-md-4" align="left">
                                                    <a href="#" onclick="showcustomer('no')"><img src="assets/images/no_cust.png" class="img-responsive" style="width: 100px; height: 100px" /></a>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 hidden" id="new_customer">
                                                    <table class="table">
                                                        <tr>
                                                            <td align="center" colspan="2"><p style="font-weight: bold;">ADD NEW CUSTOMER INFORMATION</p></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right"><p style="font-weight: bold;">Customer Name</p></td>
                                                            <td><input type="text" class="form-control" id="cname" placeholder="Nasoo Limited"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right"><p style="font-weight: bold;">Contact</p></td>
                                                            <td><input type="text" class="form-control" id="ccontact"  placeholder="0554923322"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right"><p style="font-weight: bold;">Location</p></td>
                                                            <td><input type="text" class="form-control" id="clocation"  placeholder="Kumasi"/></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="col-md-12 hidden" id="exist_customer">
                                                    <table class="table">
                                                        <tr>
                                                            <td align="center" colspan="2"><p style="font-weight: bold;">SELECT EXISTING CUSTOMER</p></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right"><p style="font-weight: bold;">Select Customer</p></td>
                                                            <td>
                                                                <select class="select2-active form-control" id="cid">
                                                                    <option value="">--SELECT CUSTOMER--</option>
                                                                    <?php
                                                                    $selcust = "SELECT cname, cid FROM customers WHERE shop = '$branch'";
                                                                    $selruncust = $conn->query($dbconnection,$selcust);
                                                                    while($data = $conn->fetch($selruncust)){
                                                                        ?>
                                                                        <option value="<?php echo $data['cid']; ?>"><?php echo $data['cname']; ?></option>
                                                                    <?php } ?>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12" align="center" style="margin-top: 20px">
                                            <button type="button" class="btn btn-lg" id="invalidtend">VALIDATE</button>&nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-lg btn-success hidden" id="validtend"  onclick = "checkoutpay()">VALIDATE</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="row" id="paymentpos">
                            <div class="col-md-5">
                                <div class="widget box" style="border: 3px solid #4d7496;">
                                    <div class="widget-header">
                                        <h4><i class="icon-shopping-cart"></i> SHOPPING CART</h4>
                                    </div>
                                    <div class="widget-content">
                                        <div class="col-md-12"  id="salesdisplay">Empty Cart</div>
                                    </div>
                                </div>
                                <!-- /Validation Example 1 -->
                            </div>
                            <div class="col-md-7">
                                <div class="widget box" style="border: 3px solid #4d7496;">
                                    <div class="widget-header">
                                        <h4><i class="icon-reorder"></i> PRODUCTS LIST</h4>
                                    </div>
                                    <div class="widget-content">
                                        <div class="row" style="margin: 1%">
                                            <div class="widget-content no-padding">
                                                <input type="text" autofocus onchange="scanbcode('<?php echo $stfID ?>','<?php echo $sessionid ?>','<?php echo $branch; ?>')" id="bcodescan"/>
                                                <table class="table table-striped table-bordered table-hover table-checkable table-responsive datatable">
                                                    <thead>
                                                    <tr>
                                                        <th data-class="expand">Pic</th>
                                                        <th>Product Name</th>
                                                        <th>Category</th>
                                                        <th>Selling Price</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <?php
                                                    $count = 0;
                                                    while($data = $conn->fetch($selrun)){
                                                        $pid = $data['pid'];
                                                        $count ++;
                                                        /*GET THE PRODUCT DETAILS
                                                        $get="SELECT * FROM products_master WHERE pid = '$pid'";
                                                        $getrun = $conn->query($dbconnection,$get);
                                                        $gdata = $conn->fetch($getrun);*/
                                                        ?>
                                                        <tr>
                                                            <td><a onclick="displaysales('<?php echo getproduct($pid); ?>','<?php echo $pid; ?>','<?php echo $stfID ?>','','<?php echo $branch ?>')" href="#"><img src="<?php echo $data['pimg']; ?>" style="width: 50px; height: 50px" class="img-responsive img-rounded"/></a></td>
                                                            <td><a onclick="displaysales('<?php echo getproduct($pid); ?>','<?php echo $pid; ?>','<?php echo $stfID ?>','','<?php echo $branch ?>')" href="#"><?php echo $data['pname']; ?></a></td>
                                                            <td><a onclick="displaysales('<?php echo getproduct($pid); ?>','<?php echo $pid; ?>','<?php echo $stfID ?>','','<?php echo $branch ?>')" href="#"><?php echo getcat($data['cat']); ?></a></td>
                                                            <td><a onclick="displaysales('<?php echo getproduct($pid); ?>','<?php echo $pid; ?>','<?php echo $stfID ?>','','<?php echo $branch ?>')" href="#"><?php echo $data['sprice']; ?></a></td>
                                                        </tr>
                                                    <?php } ?>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Validation Example 1 -->
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12" id="posreceipt">

                            </div>
                        </div>
                        <!-- /Page Content -->
                    </div>
                    <!-- /.container -->

                </div>

            <?php $conn->close($dbconnection);}else{ ?>
            <div id="content">
            <div class="container">
                <!-- Breadcrumbs line -->
                <!-- /Breadcrumbs line -->

                <!--=== Page Header ===-->
                <div class="page-header">
                    <div class="page-title">
                        <h3>Dashboard</h3>
                    </div>

                    <!-- Page Stats -->
                    <!--<ul class="page-stats">
                        <li>
                            <div class="summary">
                                <span>Products Sold</span>
                                <h3></h3>
                            </div>
                            <!-- Use instead of sparkline e.g. this:
                            <div class="graph circular-chart" data-percent="73">73%</div>

                        </li>
                        <li>
                            <div class="summary">
                                <span>Total Amount</span>
                                <h3></h3>
                            </div>
                        </li>
                    </ul>
                    <!-- /Page Stats -->
                </div>
                <!-- /Page Header -->

                <!--=== Page Content ===-->
                <!--=== Statboxes ===-->
                <div class="row row-bg"> <!-- .row-bg -->
                    <h3>User Dashboard</h3>
                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                            $conn=new Db_connect;
                            $dbconnection=$conn->conn();
                            $prod = "SELECT COUNT(*) AS totcount FROM products WHERE shop='$branch'";
                            $prodqry = $conn->query($dbconnection,$prod);
                            $prodsum = $conn->fetch($prodqry);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual cyan">
                                    <i class="icon-food"></i>
                                </div>
                                <div class="title">Products</div>
                                <div class="value"><?php echo $prodsum['totcount']; ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div> <!-- /.col-md-3 -->

                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod2 = "SELECT SUM(tot_sales) AS totcount FROM sales_summary WHERE userid='$stfID' AND shop='$branch' AND transdate BETWEEN '$sdate' AND '$edate'";
                        $prodqry2 = $conn->query($dbconnection,$prod2);
                        $prodsum2 = $conn->fetch($prodqry2);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual green">
                                    <i class="icon-shopping-cart"></i>
                                </div>
                                <div class="title">POS Sales</div>
                                <div class="value">&cent; <?php $tot = $prodsum2['totcount']; if($tot == 0){echo "0.00";}else{echo $tot;} ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div>
                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod2 = "SELECT SUM(p.amount) AS totcount FROM invoice_payment p INNER JOIN customer_invoice c ON c.invoiceid = p.invoiceid WHERE c.salesperson='$stfID' AND c.shop='$branch' AND p.paydate BETWEEN '$sdate' AND '$edate'";
                        $prodqry2 = $conn->query($dbconnection,$prod2);
                        $prodsum2 = $conn->fetch($prodqry2);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual yellow">
                                    <i class="icon-list"></i>
                                </div>
                                <div class="title">Invoice Sales</div>
                                <div class="value">&cent; <?php $tot = $prodsum2['totcount']; if($tot == 0){echo "0.00";}else{echo $tot;} ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div><!-- /.col-md-3 -->
                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod4 = "SELECT COUNT(id) AS totcount FROM customers WHERE shop='$branch'";
                        $prodqry4 = $conn->query($dbconnection,$prod4);
                        $prodsum4 = $conn->fetch($prodqry4);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual red">
                                    <i class="icon-group"></i>
                                </div>
                                <div class="title">Customers</div>
                                <div class="value"><?php $tot = $prodsum4['totcount']; if($tot == 0){echo "0";}else{echo $tot;} ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div> <!-- /.col-md-3 -->
                </div>
                <?php
                $filename = barGraph($stfID);
                if(!empty($filename)){
                    ?>
                    <div class="row row-bg">
                        <div class="col-md-12">
                            <h3>SALES CHART</h3>
                            <img src="<?php echo $filename; ?>" class="img-responsive"/>
                        </div>
                    </div>
                <?php
                }?>
                <?php if($access == "ADMINISTRATOR"){ ?>
                <div class="row row-bg"> <!-- .row-bg -->
                    <h3>Administrator Dashboard</h3>
                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod = "SELECT COUNT(*) AS totcount FROM products_master";
                        $prodqry = $conn->query($dbconnection,$prod);
                        $prodsum = $conn->fetch($prodqry);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual cyan">
                                    <i class="icon-food"></i>
                                </div>
                                <div class="title">All Products</div>
                                <div class="value"><?php echo $prodsum['totcount']; ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div> <!-- /.col-md-3 -->

                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod2 = "SELECT SUM(tot_sales) AS totcount FROM sales_summary WHERE transdate BETWEEN '$sdate' AND '$edate'";
                        $prodqry2 = $conn->query($dbconnection,$prod2);
                        $prodsum2 = $conn->fetch($prodqry2);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual green">
                                    <i class="icon-shopping-cart"></i>
                                </div>
                                <div class="title">Total POS Sales</div>
                                <div class="value">&cent; <?php $tot = $prodsum2['totcount']; if($tot == 0){echo "0.00";}else{echo $tot;} ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div>
                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod2 = "SELECT SUM(p.amount) AS totcount FROM invoice_payment p INNER JOIN customer_invoice c ON c.invoiceid = p.invoiceid WHERE p.paydate BETWEEN '$sdate' AND '$edate'";
                        $prodqry2 = $conn->query($dbconnection,$prod2);
                        $prodsum2 = $conn->fetch($prodqry2);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual yellow">
                                    <i class="icon-list"></i>
                                </div>
                                <div class="title">Invoice Sales</div>
                                <div class="value">&cent; <?php $tot = $prodsum2['totcount']; if($tot == 0){echo "0.00";}else{echo $tot;} ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div><!-- /.col-md-3 -->
                    <?php
                        $prod3 = "SELECT SUM(profit) AS totcount FROM sales_summary WHERE transdate BETWEEN '$sdate' AND '$edate'";
                        $prodqry3 = $conn->query($dbconnection,$prod3);
                        $prodsum3 = $conn->fetch($prodqry3);
                        ?>
                        <div class="col-sm-6 col-md-3 col-xs-6">
                            <div class="statbox widget box box-shadow">
                                <div class="widget-content">
                                    <div class="visual yellow">
                                        <i class="icon-dollar"></i>
                                    </div>
                                    <div class="title">Total Profit</div>
                                    <div class="value">&cent; <?php $tot = $prodsum3['totcount']; if($tot == 0){echo "0.00";}else{echo $tot;} ?></div>
                                </div>
                            </div> <!-- /.smallstat -->
                        </div> <!-- /.col-md-3 -->
                    <div class="col-sm-6 col-md-3 col-xs-6">
                        <?php
                        $prod4 = "SELECT COUNT(id) AS totcount FROM customers";
                        $prodqry4 = $conn->query($dbconnection,$prod4);
                        $prodsum4 = $conn->fetch($prodqry4);
                        ?>
                        <div class="statbox widget box box-shadow">
                            <div class="widget-content">
                                <div class="visual red">
                                    <i class="icon-group"></i>
                                </div>
                                <div class="title">Customers</div>
                                <div class="value"><?php $tot = $prodsum4['totcount']; if($tot == 0){echo "0";}else{echo $tot;} ?></div>
                            </div>
                        </div> <!-- /.smallstat -->
                    </div> <!-- /.col-md-3 -->
                </div>
                <?php
                $filename2 = generalBarGraph();
                if(!empty($filename2)){
                ?>
                <div class="row row-bg">
                    <div class="col-md-12">
                        <img src="<?php echo $filename2; ?>" class="img-responsive"/>
                    </div>
                </div>
                <?php
                }} ?>
                <!-- /.row -->
                <!-- /Statboxes -->
                <!-- /Page Content -->
            </div>
            <!-- /.container -->

        </div>
        <?php $conn->close($dbconnection);} ?>
	</div>
    <?php include("include/modals.php"); ?>
<script src="assets/js/easyNotify.js"></script>
<script type="text/javascript">

    $("#select-all").click(function(event){
        if(this.checked){
            $(':checkbox').each(function(){
               this.checked = true;
            });
        }else{
            $(':checkbox').each(function(){
                this.checked = false;
            });
        }
    });

    ///// NOTIFICATION
    var title = "";
    var dmessage = "";
    var notifyid = $("#duserid").val();

    function shownotify() {
        //onclick function on the popup
        //GETTING THE CURRENT DATE
        var currentDate = new Date()
        var day = currentDate.getDate()
        var month = currentDate.getMonth() + 1
        var year = currentDate.getFullYear()
        var ddate = year + "-" + month + "-" + day;
        var myFunction = function () {
            // alert('Click function');
            //console.log(url)
        };
        var myImg = "assets/images/pnotify/info.png";
        var uRl = "signout.php?userid=" + notifyid;
        //GET THE MESSAGES FOR THE
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getNotify=" + notifyid,
            success: function (data) {
                //console.log(data);
                var result = $.parseJSON(data);
                title = result['title'];
                dmessage = result['msg'];
                var mdate = result['date'];

                var lastlogin = result['lastlogin'];
                $("#activityCount").html(result['actcount']);
                $("#activityalert").html(result['actmsg']);
                $("#memoCount").html(result['memcount']);
                $("#memoalert").html(result['memmsg']);
                //if(lastlogin < 1200){
                if(lastlogin < 3600){
                    if (dmessage != "No Memo Available" && title != "") {
                        var audio = new Audio('assets/audio/notify.mp3');
                        audio.play();
                        var options = {
                            title: title,
                            options: {
                                body: dmessage,
                                icon: myImg,
                                lang: 'en-US',
                                onClick: myFunction,
                                onClose: "",
                                onError: ""
                            }
                        };
                        $("#easyNotify").easyNotify(options);
                    }
                }else{
                    location.replace(uRl);
                }

            },
            error: function (xhr, desc, err) {
            }
        });

        //console.log(options);
    }
    setTimeout(function(){ shownotify(); }, 1000);
    setInterval(function () { shownotify();}, 3000);
    /////END OF NOTIFICATION


    function activateInvoice(invid){
        console.log(invid);
        var branch = $("#branch").val();
        var conf = confirm("Are You Sure You Want To Activate The Invoice? This action cannot be reversed");
        if (conf == true){
            $("#trans_details").modal("show");
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "activateInvoice="+invid+"&shop="+branch,
                success: function (data) {
                    console.log(data);
                    $("#trans_details").modal("hide");
                    var url = "dashboard.php?viewinvoice=" + invid +"&branch="+branch;
                    window.location.replace(url);

                },
                error: function (xhr, desc, err) {
                    alert(err);
                }
            });
        }
    }
    function getbackup(){
        $("#trans_details").modal("show");
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "backup",
            success: function (data) {
                console.log(data);
                $("#trans_details").modal("hide");
                alert("Backup Completed. Please refresh page to see latest backup");
            },
            error: function (xhr, desc, err) {
                alert(err);
            }
        });
    }

    function getTax(taxid){
        console.log(taxid);
        $("#trans_details").modal("show");
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getTax="+taxid,
            success: function (data) {
                var result = $.parseJSON(data);
                var taxid = result['taxid'];
                var name = result['name'];
                var dval = result['dval'];
                var optin = result['optin'];
                var status = result['status'];
                $("#opt").prepend("<option selected value='" + optin + "'>" + optin + "</option>");
                $("#taxstatus").prepend("<option selected value='" + status + "'>" + status + "</option>");
                $("#taxid").val(taxid);
                $("#taxname").val(name);
                $("#percentage").val(dval);
                $("#trans_details").modal("hide");
                $("#taxedit").modal("show");
                console.log(data);
            },
            error: function (xhr, desc, err) {
                alert(err);
            }
        });
    }

    function checkoutpay(){

        var sid = $("#sessionid3").val();
        var tender = $("#paytender").val();
        var bal = $("#pos_bal").val();
        var total = $("#pos_total").val();
        var cname = $("#cname").val();
        var ccontact = $("#ccontact").val();
        var clocation = $("#clocation").val();
        var cid = $("#cid").val();
        var selecttype = $("#custselect").val();
        var branch = $("#branch").val();
        var userid = $("#duserid").val();

        $("#paymentcheckout").addClass("hidden");
        $("#paymentpos").addClass("hidden");
        $("#posreceipt").removeClass("hidden");
        $("#posreceipt").html("<div align='center'><img src='assets/images/loader.gif' style='width: 100px; height: 100px;'/><br/>Processing Sales...</div>");

        //console.log(sid+" / "+tender+" / "+bal+" / "+total+" / "+cname+" / "+ccontact+" / "+clocation+" / "+cid+" / "+selecttype );
        //CHECK OUT THE PAYMENT
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "checkoutpay&sid="+sid+"&tender="+tender+"&bal="+bal+"&total="+total+"&cname="+cname+"&ccontact="+ccontact+"&clocation="+clocation+"&cid="+cid+"&selecttype="+selecttype+"&userid="+userid+"&branch="+branch,
            success: function (data) {
                console.log(data);
                var result = $.parseJSON(data);
                var msg = result['msg'];
                var sid = result['newsid'];
                var sprice = result['newsprice'];
                $("#posreceipt").html(msg);
                //SET NEW SID
                $("#sessionid3").val(sid);
                //RESET POS
                $("#paytender").val("");
                $("#pos_bal").val("");
                $("#pos_total").val("");
                $("#cname").val("");
                $("#ccontact").val("");
                $("#clocation").val("");
                $("#custselect").val("no");
                $("#salesdisplay").text("Empty Cart");
                $("#pos_totaldisp").text("GHS 0.00");
                $("#pos_baldisp").text("0.00");
                $("#psalestot").text("GHS "+sprice);


            },
            error: function (xhr, desc, err) {
                alert(err);
            }
        });
    }

    function singleproduct(){
        $("#trans_details").modal("show");
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getproductselectwh",
            success: function (data) {
                console.log(data);
                $("#sprodtrans").html(data);
                $("#trans_details").modal("hide");
                $("#product_transfer").modal("show");
            },
            error: function (xhr, desc, err) {
                alert(err);
            }
        });
    }

    function shopproduct(){
        $("#trans_details").modal("show");
        var branch = $("#branch").val();
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getproductselectshop="+branch,
            success: function (data) {
                console.log(data);
                $("#shoptransfer").html(data);
                $("#trans_details").modal("hide");
                $("#shop_transfer").modal("show");
            },
            error: function (xhr, desc, err) {
                alert(err);
            }
        });
    }
    function resetpos(){
        $("#paymentcheckout").addClass("hidden");
        $("#paymentpos").removeClass("hidden");
        $("#posreceipt").addClass("hidden");
        $("#bcodescan").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan").focus();
    }

    function checkpass(id){
        console.log(id);
        var regexp = /^[0-9a-zA-Z]+$/;
        if (id.match(regexp) && id.length >= 8) {
            //console.log(entry + " is accepted")
            $("#simg").removeClass("hidden");
        } else {
            $("#simg").addClass("hidden");
        }
    }
    function confpass() {
        var npass = $("#npass").val();
        var rpass = $("#rpass").val();
        if (rpass == npass) {
            $("#ssimg").removeClass("hidden");
            $("#chsub").removeClass("hidden");
        } else {
            $("#ssimg").addClass("hidden");
            $("#chsub").addClass("hidden");
        }
    }
    function checkusername(){
        var pword = $("#password").val();
        var confpword = $("#confpassword").val();
        var username = $("#username").val();
        $("#psucc").addClass("hidden");
        $("#unamefail").addClass("hidden");
        $("#pfail").addClass("hidden");
        //CHeck if username is already taken
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "usercheck=" + username,
            success: function (data) {
                //console.log(data);
                var result = $.parseJSON(data);
                var msg = result['msg'];
                if (msg != "allowed") {
                    $("#unamefail").removeClass("hidden");
                }
               else {
                    if(pword == confpword){
                        $("#psucc").removeClass("hidden");
                        $("#pfail").addClass("hidden");
                        document.getElementById("userreg").submit();
                    }else{
                        $("#psucc").addClass("hidden");
                        $("#pfail").removeClass("hidden");
                    }
                }

            },
            error: function (xhr, desc, err) {
                alert(err);
            }
        });
        return false;
    }

    function checkpword(){
        var pword = $("#password").val();
        var confpword = $("#confpassword").val();
        if(pword == confpword){
            $("#psucc").removeClass("hidden");
            $("#pfail").addClass("hidden");
        }else{
            $("#psucc").addClass("hidden");
            $("#pfail").removeClass("hidden");
        }
    }

    function displaysales(pname,id,user,sid,branch){
        //console.log("CLICKED");
        $("#pid").val(id);
        //GET THE SESSION ID
        var dsid = $("#sessionid3").val();
        $("#sid").val(dsid);
        $("#usr").val(user);
        $("#branchh").val(branch);
        $("#trans_details").modal("show");
        $("#pqty").val("");
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getstock=" + id + "&branch=" + branch,
            success: function (data) {
                console.log(data);
                $("#pstock").text("Stock Value: "+data);
                $("#trans_details").modal("hide");

            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
        document.getElementById("pnameqty").innerText = pname;
        $("#pos_qty").modal("show");
    }

    function displaysales2(pname,id,user,sid,branch){
        //console.log("2222222");
        $("#pid2").val(id);
        $("#sid2").val(sid);
        $("#usr2").val(user);
        $("#branch2").val(branch);
        $("#pqty2").val("");
        document.getElementById("pnameqtywh").innerText = pname;
        $("#pos_qty2").modal("show");
    }

    function updatesales(){
        var pid = $("#pid").val();
        var sid = $("#sid").val();
        var user = $("#usr").val();
        var qty = $("#pqty").val();
        var branch = $("#branch").val();

        if(qty > 0){


            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "possales=" + pid + "&user=" + user + "&sid=" + sid + "&qty=" + qty + "&branch=" + branch,
                success: function (data) {
                    console.log(data);
                    var result = $.parseJSON(data);
                    var msg = result['msg'];
                    var error = result['errorcode'];
                    var dtotal = result['total'];
                    if(error == "001"){
                        alert(msg);
                    }else{
                        $("#pos_qty").modal("hide");
                        $("#pos_total").val(dtotal);
                        document.getElementById("salesdisplay").innerHTML = msg;
                        document.getElementById("pos_totaldisp").innerHTML = "GHC " + dtotal;
                    }

                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }
        else{
            alert("Please Select Quantity Greater Than 0");
        }
        $("#bcodescan").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan").focus();

    }

    function updatesales2(){
        var pid = $("#pid2").val();
        var sid = $("#sid2").val();
        var user = $("#usr2").val();
        var qty = $("#pqty2").val();
        var branch = $("#branch2").val();

        if(qty > 0){
            $("#pos_qty2").modal("hide");
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "possales2=" + pid + "&user=" + user + "&sid=" + sid + "&qty=" + qty + "&branch=" + branch,
                success: function (data) {
                    //console.log(data);
                    var result = $.parseJSON(data);
                    var msg = result['msg'];
                    var error = result['errorcode'];
                    var dtotal = result['total'];
                    if(error == "001"){
                        alert(msg);
                    }else{
                        $("#pos_qty2").modal("hide");
                        $("#pos_totalwh").val(dtotal);
                        document.getElementById("salesdisplay2").innerHTML = msg;
                        document.getElementById("pos_totaldispwh").innerHTML = "GHC " + dtotal.toFixed(2);
                    }

                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }
        else{
            alert("Please Select Quantity Greater Than 0");
        }
        $("#bcodescan2").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan2").focus();
    }

    function calculatebalance(tendered){
        //GET THE COST
        var dtotal = $("#pos_total").val();
        if(tendered == ""){
            $("#invalidtend").removeClass("hidden");
            $("#validtend").addClass("hidden");
        }
        else{
            $("#pos_bal").val((Number(tendered) - Number(dtotal)).toFixed(2));
            document.getElementById("pos_baldisp").innerText = (Number(tendered) - Number(dtotal)).toFixed(2);
            if((Number(tendered) - Number(dtotal)) < 0){
                $("#invalidtend").removeClass("hidden");
                $("#validtend").addClass("hidden");
            }else{
                $("#validtend").removeClass("hidden");
                $("#invalidtend").addClass("hidden");
            }

        }
    }

    function calculatebalance2(tendered){
        //GET THE COST
        var dtotal = $("#pos_totalwh").val();
        if(tendered == ""){
            $("#invalidtendwh").removeClass("hidden");
            $("#validtendwh").addClass("hidden");
        }
        else{
            $("#pos_balwh").val((Number(tendered) - Number(dtotal)).toFixed(2));
            document.getElementById("pos_baldispwh").innerText = (Number(tendered) - Number(dtotal)).toFixed(2);
            if((Number(tendered) - Number(dtotal)) < 0){
                $("#invalidtendwh").removeClass("hidden");
                $("#validtendwh").addClass("hidden");
            }else{
                $("#validtendwh").removeClass("hidden");
                $("#invalidtendwh").addClass("hidden");
            }

        }
    }

    function remsales(id){
        //console.log(id);
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "remsales=" + id,
            success: function (data) {
                console.log(data);
                var result = $.parseJSON(data);
                var msg = result['msg'];
                var dtotal = result['total'];
                document.getElementById("salesdisplay").innerHTML = msg;
                document.getElementById("pos_totaldisp").innerHTML = "GHC " + dtotal;
                $("#pos_total").val(dtotal);
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
        $("#bcodescan").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan").focus();
    }

    function remsales2(id){
        //console.log(id);
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "remsales2=" + id,
            success: function (data) {
                //console.log(data);
                document.getElementById("salesdisplay2").innerHTML = data;
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
        $("#bcodescan2").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan2").focus();
    }

    function checkout(){
        $("#paymentcheckout").removeClass('hidden');
        $("#paymentpos").addClass('hidden');
    }

    function continuesales(){
        $("#paymentcheckout").addClass('hidden');
        $("#paymentpos").removeClass('hidden');
        $("#validtend").addClass('hidden');
        $("#invalidtend").removeClass('hidden');
        $("#pos_bal").val(0);
        $("#pos_baldisp").text("0.00");
        $("#paytender").val(0);
    }

    function checkout2(){
        $("#paymentcheckoutwh").removeClass('hidden');
        $("#paymentposwh").addClass('hidden');
    }

    function showcustomer(id){
        //console.log("showwwwww");
        if(id == "new"){
            $("#new_customer").removeClass("hidden");
            $("#exist_customer").addClass("hidden");
            $("#custselect").val("new");
        }
        else if(id == "exist"){
            $("#new_customer").addClass("hidden");
            $("#exist_customer").removeClass("hidden");
            $("#custselect").val("exist");
        }
        else{
            $("#new_customer").addClass("hidden");
            $("#exist_customer").addClass("hidden");
            $("#custselect").val("no");
        }
    }

    function submit_category(){
        var cgname = $("#cgname").val();
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "submit_category=" + cgname,
            success: function (data) {
                //console.log(data);
                if(data == "allowed"){
                    document.getElementById("catsubmit").submit();
                }
                else{
                    document.getElementById("responsemsg").innerText = "Product Category " + cgname +" Already Exists";
                    $("#responsemodal").modal("show");
                    $("#category").modal("hide");
                }

            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function getsalesdetails(sid){
        $("#trans_details").modal("show");
        document.getElementById("transfershow").innerHTML = "";
        $("#loadertrans").removeClass("hidden");
        //console.log(sid);
        //PROCESS THE SESSION ID AND GET THE DETAILS
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "salesdetails=" + sid,
            success: function (data) {
                //console.log(data);
                document.getElementById("transfershow").innerHTML = data;
                $("#loadertrans").addClass("hidden");
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function gettransdetails(sid){
        $("#trans_details").modal("show");
        $("#loader_desc").text("Loading products...");
        console.log(sid);
        //PROCESS THE SESSION ID AND GET THE DETAILS
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "transferdetails=" + sid,
            success: function (data) {
                console.log(data);
                document.getElementById("transfershow").innerHTML = data;
                $("#loadertrans").addClass("hidden");
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function gettransdetails2(sid){
        $("#trans_details").modal("show");
        $("#loader_desc").text("Loading products...");
        console.log(sid);
        //PROCESS THE SESSION ID AND GET THE DETAILS
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "transferdetails2=" + sid,
            success: function (data) {
                console.log(data);
                document.getElementById("transfershow").innerHTML = data;
                $("#loadertrans").addClass("hidden");
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function checktransfer(){
        var qty = $("#tqty").val();
        var pid = $("#tprod").val();
        if(qty == "" || pid == ""){
            alert("Please select And Fill All Fields");
        }
        else{
            //console.log(qty+pid);
            //CHECK IF QUANTITY TO BE TRANSFERRED IS AVAILABLE
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "checktransfers=" + pid + "&qty=" + qty,
                success: function (data) {
                    //console.log(data);
                    var result = $.parseJSON(data);
                    var code = result['code'];
                    var realqty = result['qtyin'];
                    $("#drealqty").val(realqty);
                    if(code == 0){
                        document.getElementById("prodtrans").submit();
                    }else{
                        alert("Your Requested Quantity Of "+qty+" Is More Than The Stock Value Of "+realqty);
                    }

                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }

    }

    function categoryProducts(cid,cname){
        //console.log(cid);
        $("#trans_details").modal("show");
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getcategoryproducts=" + cid,
            success: function (data) {
                //console.log(data);
                $("#categorydetails").html(data);
                $("#cgetname").text(cname);
                $("#trans_details").modal("hide");
                $("#categoryProduct").modal("show");

            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function checktransfer2(){
        var qty = $("#stqty").val();
        var pid = $("#stprod").val();
        var branch = $("#branch").val();
        //console.log(qty + pid + branch);
        if(qty == "" || pid == ""){
            alert("Please select And Fill All Fields");
        }
        else{
            //console.log(qty+pid);
            //CHECK IF QUANTITY TO BE TRANSFERRED IS AVAILABLE
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "shoptransfers=" + pid + "&qty=" + qty + "&branch=" + branch,
                success: function (data) {
                    if(data == "Allowed"){
                        document.getElementById("shoptrans").submit();
                    }else{
                        alert("Quantity you want to transfer is more than the quantity available in the warehouse");
                    }

                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }

    }
    function updateprod(id){
        //console.log(id);
        $("#trans_details").modal("show");
        $("#loader_desc").text("Loading Product Details...");
        //GET THE PRODUCT DETAILS
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getprod=" + id,
            success: function (data) {
                //console.log(data);
                var result = $.parseJSON(data);
                var pid = result['pid'];
                var pname = result['pname'];
                var sprice = result['sprice'];
                var cprice = result['cprice'];
                var qty = result['qty'];
                var pimg = result['pimg'];
                var status = result['status'];
                var cat = result['cat'];
                var cname = result['cname'];
                var barcode = result['barcode'];

                document.getElementById("prodimg").innerHTML = "<img id='blah' src='"+pimg+"' class='img-response' style='width: 20%' />";
                $("#cat").prepend("<option selected value='" + cat + "'>" + cname + "</option>");
                $("#prodstat").prepend("<option selected value='" + status + "'>" + status + "</option>");
                $("#pname").val(pname);
                $("#updpid").val(pid);
                $("#sprice").val(sprice);
                $("#cprice").val(cprice);
                $("#qty").val(qty);
                $("#bcode").val(barcode);
                $("#trans_details").modal("hide");
                $("#product_edit").modal("show");

            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function dispimage(input,id){
        console.log(id);
        var imgid = "#" + id;
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $(imgid)
                    .attr('src', e.target.result)
                    .width(100)
                    .height(100);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    function showfeedback(bname){
        var loc = $("#branch").val();
        var url = "dashboard.php?branch=" + loc
        var link1 = document.getElementById("dboard1");
        var link2 = document.getElementById("dboard2");
        document.getElementById("selloc").innerHTML = bname;
        link1.setAttribute('href', url);
        link2.setAttribute('href', url);
        //console.log(loc);
        $("#bcodescan").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan").focus();

        $("#bcodescan2").css({
            position: 'absolute',
            top: '-1000px'
        });
        $("#bcodescan2").focus();

        var response = $("#test").val();
        var msg = $("#testmsg").val();
        if(response == "no"){
            document.getElementById("responsemsg").innerHTML = msg;
            $("#responsemodal").modal("show");
        }else if(response == "yes"){
            document.getElementById("posresponsemsg").innerHTML = msg;
            $("#posresponsemodal").modal("show");
        }
    }

    function changebranch(bch){
        var url = "dashboard.php?branch=" + bch;
        window.location.replace(url);
        //console.log(bch);
    }


    function editcategory(id,cname){
        $("#catid").val(id);
        $("#catedit").val(cname);
        $("#editcategory").modal("show");
    }

    function scanbcode(stfid, sid, branch){
        var code  = $("#bcodescan").val();
        //console.log("THING IS: "+stfid + sid + branch + code);
        //GET THE PRODUCT ID
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getprodid2=" + code + "&branch=" + branch,
            success: function (data) {
                console.log(data);
                var result = $.parseJSON(data);
                var pid = result['pid'];
                var pname = result['pname'];
                var msg = result['msg'];
                if(data == "nope"){
                    alert("BARCODE, " + code + " ,Does Not Match Any Product");
                }else{
                    $("#pid").val(pid);
                    $("#sid").val(sid);
                    $("#usr").val(stfid);
                    $("#branchh").val(branch);
                    $("#pqty").val("");
                    $("#pnameqty").text(pname);
                    $("#pos_qty").modal("show");
                }
                $("#bcodescan").val("");

            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function scanbcode2(stfid, sid, branch){
        var code  = $("#bcodescan2").val();
        //console.log(stfid + sid + branch + code);
        //GET THE PRODUCT ID
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getprodid=" + code,
            success: function (data) {
                if(data == "nope"){
                    alert("BARCODE, " + code + " ,Does Not Match Any Product");
                }else{
                    $("#pid2").val(data);
                    $("#sid2").val(sid);
                    $("#usr2").val(stfid);
                    $("#branch2").val(branch);
                    $("#pqty2").val("");
                    $("#pos_qty2").modal("show");
                }
                $("#bcodescan2").val("");

            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function getcompany(){
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getcompany",
            success: function (data) {
                //console.log(data);
                var result = $.parseJSON(data);
                var cname = result['cname'];
                var ccont = result['ccont'];
                var cmail = result['cmail'];
                var cloc = result['cloc'];
                var caddr = result['caddr'];
                var clogo = result['clogo'];
                var tag = result['tag'];

                document.getElementById("dcompimg").innerHTML = "<img id='compimg' src='"+clogo+"' class='img-response' style='width: 100px; height: 100px' />";
                $("#cname").val(cname);
                $("#ccont").val(ccont);
                $("#cmail").val(cmail);
                $("#cloc").val(cloc);
                $("#caddr").val(caddr);
                $("#tag").val(tag);
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function getbranch(bid, type){
        console.log(bid);
        $("#trans_details").modal("show");
        if(type == "create"){
            $("#bname").val("");
            $("#bcontact").val("");
            $("#bemail").val("");
            $("#blocate").val("");
            $("#bstatus").addClass("hidden");
            $("#branchcreate").removeClass("hidden");
            $("#branchedit").addClass("hidden");
            $("#branchword").text("Branch Creation");
            $("#loader_desc").text("Branch Creation In Progress....");
        }else{
            //GET THE BRANCH DETAILS
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "getbranch="+bid,
                success: function (data) {
                    console.log(data);
                    var result = $.parseJSON(data);
                    var bname = result['bname'];
                    var bcont = result['bcont'];
                    var bmail = result['bmail'];
                    var bloc = result['bloc'];
                    var status = result['bstatus'];

                    $("#bname").val(bname);
                    $("#brancheditid").val(bid);
                    $("#bcontact").val(bcont);
                    $("#bemail").val(bmail);
                    $("#blocate").val(bloc);
                    $("#bstatus").removeClass("hidden");
                    $("#branchcreate").addClass("hidden");
                    $("#branchedit").removeClass("hidden");
                    $("#branchword").text("Branch Update");
                    $("#loader_desc").text("Branch Update In Progress....");
                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }
        $("#trans_details").modal("hide");
        $("#branch_create").modal("show");

    }

    function addinvoice() {
        //GET THE PRODUCTS ASSIGNED TO THE SHOP
        var branch = $("#branch").val();
        var counter = $("#rowcounter").val();
        var ncounter = Number(counter) + 1;
        var invtype = $("#invtype").val();
        $("#rowcounter").val(ncounter);

        //console.log(invtype);
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getproductselect=" + branch + "&count=" + ncounter+"&invtype=" + invtype,
            success: function (data) {
                //console.log(data);
                var new_row = "<tr id='" + ncounter + "'><td>" + data + "</td><td><input class = 'form-control' type = 'number' name = 'qty[]' id = 'qty"+ncounter+"' value='1' onchange='calcprod("+ncounter+")' min='1' required></td><td><input class = 'form-control' type = 'text' name = 'price[]' id = 'price"+ncounter+"' value='0' onchange='calcprod2("+ncounter+")'  /></td><td><input class = 'form-control' type = 'text'  id = 'subtotal"+ncounter+"' value='0' readonly></td><td><a onclick='removeRow(" + ncounter + ")'><span class='icon icon-trash btn btn-danger'></span></a></td></tr>";
                $(".dataTables-example").append(new_row);
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function invoicetype(id){
        document.getElementById("pvbody").innerHTML = "";
        $("#rowcounter").val("0");
        $("#invtype").val(id);
        if(id == "invoice"){
            $("#geninvoice").removeClass("hidden");
            $("#genquote").addClass("hidden");
            $("#invdesc").text("Generate Invoice");
        }else{
            $("#geninvoice").addClass("hidden");
            $("#genquote").removeClass("hidden");
            $("#invdesc").text("Generate Quotation");
        }
        $("#compinvoices").modal("show");
    }

    function warehousetransfer() {
        //GET THE PRODUCTS ASSIGNED TO THE SHOP
        var counter = $("#rowcounterwh").val();
        var ncounter = Number(counter) + 1;
        $("#rowcounterwh").val(ncounter);
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getproductselectwh=" + ncounter,
            success: function (data) {
                console.log(data);
                var new_row = "<tr id='" + ncounter + "'><td>" + data + "</td><td><input class = 'form-control' type = 'number' name = 'qtywh[]' id = 'qtywh"+ncounter+"' value='1' onchange='calcprodwh("+ncounter+")' min='1' required></td><td><a onclick='removeRowwh(" + ncounter + ")'><span class='icon icon-trash btn btn-danger'></span></a></td></tr>";
                $(".dataTables-example2").append(new_row);
                //console.log(new_row);
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }
    function removeRow(id) {
        //console.log(id);
        var parent = document.getElementById("pvbody");
        var child = document.getElementById(id);
        parent.removeChild(child);
    }

    function removeRowwh(id) {
        //console.log(id);
        var parents = document.getElementById("pvbodywh");
        var childs = document.getElementById(id);
        parents.removeChild(childs);
    }

    //FUNCTION FOR CHECKING IF  A FILE IS IN EXCEL FORMAT
    var _validFile = [".xlsx",".xlsm"];
    function checkexcel(oForm) {
        var arrInputs = oForm.getElementsByTagName("input");
        for (var i = 0; i < arrInputs.length; i++) {
            var oInput = arrInputs[i];
            if (oInput.type == "file") {
                var sFileName = oInput.value;
                if (sFileName.length > 0) {
                    var blnValid = false;
                    for (var j = 0; j < _validFile.length; j++) {
                        var sCurExtension = _validFile[j];
                        if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                            blnValid = true;
                            break;
                        }
                    }

                    if (!blnValid) {
                        alert("The file you have uploaded is not valid. Make sure to upload the approved ");
                        return false;

                    }
                }
            }
        }


        return true;
    }

    function calcprod(id){
        //console.log(id);
        //GET THE CURRENT TOTAL
        var selid = "#selprod" + id
        var qtyid = "#qty" + id
        var pid = $(selid).val();
        var qty = $(qtyid).val();
        var branch = $("#branch").val();
        var invtype = $("#invtype").val();
        /*GET THE RADIO BUTTON VALUE FOR INVOICE TYPE
        var rvalue = "quotation";
        if (document.getElementById('radioquote').checked) {
            rvalue = "quotation";
        }else if (document.getElementById('radioinvoice').checked) {
            rvalue = "invoice";
        }
        console.log(rvalue);*/
        if(pid == ""){
            alert("Please select a product to continue");
        }else{
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "getproductprice=" + pid +"&qty=" + qty + "&branch=" + branch+"&invtype="+invtype,
                success: function (data) {
                    console.log("Returned Data Is: " + data+" : "+invtype);
                    var result = $.parseJSON(data);
                    var sprice = result['sprice'];
                    var subtotal = result['subtotal'];
                    var msg = result['msg'];

                    if(msg == "OK"){
                        var priceid = "#price" + id;
                        var subtotalid = "#subtotal" + id;
                        $(priceid).val(sprice);
                        $(subtotalid).val(subtotal);
                    }else if(msg == "NOQTY"){
                        alert("Please Enter The Quantity")
                    }
                    else{
                        var priceid = "#price" + id;
                        var subtotalid = "#subtotal" + id;
                        $(priceid).val("0.00");
                        $(subtotalid).val("0.00");
                        $(qtyid).val("");
                        alert("Quantity In Stock Is Less Than The Quantity Specified. Please Try Again")
                    }


                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }
    }

    function validatequotation(id){
        var branch = $("#branch").val();
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "validatequotation=" + id + "&branch=" + branch,
            success: function (data) {
                console.log(data);
                if(data == "OK"){
                    var uRl = "dashboard.php?invoicegenerate=" + id;
                    location.replace(uRl);
                }else{
                   alert(data);
                }
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

    function calcprod2(id){
        console.log(id);
        //GET THE CURRENT TOTAL
        var selid = "#selprod" + id
        var qtyid = "#qty" + id
        var priceid = "#price" + id

        var pid = $(selid).val();
        var qty = $(qtyid).val();
        var price = $(priceid).val();
        var branch = $("#branch").val();

        console.log("Product Id: " + pid);
        console.log("Quantity: " + qty);
        console.log("Price: " + price);
        console.log("Branch: " + branch);
        if(pid == "" || qty == "" || price == ""){
            alert("Please select All Fields To Continue");
        }else{
            var subtotal = qty * price;
            var subtotalid = "#subtotal" + id;
            $(subtotalid).val(subtotal);
        }
        /*
        if(pid == ""){
            alert("Please select a product to continue");
        }else{
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "getproductprice=" + pid +"&qty=" + qty + "&branch=" + branch,
                success: function (data) {
                    console.log(data);
                    var result = $.parseJSON(data);
                    var sprice = result['sprice'];
                    var subtotal = result['subtotal'];
                    var msg = result['msg'];

                    if(msg == "OK"){
                        var priceid = "#price" + id;
                        var subtotalid = "#subtotal" + id;
                        $(priceid).val(sprice);
                        $(subtotalid).val(subtotal);
                    }else if(msg == "NOQTY"){
                        alert("Please Enter The Quantity")
                    }
                    else{
                        var priceid = "#price" + id;
                        var subtotalid = "#subtotal" + id;
                        $(priceid).val("0.00");
                        $(subtotalid).val("0.00");
                        $(qtyid).val("");
                        alert("Quantity In Stock Is Less Than The Quantity Specified. Please Try Again")
                    }


                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }*/
    }

    function calcprodwh(id){
        //console.log(id);
        //GET THE CURRENT TOTAL
        var selid = "#tprod" + id;
        var qtyid = "#qtywh" + id;
        var pid = $(selid).val();
        var qty = $(qtyid).val();
        console.log(pid);
        if(pid == ""){
            alert("Please Select Product");
        }
        else{
            //GET THE PRICE OF THE PRODUCT
            $.ajax({
                type: "post",
                url: "Ajax-table/ajax.php",
                data: "getproductpricewh=" + pid +"&qty=" + qty,
                success: function (data) {
                    console.log(data);
                    /*var result = $.parseJSON(data);
                    var sprice = result['sprice'];
                    var subtotal = result['subtotal'];
                    var msg = result['msg'];

                    if(msg == "OK"){
                        var priceid = "#pricewh" + id;
                        var subtotalid = "#subtotalwh" + id;
                        $(priceid).val(sprice);
                        $(subtotalid).val(subtotal);
                    }else{
                        var priceid = "#pricewh" + id;
                        var subtotalid = "#subtotalwh" + id;
                        $(priceid).val("0.00");
                        $(subtotalid).val("0.00");
                        $(qtyid).val("");
                        alert("Quantity In Stock Is Less Than The Quantity Specified. Please Try Again")
                    }*/


                },
                error: function (xhr, desc, err) {
                    alert(err);
                    return false;
                }
            });
        }
    }

    function updateuser(userid){
        //console.log(userid);
        $("#trans_details").modal("show");
        $.ajax({
            type: "post",
            url: "Ajax-table/ajax.php",
            data: "getuserinfo=" + userid,
            success: function (data) {
                console.log(data);
                var result = $.parseJSON(data);
                document.getElementById("uuimg").innerHTML = result['img'];
                document.getElementById("userbranch").innerHTML = result['branches'];
                $("#ufname").val(result['fname']);
                $("#ulname").val(result['lname']);
                $("#userrid").val(userid);
                $("#uaccess").prepend("<option selected value='" + result['access'] + "'>" + result['access'] + "</option>");
                $("#trans_details").modal("hide");
                $("#updateuser").modal("show");
            },
            error: function (xhr, desc, err) {
                alert(err);
                return false;
            }
        });
    }

</script>
</body>
</html>