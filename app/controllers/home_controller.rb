class HomeController < ApplicationController

  def index
  end

  def contact
    ContactMailer.contact_form(params[:user][:email], params[:subject], params[:content]).deliver_now
    flash[:notice] = "Your message was sent !"
    redirect_to root_path
  end

end
