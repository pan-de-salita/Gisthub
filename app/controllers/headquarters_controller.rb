class HeadquartersController < ApplicationController
  before_action :get_user

  def overview
    @top_four_languages = @user.solutions.each_with_object(Hash.new(0)) do |solution, hash|
      hash[solution.programming_language] += 1
    end.sort_by { |_, value| -value }.first(4).to_h
  end

  def solutions; end

  private

  def get_user
    @user = User.first
  end
end
