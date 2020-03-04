class SponsorMailer < ApplicationMailer
  def new_idea
    @idea = params[:idea]
    user = params[:user]
    I18n.locale = user.locale
    mail(to: user.email, subject: t(:msg_new_idea))
  end
end
