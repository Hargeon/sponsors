class SendMailsServise
  def self.create_idea(idea)
    SponsorMailer.with(idea: idea).new_idea.deliver_later
  end
end