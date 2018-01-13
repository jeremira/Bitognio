class ContactMailer < ApplicationMailer
  #This mailer is used only to send email to admin from contact form
  default from: 'contactform@bitognio.com'

  def contact_form(email, subject, content)
    @email = email
    @subject = subject
    @content = content
    mail(to: 'jmiraille@gmail.com', subject: 'Contact form from Bitognio')
  end
end
