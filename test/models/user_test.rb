# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  USER_ATTRIBUTES = %w[alias bio email password password_confirmation].freeze

  setup do
    @test_user = User.new(
      alias: 'User Test',
      bio: 'For testing the User model.',
      email: 'test_user@user.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
  end

  test 'test_user should be valid' do
    assert @test_user.valid?
  end

  test 'User aliases should be unique' do
    test_user_dup = @test_user.dup
    test_user_dup.save
    assert_not @test_user.valid?
  end

  test 'all fields should be filled' do
    USER_ATTRIBUTES.each do |user_attribute|
      @test_user.send("#{user_attribute}=", '   ')
      assert_not @test_user.valid?
    end
  end

  test 'User aliases between 3 and 50 characters long should be valid' do
    valid_aliases = %w[polo vince plato derrida yarnIsForKnitting antidisestablishmentarianism]
    valid_aliases.each do |valid_alias|
      @test_user.alias = valid_alias
      assert @test_user.valid?
    end
  end

  test 'User aliases shorter than 3 or longer than 50 characters long should not be valid' do
    invalid_aliases = %w[a ra ako_si_9876543210987654321098765432109876543210asj;ldfkjaslkdfjlsadfj]
    invalid_aliases.each do |invalid_alias|
      @test_user.alias = invalid_alias
      assert_not @test_user.valid?
    end
  end

  test 'User bio should be within 512 characters long' do
    @test_user.bio = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus e'
    assert @test_user.valid?
  end

  test 'User bios longer than 512 characters long should not be valid' do
    @test_user.bio = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus e' * 2
    assert_not @test_user.valid?
  end

  test 'email should not be too long' do
    @test_user.email = "#{'a' * 1200}@example.com"
    assert_not @test_user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.com
                         first.last@foo.jp alice+bob@baz.com]

    valid_addresses.each do |valid_address|
      @test_user.email = valid_address
      assert @test_user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reflect invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |invalid_address|
      @test_user.email = invalid_address
      assert_not @test_user.valid?
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @test_user.dup
    @test_user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lowercase' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @test_user.email = mixed_case_email
    @test_user.save
    assert_equal mixed_case_email.downcase, @test_user.reload.email
  end

  test 'a User can have many languages and solutions' do
    user_for_languages_and_solutions = User.create(
      alias: 'UserWithSolves',
      bio: 'For testing multiple languages and solutions.',
      email: 'test_user@langsol.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
    Solution.create(
      title: 'Tic-Tac-Toe Checker',
      instructions: "If we were to set up a Tic-Tac-Toe game, we would want to know whether the board's current state is solved, wouldn't we? Our goal is to create a function that will check that for us!",
      attempt: 'def is_solved(board) result = horizontal_solve?(board) || vertical_solve?(board) || diagonal_solve?(board) return result if result board.any? { |row| row.include?(0) } ? -1 : 0 end def horizontal_solve?(board) board.each do |row| return 1 if row.all? { |num| num == 1 } return 2 if row.all? { |num| num == 2 } end nil end def vertical_solve?(board) # col_to_row = board.each_with_index.map do |row, x| #   row.each_with_index.map { |_, y| board[y][x] } # end col_to_row = board.transpose horizontal_solve?(col_to_row) end def diagonal_solve?(board) diag_to_row = [ board.each_with_index.map { |row, idx| row[idx] }, board.each_with_index.map { |row, idx| row.reverse[idx] } ] horizontal_solve?(diag_to_row) end',
      programming_language: 'Ruby',
      tags: %w[arrays algorithms],
      user_id: user_for_languages_and_solutions.id
    )
    Solution.create(
      title: 'Create Phone Number',
      instructions: 'Write a function that accepts an array of 10 integers (between 0 and 9), that returns a string of those numbers in the form of a phone number.',
      attempt: "def create_phone_number(numbers) phone_number = '(xxx) xxx-xxxx' numbers.each { |num| phone_number = phone_number.sub('x', num.to_s) } phone_number end",
      programming_language: 'Ruby',
      tags: %w[arrays algorithms],
      user_id: user_for_languages_and_solutions.id
    )
    Solution.create(
      title: 'Does my number look big in this?',
      instructions: 'Write a function that accepts an array of 10 integers (between 0 and 9), that returns a string of those numbers in the form of a phone number.',
      attempt: 'function narcissistic(value) { return value === [...value.toString()].reduce((accumulator, currentValue) => { return Number(accumulator) + Math.pow(Number(currentValue), [...value.toString()].length); }, 0); }',
      programming_language: 'JavaScript',
      tags: %w[algorithms],
      user_id: user_for_languages_and_solutions.id
    )

    assert user_for_languages_and_solutions.languages.count == 2
    assert user_for_languages_and_solutions.solutions.count == 3
    assert user_for_languages_and_solutions.solutions_in('Ruby').count == 2
    assert user_for_languages_and_solutions.solutions_in('Javascript').count == 1
  end
end
