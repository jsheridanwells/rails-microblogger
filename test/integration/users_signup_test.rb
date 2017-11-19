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
end
