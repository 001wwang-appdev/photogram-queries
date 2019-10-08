require "rails_helper"

describe Photo, "#poster" do
  it "returns the user who posted the photo", :points => 1 do
    other_user = User.new
    other_user.save

    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.save

    expect(photo.poster).to eq(user)
  end
end


describe Photo, "#comments" do
  it "returns the comments made on the photo", :points => 1 do
    photo = Photo.new
    photo.save

    other_photo = Photo.new
    other_photo.save

    first_comment = Comment.new
    first_comment.photo_id = photo.id
    first_comment.save

    second_comment = Comment.new
    second_comment.photo_id = other_photo.id
    second_comment.save

    third_comment = Comment.new
    third_comment.photo_id = photo.id
    third_comment.save

    expect(photo.comments).to match_array([first_comment, third_comment])
  end
end

describe Comment, "#commenter" do
  it "returns the user who authored the comment", :points => 1 do
    other_user = User.new
    other_user.save

    user = User.new
    user.save

    comment = Comment.new
    comment.author_id = user.id
    comment.save

    expect(comment.commenter).to eq(user)
  end
end

describe Photo, "#likes" do
  it "returns the likes made on the photo", :points => 1 do
    photo = Photo.new
    photo.save

    other_photo = Photo.new
    other_photo.save

    first_like = Like.new
    first_like.photo_id = photo.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = other_photo.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = photo.id
    third_like.save

    expect(photo.likes).to match_array([first_like, third_like])
  end
end

describe Photo, "#fans" do
  it "returns the users that have liked the photo", :points => 2 do
    photo = Photo.new
    photo.save

    other_photo = Photo.new
    other_photo.save

    first_user = User.new
    first_user.save

    second_user = User.new
    second_user.save

    third_user = User.new
    third_user.save

    first_like = Like.new
    first_like.photo_id = photo.id
    first_like.fan_id = first_user.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = other_photo.id
    second_like.fan_id = second_user.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = photo.id
    third_like.fan_id = third_user.id
    third_like.save

    expect(photo.fans).to match_array([first_user, third_user])
  end
end

describe Photo, "#fan_list" do
  it "returns the usernames of the users that have liked the photo as a sentence", :points => 3 do
    photo = Photo.new
    photo.save

    first_user = User.new
    first_user.username = "alice"
    first_user.save

    second_user = User.new
    second_user.username = "bob"
    second_user.save

    third_user = User.new
    third_user.username = "carol"
    third_user.save

    first_like = Like.new
    first_like.photo_id = photo.id
    first_like.fan_id = first_user.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = photo.id
    second_like.fan_id = second_user.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = photo.id
    third_like.fan_id = third_user.id
    third_like.save

    expect(photo.fan_list).to eq("alice, bob, and carol")
  end
end

describe User, "#comments" do
  it "returns the comments the user has made", :points => 1 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_comment = Comment.new
    first_comment.author_id = user.id
    first_comment.save

    second_comment = Comment.new
    second_comment.author_id = other_user.id
    second_comment.save

    third_comment = Comment.new
    third_comment.author_id = user.id
    third_comment.save

    expect(user.comments).to match_array([first_comment, third_comment])
  end
end

describe User, "#own_photos" do
  it "returns the photos posted by the user", :points => 1 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = user.id
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = other_user.id
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = user.id
    third_photo.save

    expect(user.own_photos).to match_array([first_photo, third_photo])
  end
end

describe User, "#likes" do
  it "returns the likes created by the user", :points => 1 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_like = Like.new
    first_like.fan_id = user.id
    first_like.save

    second_like = Like.new
    second_like.fan_id = other_user.id
    second_like.save

    third_like = Like.new
    third_like.fan_id = user.id
    third_like.save

    expect(user.likes).to match_array([first_like, third_like])
  end
end

describe User, "#liked_photos" do
  it "returns the photos the user has liked", :points => 2 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_photo = Photo.new
    first_photo.save

    second_photo = Photo.new
    second_photo.save

    third_photo = Photo.new
    third_photo.save

    first_like = Like.new
    first_like.photo_id = first_photo.id
    first_like.fan_id = user.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = second_photo.id
    second_like.fan_id = other_user.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = third_photo.id
    third_like.fan_id = user.id
    third_like.save

    expect(user.liked_photos).to match_array([first_photo, third_photo])
  end
end

