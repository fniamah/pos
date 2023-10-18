<div class="modal fade" id="user_create">
    <div class="modal-dialog">
        <form method="post" enctype="multipart/form-data" id="userreg">
            <input type="hidden" value="<?php echo $branch; ?>" name="branch" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">CREATE USER</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <td align="center" colspan="2">
                                <label>
                                    <input type="file" class="form-control" style="display:none" name="userimg" onchange="dispimage(this,'blah4')"/>
                                    <span><img id="blah4" src="assets/images/noimage.png" width="100" height="100" class="img-responsive img-rounded" /></span><br/>
                                    <div>Click To Upload Picture</div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">First Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="fname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Last Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="lname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Gender <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td>
                                <select class="select2-active form-control" name="gender" required>
                                    <option value="MALE">MALE</option>
                                    <option value="FEMALE">FEMALE</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Phone Number <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="contact" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Address / Location Details</p></td>
                            <td><textarea name="address" class="form-control" rows="3" maxlength="100"></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2"><p class="mainbold">Account Details</p></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Access Level <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td>
                                <select class="select2-active form-control" name="access" required>
                                    <option value="ADMINISTRATOR">ADMINISTRATOR</option>
                                    <option value="USER">USER</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Branch(es)</p></td>
                            <td>
                                <table border="0">
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $sel = "SELECT bname, id FROM branches WHERE status = 'Active'";
                                    $selrun = $conn->query($dbconnection,$sel);
                                    while($data = $conn->fetch($selrun)){
                                        $bname = $data['bname'];
                                        $bid = $data['id'];
                                        echo "<tr><td><input type='checkbox' class='checkbox' name='reclist[]' value='$bid' /></td><td>$bname</td></tr>";
                                    }$conn->close($dbconnection); ?>
                                </table>

                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="createUser('userreg')">Add User</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="updateuser">
    <div class="modal-dialog">
        <form method="post" enctype="multipart/form-data" id="userregedit">
            <input type="hidden" value="<?php echo $branch; ?>" name="branch" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <input type="hidden" id="userrid" name="userid" />
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">UPDATE USER INFO</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <!--<td align="center" colspan="2"><div id="uuimg"></div><p>User Image</p></td>-->
                            <td align="center" colspan="2">
                                <label>
                                    <input type="file" class="form-control" style="display:none" name="userimgedit" onchange="dispimage(this,'blahuimg')"/>
                                    <span id="uuimg"></span><br/>
                                    <div class="mainbold">Click To Update Picture</div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">First Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="fname" id="ufname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Last Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="lname" id="ulname" required/></td>
                        </tr>
                        <!--<tr>
                            <td align="right"><p style="font-weight: bold;">Change Image?</p></td>
                            <td><input type="file" class="form-control" name="userimg" onchange="dispimage(this,'blahuimg')" /></td>
                        </tr>-->
                        <tr>
                            <td align="right" colspan="2"><p style="font-weight: bold;text-align: center;">Account Details</p></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Access Rights <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td>
                                <select class="select2-active form-control" name="access" id="uaccess" required>
                                    <option value="ADMINISTRATOR">ADMINISTRATOR</option>
                                    <option value="MANAGER">MANAGER</option>
                                    <option value="USER">USER</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">User Status <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td>
                                <select class="select2-active form-control" name="status" required>
                                    <option value="ACTIVE">ACTIVE</option>
                                    <option value="INACTIVE">INACTIVE</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Branch(es)</p></td>
                            <td>
                                <table border="0" id="userbranch">
                                </table>

                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary"  onclick="createUser('userregedit')">Save User</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="branch_create">
    <div class="modal-dialog">
        <form method="post" enctype="multipart/form-data" id="branchform">
            <input type="hidden" value="<?php echo $branch; ?>" name="branch" />
            <input type="hidden" name="brancheditid" id="brancheditid" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="branchword"></h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Branch Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="bname" id="bname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Contact</p></td>
                            <td><input type="text" class="form-control" name="bcontact" id="bcontact" /></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">E-Mail</p></td>
                            <td><input type="text" class="form-control" name="bemail" id="bemail" /></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Location</p></td>
                            <td><input type="text" class="form-control" name="bloc" id="blocate" /></td>
                        </tr>
                        <tr id="bstatus">
                            <td align="right"><p style="font-weight: bold;">Status</p></td>
                            <td>
                                <select class="form-control" name="bstatus">
                                    <option value="ACTIVE">ACTIVE</option>
                                    <option value="INACTIVE">INACTIVE</option>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" name="branchcreate" id="branchcreate" onclick="createUser('branchform')">Create Branch</button>
                    <button type="button" class="btn btn-primary" name="branchedit" id="branchedit" onclick="createUser('branchform')">Edit Branch</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="responsemodal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2" align="center"><img src="../pos/assets/images/pnotify/danger.png" /></div>
                    <div class="col-md-10" id="responsemsg" align = "center"></div>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="category">
    <div class="modal-dialog">
        <form method="post" id="catsubmit">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">PRODUCT CATEGORY</h4>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Category Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b>:</p></td>
                            <td><input type="text" class="form-control" name="cgname" id="cgname" required/><small style="color: #F00" id="cgfail" class="hidden">Category Already Created!!</small></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="createUser('catsubmit')">Save Category</button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="receipt_search">
    <div class="modal-dialog">
        <input type="hidden" name="branch" value="<?php echo $branch ?>" />
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">RECEIPT SEARCH</h4>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tr>
                        <td align="right"><p style="font-weight: bold;">Receipt Number <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b>:</p></td>
                        <td><input type="text" class="form-control" id="viewslip" required/></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="getReceipt()"><span class="icon icon-search"></span>Search</button>
            </div>
        </div>
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="product_create">
    <div class="modal-dialog">
        <form method="post" enctype="multipart/form-data" id="productform">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">PRODUCT CREATION</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <!--<td align="center" colspan="2"><img id="blah2" src="assets/images/noimage.png" style="width: 100px; height: 100px"/></td>-->
                            <td align="center" colspan="2">
                                <label>
                                    <input type="file" class="form-control" style="display:none" name="pimg" onchange="dispimage(this,'blah2')"/>
                                    <span><img id="blah2" src="assets/images/noimage.png" width="100" height="100" class="img-responsive img-rounded" /></span><br/>
                                    <div>Click To Upload Picture</div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Product Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="pname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Selling Price <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="number" class="form-control" name="sprice" required step="any" min="0.00" placeholder="0.00"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Cost Price <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="number" class="form-control" name="cprice" value="0.00" step="any" min="0.00" placeholder="0.00"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Quantity</p></td>
                            <td><input type="number" class="form-control" name="qty"  min="0" placeholder="0"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Category <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td>
                                <select class="select2-active form-control" name="cat" required>
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $sel = "SELECT id,cname FROM category WHERE status = 'Active' ORDER BY cname ASC";
                                    $selrun = $conn->query($dbconnection,$sel);
                                    while($data = $conn->fetch($selrun)){
                                        ?>
                                        <option value="<?php echo $data['id'] ?>"><?php echo $data['cname']; ?></option>
                                    <?php }$conn->close($dbconnection); ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Barcode</p></td>
                            <td><input type="text" class="form-control" name="barcode"/></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="createUser('productform')">Save Product</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="company">
    <div class="modal-dialog">
        <form method="post" enctype="multipart/form-data" id="companycreate">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">COMPANY DETAILS</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <td align="center" colspan="2">
                                <label>
                                    <input type="file" class="form-control" style="display:none" name="clogo" onchange="dispimage(this,'compimg')"/>
                                    <span id="dcompimg"><img id="compimg" src="assets/images/noimage.png" width="100" height="100" class="img-responsive img-rounded" /></span><br/>
                                    <div>Click To Upload Picture</div>
                                </label>
                            </td>
                        </tr>

                        <tr>
                            <td align="right"><p style="font-weight: bold;">Company Name <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="cname" id="cname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Phone Number <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td><input type="text" class="form-control" name="ccont" id="ccont" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">E-mail</p></td>
                            <td><input type="text" class="form-control" name="cmail" id="cmail"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Location</p></td>
                            <td><input type="text" class="form-control" name="cloc" id="cloc" /></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Address</p></td>
                            <td><textarea maxlength="100" name="caddr" rows="3" class="form-control" id="caddr"></textarea></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Tag Line</p></td>
                            <td><input type="text" class="form-control" name="tag" id="tag" /></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="createUser('companycreate')">SAVE</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="product_edit">
    <div class="modal-dialog">
        <form method="post" enctype="multipart/form-data" id="productedit">
            <input type="hidden" id="updpid" name="updpid" />
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">UPDATE PRODUCT DETAILS</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <td align="center" colspan="2">
                                <label>
                                    <input type="file" class="form-control" style="display:none" name="updpimg" onchange="dispimage(this,'prodimg')"/>
                                    <span id="prodimg"><img id="compimg" src="assets/images/noimage.png" width="100" height="100" class="img-responsive img-rounded" /></span><br/>
                                    <div>Click To Upload Picture</div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Product Name</p></td>
                            <td><input type="text" class="form-control" id="pname" name="pname" required/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Selling Price</p></td>
                            <td><input type="number" class="form-control" id="sprice" name="sprice" required step="any" min="0.00" placeholder="0.00"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Cost Price</p></td>
                            <td><input type="number" class="form-control" id="cprice" name="cprice" required step="any" min="0.00" placeholder="0.00"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Quantity</p></td>
                            <td><input type="number" class="form-control" id="qty" name="qty"  min="0" placeholder="0"/></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Category</p></td>
                            <td>
                                <select class="select2-active form-control" id="cat" name="cat">
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $sel = "SELECT id,cname FROM category WHERE status = 'Active' ORDER BY cname ASC";
                                    $selrun = $conn->query($dbconnection,$sel);
                                    while($data = $conn->fetch($selrun)){
                                        ?>
                                        <option value="<?php echo $data['id'] ?>"><?php echo $data['cname']; ?></option>
                                    <?php }$conn->close($dbconnection); ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Status</p></td>
                            <td>
                                <select id="prodstat" class="form-control select" name="prodstat">
                                    <option value="ACTIVE">ACTIVE</option>
                                    <option value="INACTIVE">INACTIVE</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Barcode</p></td>
                            <td><input type="text" class="form-control" id="bcode" name="bcode"/></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="createUser('productedit')">Update Product</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="compinvoices">
    <div class="modal-dialog" style="width: 1000px">
        <form method="post">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden" id="invtype" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="invdesc"></h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Customer Name<b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></div>
                            <div class="col-md-8" align="left"><input type="text" class="form-control" name="custname" required/></div>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Invoice Date <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></div>
                            <div class="col-md-8" align="left"><input type="date" class="form-control" name="invdate" value="<?php echo date('Y-m-d'); ?>" required/></div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Contact</div>
                            <div class="col-md-8" align="left"><input type="text" class="form-control" name="cont"/></div>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Due Date</div>
                            <div class="col-md-8" align="left"><input type="date" class="form-control" name="duedate" value="<?php echo date('Y-m-d'); ?>"/></div>
                        </div>
                    </div>
                    <div class="row" style=" margin-top: 30px">
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Organization</div>
                            <div class="col-md-8" align="left"><input type="text" class="form-control" name="organ"/></div>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Organization Contact</div>
                            <div class="col-md-8" align="left"><input type="text" class="form-control" name="orgcont" /></div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Location Address</div>
                            <div class="col-md-8" align="left"><input type="text" class="form-control" name="orgloc"/></div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-12">
                            <input type="hidden" value="0" id="rowcounter"/>
                            <table class="table table-bordered dataTables-example">
                                <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Sub Total</th>
                                </tr>
                                </thead>
                                <tbody id="pvbody">

                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-12"><a onclick="addinvoice()">Add New Items</a> </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" name="generatequotes" class="btn btn-primary" id="genquote">Generate Quotation</button>
                    <button type="submit" name="generateinvoice" class="btn btn-success hidden" id="geninvoice">Generate Invoice</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div id="taxconfig" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h3 class="modal-title">Create Tax</h3>
            </div>
            <div class="modal-body">
                <form method="post" id="taxconfigg">
                    <div class="row" id="hidethis">
                        <div class="col-md-12">
                            <p style="font-weight: bold; font-style: italic; color: #FD550F; text-align: center;"><b>Note:</b><br>
                                Enter a percentage value in the percentage text box. Use (-) for deductible taxes. Eg: -7.5
                            </p>
                        </div>
                        <div class="col-md-12">
                            <table width="100%" class="table">
                                <tr>
                                    <td align="right">Tax ID:</td>
                                    <td><input type="text" name="taxid" class="form-control" required placeholder="Eg: VAT,NHIA" maxlength="5"/></td>
                                </tr>
                                <tr>
                                    <td align="right">Name:</td>
                                    <td><input type="text" name="taxname" class="form-control" required /></td>
                                </tr>
                                <tr>
                                    <td align="right">Percentage Value (%):</td>
                                    <td><input type="number" name="percentage" class="form-control" required step="any"/></td>
                                </tr>
                                <tr>
                                    <td align="right">Add In Sales?:</td>
                                    <td>
                                        <select class="form-control" name="opt" required>
                                            <option value="No">No</option>
                                            <option value="Yes">Yes</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center"><button type="button" class="btn btn-success"  name="taxes" onclick="createUser('taxconfigg')">Create</button></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </form>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div id="taxedit" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h3 class="modal-title">Edit Tax</h3>
            </div>
            <div class="modal-body">
                <form method="post" id="taxeditt">
                    <div class="row">
                        <div class="col-md-12">
                            <p style="font-weight: bold; font-style: italic; color: #FD550F; text-align: center;"><b>Note:</b><br>
                                Enter a percentage value in the percentage text box. Use (-) for deductible taxes. Eg: -7.5
                            </p>
                        </div>
                        <div class="col-md-12">
                            <table width="100%" class="table">
                                <tr>
                                    <td align="right">Tax ID:</td>
                                    <td><input type="text" name="taxid" id="taxid" class="form-control" required placeholder="Eg: VAT,NHIA" maxlength="5" readonly/></td>
                                </tr>
                                <tr>
                                    <td align="right">Name:</td>
                                    <td><input type="text" name="taxnamee" id="taxname" class="form-control" required /></td>
                                </tr>
                                <tr>
                                    <td align="right">Percentage Value (%):</td>
                                    <td><input type="number" name="percentage" id="percentage" class="form-control" required step="any"/></td>
                                </tr>
                                <tr>
                                    <td align="right">Add In Sales?:</td>
                                    <td>
                                        <select class="form-control" name="opt" id="opt" required>
                                            <option value="No">No</option>
                                            <option value="Yes">Yes</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Status:</td>
                                    <td>
                                        <select class="form-control" name="taxstatus" id="status" required>
                                            <option value="ACTIVE">ACTIVE</option>
                                            <option value="INACTIVE">INACTIVE</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center"><button type="button" class="btn btn-success"  name="taxes" onclick="createUser('taxeditt')">Update Tax</button></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </form>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="warehousetransfer">
    <div class="modal-dialog" style="width: 1000px">
        <form method="post" id="warehousetransferform">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">WAREHOUSE PRODUCT TRANSFER</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Shop</div>
                            <div class="col-md-8" align="left">
                                <select class="select2-active form-control" name="tshopwh">
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $sell="SELECT id, bname FROM branches WHERE status = 'Active' ORDER BY bname ASC";
                                    $sellrun = $conn->query($dbconnection,$sell);
                                    while($seldata = $conn->fetch($sellrun)){
                                        ?>
                                        <option value="<?php echo $seldata['id'] ?>"><?php echo $seldata['bname'] ?></option>
                                    <?php }$conn->close($dbconnection); ?>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Transfer Date</div>
                            <div class="col-md-8" align="left"><input type="date" class="form-control" name="whdate" value="<?php echo date('Y-m-d'); ?>"/></div>
                        </div>
                    </div>

                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-12">
                            <input type="hidden" value="0" id="rowcounterwh"/>
                            <table class="table table-bordered dataTables-example2">
                                <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                </tr>
                                </thead>
                                <tbody id="pvbodywh">

                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-12"><a onclick="addNewWarehouseProd()">Add New Items</a> </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary hidden" id="transhidden" onclick="createUser('warehousetransferform')">Transfer Product</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="shoptransfer">
    <div class="modal-dialog" style="width: 1000px">
        <form method="post">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">SHOP PRODUCT TRANSFER</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Shop</div>
                            <div class="col-md-8" align="left">
                                <select class="select2-active form-control" name="tshopsh">
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $sell="SELECT id, bname FROM branches WHERE status = 'Active' AND id <> $branch ORDER BY bname ASC";
                                    $sellrun = $conn->query($dbconnection,$sell);
                                    while($seldata = $conn->fetch($sellrun)){
                                        ?>
                                        <option value="<?php echo $seldata['id'] ?>"><?php echo $seldata['bname'] ?></option>
                                    <?php }$conn->close($dbconnection); ?>
                                    <option value="WH">WAREHOUSE</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-4" align="right">Transfer Date</div>
                            <div class="col-md-8" align="left"><input type="date" class="form-control" name="shdate" value="<?php echo date('Y-m-d'); ?>"/></div>
                        </div>
                    </div>

                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-12">
                            <input type="hidden" value="0" id="rowcountersh"/>
                            <table class="table table-bordered dataTables-example3">
                                <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                </tr>
                                </thead>
                                <tbody id="pvbodysh">

                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-12"><a onclick="shoptransfers()">Add New Items</a> </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary hidden" id="transhophidden">Transfer Product</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="product_transfer">
    <div class="modal-dialog">
        <form method="post" id="prodtrans">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <input type="hidden" name="drealqty" value="" id="drealqty"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">SINGLE PRODUCT TRANSFER</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Product <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td id="sprodtrans"></td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Shop <b style="color: #FF0000; font-weight: bold; font-size: large;">*</b></p></td>
                            <td>
                                <select class="select2-active form-control" name="tshop" required>
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $sell="SELECT bname, id FROM branches WHERE status = 'Active' ORDER BY bname ASC";
                                    $sellrun = $conn->query($dbconnection,$sell);
                                    while($seldata = $conn->fetch($sellrun)){
                                        ?>
                                        <option value="<?php echo $seldata['id'] ?>"><?php echo $seldata['bname'] ?></option>
                                    <?php }$conn->close($dbconnection); ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Quantity</p></td>
                            <td><input type="number" class="form-control" name="tqty" id="tqty"  min="0" placeholder="0"/></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="checktransfer()">Transfer Product</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="price_adjust">
    <div class="modal-dialog">
        <form method="post" id="prodtrans">
            <input type="hidden" name="branch" value="<?php echo $branch ?>" />
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">PRICE ADJUSTMENTS</h4>
                </div>
                <div class="modal-body">
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-12">
                            <input type="hidden" value="0" id="rowcounter"/>
                            <table class="table table-striped">
                                <tr><td colspan="2"><p style="text-align: center;font-weight: bold;">Enter positive(+) value for increments and negative(-) value for reductions</p></td></tr>
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
                                </tr>
                            </table>
                            <table class="table table-bordered dataTables-example">
                                <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Sub Total</th>
                                </tr>
                                </thead>
                                <tbody id="pvbody">
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update Prices</button>
                </div>
            </div>
        </form><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="pos_qty">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">ADD QUANTITY</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tr>
                        <td colspan="3"><div style="font-weight: bold; text-align: center; font-size: large;" id="pnameqty"></div></td>
                    </tr>
                    <tr>
                        <td colspan="3"><div style="font-weight: bold; text-align: center; color: #f39503; font-size: medium" id="pstock"></div></td>
                    </tr>
                    <tr>
                        <td align="right"><p style="font-weight: bold;">Quantity</p></td>
                        <td>
                            <input type="number" class="form-control" id="pqty" min="1"/>
                            <input type="hidden" class="form-control" id="sid" />
                            <input type="hidden" class="form-control" id="pid" />
                            <input type="hidden" class="form-control" id="usr" />
                            <input type="hidden" class="form-control" id="branchh" />
                        </td>
                        <td><button class="btn btn-sm btn-success" onclick="updatesales()"><span class="icon icon-next">Add to cart</span></button></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="bulkupload">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Product Bulk Upload</h4>
            </div>
            <div class="modal-body">
                <!-- Tabs-->
                <div class="tabbable tabbable-custom tabbable-full-width">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_overviewmtn" data-toggle="tab">Bulk Upload</a></li>
                    </ul>
                    <div class="tab-content row">
                        <!--=== Overview ===-->
                        <div class="tab-pane active" id="tab_overviewmtn">
                            <form method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table width="100%" class="table">
                                            <tr>
                                                <td>Excel File</td>
                                                <td><input type="file" name="contentdoc" class="form-control" required /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><p style="font-size: small; color: #FD550F;text-align: center;"><i>File should be in excel format and not more than 4 MB.</i></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center"><button type="submit" class="btn btn-primary">Proceed</button></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div> <!-- /.tab-content -->
                </div>
            </div>
            <!--END TABS-->
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="trans_details">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div id="loadertrans" align="center">
                    <img src="assets/images/loader.gif" class="img-responsive img-rounded" style="width: 200px; height: 200px" />
                    <p id="loader_desc">Loading ....</p>
                </div>
                <div id="transfershow"></div>
            </div>
        </div>
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="product_loading" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div id="loadertrans" align="center">
                    <img src="assets/images/loader.gif" class="img-responsive img-rounded" style="width: 200px; height: 200px" />
                    <p id="loader_desc">Loading Products. Please be patient ....</p>
                </div>
            </div>
        </div>
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="transfers">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">PRODUCT TRANSFER REPORT</h4>
            </div>
            <div class="modal-body">
                <form method="get">
                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                    <table class="table table-striped">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Shop</p></td>
                            <td>
                                <select class="form-control" name="transreport">
                                    <option value="All">All Shops</option>
                                    <?php
                                    $conn=new Db_connect;
                                    $dbconnection=$conn->conn();
                                    $selb = "SELECT bname FROM branches ORDER BY bname ASC";
                                    $selbrun = $conn->query($dbconnection,$selb);
                                    while($data = $conn->fetch($selbrun)){
                                        ?>
                                        <option value="<?php echo $data['bname']; ?>"><?php echo $data['bname']; ?></option>
                                    <?php }$conn->close($dbconnection); ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Start Date</p></td>
                            <td>
                                <input type="date" name="sdate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">End Date</p></td>
                            <td>
                                <input type="date" name="edate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="submit" name="warehouse_transfer" class="btn btn-primary">View Report</button>
                            </td>
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

