require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  let(:current_user) { FactoryGirl.create(:user, name: "Jane Doe") }

  describe "GET index" do
    it "fetches all matches" do
      get :index
      expect(assigns[:matches]).to eq(Match.all)
    end
  end

  describe "GET show" do
    let(:match) { FactoryGirl.create(:match) }

    it "fetches the right show" do
      get :show, id: match.id
      expect(assigns[:match]).to eq(match)
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
      expect { post :create }.to change(Match, :count).by(1)
    end

    it "sets the black_user_id to current_user's id" do
      post :create, match: {"white_user_id" => white_user.id}
      expect(Match.last.black_user_id).to eq(current_user.id)
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
end
