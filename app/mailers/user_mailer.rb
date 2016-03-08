class UserMailer < ActionMailer::Base
  default from: 'notifications@trainservise.com'

  def order_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ваш билеты зарезервированы')
  end

  def delete_order_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ваши билеты сняты с резерва')
  end
end
