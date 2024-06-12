class SolutionsController < ApplicationController
  before_action :set_user, :set_languages, :set_solutions, :set_solution

  def solutions; end

  def solutions_in_language; end

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.tags = params[:solution][:tags].split(',') if params[:solution][:tags].present?

    respond_to do |format|
      if @solution.save
        format.html { redirect_to solutions_path, notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @micropost }
      else
        puts "ERRORS: #{@solution.errors.full_messages}"
        format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

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

  def set_solution
    @solution = Solution.new
  end

  def solution_params
    params.require(:solution).permit(:title, :instructions, :attempt, :programming_language, :tags, :language_id,
                                     :user_id)
  end
end
