require 'bike.rb'
include Bike
describe Bike do
  context "Getting a new bike" do
    let(:bike) {Bike::dot_new[]}
    it "should be a bike" do
      expect(bike[:dot_class?]).to eq(:Bike)
    end
    it "a new bike should be working" do
      expect(bike[:dot_working?]).to be true
    end
  end
end
