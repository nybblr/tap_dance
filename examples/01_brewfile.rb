tap :dev, "nybblr/dev"
tap :dart, "dartsim/dart" do
  brew "dartsim"
end

brew "sack", :tap => :dev
brew "vim", :flags => { :with => [:ruby, :perl, :python] }
