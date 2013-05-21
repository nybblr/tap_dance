describe "bindle" do
  it "should output basic usage info" do
    system("./bin/bindle").should be_true
    puts `echo $PWD`
  end

  it "should have an install task" do
    system("./bin/bindle install").should be_true
  end

  it "should have an update task" do
    system("./bin/bindle update").should be_true
  end
end
