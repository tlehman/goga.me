class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  enum color: [:black, :white]
end
