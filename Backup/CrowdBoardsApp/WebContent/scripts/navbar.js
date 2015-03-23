$(document).ready(function(){
  $(".navbar-responsive").click(function() {
     if ($(".navbar-responsive > ul").css("display") == "none") {
      $(".navbar-responsive > ul").css("display","block");
     }
     else {
      $(".navbar-responsive > ul").css("display","none");
     }
  });
   $("#last").click(function(){
     if ($("#last > ul").css("display") == "none") {
      $("#last > ul").css("display","block");
     }
     else {
      $("#last > ul").css("display","none");
     }
  });
});