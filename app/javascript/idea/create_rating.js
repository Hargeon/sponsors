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
    },
    locale: locale()
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
  $('.rating-item.average').addClass('exclude');

  let average_rating = Math.floor(response.average_rating)
  $('.rating-item.average').slice(0, average_rating).removeClass('exclude')

  $('.average-rating').text(`${parseFloat(response.average_rating)}`);
  $('.count-votes').text(`${response.count_votes}`);
}

function attraction() {
  return $('#attraction .current-active').data('rate');
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

function locale() {
  return $('#lang').val()
}
