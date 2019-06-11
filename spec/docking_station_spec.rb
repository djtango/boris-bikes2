require 'docking_station.rb'

describe DockingStation do
  context "creating a new docking station" do
    let(:docking_station) {DockingStation[:dot_new][]}
    it "DockingStation should return a new docking station when dot_new is called" do
      expect(docking_station[:dot_class?][]).to eq(:DockingStation)
    end
    it "Should be able to receive a bike" do
      docking_station[:dot_dock][:bike]
      expect(docking_station[:dot_bikes][]).to include(:bike)
    end
    describe "#release_bike" do
      before do
        docking_station[:dot_dock][:bike]
      end
      it "Should return a bike to the user" do
        expect(docking_station[:dot_release_bike][]).to eq(:bike)
      end
      it "Should be able to release a bike" do
        docking_station[:dot_release_bike][]
        expect(docking_station[:dot_bikes][]).to be_empty
      end
    end
  end
end
