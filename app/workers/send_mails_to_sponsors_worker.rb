class SendMailsToSponsorsWorker
  include Sidekiq::Worker

  def perform(idea_id)
    idea = Idea.find(idea_id)
    users = SponsorsQueries.new(idea).idea_will_like_sponsors
    users.each do |user|
      SponsorMailer.with(idea: idea, user: user).new_idea.deliver_later
    end
  end
end
