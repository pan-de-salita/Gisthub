class LanguagesController < ApplicationController
  before_action :set_user, :set_languages, :set_solutions

  def new
    @language = @user.languages.new
  end

  def create
    @language = @user.languages.build(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to solutions_path, notice: 'Language was successfully created.' }
        format.json { render :show, status: :created, location: @language }
      else
        puts "ERRORS: #{@language.errors.full_messages}"
        format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    # @language = @user.language.find(params[:programming_language])
    # tags_array = solution_params[:tags].split
    #
    # respond_to do |format|
    #   if @solution.update(tags: tags_array)
    #     if @solution.update(solution_params.except(:tags))
    #       format.html do
    #         redirect_to solutions_url(programming_language: @solution.programming_language),
    #                     notice: 'Solution was successfully updated.'
    #       end
    #       format.json { render :show, status: :ok, location: @solution }
    #     else
    #       puts "ERRORS: #{@solution.errors.full_messages}"
    #       format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
    #       format.json { render json: @solution.errors, status: :unprocessable_entity }
    #     end
    #   else
    #     puts "ERRORS: #{@solution.errors.full_messages}"
    #     format.html { redirect_to solutions_path :new, status: :unprocessable_entity }
    #     format.json { render json: @solution.errors, status: :unprocessable_entity }
    #   end
    # end
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

  def language_params
    params.require(:language).permit(:name, :user_id)
  end
end
