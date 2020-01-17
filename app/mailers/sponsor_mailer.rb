class SponsorMailer < ApplicationMailer
  def new_idea
    @idea = params[:idea]
    emails = User.sponsors.pluck(:email)
    emails.each do |email|
      mail(to: email, subject: 'New Idea')
    end
  end
end
