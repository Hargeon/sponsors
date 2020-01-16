$(document).ready(function() {
  $('#add-like').bind('click', addLike);

  $('#remove-like').bind('click', removeLike);

  $('#add-dislike').bind('click', addDislike);

  $('#remove-dislike').bind('click', removeDislike);
})

function addLike() {
  id = Number($('#idea_id').val());
  $.ajax({
    url: '/api/v1/likes',
    type: 'POST',
    data: { idea_id: id},
    dataType: 'JSON',
    success: function (param) {
      $('#add-like').remove();
      $('#like-count').text(param.like_count);
      $('#like').html('<button id="remove-like" class="btn btn-outline-danger">Like</button>' +
      `<input type="hidden" name="like_id" id="like_id" value=${param.id}>`
      );
      $('#remove-like').bind('click', removeLike);
      if(param.dislike){
        successRemoveDislike(param);
      }
    }
  })
}

function removeLike() {
  id = Number($('#like_id').val());
  $.ajax({
    url: `/api/v1/likes/${id}`,
    type: 'DELETE',
    dataType: 'JSON',
    success: function (param) {
      successRemoveLike(param);
    }
  })
}

function addDislike() {
  id = Number($('#idea_id').val());
  $.ajax({
    url: '/api/v1/dislikes',
    type: 'POST',
    data: { idea_id: id},
    dataType: 'JSON',
    success: function (param) {
      $('#add-dislike').remove();
      $('#dislike-count').text(param.dislike_count);
      $('#dislike').html('<button id="remove-dislike" class="btn btn-outline-danger">Dislike</button>' +
          `<input type="hidden" name="dislike_id" id="dislike_id" value=${param.id}>`
      );
      $('#remove-dislike').bind('click', removeDislike);
      if(param.like){
        successRemoveLike(param);
      }
    }
  })
}

function removeDislike() {
  id = Number($('#dislike_id').val());
  $.ajax({
    url: `/api/v1/dislikes/${id}`,
    type: 'DELETE',
    dataType: 'JSON',
    success: function (param) {
      successRemoveDislike(param);
    }
  })
}

function successRemoveDislike(param) {
  $('#dislike_id').remove();
  $('#remove-dislike').remove();
  $('#dislike-count').text(param.dislike_count);
  $('#dislike').html('<button id="add-dislike" class="btn btn-outline-warning">Dislike</button>');
  $('#add-dislike').bind('click', addDislike);
}

function successRemoveLike(param) {
  $('#like_id').remove();
  $('#remove-like').remove();
  $('#like-count').text(param.like_count);
  $('#like').html('<button id="add-like" class="btn btn-outline-primary">Like</button>');
  $('#add-like').bind('click', addLike);
}
