class UserMailer < ApplicationMailer
  default from: 'injuniormailer@gmail.com'
  default_url_options[:host] = "https://eventin-rodcav.c9users.io"
  
  def registration_confirmation(user)
    @user = user
     mail(to: "#{user.name} #{user.last_name} <#{user.email}>",
     subject: "Confirmar cadastro")
  end
  
  def password_reset(user)
    @user = user
    mail(to: "#{user.name} #{user.last_name} <#{user.email}>",
    subject: "Redefinir sua senha")
  end
end
