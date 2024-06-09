class HeadquartersController < ApplicationController
  before_action :set_user, :set_languages, :set_solutions

  def overview
    @top_four_languages = @solutions.each_with_object(Hash.new(0)) do |solution, hash|
                            hash[solution.programming_language] += 1
                          end.sort_by { |_, value| -value }.first(4).to_h

    months_count = Hash.new(0)
    %w[January February March April May June
       July August September October November December].each do |month|
      months_count[month] = 0
    end
    @solutions = @solutions.each_with_object(months_count) do |solution, hash|
      hash[solution.created_at.strftime('%B')] += 1
    end
  end

  def solutions; end

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
