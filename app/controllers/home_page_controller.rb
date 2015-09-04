class HomePageController < ApplicationController
  skip_before_action :limitation_without_confirmation, only: [:show, :index]

  def index
  end

  def about
  end

  def help
  end
end
