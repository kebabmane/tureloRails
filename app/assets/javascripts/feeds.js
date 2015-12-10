$(document).ready(function () {
  var $container = $('#blog-mansonry');
  $container.imagesLoaded( function() {
        $container.masonry({
            itemSelector : '.post'
        });
  });
});
