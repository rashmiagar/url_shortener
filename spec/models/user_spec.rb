require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "uniqueness validations" do
	  context "when user with identical email" do
	    let!(:valid_user) {create(:user)}

	    it "should not let a user be created" do
	    	invalid_user = build(:user, email: valid_user.email)
	      expect(invalid_user.valid?).to eq(false)
	      expect{invalid_user.save}.to change{User.count}.by(0) 
	    end

	    it "should render correct errors" do
        user = build(:user, email: valid_user.email)
        user.save
        expect(user.errors.keys).to include(:email)
        expect(user.errors.values).to include(["has already been taken"])
      end
	  end
	end

	describe '.find_by_api_token!' do
    let(:user) {create(:user)}
    
    context "when no user exists with the token" do
      it "should raise exception" do
        expect{User.find_by_api_token!("TOKEN")}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    context "when user exists with the token" do
      before do
        @raw = user.api_token
      end

      it "should return the right user" do
        expect(User.find_by_api_token!(@raw)).to eq(user)
      end
    end
  end

  describe "#email_lowercase" do
    let(:user) {create(:user, email: Faker::Internet.email.upcase)}
    
    it "should save email with all lowercase in database" do
      expect(User.find_by_email(user.email).email).to eq(user.email.downcase)
    end
  end

  describe "associations" do
  	subject { create(:user) }

    it { is_expected.to have_many(:short_urls) }
  end
end