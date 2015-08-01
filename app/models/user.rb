class User < ActiveRecord::Base
  belongs_to :user_match
  has_many :user_matches
end
