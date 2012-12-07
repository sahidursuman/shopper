require 'spec_helper'

describe AddressesController do

  let!(:user)        { User.make!}
  let!(:address)     { user.addresses.make! }

  before { sign_in user }

  describe "GET 'new'" do
    it "assigns to the new address" do
      get :new, format: :js
      assigns(:address).should_not be_nil
    end
  end

  describe "POST 'create'" do
    let(:address_attr) { { street_address: 'street-1', city: 'city-1', 
                           state: 'state-1', zip: 12223, 
                           country_id: 1, phone: 2312, email: "test@test.com",
                           user_id: user.id } }

    it "creates a new address" do
      expect{
        post :create, address: address_attr, format: :js
      }.to change(Address, :count).by(1)
    end
  end

  describe "PUT 'update'" do

    let(:address_attr) { { street_address: 'street-1', city: 'city-1', 
                           state: 'state-1', zip: 12223, 
                           phone: 2312, email: "test@test.com",
                           user_id: user.id } }
    before :all do
      @address = user.addresses.make!
    end

    it "should located the requested @address " do
      put :update, id: @address.id, address: address_attr, format: :js
      @address.reload
      assigns(:address).should eq(@address) 
    end

    it "should changes @address's attributes" do
      put :update, id: @address.id, address: address_attr, format: :js
      @address.reload
      @address.street_address.should eq("street-1")
    end
  end

  describe 'DELETE destroy' do
  
    it "should deletes the address" do
      expect{
        delete :destroy, id: address.id, format: :js
      }.to change(Address,:count).by(-1)
    end
  end

end