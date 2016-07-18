$ ->
  $('#blog-mansonry').imagesLoaded ->
    $('#blog-mansonry').masonry
      itemSelector: '.post',
      isFitWidth: true
