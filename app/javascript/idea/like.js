$(document).ready(function() {
  $('#add-like').bind('click', function () {
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
      }
    })
  })

  $('#remove-like').bind('click', function() {
    id = Number($('#like_id').val());
    $.ajax({
      url: `/api/v1/likes/${id}`,
      type: 'DELETE',
      dataType: 'JSON',
      success: function (param) {
        $('#like_id').remove();
        $('#remove-like').remove();
        $('#like-count').text(param.like_count);
        $('#like').html('<button id="add-like" class="btn btn-outline-primary">Like</button>');
      }
    })
  })
})
