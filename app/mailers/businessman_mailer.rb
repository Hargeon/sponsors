class BusinessmanMailer < ApplicationMailer
  def old_idea
    @idea = params[:idea]
    @user = @idea.user
    mail(to: @user.email, subject: "#{@idea.name} will soon become inactive")
  end
end
