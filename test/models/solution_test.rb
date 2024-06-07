require 'test_helper'

class SolutionTest < ActiveSupport::TestCase
  setup do
    @user_for_solution_tests = User.create(
      alias: 'Solution Test',
      bio: 'For testing the Solution model.',
      email: 'test_user@solution.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
    @language_for_solution_tests = Language.create(name: 'Rooby', user_id: @user_for_solution_tests)
    @test_solution = Solution.new(
      title: 'Tic-Tac-Toe Checker',
      instructions: "If we were to set up a Tic-Tac-Toe game, we would want to know whether the board's current state is solved, wouldn't we? Our goal is to create a function that will check that for us!",
      attempt: 'def is_solved(board) result = horizontal_solve?(board) || vertical_solve?(board) || diagonal_solve?(board) return result if result board.any? { |row| row.include?(0) } ? -1 : 0 end def horizontal_solve?(board) board.each do |row| return 1 if row.all? { |num| num == 1 } return 2 if row.all? { |num| num == 2 } end nil end def vertical_solve?(board) # col_to_row = board.each_with_index.map do |row, x| #   row.each_with_index.map { |_, y| board[y][x] } # end col_to_row = board.transpose horizontal_solve?(col_to_row) end def diagonal_solve?(board) diag_to_row = [ board.each_with_index.map { |row, idx| row[idx] }, board.each_with_index.map { |row, idx| row.reverse[idx] } ] horizontal_solve?(diag_to_row) end',
      programming_language: 'Rooby',
      tags: %w[arrays algorithms],
      user_id: @user_for_solution_tests.id,
      language_id: @language_for_solution_tests.id
    )
  end

  test 'test_solution should be valid' do
    assert @test_solution.valid?
  end

  test 'all fields must not be blank' do
    solution_attributes = %w[title instructions attempt programming_language tags user_id language_id]

    solution_attributes.each do |solution_attribute|
      @test_solution.send("#{solution_attribute}=", '    ')
      assert_not @test_solution.valid?
    end
  end

  test 'Solution instructions should not be more than 60 chars long' do
    @test_solution.title = @test_solution.title * 10
    assert_not @test_solution.valid?
  end

  test 'Solution should not be associated with a non-existent user' do
    @test_solution.user_id = @test_solution.user_id + 1
    assert_not @test_solution.valid?
  end

  # iter 1:
  # test 'Specifying a non-existent programming_language when making a Solution creates the corresponding Language instance, thus making the Solution valid' do
  #   unless Language.find_by(name: 'Clojure')
  #     @test_solution.programming_language = 'Clojure'
  #     @test_solution.save
  #     assert @test_solution.valid? if Language.find_by(name: 'Clojure')
  #   end
  # end

  test 'Specifying a non-existent programming_language when making a Solution creates the corresponding Language instance, thus making the Solution valid' do
    initial_language_count = Language.count
    @test_solution.programming_language = 'Clojure'
    @test_solution.save
    assert Language.count == initial_language_count + 1
    assert @test_solution.valid?
  end
end
