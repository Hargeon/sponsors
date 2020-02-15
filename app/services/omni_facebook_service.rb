class OmniFacebookService
  attr_reader :user
  def initialize(auth)
    @auth = auth
    @user = User.find_by(provider: @auth['provider'], uid: @auth['uid'])
  end

  def registrate?
    @auth['info']['email'].nil? || @user.present?
  end
end
