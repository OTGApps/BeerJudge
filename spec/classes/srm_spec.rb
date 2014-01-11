describe "SRM" do

  it "returns color values" do
    SRM.color(1).is_a?(UIColor).should == true
    SRM.color(30).is_a?(UIColor).should == true
  end

  it "should be false if color doesn't exist" do
    SRM.color(31).should == false
  end

  it "returns a cgcolor" do
    SRM.cgcolor(1).class.should == UIColor.redColor.CGColor.class
  end

  it "creates a solid color image" do
    SRM.imageWithSRM(2, andSize:CGSizeMake(10,10)).is_a?(UIImage).should == true
  end

  it "creates a solid color image with one size value" do
    SRM.imageWithSRM(2, andSize:10).is_a?(UIImage).should == true
  end

  it "returns all steps" do
    SRM.steps.is_a?(Hash).should == true
  end

  it "returns a spectrum" do
    SRM.spectrum.is_a?(Array).should == true
    SRM.spectrum.count.should == SRM.steps.count
  end

  it "returns a close color" do
    SRM.closest_srm_to_color(UIColor.redColor).is_a?(Array).should == true
    SRM.closest_srm_to_color(UIColor.redColor).count.should == 2
  end

  it 'close color should have a valid spectrum' do
    close = SRM.closest_srm_to_color(UIColor.redColor)
    SRM.steps.keys.include?(close[0]).should == true
  end

  it 'close color should have a valid RGB value' do
    close = SRM.closest_srm_to_color(UIColor.redColor)
    close[1].should<= 255
  end

end
