class PassengerMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def thanks_email(user)
    @user = user
    mail(to: @user.email, subject: 'Flight Booked')
  end
end
