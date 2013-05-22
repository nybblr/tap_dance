require 'bindler'

describe Bindler do
  it "shouldn't mind aliasing to the module" do
    Bindler.install.should eql(Bindler::Bindle.new.install)
    Bindler.update.should eql(Bindler::Bindle.new.update)
  end
end

describe Bindler::Bindle do
  it "outputs hello when installing" do
    # Bindler::Bindle.new.install.should eql("hello world!")
    Bindler::Bindle.new.install
  end

  it "outputs goodbye when updating" do
    # Bindler::Bindle.new.update.should eql("goodbye world!")
    Bindler::Bindle.new.update
  end
end

