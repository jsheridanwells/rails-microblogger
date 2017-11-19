require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'cannot post invalid signup' do
    get signup_path
    assert_no_difference  'User.count' do
      post users_path, params: {user: {
          name: '',
          email: 'user@invalid',
          password: '123',
          password_confirmation: '456'
        }}
      end
      assert_template 'users/new'
  end

  test 'error messages appear on invalid submission' do
    get signup_path
    assert_no_difference  'User.count' do
      post users_path, params: {user: {
          name: '',
          email: 'user@invalid',
          password: '123',
          password_confirmation: '456'
        }}
      end
      assert_template 'users/new'
      assert_select 'div#error_explanation'
  end

  test 'new item in db if user signup is successful' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {
          name: 'good user',
          email: 'user@valid.com',
          password: '123456',
          password_confirmation: '123456'
        }}
    end
  end
end
