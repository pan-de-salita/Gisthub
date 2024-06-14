class LanguagesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_user, :set_languages, :set_solutions

  def new
    @language = @user.languages.new
  end

  def create
    @language = @user.languages.build(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to solutions_path(@user.alias), notice: 'Language was successfully created.' }
        format.json { render :show, status: :created, location: @language }
      else
        puts "ERRORS: #{@language.errors.full_messages}"
        format.html { redirect_to solutions_path(@user.alias) :new, status: :unprocessable_entity }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
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
