require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  setup do
    @user_for_language_tests = User.create(
      alias: 'Language Test',
      bio: 'For testing the Language model.',
      email: 'test_user@language.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
    @test_language_x = Language.new(name: 'Ruby', user_id: @user_for_language_tests.id)
    @test_language_y = Language.new(name: 'Elixir', user_id: @user_for_language_tests.id)
  end

  test 'Language name should not be blank' do
    @test_language_x.name = '   '
    assert_not @test_language_x.valid?
  end

  test 'No two Language names should be the same' do
    @test_language_x.name = 'Ruby'
    @test_language_x.user_id = @user_for_language_tests.id
    @test_language_x.save

    @test_language_y.name = 'Ruby'
    assert_not @test_language_y.valid?
  end

  test 'Language user_id should not be blank' do
    @test_language_y.user_id = '    '
    assert_not @test_language_y.valid?
  end

  test 'Language should not be associated with a non-existent user' do
    @test_language_y.user_id = @user_for_language_tests.id + 1
    assert_not @test_language_y.valid?
  end

  test 'Language name should be capitalized upon save' do
    @test_language_y.name = 'Elixir'
    @test_language_y.user_id = @user_for_language_tests.id
    @test_language_y.save if @test_language_y.valid?

    assert @test_language_y.name[0].upcase == @test_language_y.name[0]
  end

  test 'Multiple languages can be associated with a single user' do
    Language.create(name: 'C', user_id: @user_for_language_tests.id)
    Language.create(name: 'Common Lisp', user_id: @user_for_language_tests.id)
    Language.create(name: 'Clojure', user_id: @user_for_language_tests.id)

    assert @user_for_language_tests.languages.length == 3
  end
end
