class BusinessmanMailer < ApplicationMailer
  def old_idea
    @idea = params[:idea]
    @user = @idea.user
    I18n.locale = @user.locale
    mail(to: @user.email, subject: t(:msg_old_idea, name: @idea.name))
  end
end
