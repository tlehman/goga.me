class Match < ActiveRecord::Base
  belongs_to :black_user, class_name: "User", foreign_key: :black_user_id
  belongs_to :white_user, class_name: "User", foreign_key: :white_user_id

  delegate :name, to: :black_user, prefix: true, allow_nil: true
  delegate :name, to: :white_user, prefix: true, allow_nil: true
end
