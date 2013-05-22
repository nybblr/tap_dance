tap = "./bin/tap"

describe "tap" do
  it "should output basic usage info" do
    system(tap).should be_true
  end

  it "should have an install task" do
    system("#{tap} install").should be_true
  end

  it "should have an update task" do
    system("#{tap} update").should be_true
  end

  it "should use the default Brewfile without args" do
    `#{tap}`.should include(File.join File.expand_path(Dir.pwd), "Brewfile")
  end

  it "should use the given Brewfile" do
    brewfile = "lib/tap_dance/Brewfile"
    `#{tap} -B #{brewfile}`.should include(File.join File.expand_path(Dir.pwd), brewfile)
  end
end
