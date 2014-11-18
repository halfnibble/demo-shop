// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

$('#voucher_form_link, #voucher_form_cancel').click(function(e){
	$('#voucher_form_container').toggle();
});