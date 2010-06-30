require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :users

  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_initialize_activation_code_upon_creation
    user = create_user
    user.reload
    assert_not_nil user.activation_code
  end

  def test_should_require_login
    assert_no_difference 'User.count' do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    users(:alice).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:alice), User.authenticate('alice', 'new password')
  end

  def test_should_not_rehash_password
    users(:alice).update_attributes(:login => 'alice2')
    assert_equal users(:alice), User.authenticate('alice2', 'monkey')
  end

  def test_should_authenticate_user
    assert_equal users(:alice), User.authenticate('alice', 'monkey')
  end

  def test_should_set_remember_token
    users(:alice).remember_me
    assert_not_nil users(:alice).remember_token
    assert_not_nil users(:alice).remember_token_expires_at
  end

  def test_should_unset_remember_token
    users(:alice).remember_me
    assert_not_nil users(:alice).remember_token
    users(:alice).forget_me
    assert_nil users(:alice).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    users(:alice).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil users(:alice).remember_token
    assert_not_nil users(:alice).remember_token_expires_at
    assert users(:alice).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    users(:alice).remember_me_until time
    assert_not_nil users(:alice).remember_token
    assert_not_nil users(:alice).remember_token_expires_at
    assert_equal users(:alice).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    users(:alice).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil users(:alice).remember_token
    assert_not_nil users(:alice).remember_token_expires_at
    assert users(:alice).remember_token_expires_at.between?(before, after)
  end

protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
