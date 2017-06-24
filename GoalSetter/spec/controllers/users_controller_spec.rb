require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET :new" do
    it "should render the sign in page" do
    get :new
    expect(response).to render_template(:new)
    end
  end

  describe "POST :create" do

    context "valid parameters" do

      # it "persists the user to the database" do
      #   get :create, user: {username: 'Syrie', password: "Bianco"}
      #   expect(:user).to receive(:save)
      # end
      it "redirect user to the user url" do
        get :create, user: {username: 'Syrie', password: "Bianco"}
        user = User.find_by_username("Syrie")
        expect(response).to redirect_to(user_url(user))
      end
      it "logs the user in" do
        get :create, user: {username: "Syrie", password: "Bianco"}
        user = User.find_by_username("Syrie")
        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end



end
