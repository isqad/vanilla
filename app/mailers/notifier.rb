class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def reset_password_instructions(user)
    @reset_link = edit_password_url(:token => user.perishable_token)
    mail(:to => user.email, :subject => 'Reset password instructions')
  end
end
