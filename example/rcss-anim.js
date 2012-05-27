function BoxAnimation(elementName) {
  element = $(elementName);
  element.addClass("BoxAnimation0");


  element.bind("webkitAnimationEnd", function() {
    if(element.hasClass("BoxAnimation0")) {
      element.toggleClass("BoxAnimation0")
      element.toggleClass("BoxAnimation1")
    }
    else if(element.hasClass("BoxAnimation1")) {
      element.toggleClass("BoxAnimation1")
      element.toggleClass("BoxAnimation2")
    }
    else if(element.hasClass("BoxAnimation2")) {
    }
  });
}
