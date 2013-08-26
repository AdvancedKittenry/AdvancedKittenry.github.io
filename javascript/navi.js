$(document).ready(function(){

  if (typeof(addSectionLinks) !== 'undefined' && addSectionLinks) {
    var currentLink = $('li.selected');
    var mainlink = currentLink.children('a');
    var links = $('<ul></ul>');
    var url = document.location.href;
    url = url.substring(0, (url.indexOf("#") == -1) ? url.length : url.indexOf("#"));
    url = url.substring(url.lastIndexOf("/") + 1, url.length);

    var hasLinks = false;
    $('section.level2').each(function() {
      var title = $(this).find('h2').html();
      var link = url+"#"+$(this).attr('id');
      links.append($('<li><a href="'+link+'">'+title+'</a></li>'));
      hasLinks = true;
    });

    if (hasLinks) {
      currentLink.append(links).addClass('open');
      mainlink.click(function() {
        $.scrollTo('0%', 1000, {axis:'y'} );
        links.find('a').removeClass('selected');
        return false;
      });

      links.onePageNav({
        currentClass: 'selected' 
      });
    }
  }
  
  $("nav > ul > li > ul").treeview({
    animated: "fast",
    persist: "location",
    collapsed: true,
  });

  // Stick the #nav to the top of the window
  var nav = $('nav');
  var navHomeY = nav.offset().top;
  var isFixed = false;
  var $w = $(window);
  $w.scroll(function() {
      var scrollTop = $w.scrollTop();
      var shouldBeFixed = scrollTop > navHomeY;
      if (shouldBeFixed && !isFixed) {
          nav.css({
              position: 'fixed',
              top: 0,
              left: nav.offset().left,
              width: nav.width()
          });
          isFixed = true;
      }
      else if (!shouldBeFixed && isFixed)
      {
          nav.css({
              position: 'static'
          });
          isFixed = false;
      }
  });

});
