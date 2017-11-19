require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: 'Example Person',
      email: 'example@example.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  test 'user with name and email should be valid' do
    assert @user.valid?
  end

  test 'user without name is not valid' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'user without email is not valid' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'user name should not be more than 50 characters' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'user email should not be more than 50 characters' do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test 'model should accept valid email addresses' do
    valid_emails = [
        'example@example.com',
        'EXAMPLE@example.COM',
        'ex_amp-le@example.com'
    ]

    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test 'model should not accept invalid email addresses' do
    invalid_emails = [
        'exampleexample.com',
        'EXAMPLE@example,COM',
        'ex_amp-le @example.com'
    ]

    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email should be saved lowercase' do
    @user.email = 'EXample@EXample.COM'
    @user.save
    assert_equal @user.email.downcase, @user.reload.email
  end

  test 'password is not blank' do
    @user.password = @user.password_confirmation = '' * 6
    assert_not @user.valid?
  end

  test 'password is 6 or greater characters' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

end
