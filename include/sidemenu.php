<div id="sidebar" class="sidebar-fixed">
    <div id="sidebar-content">

        <!--=== Navigation ===-->
        <ul id="nav">
            <li> <div id="selloc" style="text-align: center; font-weight: bold; font-size: large; color: #4d7496"></div></li>
            <li class="current">
                <div align="center">
                    <img src="<?php echo $clogo; ?>" class="img-responsive img-rounded" alt="logo" style="width: 100px; height: 100px"/>
                </div>
            </li>
            <li>
                <a href="dashboard.php" id="dboard2">
                    <i class="icon-bar-chart"></i>
                    Dashboard
                </a>
            </li>
            <?php if($access == "ADMINISTRATOR"){ ?>
                <li>
                    <a href="javascript:void(0);">
                        <i class="icon-briefcase"></i>
                        Administration
                        <span class="label label-default pull-right">5</span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="dashboard.php?backups"><i class="icon-upload"></i>Backups</a></li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&branches">
                                <i class="icon-home"></i>
                                Branches
                            </a>
                        </li>
                        <li><a  data-toggle="modal" href="#company" onclick="getcompany()"><i class="icon-building"></i>  Company Details</a></li>
                        <li><a href="dashboard.php?branch=<?php echo $branch; ?>&taxes"><i class="icon-money"></i> Sales
                                Tax</a></li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&users">
                                <i class="icon-group"></i>
                                Users
                            </a>
                        </li>




                    </ul>
                </li>
            <?php }if($branch != "") { ?>
                <li>
                    <a href="javascript:void(0);">
                        <i class="icon-list-alt"></i>
                        Invoice & Quotation
                        <span class="label label-danger pull-right">3</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&customers">
                                <i class="icon-male"></i>
                                Customers
                            </a>
                        </li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&invoices">
                                <i class="icon-list"></i>
                                Invoice
                            </a>
                        </li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&quotations">
                                <i class="icon-list-ul"></i>
                                Quotations
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <i class="icon-globe"></i>
                                Report
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li><a data-toggle="modal" href="#invoice_sales_report"><i class="icon-bell"></i> Invoice Payments
                                        Report</a></li>
                                <!--<li><a data-toggle="modal" href="#sales_report"><i class="icon-bell"></i> Product Sales
                                        Report</a></li>-->
                            </ul>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:void(0);">
                        <i class="icon-apple"></i>
                        PRODUCTS
                        <span class="label label-info pull-right">2</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&items_list">
                                <i class="icon-food"></i>
                                Items
                            </a>
                        </li>
                        <?php if($access == "ADMINISTRATOR"){ ?>
                        <li>
                            <a href="dashboard.php?pending_transfers&branch=<?php echo $branch; ?>">
                                <i class="icon-share"></i>
                                Inbound Transfers
                            </a>
                        </li>
                            <li>
                            <a href="dashboard.php?shop_transfer&branch=<?php echo $branch; ?>">
                                <i class="icon-share"></i>
                                Outbound Transfers
                            </a>
                        </li>
                        <?php } ?>
                    </ul>
                </li>
                <li>
                    <a href="javascript:void(0);">
                        <i class="icon-shopping-cart"></i>
                        Point Of Sale
                        <span class="label label-warning pull-right">2</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&pos">
                                <i class="icon-food"></i>
                                Cash Sales
                            </a>
                        </li>
                        <li>
                            <a data-toggle="modal" href="#receipt_search">
                                <i class="icon-search"></i>
                                Search Receipt
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <i class="icon-globe"></i>
                                Report
                                <span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li><a data-toggle="modal" href="#sales_report"><i class="icon-bell"></i> Sales
                                        Report</a></li>
                                <?php if($access == "ADMINISTRATOR"){?><li><a data-toggle="modal" href="#sales_summary_report"><i class="icon-bell"></i> Sales Summary
                                        Report</a></li>
                                <li><a data-toggle="modal" href="#user_sales_report"><i class="icon-bell"></i> User Sales
                                        Report</a></li><?php } ?>
                                <!--<li><a data-toggle="modal" href="#sales_report"><i class="icon-bell"></i> Product Sales
                                        Report</a></li>-->
                            </ul>
                        </li>
                    </ul>
                </li>
                <?php
            }if($access == "ADMINISTRATOR"){
                ?>
                <li>
                    <a href="javascript:void(0);">
                        <i class="icon-home"></i>
                        Warehouse
                        <span class="label label-success pull-right">6</span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&product_category">
                                <i class="icon-angle-right"></i>
                                Category
                            </a>
                        </li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&items_master">
                                <i class="icon-angle-right"></i>
                                Products
                            </a>
                        </li>
                        <!--<li>
                            <a data-toggle="modal" href="#bulkupload">
                                <i class="icon-upload-alt"></i>
                                Bulk Products Upload
                            </a>
                        </li>-->
                        <!--<li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&warehouse_retail">
                                <i class="icon-angle-right"></i>
                                Retail
                            </a>
                        </li>-->
                        <li>
                            <a data-toggle="modal" href="#warehousetransfer">
                                <i class="icon-angle-right"></i>
                                Bulk Transfer
                            </a>
                        </li>
                        <!--<li>
                            <a data-toggle="modal" href="#product_transfer">
                                <i class="icon-angle-right"></i>
                                Single Product Transfer
                            </a>
                        </li>-->
                        <!--<li>
                            <a onclick="singleproduct()">
                                <i class="icon-angle-right"></i>
                                Single Product Transfer
                            </a>
                        </li>-->
                        <li>
                            <a href="dashboard.php?price_adjustment">
                                <i class="icon-angle-right"></i>
                                Price Adjustments
                            </a>
                        </li>
                        <li>
                            <a href="dashboard.php?inbound_pending_transfers">
                                <i class="icon-angle-right"></i>
                                Inbound Transfers
                            </a>
                        </li>
                        <li><a  data-toggle="modal" href="#transfers"><i class="icon-user"></i>  Outbound Transfers</a></li>

                    </ul>
                </li>
                <!--<li>
                    <a href="javascript:void(0);">
                        <i class="icon-shopping-cart"></i>
                        Customer Orders
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&pending_orders">
                                <i class="icon-angle-right"></i>
                                Pending Orders
                            </a>
                        </li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&items_master">
                                <i class="icon-angle-right"></i>
                                Cancelled Orders
                            </a>
                        </li>
                        <li>
                            <a href="dashboard.php?branch=<?php echo $branch; ?>&warehouse_retail">
                                <i class="icon-angle-right"></i>
                                Approved Orders
                            </a>
                        </li>
                    </ul>
                </li>-->
            <?php } ?>

        </ul>

        <!-- /Navigation -->

        <div class="sidebar-widget align-center">
            <div class="btn-group" data-toggle="buttons" id="theme-switcher">
                <h3>THEMES</h3>
                <label class="btn active">
                    <input type="radio" name="theme-switcher" data-theme="bright"><i class="icon-sun"></i> Bright
                </label>
                <label class="btn">
                    <input type="radio" name="theme-switcher" data-theme="dark"><i class="icon-moon"></i> Dark
                </label>
            </div>
        </div>

    </div>
    <div id="divider" class="resizeable"></div>
</div>
