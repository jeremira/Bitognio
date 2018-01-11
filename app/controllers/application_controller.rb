class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


before_action :set_locale

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end

#add locale params i18n by default in all url
def default_url_options
  { locale: I18n.locale }
end

end
