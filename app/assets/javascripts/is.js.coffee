jQuery ->
     if $('.pagination').length
          $(window).scroll throttle ->
                  url = $('.pagination .next a').attr('href')
                  if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
                          $.getScript(url)
                , 1500
