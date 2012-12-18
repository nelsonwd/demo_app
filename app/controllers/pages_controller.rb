class PagesController < ApplicationController
before_filter :authenticate, :only => [:blast]

  def blast
    @title = "Blast Search"
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

def data
  @title = "Data"
  @tab = (params[:tab])?"selected:#{params[:tab]}":'selected:1'
end

private

  def authenticate
    deny_access unless signed_in?
  end
 

end
