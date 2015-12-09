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
