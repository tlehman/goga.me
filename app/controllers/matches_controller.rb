class MatchesController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @matches = Match.all.order("id DESC")
  end

  def show
    @match = Match.find(params['id'])
  end

  def new
    @match = Match.new
    @users = User.all
  end

  def create
    @match = Match.create(black_user: black_user, white_user: white_user)
    @match.create_board(board_width)
    respond_with @match
  end

  def update
    @match = Match.find_by(id: params['id'])
    if @match.joined?
      flash[:error] = "Match has already been joined by another player"
    else
      @match.update_attributes(white_user_id: current_user.id)
      @match.save
    end

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

  def board_width
    params['match']['board_width'].to_i
  end
end

