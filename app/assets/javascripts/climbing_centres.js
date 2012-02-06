$(document).ready(function() {

  // add markup to container and apply click handlers to anchors
  $(".voteUp").click(function(e) {
    // stop normal link click
    e.preventDefault();
    wall_info = $(this).attr("wall_id");
	centre_info = $(this).attr("centre_id");
	dest = "climbing_centres/" + centre_info + "/walls/" + wall_info
	
    // send request
    $.post(dest, {commit: "upVote", wall: wall_info, centre: centre_info}, function(data) {
	   // $("#"+wall_info).slideUp('2000',function() {
	   // 	$(this).slideDown('2000',function(){
	   // 		$(this).html(data.pt);
	   // 	});
	   // 
	   // });
      //format and output result
     $("#"+wall_info).html(data.pt);
	 $("#"+wall_info).effect("highlight", {}, 3000);
	});
	$(this).slideUp('2000');
  });
});