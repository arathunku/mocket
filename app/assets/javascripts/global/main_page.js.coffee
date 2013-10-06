$(document).ready ->
  if $('.main-page').length
    $('.js-source-select').change ->
      new_serivce = $(this).val()
      parent = $(this).closest('.song')
      parent.find(".service.display").removeClass('display').addClass('hide')
      parent.find(".#{new_serivce}").parent().addClass('display').removeClass('hide')
      $(window).trigger('resize')
    $(window).resize ->
      $('iframe[src*="embed.spotify.com"]').each ->
        $(this).css('width',$(this).parent(1).css('width'));
        $(this).attr('src',$(this).attr('src'));
