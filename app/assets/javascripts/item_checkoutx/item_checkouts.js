// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$( "#checkout_out_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#checkout_request_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#checkout_start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#checkout_end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});