<div class="modal fade" id="user_sales_report">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">USER SALES REPORT</h4>
            </div>
            <div class="modal-body">
                <form method="get">
                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                    <table class="table table-striped">

                        <tr>
                            <td align="right"><p style="font-weight: bold;">Sales Officer</p></td>
                            <td>
                                <select class="form-control" name="user_sales_report">
                                    <?php if($access == "ADMINISTRATOR"){
                                        $conn=new Db_connect;
                                        $dbconnection=$conn->conn();
                                        $seluser = "SELECT userid, fname, lname FROM users ORDER BY fname ASC";
                                        $seluserrun = $conn->query($dbconnection,$seluser);
                                        ?>
                                        <option value="All">All Sales Officers</option>
                                        <?php
                                        while($udata = $conn->fetch($seluserrun)){
                                            ?>
                                            <option value="<?php echo $udata['userid'] ?>"><?php echo $udata['fname']." ".$udata['lname']; ?></option>
                                        <?php }$conn->close($dbconnection); }else{ ?><option value="<?php echo $stfID; ?>"><?php echo $fname." ".$lname; ?></option><?php }?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Start Date</p></td>
                            <td>
                                <input type="date" name="sdate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">End Date</p></td>
                            <td>
                                <input type="date" name="edate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="submit" class="btn btn-primary">View Report</button>
                            </td>
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

