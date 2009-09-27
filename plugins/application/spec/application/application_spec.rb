require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe Redcar::Application do
  it "has a name" do
    Redcar::Application::NAME.should_not be_nil
  end
  
  it "has a default instance" do
    Redcar.app.is_a? Redcar::Application
  end
  
  describe "instance" do
    before do
      @app = Redcar::Application.new
      @app.controller = RedcarSpec::ApplicationController.new
    end
    
    it "creates a new window" do
      @app.new_window
      @app.windows.length.should == 1
    end
    
    it "notifies the controller that the menu has changed" do
      @app.controller.should_receive(:menu_changed)
      @app.menu = 1
    end
  end
end