module DislikesHelper
  def dislike_present?(idea)
    current_user.dislikes.find_by(idea_id: idea.id).present?
  end

  def dislike_id(idea)
    current_user.dislikes.find_by(idea_id: idea.id).id
  end

  def dislike_data_id(idea)
    return dislike_id(idea) if dislike_present?(idea)

    ''
  end

  def dislike_data_action(idea)
    return 'remove' if dislike_present?(idea)

    'add'
  end

  def dislike_btn_class(idea)
    return 'btn btn-outline-danger' if dislike_present?(idea)

    'btn btn-outline-warning'
  end

  def dislike_button(idea)
    button_tag('Dislike',
               id: 'dislike',
               type: 'button',
               class: dislike_btn_class(idea),
               data: { id: dislike_data_id(idea), action: dislike_data_action(idea) })
  end

  def dislikes_count(idea_id)
    Dislike.where(idea_id: idea_id).count
  end
end
