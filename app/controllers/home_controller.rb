class HomeController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  # caches_page :about
  #expire_page action: 'about'
  # caches_action :top

  def top
  end

  def about
  end

end