describe User, "#commented_photos" do
  context "when the user made only one comment per photo" do
    it "returns the photos the user has commented on", :points => 2 do
      user = User.new
      user.save

      other_user = User.new
      other_user.save

      first_photo = Photo.new
      first_photo.save

      second_photo = Photo.new
      second_photo.save

      third_photo = Photo.new
      third_photo.save

      first_comment = Comment.new
      first_comment.author_id = user.id
      first_comment.photo_id = first_photo.id
      first_comment.save

      second_comment = Comment.new
      second_comment.author_id = other_user.id
      second_comment.photo_id = second_photo.id
      second_comment.save

      third_comment = Comment.new
      third_comment.author_id = user.id
      third_comment.photo_id = third_photo.id
      third_comment.save

      expect(user.commented_photos).to match_array([first_photo, third_photo])
    end
  end
end

describe User, "#commented_photos" do
  context "when the user made more than one comment per photo" do
    it "returns the photos the user has commented on", :points => 3 do
      user = User.new
      user.save

      other_user = User.new
      other_user.save

      first_photo = Photo.new
      first_photo.save

      second_photo = Photo.new
      second_photo.save

      third_photo = Photo.new
      third_photo.save

      first_comment = Comment.new
      first_comment.author_id = user.id
      first_comment.photo_id = first_photo.id
      first_comment.save

      second_comment = Comment.new
      second_comment.author_id = other_user.id
      second_comment.photo_id = second_photo.id
      second_comment.save

      third_comment = Comment.new
      third_comment.author_id = user.id
      third_comment.photo_id = third_photo.id
      third_comment.save

      another_comment_on_first_photo = Comment.new
      another_comment_on_first_photo.author_id = user.id
      another_comment_on_first_photo.photo_id = first_photo.id
      another_comment_on_first_photo.save

      another_comment_on_third_photo = Comment.new
      another_comment_on_third_photo.author_id = user.id
      another_comment_on_third_photo.photo_id = third_photo.id
      another_comment_on_third_photo.save

      expect(user.commented_photos).to match_array([first_photo, third_photo])
    end
  end
end

describe User, "#sent_follow_requests" do
  it "returns all of the follow requests that were sent by the user", :points => 1 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = other_user.id
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.save

    expect(user.sent_follow_requests).to match_array([first_follow_request, third_follow_request])
  end
end

describe User, "#received_follow_requests" do
  it "returns all of the follow requests that were received by the user", :points => 1 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_follow_request = FollowRequest.new
    first_follow_request.recipient_id = user.id
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.recipient_id = other_user.id
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.recipient_id = user.id
    third_follow_request.save

    expect(user.received_follow_requests).to match_array([first_follow_request, third_follow_request])
  end
end

describe User, "#accepted_sent_follow_requests" do
  it "returns the follow requests that were sent by the user and accepted", :points => 2 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = other_user.id
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.status = "accepted"
    third_follow_request.save

    expect(user.accepted_sent_follow_requests).to match_array([third_follow_request])
  end
end

describe User, "#accepted_received_follow_requests" do
  it "returns the follow requests that were received by the user and accepted", :points => 2 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_follow_request = FollowRequest.new
    first_follow_request.recipient_id = user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.recipient_id = other_user.id
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.recipient_id = user.id
    third_follow_request.status = "accepted"
    third_follow_request.save

    expect(user.accepted_received_follow_requests).to match_array([third_follow_request])
  end
end

describe User, "#followers" do
  it "returns the people who the user has accepted follow requests from", :points => 3 do
    user = User.new
    user.save

    first_other_user = User.new
    first_other_user.save

    second_other_user = User.new
    second_other_user.save

    third_other_user = User.new
    third_other_user.save

    fourth_other_user = User.new
    fourth_other_user.save

    first_follow_request = FollowRequest.new
    first_follow_request.recipient_id = user.id
    first_follow_request.sender_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.recipient_id = user.id
    second_follow_request.sender_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.recipient_id = user.id
    third_follow_request.sender_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.recipient_id = user.id
    fourth_follow_request.sender_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    expect(user.followers).to match_array([second_other_user, fourth_other_user])
  end
end

describe User, "#following" do
  it "returns the people who have accepted follow requests from the user", :points => 3 do
    user = User.new
    user.save

    first_other_user = User.new
    first_other_user.save

    second_other_user = User.new
    second_other_user.save

    third_other_user = User.new
    third_other_user.save

    fourth_other_user = User.new
    fourth_other_user.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    expect(user.following).to match_array([second_other_user, fourth_other_user])
  end
end

