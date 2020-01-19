$(document).ready(function () {
  $('#create-rating').bind('click', post);
});

function post() {
  let data = {
    rating: {
      attraction: attraction(),
      strategy: strategy(),
      competitiveness: competitiveness(),
      finance: finance(),
      idea_id: Number($('#idea_id').val())
    }
  };

  $.ajax({
    url: '/api/v1/ratings',
    type: 'POST',
    data: data,
    dataType: 'JSON',
    success: successResponse,
    error: function (response) {
      alert(response.responseJSON.message);
    }
  })
}

function successResponse(response) {
  $('.starts').remove();
}

function attraction() {
  return $($('#attraction').children('.current-active')[0]).data('rate');
}

function strategy() {
  return $($('#strategy').children('.current-active')[0]).data('rate');
}

function competitiveness() {
  return $($('#competitiveness').children('.current-active')[0]).data('rate');
}

function finance() {
  return $($('#finance').children('.current-active')[0]).data('rate');
}