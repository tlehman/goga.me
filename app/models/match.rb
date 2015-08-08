class Match < ActiveRecord::Base
  belongs_to :black_user, class_name: "UserMatch"
  belongs_to :white_user, class_name: "UserMatch"

  delegate :black_user_name, to: :black_user, allow_nil: true
  delegate :white_user_name, to: :white_user, allow_nil: true
end
