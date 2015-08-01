class Match < ActiveRecord::Base
  belongs_to :black_user, class_name: "UserMatch"
  belongs_to :white_user, class_name: "UserMatch"
end
