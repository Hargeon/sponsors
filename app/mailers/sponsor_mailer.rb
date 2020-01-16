class SponsorMailer < ApplicationMailer
  def new_idea
    @idea = params[:idea]
    emails = User.sponsors.pluck(:email)
    mail(to: emails, subject: 'New Idea')
  end
end
