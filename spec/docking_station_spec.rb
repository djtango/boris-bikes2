require 'docking_station.rb'
include DockingStation
describe DockingStation do
  context "creating a new docking station" do
    it "DockingStation should return a new docking station when dot_new is called" do
      expect(DockingStation::dot_new[]).to be_kind_of(Proc)
    end
    it "Should be able to receive a bike" do
      docking_station = DockingStation::dot_new[]
      docking_station[:dot_dock][:bike]
      expect(docking_station[:dot_bikes]).to include(:bike)
    end
  end
end
