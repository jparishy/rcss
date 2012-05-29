function HeaderAnimation(elementName) {
  element = $(elementName);
  element.addClass("HeaderAnimation0");


  element.bind("webkitAnimationEnd", function() {
    if(element.hasClass("HeaderAnimation0")) {
      element.toggleClass("HeaderAnimation0")
      element.toggleClass("HeaderAnimation1")
    }
    else if(element.hasClass("HeaderAnimation1")) {
    }
  });
}
