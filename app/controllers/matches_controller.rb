class MatchesController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params['id'])
  end

  def new
    @match = Match.new
    @users = User.all
  end

  def update
    @match = Match.find_by(id: params['id'])
    @match.update_attributes(white_user_id: current_user.id)
    @match.save
    respond_with @match
  end

  def create
    @match = Match.create(black_user: black_user, white_user: white_user)
    respond_with @match
  end

  private

  def black_user
    current_user
  end

  def white_user
    white_user = User.find_by(id: white_user_id)
    white_user = current_user if white_user.blank?

    white_user
  end

  def white_user_id
    params['match'] && params['match']['white_user_id']
  end
end

