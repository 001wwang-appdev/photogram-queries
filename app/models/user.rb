# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  comments_count :integer
#  likes_count    :integer
#  private        :boolean
#  username       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class User < ApplicationRecord

    def comments
        return Comment.where({author_id: self.id})
    end

    def own_photos
        return Photo.where({owner_id: self.id})
    end

    def likes
        return Like.where({fan_id: self.id})
    end

    def liked_photos
        return Photo.where({id: self.likes.pluck('photo_id')})
    end

    def commented_photos
        return Photo.where({id: self.comments.pluck('photo_id')})
    end

    def sent_follow_requests
        return FollowRequest.where({sender_id: self.id})
    end

    def received_follow_requests
        return FollowRequest.where({recipient_id: self.id})
    end

    def accepted_sent_follow_requests
        return self.sent_follow_requests.where({status: 'accepted'})
    end

    def accepted_received_follow_requests
        return self.received_follow_requests.where({status: 'accepted'})
    end

    def followers
        return User.where({id: self.accepted_received_follow_requests.pluck('sender_id')})
    end

    def following
        return User.where({id: self.accepted_sent_follow_requests.pluck('recipient_id')})
    end

    def feed
        return Photo.where({owner_id: self.following.pluck('id')})
    end

    def discover
        return Photo.where({id: Like.where({fan_id: self.following.pluck('id')}).pluck('photo_id')})
    end
end