<div class="modal fade" id="sales_report">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">SALES REPORT</h4>
            </div>
            <div class="modal-body">
                <form method="get">
                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                    <table class="table table-striped">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Shop</p></td>
                            <td>
                                <select class="form-control" name="salesreport">
                                    <?php
                                    if($access == 'USER'){
                                        ?>
                                        <option value="<?php echo $branch; ?>"><?php echo getbranch($branch); ?></option>
                                    <?php }else{ ?>
                                        <option value="All">All Shops</option>
                                        <?php
                                        $conn=new Db_connect;
                                        $dbconnection=$conn->conn();
                                        $selb = "SELECT id, bname FROM branches ORDER BY bname ASC";
                                        $selbrun = $conn->query($dbconnection,$selb);
                                        while($data = $conn->fetch($selbrun)){
                                            ?>
                                            <option value="<?php echo $data['id']; ?>"><?php echo $data['bname']; ?></option>
                                        <?php }$conn->close($dbconnection); } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Sales Officer</p></td>
                            <td>
                                <select class="form-control" name="salesofficer">
                                    <?php if($access == "ADMINISTRATOR"){
                                        $conn=new Db_connect;
                                        $dbconnection=$conn->conn();
                                        $seluser = "SELECT userid, fname, lname FROM users ORDER BY fname ASC";
                                        $seluserrun = $conn->query($dbconnection,$seluser);
                                        ?>
                                        <option value="All">All Sales Officers</option>
                                        <?php
                                        while($udata = $conn->fetch($seluserrun)){
                                            ?>
                                            <option value="<?php echo $udata['userid'] ?>"><?php echo $udata['fname']." ".$udata['lname']; ?></option>
                                        <?php }$conn->close($dbconnection); }else{ ?><option value="<?php echo $stfID; ?>"><?php echo $fname." ".$lname; ?></option><?php }?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Start Date</p></td>
                            <td>
                                <input type="date" name="sdate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">End Date</p></td>
                            <td>
                                <input type="date" name="edate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="submit" class="btn btn-primary">View Report</button>
                            </td>
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
<div class="modal fade" id="invoice_sales_report">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">INVOICE PAYMENTS REPORT</h4>
            </div>
            <div class="modal-body">
                <form method="get">
                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                    <table class="table table-striped">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Shop</p></td>
                            <td>
                                <select class="form-control" name="invoicereport">
                                    <?php
                                    if($access == 'USER'){
                                        ?>
                                        <option value="<?php echo $branch; ?>"><?php echo getbranch($branch); ?></option>
                                    <?php }else{ ?>
                                        <option value="All">All Shops</option>
                                        <?php
                                        $conn=new Db_connect;
                                        $dbconnection=$conn->conn();
                                        $selb = "SELECT id, bname FROM branches ORDER BY bname ASC";
                                        $selbrun = $conn->query($dbconnection,$selb);
                                        while($data = $conn->fetch($selbrun)){
                                            ?>
                                            <option value="<?php echo $data['id']; ?>"><?php echo $data['bname']; ?></option>
                                        <?php }$conn->close($dbconnection); } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Sales Officer</p></td>
                            <td>
                                <select class="form-control" name="salesofficer">
                                    <?php if($access == "ADMINISTRATOR"){
                                        $conn=new Db_connect;
                                        $dbconnection=$conn->conn();
                                        $seluser = "SELECT userid, fname, lname FROM users ORDER BY fname ASC";
                                        $seluserrun = $conn->query($dbconnection,$seluser);
                                        ?>
                                        <option value="All">All Sales Officers</option>
                                        <?php
                                        while($udata = $conn->fetch($seluserrun)){
                                            ?>
                                            <option value="<?php echo $udata['userid'] ?>"><?php echo $udata['fname']." ".$udata['lname']; ?></option>
                                        <?php }$conn->close($dbconnection); }else{ ?><option value="<?php echo $stfID; ?>"><?php echo $fname." ".$lname; ?></option><?php }?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Start Date</p></td>
                            <td>
                                <input type="date" name="sdate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">End Date</p></td>
                            <td>
                                <input type="date" name="edate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="submit" class="btn btn-primary"><span class="icon icon-money"></span> View Payment Report</button>
                            </td>
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

