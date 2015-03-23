$(window).scroll(function(){ 
  $el = $('.fixedElement'); 
	if ($(this).scrollTop() > 380 && $el.css('position') == 'absolute') {
		$('.fixedElement').css({'position': 'fixed', 'top': '50px', 'right':'5px'}); 
	} 
	if ($(this).scrollTop() < 380 && $el.css('position') == 'fixed') {
		$('.fixedElement').css({'position': 'absolute', 'top': '450px', 'right':'5px','float':'right'});
	}
	if ($(this).scrollTop() > 5 && $el.css('position') == 'absolute') {
		$('.opaque').css({'background': 'rgba(60, 60, 60, .9)', 'box-shadow': '0 0 8px rgba(150, 149, 150, .9)'});
	}
	if ($(this).scrollTop() < 5 && $el.css('position') == 'absolute') {
		$('.opaque').css({'background': 'rgba(60, 60, 60, 1)'});
	}
});