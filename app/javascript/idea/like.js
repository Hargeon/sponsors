$(document).ready(function() {
  $('#like').bind('click', like);
  $('#dislike').bind('click', dislike);
})

function like(){
  if($('#like').data('action') == 'remove') {
    let id = Number($('#like').data('id'))

    $.ajax({
      url: `/api/v1/likes/${id}`,
      type: 'DELETE',
      dataType: 'JSON',
      success: removeLike
    })

  } else if($('#like').data('action') == 'add') {
    let id = Number($('#idea_id').val());

    $.ajax({
      url: '/api/v1/likes',
      type: 'POST',
      data: { idea_id: id},
      dataType: 'JSON',
      success: addLike
    })
  }
}

function removeLike(response) {
  $('#like').data('id', '');
  $('#like').data('action', 'add');
  $('#like').removeClass('btn-outline-danger').addClass('btn-outline-primary')
  $('#like-count').text(response.like_count);
}

function addLike(response) {
  $('#like').data('id', response.id)
  $('#like').data('action', 'remove')
  $('#like-count').text(response.like_count);
  $('#like').removeClass('btn-outline-primary').addClass('btn-outline-danger')
  if(response.dislike){
    removeDislike(response);
  }
}

function dislike() {
  if($('#dislike').data('action') == 'remove') {
    let id = Number($('#dislike').data('id'))

    $.ajax({
      url: `/api/v1/dislikes/${id}`,
      type: 'DELETE',
      dataType: 'JSON',
      success: removeDislike
    })

  } else if($('#dislike').data('action') == 'add') {
    let id = Number($('#idea_id').val());

    $.ajax({
      url: '/api/v1/dislikes',
      type: 'POST',
      data: { idea_id: id},
      dataType: 'JSON',
      success: addDislike
    })
  }
}

function removeDislike(response) {
  $('#dislike').data('id', '');
  $('#dislike').data('action', 'add');
  $('#dislike').removeClass('btn-outline-danger').addClass('btn-outline-warning');
  $('#dislike-count').text(response.dislike_count);
}

function addDislike(response) {
  $('#dislike').data('id', response.id);
  $('#dislike').data('action', 'remove');
  $('#dislike').removeClass('btn-outline-warning').addClass('btn-outline-danger')
  $('#dislike-count').text(response.dislike_count);

  if(response.like){
    removeLike(response);
  }
}
