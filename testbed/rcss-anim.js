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
      element.toggleClass("BoxAnimation2")
      element.toggleClass("BoxAnimation3")
    }
    else if(element.hasClass("BoxAnimation3")) {
      element.toggleClass("BoxAnimation3")
      element.toggleClass("BoxAnimation4")
    }
    else if(element.hasClass("BoxAnimation4")) {
      element.toggleClass("BoxAnimation4")
      element.toggleClass("BoxAnimation5")
    }
    else if(element.hasClass("BoxAnimation5")) {
      element.toggleClass("BoxAnimation5")
      element.toggleClass("BoxAnimation6")
    }
    else if(element.hasClass("BoxAnimation6")) {
      element.toggleClass("BoxAnimation6")
      element.toggleClass("BoxAnimation7")
    }
    else if(element.hasClass("BoxAnimation7")) {
      element.toggleClass("BoxAnimation7")
      element.toggleClass("BoxAnimation8")
    }
    else if(element.hasClass("BoxAnimation8")) {
      element.toggleClass("BoxAnimation8")
      element.toggleClass("BoxAnimation9")
    }
    else if(element.hasClass("BoxAnimation9")) {
      element.toggleClass("BoxAnimation9")
      element.toggleClass("BoxAnimation10")
    }
    else if(element.hasClass("BoxAnimation10")) {
      element.toggleClass("BoxAnimation10")
      element.toggleClass("BoxAnimation11")
    }
    else if(element.hasClass("BoxAnimation11")) {
    }
  });
}