<div class="modal fade" id="sales_summary_report">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">SALES SUMMARY REPORT</h4>
            </div>
            <div class="modal-body">
                <form method="get">
                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                    <table class="table table-striped">
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Shop</p></td>
                            <td>
                                <select class="form-control" name="salesummaryreport">
                                    <?php
                                    if($access == 'USER'){
                                        ?>
                                        <option value="<?php echo $branch; ?>"><?php echo getbranch($branch); ?></option>
                                    <?php }else{ ?>
                                        <option value="All">All Shops</option>
                                        <?php
                                        $conn=new Db_connect;
                                        $dbconnection=$conn->conn();
                                        $selb = "SELECT id, bname FROM branches ORDER BY bname ASC";
                                        $selbrun = $conn->query($dbconnection,$selb);
                                        while($data = $conn->fetch($selbrun)){
                                            ?>
                                            <option value="<?php echo $data['id']; ?>"><?php echo $data['bname']; ?></option>
                                        <?php }$conn->close($dbconnection); } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">Start Date</p></td>
                            <td>
                                <input type="date" name="sdate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><p style="font-weight: bold;">End Date</p></td>
                            <td>
                                <input type="date" name="edate" class="form-control" value="<?php echo date('Y-m-d') ?>" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="submit" class="btn btn-primary">View Report</button>
                            </td>
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

