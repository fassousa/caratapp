function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon-home');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-wagon-blue');
      } else {
        navbar.classList.remove('navbar-wagon-blue');
      }
    });
  }

  $('a.slow-anchor').click(function(){
    //Toggle Class
    //$(".active").removeClass("active");
    //$(this).closest('li').addClass("active");
    //var theClass = $(this).attr("class");
    //$('.'+theClass).parent('li').addClass('active');
    //Animate
    $('html, body').stop().animate({
        scrollTop: $( $(this).attr('href') ).offset().top
    }, 400);
    return false;
  });
  $('.scrollTop a').scrollTop();
}

export { initUpdateNavbarOnScroll };
