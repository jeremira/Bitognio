class ContactMailer < ApplicationMailer
  #This mailer is used only to send email to admin from contact form
  default from: 'contactbitognio@gmail.com'

  def contact_form(email, subject, content)
    @email = email
    @subject = subject
    @content = content
    mail(to: 'contactbitognio@gmail.com', subject: 'Contact form from Bitognio')
  end
end
