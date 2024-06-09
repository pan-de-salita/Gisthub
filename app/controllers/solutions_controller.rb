class SolutionsController < ApplicationController
  before_action :set_user, :set_languages, :set_solutions

  def solutions; end

  def solutions_in_language
    current_language_id = language_id
    @solutions_in_language = Solution.where(user_id: @user.id, language_id: current_language_id,
                                            programming_language: params[:programming_language])
  end

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
