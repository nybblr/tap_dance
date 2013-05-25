cmd = "./bin/dance"

describe "dancer" do
  it "should output basic usage info" do
    system(cmd).should be_true
  end

  it "should have an install task" do
    system("#{cmd} install").should be_true
  end

  it "should have an update task" do
    system("#{cmd} update").should be_true
  end

  it "should use the default Brewfile without args" do
    `#{cmd}`.should include(File.join File.expand_path(Dir.pwd), "Brewfile")
  end

  it "should use the given Brewfile" do
    brewfile = "lib/tap_dance/Brewfile"
    `#{cmd} -B #{brewfile}`.should include(File.join File.expand_path(Dir.pwd), brewfile)
  end
end
