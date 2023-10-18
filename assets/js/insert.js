// JavaScript Document
$('#myForm').submit(function(){
return false;
});
 
$('#insert').click(function(){
$.post( 
$('#myForm').attr('action'),
$('#myForm :input').serializeArray(),
function(result){
$('#result').html(result);
}
);
});
