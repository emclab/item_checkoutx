// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$( "#checkout_out_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#checkout_request_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});

$(function() {
  $(document).on('change', '#whs_id', function (){  //only document/'body' works with every change. ('#whs_id') only works once.
     // alert("fire");
  	$.get(window.location, {whs_id: $('#whs_id').val(), field_changed: 'whs_id'}, null, "script");
    return false;
  });
});