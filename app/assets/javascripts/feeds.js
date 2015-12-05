# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {

    /* ======= Blog page masonry ======= */
    /* Ref: http://desandro.github.io/masonry/index.html */

    var $container = $('#blog-mansonry');
    $container.imagesLoaded(function(){
        $container.masonry({
            itemSelector : '.post'
        });
    });

});
