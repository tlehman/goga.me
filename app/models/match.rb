class Match < ActiveRecord::Base
  has_one :black_player, class_name: 'User'
  has_one :white_player, class_name: 'User'
end
