require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  let(:current_user) { FactoryGirl.create(:user, name: "Jane Doe", email: "jdoe@example.com") }

  describe "GET index" do
    it "fetches all matches" do
      FactoryGirl.create(:match)
      get :index
      expect(assigns[:matches].map(&:id)).to eq(Match.pluck(:id))
    end
  end

  describe "GET show" do
    let(:board) { FactoryGirl.create(:board, size: 9) }

    it "fetches the right show" do
      get :show, id: board.match_id
      expect(assigns[:match]).to eq(board.match)
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in current_user
    end

    it "makes a new Match" do
      get :new
      expect(assigns[:match]).to be_a_new(Match)
    end

    it "fetches all users" do
      get :new
      expect(assigns[:users]).to eq(User.all)
    end

  end


  describe "POST create" do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:white_user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in current_user
    end

    it "creates a new Match" do
      expect { post :create, match: {} }.to change(Match, :count).by(1)
    end

    it "sets the black_user_id to current_user's id" do
      post :create, match: {"white_user_id" => white_user.id, "board_size" => "19"}
      expect(Match.last.black_user_id).to eq(current_user.id)
    end

    it "creates a 19x19 board" do
      post :create, match: {"white_user_id" => white_user.id, "board_size" => "19"}
      expect(assigns[:match].board_size).to eq(19)
    end

    context "no white user given" do

      it "sets the white user to a non-nil value" do
        post :create, match: {"white_user_id" => ""}
        expect(Match.last.white_user_id).to_not eq(nil)
      end

      it "sets the white user to the black user" do
        post :create, match: {"white_user_id" => ""}
        expect(Match.last.black_user_id).to eq(current_user.id)
      end
    end

  end

  describe "PATCH update" do
    let(:other_user) { FactoryGirl.create(:user, email: "other@example.com") }
    let(:another_user) { FactoryGirl.create(:user, email: "another@example.com") }
    before(:each) do
      sign_in current_user
    end

    context "to join the match" do
      let(:match) { FactoryGirl.create(:match, black_user: other_user, white_user: other_user) }
      it "sets the match's white_user to current_user" do
        expect {
          patch :update, id: match.id
          match.reload
        }.to change(match, :white_user_id).from(other_user.id).to(current_user.id)
      end

      context "when match has two different users" do
        let(:match) { FactoryGirl.create(:match, black_user: other_user, white_user: another_user) }

        it "does not allow a third user to join" do
          expect {
            patch :update, id: match.id
            match.reload
          }.to_not change(match, :white_user_id).from(another_user.id)
        end
      end
    end
  end
end
