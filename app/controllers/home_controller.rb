class HomeController < ApplicationController

  def index
  end

  #Post form contact content and send email
  def contact
    ContactMailer.contact_form(params[:user][:email], params[:content]).deliver_later
    flash[:notice] = t :__email_sent
    redirect_to root_path
  end

end
