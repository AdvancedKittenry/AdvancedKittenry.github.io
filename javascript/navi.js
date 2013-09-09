$(document).ready(function(){

  if (typeof(addSectionLinks) !== 'undefined' && addSectionLinks) {

    function findLinks(where, level) {
      var hasLinks = false;
      var links = $('<ul></ul>');
      where.find('section.level'+level).each(function() {
        var title = $(this).find('h'+level).html();
        title = title.replace(/^\d+\.? */, ""); //Remove ordinal numering
        var link = "#"+$(this).attr('id');
        var listItem = $('<li class="open"><a href="'+link+'">'+title+'</a></li>');
        var subLinks = findLinks($(this), level+1);
        if (subLinks) listItem.append(subLinks);
        links.append(listItem);
        hasLinks = true;
      });
      if (!hasLinks) return null;
      else return links;
    }

    var links = findLinks($('#content'), 2);

    if (links) {
      var currentLink = $('li.selected');
      currentLink.append(links).addClass('open');
      currentLink.children('a').click(function() {
        $.scrollTo('0%', 1000, {axis:'y'} );
        links.find('a').removeClass('selected');
        return false;
      });

      links.onePageNav({
        currentClass: 'selected' 
      });
    }
  }

  /* Make the navigation expandable */
  $("nav > ul > li > ul").treeview({
    animated: "fast",
    persist: "location",
    collapsed: true,
  });

  // Stick the #nav to the top of the window
  var nav = $('nav');
  var footer = $('footer');
  var content = $('#content');
  var navHomeY = nav.offset().top;
  var isFixed = false;
  var $w = $(window);

  function checkNavi() {
      var scrollTop = $w.scrollTop();
      var shouldBeFixed = (scrollTop > navHomeY) && 
        (nav.outerHeight() < content.outerHeight()) &&
        $w.width() > 992; 
      if (shouldBeFixed) {
          if (!isFixed) {
              nav.css({
                  position: 'fixed',
                  top: offset + "px",
                  left: nav.offset().left,
                  width: nav.width()
              });
              isFixed = true;
          }
          //Calculate if the navi bottom is hitting the page bottom
          var footerMargin = footer.css('margin-top').replace("px", "") * 1;
          var offset = Math.min(footer.offset().top - (scrollTop + nav.outerHeight() + footerMargin), 0);
          nav.css({
              top: offset + "px",
          });
      }
      else if (!shouldBeFixed && isFixed)
      {
          nav.css({
            position: 'static',
          });
          isFixed = false;
      }
  }
  $w.scroll(checkNavi);
  $w.resize(checkNavi);
  nav.resize(checkNavi);

});
