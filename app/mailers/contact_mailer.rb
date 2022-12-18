class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail to: ENV["GMAIL_ADD"], subject: 'whiskey_lovers(お問合せ)'
  end
end
