
class UserMailer < ApplicationMailer
  default from: "welcome-team@example.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to the Social Connection #{@user.first_name}!")
  end

end
