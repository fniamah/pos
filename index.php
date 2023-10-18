<?php
include("connection/conn.php");
session_unset();
session_destroy();
//GET THE COMPANY INFORMATION / DETAILS
$cname="COMPANY NAME";
$clogo="assets/images/noimage.png";
$ctag = "";
$conn=new Db_connect;
$dbconnection=$conn->conn();
$getcomp = "SELECT cname, clogo, tag FROM company";
$getcomprun = $conn->query($dbconnection,$getcomp);
if($conn->sqlnum($getcomprun) != 0){
    $getcompdata = $conn->fetch($getcomprun);
    $cname = $getcompdata['cname'];
    $clogo = $getcompdata['clogo'];
    $ctag = $getcompdata['tag'];
}
$conn->close($dbconnection);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Login | <?php echo $cname; ?></title>

    <!--=== CSS ===-->

    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <!-- Theme -->
    <link href="assets/css/main.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/plugins.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />

    <!-- Login -->
    <link href="assets/css/login.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="assets/css/fontawesome/font-awesome.min.css">
    <!--[if IE 7]>
    <link rel="stylesheet" href="assets/css/fontawesome/font-awesome-ie7.min.css">
    <![endif]-->

    <!--[if IE 8]>
    <link href="assets/css/ie8.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>

    <!--=== JavaScript ===-->

    <script type="text/javascript" src="assets/js/libs/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="assets/js/libs/lodash.compat.min.js"></script>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="assets/js/libs/html5shiv.js"></script>
    <![endif]-->

    <!-- Beautiful Checkboxes -->
    <script type="text/javascript" src="plugins/uniform/jquery.uniform.min.js"></script>

    <!-- Form Validation -->
    <script type="text/javascript" src="plugins/validation/jquery.validate.min.js"></script>

    <!-- Slim Progress Bars -->
    <script type="text/javascript" src="plugins/nprogress/nprogress.js"></script>

    <!-- Noty -->
    <script type="text/javascript" src="plugins/noty/jquery.noty.js"></script>
    <script type="text/javascript" src="plugins/noty/layouts/top.js"></script>
    <script type="text/javascript" src="plugins/noty/themes/default.js"></script>

    <!-- App -->
    <script type="text/javascript" src="assets/js/login.js"></script>
    <script type="text/javascript" src="assets/js/myjs.js"></script>
    <script>
        $(document).ready(function(){
            "use strict";

            Login.init(); // Init login JavaScript
        });
    </script>
</head>

<body class="login" style="background-image: url('assets/images/backgrounds/bg.jpg'); background-repeat: no-repeat; height: 100%; background-position: center; background-size: cover">
<!-- Logo -->
<div class="logo" style="color: #FFFFFF;">
    Adwuma<img src="assets/img/logo.png" alt="logo" />
    <strong>Wura</strong>
</div>
<!-- /Logo -->

<!-- Login Box -->
<div class="box">
    <div class="content">
        <!-- Login Formular -->
        <form method="post" class="form-vertical" id="loginform2">
            <input type="hidden" name="login"  value=""/>
            <!-- Title -->
            <div class="form-group" align="center">
                <img src="<?php echo $clogo; ?>" class="img-responsive" style="width: 100px; height: 100px;"/>
            </div>
            <h3 class="form-title">Sign In</h3>
            <!-- Input Fields -->
            <div class="form-group">
                <!--<label for="username">Username:</label>-->
                <div class="input-icon">
                    <i class="icon-user"></i>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Username" autofocus="autofocus" data-rule-required="true" data-msg-required="Please enter your username." />
                </div>
            </div>
            <div class="form-group">
                <!--<label for="password">Password:</label>-->
                <div class="input-icon">
                    <i class="icon-lock"></i>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Password" data-rule-required="true" data-msg-required="Please enter your password." />
                </div>
            </div>
            <!-- /Input Fields -->

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="button" class="submit btn btn-primary pull-right" id="loadbtn" onclick="logIn()">
                    Sign In <i class="icon-angle-right"></i>
                </button>
                <div align="center" id="loader" class="hidden"><img src="assets/images/loader.gif" class="img-responsive"  width="50" height="50"/><br/>
                <p style="font-size: smaller">user validation in progress</p></div>
            </div>
        </form>
        <!-- /Login Formular -->
    </div> <!-- /.content -->
</div>
<!-- /Login Box -->
</body>
</html>