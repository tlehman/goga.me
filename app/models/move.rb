class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :match
  enum color: [:black, :white]
end
