
var flashMessages = (function(){

  var $flashContainer;

  var display = function(flash){
    $flashContainer = $("#flash-container");
    $flashContainer.html(flash).fadeOut(3000);
    setTimeout(_removeFlash, 2000);
  };

  var _removeFlash = function(){
    $flashContainer.slideUp();
  };

  return {
    display: display
  };

}($));
