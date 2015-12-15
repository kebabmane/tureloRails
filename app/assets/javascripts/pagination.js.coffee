jQuery ->
  if $('.pagination').length
          $(window).scroll ->
                  url = $('.pagination .next_page').attr('href')
                  if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 300
                          $('.pagination').text('Fetching more products...')
                          $.getScript(url)
    $(window).scroll()
