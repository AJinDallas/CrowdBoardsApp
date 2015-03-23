$(window).scroll(function(){ 
  $el = $('.fixedElement'); 
	if ($(this).scrollTop() > 0 && $el.css('position') == 'absolute') {
		$('.fixedElement').css({'top': $(window).scrollTop() + 56, 'right':'0px'}); 
	} 

	if ($(this).scrollTop() < 0 && $el.css('position') == 'absolute') {
		$('.fixedElement').css({'top': '56px', 'right':'0px'}); 
	} 

	if ($(this).scrollTop() > 5 && $el.css('position') == 'absolute') {
		$('.opaque').css({'background': 'rgba(60, 60, 60, .9)', 'box-shadow': '0 0 8px rgba(150, 149, 150, .9)'});
	}
	if ($(this).scrollTop() < 5 && $el.css('position') == 'absolute') {
		$('.opaque').css({'background': 'rgba(60, 60, 60, 1)'});
	}
});



