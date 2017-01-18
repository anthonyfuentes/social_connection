
var flashMessages = (function(){

  var $flashContainer;

  var display = function(flash){
    $flashContainer = $("#flash-container");
    $flashContainer.html(flash);
    setTimeout(_removeFlash, 3000);
  };

  var _removeFlash = function(){
    $flashContainer.fadeOut();
  };

  return {
    display: display
  };

}($));
