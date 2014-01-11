describe "AboutViewController" do
  tests AboutViewController

  def controller
    rotate_device to: :portrait, button: :bottom
    @vc = AboutViewController.new
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@vc)
  end

  it "sets the title" do
    @vc.title.should == "About #{App.name}"
  end

  it "has a form" do
    @vc.form.class.should == Formotion::Form
  end

  it "has multiple sections" do
    @vc.form.sections.count.should.be > 0
  end

end
