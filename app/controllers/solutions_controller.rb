class SolutionsController < ApplicationController
  before_action :set_user, :set_languages, :set_solutions, :set_solution

  def index; end

  def show; end

  def new
    @solution = @user.solutions.new
  end

  def create
    @solution = @user.solutions.new(solution_params)
    @solution.tags = params[:solution][:tags].split(',') if params[:solution][:tags].present?

    respond_to do |format|
      if @solution.save
        format.html { redirect_to solutions_path, notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        puts "ERRORS: #{@solution.errors.full_messages}"
        format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @solution = @user.solutions.find(params[:id])
  end

  def update
    @solution = @user.solutions.find(params[:id])
    tags_array = solution_params[:tags].split

    respond_to do |format|
      if @solution.update(tags: tags_array)
        if @solution.update(solution_params.except(:tags))
          format.html do
            redirect_to solutions_url(programming_language: @solution.programming_language),
                        notice: 'Solution was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @solution }
        else
          puts "ERRORS: #{@solution.errors.full_messages}"
          format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
          format.json { render json: @solution.errors, status: :unprocessable_entity }
        end
      else
        puts "ERRORS: #{@solution.errors.full_messages}"
        format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @solution = @user.solutions.find(params[:id])
    @solution.destroy!

    respond_to do |format|
      format.html { redirect_to solutions_path, notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  def set_solution
    @solution = Solution.new
  end

  def solution_params
    params.require(:solution)
          .permit(:title, :instructions, :attempt, :programming_language, :tags, :language_id, :user_id)
  end
end
