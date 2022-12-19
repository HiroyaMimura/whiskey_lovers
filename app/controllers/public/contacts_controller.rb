class Public::ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact) && @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to thanks_contacts_path
    else
      render "new"
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
