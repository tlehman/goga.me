class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :black_matches, class_name: "Match", foreign_key: :black_user_id
  has_many :white_matches, class_name: "Match", foreign_key: :white_user_id
end
