class StaticController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    render :guest unless current_user
  end

end
