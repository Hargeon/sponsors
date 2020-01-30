$(document).ready(function() {
  $('#search').keyup(function() {
    if($('#search').val().length > 0) {
      let data = {
        term: $('#search').val()
      };

      $.ajax ({
        url: '/api/v1/autofills',
        type: 'POST',
        data: data,
        dataType: 'JSON',
        success: function(response) {
          console.log(response);
          $('#search').mbAutocomplete({
            data: response.suggestions
          })
        }
      })
    }
  })
})
