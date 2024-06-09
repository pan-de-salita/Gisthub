class ApplicationController < ActionController::Base
  before_action :set_user, :set_languages, :set_solutions

  private

  def set_user
    @user = User.find(1)
  end

  def set_languages
    @languages = @user.languages
  end

  def set_solutions
    @solutions = @user.solutions
  end
end
