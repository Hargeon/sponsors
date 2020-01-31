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
          let option = '';

          for(let i = 0; i < response.suggestions.length; i++) {
            option += `<option value="${response.suggestions[i]}">`;
          }

          $('#autofill').html(option);
        }
      })
    }
  })
})
