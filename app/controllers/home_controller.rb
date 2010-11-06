class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    return redirect_to tasks_path if user_signed_in?
  end

  def feedback
  end

end
