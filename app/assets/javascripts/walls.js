jQuery.ajaxSetup({
 'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});

$.fn.subSelectWithAjax = function() {
  var that = this;
 
  this.change(function() {
	alert("hallo");
    $.post(that.attr('rel'), {id: that.val()}, null, "script");
  });
}

jQuery(function($) {
  // when the #country field changes
  $("#kind").change(function() {
    // make a POST call and replace the content
	$.post('/kinds', {id: $("#wall_kind").val()}, null, "script");
    //jQuery.get('/profiles/update_state_select/' + country, function(data){
      //  $("#addressStates").html(data);
    //})this.getAttribute('rel')
    return false;
  });

})


//$(document).ready($("#kind").subSelectWithAjax(););

//$(document).ready(function(){
//	$('#kind').change(function () { 
//		//alert("hallo");
//		if($("#gradelist").val() == "Leading") {
//			
//		}
//		else{
//
//		} 
//
//	   });
//});


