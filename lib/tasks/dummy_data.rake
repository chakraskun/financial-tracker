# frozen_string_literal: true
namespace :initialize_user do
  desc 'Create User'
  task user: :environment do
    user_test = User.find_or_initialize_by email: 'kuntjoro.chakras@gmail.com'
    user_test_attributes = {
      name: 'Admin',
    }

    user_test.password = 'password'
    user_test.assign_attributes user_test_attributes
    user_test.add_role :admin
    user_test.save! if user_test.changed? || user_test.new_record?
  end
end
