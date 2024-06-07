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
    @language_of_solution_tests = Language.create(name: 'Rooby', user_id: @user_for_solution_tests)
    @test_solution = Solution.new(
      title: 'Tic-Tac-Toe Checker',
      instructions: "If we were to set up a Tic-Tac-Toe game, we would want to know whether the board's current state is solved, wouldn't we? Our goal is to create a function that will check that for us!",
      attempt: 'def is_solved(board) result = horizontal_solve?(board) || vertical_solve?(board) || diagonal_solve?(board) return result if result board.any? { |row| row.include?(0) } ? -1 : 0 end def horizontal_solve?(board) board.each do |row| return 1 if row.all? { |num| num == 1 } return 2 if row.all? { |num| num == 2 } end nil end def vertical_solve?(board) # col_to_row = board.each_with_index.map do |row, x| #   row.each_with_index.map { |_, y| board[y][x] } # end col_to_row = board.transpose horizontal_solve?(col_to_row) end def diagonal_solve?(board) diag_to_row = [ board.each_with_index.map { |row, idx| row[idx] }, board.each_with_index.map { |row, idx| row.reverse[idx] } ] horizontal_solve?(diag_to_row) end',
      programming_language: 'Rooby',
      tags: %w[arrays algorithms],
      user_id: @user_for_solution_tests.id,
      language_id: @language_of_solution_tests.id
    )
  end

  test 'test_solution should be valid' do
    assert @test_solution.valid?
  end

  test 'Solution title should not be blank' do
    @test_solution.title = '    '
    assert_not @test_solution.valid?
  end

  test 'Solution instructions should not be more than 60 chars long' do
    @test_solution.title = @test_solution.title * 10
    assert_not @test_solution.valid?
  end

  test 'Solution instructions should not be blank' do
    @test_solution.instructions = '    '
    assert_not @test_solution.valid?
  end

  test 'Solution attempt should not be blank' do
    @test_solution.attempt = '    '
    assert_not @test_solution.valid?
  end

  test 'Solution programming_language should not be blank' do
    @test_solution.programming_language = '    '
    assert_not @test_solution.valid?
  end

  test 'Solution tags should not be blank' do
    @test_solution.tags = []
    assert_not @test_solution.valid?
  end

  test 'Solution user_id should not be blank' do
    @test_solution.user_id = '    '
    assert_not @test_solution.valid?
  end

  test 'Solution language_id should not be blank' do
    @test_solution.programming_language = '   '
    @test_solution.language_id = '    '
    assert_not @test_solution.valid?
  end

  test 'Solution should not be associated with a non-existent user' do
    @test_solution.user_id = @test_solution.user_id + 1
    assert_not @test_solution.valid?
  end

  # test 'Specifying a non-existent programming_language when making a Solution creates the corresponding Language instance, thus making the Solution valid' do
  #   unless Language.find_by(name: 'Clojure')
  #     @test_solution.programming_language = 'Clojure'
  #     @test_solution.save
  #     assert @test_solution.valid? if Language.find_by(name: 'Clojure')
  #   end
  # end

  test 'Specifying a non-existent programming_language when making a Solution creates the corresponding Language instance, thus making the Solution valid' do
    old_count = Language.count
    @test_solution.programming_language = 'Clojure'
    @test_solution.save
    assert Language.count == old_count + 1, 'Expected a new Language record to be created'
    assert @test_solution.valid?, 'Expected solution to be valid after saving'
  end
end
