$(document).ready(function() {
  $('#browseBtn').on('click', function() {
    $(this).parent().find('input[type=file]').click();
  });

  $('#fileField').change(function() {
    $(this).parent().parent().find('.form-control').html($(this).val().split(/[\\\\|/]/).pop());
  });
})
