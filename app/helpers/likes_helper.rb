module LikesHelper
  def like_present?(idea)
    current_user.likes.find_by(idea_id: idea.id).present?
  end

  def like_id(idea)
    current_user.likes.find_by(idea_id: idea).id
  end

  def like_data_id(idea)
    return like_id(idea) if like_present?(idea)

    ''
  end

  def like_data_action(idea)
    return 'remove' if like_present?(idea)

    'add'
  end

  def like_btn_class(idea)
    return 'btn btn-outline-danger' if like_present?(idea)

    'btn btn-outline-primary'
  end

  def like_button(idea)
    button_tag('Like',
               id: 'like',
               type: 'button',
               class: like_btn_class(idea),
               data: { id: like_data_id(idea), action: like_data_action(idea) })
  end
end
