class SponsorMailer < ApplicationMailer
  def new_idea
    @idea = params[:idea]
    mail(to: params[:email], subject: 'New Idea')
  end
end
