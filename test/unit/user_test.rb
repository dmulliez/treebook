require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should have_many(:user_friendships)
	should have_many(:friends)

	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:damien).profile_name
		users(:damien)
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new
		user.profile_name = "My profile name with spaces"
		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly")
	end

	test "no error is raised when trying to access to a friend list" do
		assert_nothing_raised do
			users(:damien).friends
		end
	end

	test "that creating a friendship works" do
		users(:clothilde).friends << users(:john)
		users(:clothilde).friends.reload
		assert users(:clothilde).friends.include?(users(:john))
	end

end
