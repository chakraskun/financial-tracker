# frozen_string_literal: true
namespace :dummy_data do
  desc 'Create User'
  task user: :environment do
    #singapore
    user_test = User.find_or_initialize_by email: 'demo@wellcode.io'
    user_test_attributes = {
      name: 'Admin',
    }

    user_test.password = 'Admin123'
    user_test.assign_attributes user_test_attributes
    user_test.add_role :admin
    user_test.save! if user_test.changed? || user_test.new_record?
  end

  desc 'create dummy project'
  task project: :environment do
    (1..3).each do |i|
      Project.create(
        name: Faker::Lorem.sentence(word_count: 3),
        price_cents: 0.100000e6,
        date: DateTime.current - i,
        due_date: DateTime.current + i,
        description: Faker::Lorem.sentence(word_count: 7)
      )
    end
  end
end
