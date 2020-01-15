$(document).ready(function () {
    $('#add-dislike').bind('click', function () {
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
                if(param.like){
                    $('#like_id').remove();
                    $('#remove-like').remove();
                    $('#like').html('<button id="add-like" class="btn btn-outline-primary">Like</button>');
                    $('#like-count').text(param.like_count);
                }
            }
        })
    })

    $('#remove-dislike').bind('click', function() {
        id = Number($('#dislike_id').val());
        $.ajax({
            url: `/api/v1/dislikes/${id}`,
            type: 'DELETE',
            dataType: 'JSON',
            success: function (param) {
                $('#dislike_id').remove();
                $('#remove-dislike').remove();
                $('#dislike-count').text(param.count);
                $('#dislike').html('<button id="add-dislike" class="btn btn-outline-warning">Dislike</button>');
            }
        })
    })
})