describe User, "#feed" do
  it "returns the photos posted by the people the user is following", :points => 4 do
    user = User.new
    user.save

    first_other_user = User.new
    first_other_user.save

    first_other_user_first_photo = Photo.new
    first_other_user_first_photo.owner_id = first_other_user.id
    first_other_user_first_photo.save
    first_other_user_second_photo = Photo.new
    first_other_user_second_photo.owner_id = first_other_user.id
    first_other_user_second_photo.save

    second_other_user = User.new
    second_other_user.save

    second_other_user_first_photo = Photo.new
    second_other_user_first_photo.owner_id = second_other_user.id
    second_other_user_first_photo.save
    second_other_user_second_photo = Photo.new
    second_other_user_second_photo.owner_id = second_other_user.id
    second_other_user_second_photo.save

    third_other_user = User.new
    third_other_user.save

    third_other_user_first_photo = Photo.new
    third_other_user_first_photo.owner_id = third_other_user.id
    third_other_user_first_photo.save
    third_other_user_second_photo = Photo.new
    third_other_user_second_photo.owner_id = third_other_user.id
    third_other_user_second_photo.save

    fourth_other_user = User.new
    fourth_other_user.save

    fourth_other_user_first_photo = Photo.new
    fourth_other_user_first_photo.owner_id = fourth_other_user.id
    fourth_other_user_first_photo.save
    fourth_other_user_second_photo = Photo.new
    fourth_other_user_second_photo.owner_id = fourth_other_user.id
    fourth_other_user_second_photo.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    expect(user.feed).to match_array(
      [
        second_other_user_first_photo,
        second_other_user_second_photo,
        fourth_other_user_first_photo,
        fourth_other_user_second_photo
      ]
    )
  end
end

describe User, "#discover" do
  it "returns the photos that are liked by the people the user is following", :points => 4 do
    user = User.new
    user.save

    first_other_user = User.new
    first_other_user.save

    first_other_user_first_liked_photo = Photo.new
    first_other_user_first_liked_photo.save

    first_other_user_first_like = Like.new
    first_other_user_first_like.fan_id = first_other_user.id
    first_other_user_first_like.photo_id = first_other_user_first_liked_photo.id
    first_other_user_first_like.save

    first_other_user_second_liked_photo = Photo.new
    first_other_user_second_liked_photo.save

    first_other_user_first_like = Like.new
    first_other_user_first_like.fan_id = first_other_user.id
    first_other_user_first_like.photo_id = first_other_user_second_liked_photo.id
    first_other_user_first_like.save

    second_other_user = User.new
    second_other_user.save

    second_other_user_first_liked_photo = Photo.new
    second_other_user_first_liked_photo.save

    second_other_user_first_like = Like.new
    second_other_user_first_like.fan_id = second_other_user.id
    second_other_user_first_like.photo_id = second_other_user_first_liked_photo.id
    second_other_user_first_like.save

    second_other_user_second_liked_photo = Photo.new
    second_other_user_second_liked_photo.save

    second_other_user_first_like = Like.new
    second_other_user_first_like.fan_id = second_other_user.id
    second_other_user_first_like.photo_id = second_other_user_second_liked_photo.id
    second_other_user_first_like.save

    third_other_user = User.new
    third_other_user.save

    third_other_user_first_liked_photo = Photo.new
    third_other_user_first_liked_photo.save

    third_other_user_first_like = Like.new
    third_other_user_first_like.fan_id = third_other_user.id
    third_other_user_first_like.photo_id = third_other_user_first_liked_photo.id
    third_other_user_first_like.save

    third_other_user_second_liked_photo = Photo.new
    third_other_user_second_liked_photo.save

    third_other_user_first_like = Like.new
    third_other_user_first_like.fan_id = third_other_user.id
    third_other_user_first_like.photo_id = third_other_user_second_liked_photo.id
    third_other_user_first_like.save

    fourth_other_user = User.new
    fourth_other_user.save

    fourth_other_user_first_liked_photo = Photo.new
    fourth_other_user_first_liked_photo.save

    fourth_other_user_first_like = Like.new
    fourth_other_user_first_like.fan_id = fourth_other_user.id
    fourth_other_user_first_like.photo_id = fourth_other_user_first_liked_photo.id
    fourth_other_user_first_like.save

    fourth_other_user_second_liked_photo = Photo.new
    fourth_other_user_second_liked_photo.save

    fourth_other_user_first_like = Like.new
    fourth_other_user_first_like.fan_id = fourth_other_user.id
    fourth_other_user_first_like.photo_id = fourth_other_user_second_liked_photo.id
    fourth_other_user_first_like.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    expect(user.discover).to match_array(
      [
        second_other_user_first_liked_photo,
        second_other_user_second_liked_photo,
        fourth_other_user_first_liked_photo,
        fourth_other_user_second_liked_photo
      ]
    )
  end
end