<div class="modal fade" id="posresponsemodal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2" align="center"><img src="../pos/assets/images/pnotify/success.png" /></div>
                    <div class="col-md-10" id="posresponsemsg" align = "center"></div>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="editcategory">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <form method="post" id="categoryedit">
                    <input type="hidden" id="catid" name="catid"/>
                    <input type="hidden" name="product_category"/>
                    <input type="hidden" name="branch" value="<?php echo $branch ?>" />
                    <input type="hidden"  value="<?php echo $stfID; ?>" name="duserid"/>
                    <div class="row">
                        <table class="table">
                            <tr>
                                <td colspan="2" align="center"><p style="font-size: large; font-weight: bold">EDIT CATEGORY</p></td>
                            </tr>
                            <tr>
                                <td align="right"><b>Category Name</b></td>
                                <td align="left"><input type="text" id="catedit" name="catedit" class="form-control" required/> </td>
                            </tr>
                            <tr>
                                <td align="right"><b>Category Status</b></td>
                                <td align="left">
                                    <select class="select2-search form-control" name="catstatus" id="catstatus">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><button type="button" class="btn btn-lg btn-success" onclick="createUser('categoryedit')">Update</button></td>
                            </tr>
                        </table>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="categoryProduct">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <div class="row"><div class="col-md-12" style="text-align: center; font-weight: bold; font-size: large; color: #ff0012" id="cgetname"></div> </div>
                <div class="row" id="categorydetails">
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>