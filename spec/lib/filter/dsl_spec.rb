require 'tap_dance/filter/dsl'

describe TapDance::Filter::DSL do
  it "should return a list of filters" do
    filters = TapDance::Filter::DSL.evaluate {
      env :pwd, "/root"
      rbenv '1.9.3'
      rvm 'system'
    }

    filters[0].value.should == "/root"
    filters[1].version.should == "1.9.3"
    filters[2].version.should == "system"
  end
end
