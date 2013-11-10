require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a friendshipo works without raising an exception" do
		assert_nothing_raised do
			UserFriendship.create user: users(:damien), friend: users(:john)
		end
	end

	test "that creating a friendship based on user id and friend id works" do
		UserFriendship.create user_id: users(:damien).id, friend_id: users(:clothilde).id
		assert users(:damien).friends.include?(users(:clothilde))
	end

end
