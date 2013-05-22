bindle = "./bin/bindle"

describe "bindle" do
  it "should output basic usage info" do
    system(bindle).should be_true
  end

  it "should have an install task" do
    system("#{bindle} install").should be_true
  end

  it "should have an update task" do
    system("#{bindle} update").should be_true
  end

  it "should use the default Brewfile without args" do
    `#{bindle}`.should include(File.join File.expand_path(Dir.pwd), "Brewfile")
  end

  it "should use the given Brewfile" do
    brewfile = "lib/bindler/Brewfile"
    `#{bindle} -B #{brewfile}`.should include(File.join File.expand_path(Dir.pwd), brewfile)
  end
end
