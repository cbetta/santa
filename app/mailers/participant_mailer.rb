class ParticipantMailer < ActionMailer::Base
  default from: "santa@cgb.im"
  default_url_options[:host] = Rails.env.development? ? "127.0.0.1:3000" : "santa.cgb.im"
  
  def pick_email(pick)
    @url = pick_url(pick.hash)
    @pick = pick
    mail(:to => pick.picker.email, :subject => "#{pick.draw.user.name} invites you to \"#{pick.draw.title}\"")
  end
  
  
end
