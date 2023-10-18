function sendAlert(dtext,dtype, timer = 2000){
    var self = $(this);
    var dlayout = "top";

    noty({
        text: dtext,
        type: dtype,
        layout: dlayout,
        timeout: timer,
        modal: self.data('modal')
    });

    return false;
}

function editcategory(id,cname,status){
    $("#catid").val(id);
    $("#catedit").val(cname);
    $("#catstatus").prepend("<option value='"+status+"' selected='selected'>"+status+"</option>");
    $("#editcategory").modal("show");
}

function logIn(){
    var uname = $("#username").val();
    var pword = $("#password").val();

    //CHEKC IF BOTH USERNAME AND PASSWORD HAVE BEEN ENTERED
    if(uname == "" || pword == ""){
        sendAlert('Missing username or password','error');
    }else{
        $("#loadbtn").addClass("hidden");
        $("#loader").removeClass("hidden");
        $.ajax({
            type: "get",
            url: "Ajax-table/ajax.php",
            data: "validateUser=" + uname + "&pword=" + pword,
            success: function (data) {
                console.log(data);
                var result = $.parseJSON(data);
                var code = result['errorCode'];
                var dmessage = result['errorMsg'];
                console.log(code);
                if (code == "1") {
                    sendAlert(dmessage,'error');
                    $("#loadbtn").removeClass("hidden");
                    $("#loader").addClass("hidden");
                } else {
                    sendAlert(dmessage,'success');
                    setTimeout(function(){
                        document.getElementById('loginform2').submit();
                    },3000);

                }
            },
            error: function (xhr, desc, err) {
                $("#loader").modal("hide");
                alert(err);
                return false;
            }
        });
    }
}

function createUser(idtype){
    let myform = document.getElementById(idtype);
    let fd = new FormData(myform);
    $("#trans_details").modal("show");
    $.ajax({
        url:"Ajax-table/ajax.php",
        method:"POST",
        data:fd,
        contentType:false,          // The content type used when sending data to the server.
        cache:false,                // To unable request pages to be cached
        processData:false,          // To send DOMDocument or non processed data file it is set to false
        success: function(data){
            console.log(data);
            $("#trans_details").modal("hide");
            var result = $.parseJSON(data);
            var code = result['errorCode'];
            var dmessage = result['errorMsg'];
            var speed = 2000;
            if(code == "1"){
                if(idtype == "warehousetransferform"){
                    speed = 200000;
                }
                sendAlert(dmessage,'error',speed);
            }else{
                sendAlert(dmessage,'success',speed);
                setTimeout(function(){
                    window.location.reload();
                },2000);
            }
        }
    });
    return false;
}


function transferOps(transid, action, userid, sender, sendershop){
    //console.log(transid,action);
    //let accept = true;
    let branch = $("#branch").val();
    let descr = "";
    var self = $(this);
    if(action == "accept"){
        descr = "Are you sure you want to Accept this transfer? This action cannot be reversed if you proceed";
    }else{
        descr = "Are you sure you want to Reject this transfer? This action cannot be reversed if you proceed";
    }

    var dtype = "confirm";
    noty({
        text: descr,
        type: "confirm",
        layout: "top",
        timeout: 2000,
        modal: self.data('modal'),
        buttons: (dtype != 'confirm') ? false : [
            {
                addClass: 'btn btn-primary', text: 'Ok', onClick: function($noty) {
                    $noty.close();
                    $("#trans_details").modal("show");
                    $.ajax({
                        type: "post",
                        url: "Ajax-table/ajax.php",
                        data: "transferops="+transid+"&action="+action+"&shop="+branch+"&userid="+userid+"&sender="+sender+"&sendershop="+sendershop,
                        success: function (data) {
                            $("#trans_details").modal("hide");
                            var url = "dashboard.php?transferid="+transid+"&branch=" + branch+"&status="+data;
                            sendAlert(data,'success');
                            setTimeout(function(){
                                window.location.reload(url);
                            },2000);
                        },
                        error: function (xhr, desc, err) {
                            alert(err);
                        }
                    });
                    //noty({force: true, text: 'You clicked "Ok" button', type: 'success', layout: self.data('layout')});
                }
            }, {
                addClass: 'btn btn-danger', text: 'Cancel', onClick: function($noty) {
                    $noty.close();
                    noty({force: true, text: 'Action has been cancelled', type: 'error', layout: self.data('layout')});
                }
            }
        ]
    });
}

function previous(){
    window.history.back();
}

function next(){
    window.history.forward();
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
    $("#trans_details").modal("show");
    if(type == "create"){
        $("#bname").val("");
        $("#bcontact").val("");
        $("#bemail").val("");
        $("#blocate").val("");
        $("#brancheditid").val("");
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

function addNewWarehouseProd() {
    //GET THE PRODUCTS ASSIGNED TO THE SHOP
    var counter = $("#rowcounterwh").val();
    var ncounter = Number(counter) + 1;
    $("#rowcounterwh").val(ncounter);
    if(ncounter != 0){
        $("#transhidden").removeClass("hidden");
    }else{
        $("#transhidden").addClass("hidden");
    }
    $.ajax({
        type: "post",
        url: "Ajax-table/ajax.php",
        data: "getproductselectwh=" + ncounter,
        success: function (data) {
            var new_row = "<tr id='" + ncounter + "'><td>" + data + "</td><td><input class = 'form-control' type = 'number' name = 'qtywh[]' id = 'qtywh"+ncounter+"' value='1' min='1' required></td><td><a onclick='removeRowwh(" + ncounter + ")'><span class='icon icon-trash btn btn-danger'></span></a></td></tr>";
            $(".dataTables-example2").append(new_row);
            //console.log(new_row);
        },
        error: function (xhr, desc, err) {
            alert(err);
            return false;
        }
    });
}