class GuestsController < ApplicationController
  def index
    if signed_in?
      redirect_to timer_path
    else
      redirect_to welcome_path
    end
  end

  def welcome
  end
end
