jQuery.ajaxSetup({
 'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});

jQuery.fn.submitWithAjax = function() {
  this.change(function() {
    $.post('/kinds', {id: $("#wall_kind").val()}, null, "script");
    return false;
  })
  return this;
};
$(document).ready(function() {
  $("#kind").submitWithAjax();
});
//jQuery(function($) {
//  // when the #kind field changes
//  $("#kind").change(function() {
//    // make a POST call and replace the content
//	//$.post('/kinds', {id: $("#wall_kind").val()}, null, "script");
//	$.post('/kinds', {id: $("#wall_kind").val()},
//		function(data){
//			alert("data loaded");
//		});
//    return false;
//  });

//})





