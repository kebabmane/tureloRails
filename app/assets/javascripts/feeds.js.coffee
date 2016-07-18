    $ ->
      $('#blog-mansonry').imagesLoaded ->
        $('#blog-mansonry').masonry
          itemSelector: '.post '
          columnWidth: (containerWidth) ->
            if $(window).width() >= 992  //for col-md-4
              containerWidth /3
