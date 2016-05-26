require 'rails_helper'

RSpec.describe ShortUrl, :type => :model do
  describe "uniqueness validations" do
	  context "when url with identical shorty" do
	    let!(:url) {create(:short_url)}

	    it "should not let a link be created" do
	    	invalid_url = build(:short_url, shorty: url.shorty)
	      expect(invalid_url.valid?).to eq(false)
	      expect{invalid_url.save}.to change{ShortUrl.count}.by(0) 
	    end
	  end
    context "when identical long_url and user_id already exists" do
      let!(:url) {create(:short_url)}

      it "should not let a link be created" do
        invalid_url = build(:short_url, long_url: url.long_url, user_id: url.user_id)

        expect(invalid_url.valid?).to eq(false)
      end
    end
	end
  describe "#generate" do
    context "when unique url is generated" do
      before do
        @url = ShortUrl.generate("http://google.com")
      end
      it "should return alphanumeric characters" do
        expect(@url).to match(/^[a-zA-Z0-9_]+$/)
      end
      it "should have length 5" do
        expect(@url.length).to eq(5)
      end
    end
  end

  describe "associations" do
    subject { create(:short_url) }
    it { is_expected.to have_many(:short_visits) }
    it { is_expected.to belong_to(:user)}
  end
end