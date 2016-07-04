$(document).ready( function() {

  // init Masonry
  var $grid = $('#blog-mansonry').packery({
    itemSelector: '.post',
    percentPosition: true
  });
  // layout Isotope after each image loads
  $grid.imagesLoaded().progress( function() {
    $grid.packery();
  });

  var ready;
  ready = function() {
      var engine = new Bloodhound({
          datumTokenizer: function(d) {
              console.log(d);
              return Bloodhound.tokenizers.whitespace(d.food_name);
          },
          queryTokenizer: Bloodhound.tokenizers.whitespace,
          remote: {
              url: '/api/v1/feeds/autocomplete?query=%QUERY',
              wildcard: "%QUERY"
          }
      });

      var promise = engine.initialize();

      promise
          .done(function() { console.log('success!'); })
          .fail(function() { console.log('err!'); });

      $('#feeds_typeahead').typeahead(null, {
          name: 'engine',
          displayKey: 'feed_name',
          source: engine.ttAdapter()
      });
  }

  $(document).ready(ready);
  $(document).on('page:load', ready);



});
