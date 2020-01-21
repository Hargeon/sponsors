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
  $('.stars').remove();
  $('.all-stars').html();

  for(let i = 0; i < Math.floor(response.average_rating); i++) {
    $('.all-stars').append('<div class="rating-item active"></div>');
  }

  $('.average-rating').text(`${response.average_rating} Average rating`);
  $('.count-votes').text(`${response.count_votes} votes`);
}

function attraction() {
  return $('#attraction .current-active').data('rate')
}

function strategy() {
  return $('#strategy .current-active').data('rate');
}

function competitiveness() {
  return $('#competitiveness .current-active').data('rate');
}

function finance() {
  return $('#finance .current-active').data('rate');
}