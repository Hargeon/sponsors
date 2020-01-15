class ViewServise
  def initialize(current_user, idea)
    @current_user = current_user
    @idea = idea
  end

  def find_or_create
    return if @current_user.nil?

    View.find_or_create_by!(idea_id: @idea.id, user_id: @current_user.id)
  end
end
