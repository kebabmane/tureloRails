$(function() {

  function fadeAlert(){
    $('.flash-alert').removeClass('in');
  }

  function removeAlert(){
    $('.flash-alert').fadeOut();
  }

  window.setTimeout(fadeAlert,1000);
  window.setTimeout(removeAlert,5000);

});
