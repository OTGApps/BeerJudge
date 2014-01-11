class AboutViewController < Formotion::FormController

  def viewDidLoad
    super
    self.title = "About #{App.name}"
    self.tabBarItem.setTitle("About")
    self.tabBarItem.setImage(UIImage.imageNamed('tab_info'))

    Flurry.logEvent "AboutView" unless Device.simulator?
  end

  def init
    @form ||= Formotion::Form.new({
      sections: [{
        title: "Tell Your friends:",
        rows: [{
          title: "Share the app",
          subtitle: "Text, Email, Tweet, or Facebook!",
          type: :share,
          image: "share",
          value: {
            items: "I'm using the #{App.name} app to send cool text art. Check it out! http://www.mohawkapps.com/app/textables/",
            excluded: [
              UIActivityTypeAddToReadingList,
              UIActivityTypeAirDrop,
              UIActivityTypeCopyToPasteboard,
              UIActivityTypePrint
            ]
          }
        },{
          title: "Rate on iTunes",
          type: :rate_itunes,
          image: "itunes"
        }]
      }, {
        title: "#{App.name} is open source:",
        rows: [{
          title: "View on GitHub",
          type: :github_link,
          image: "github",
          warn: true,
          value: "https://github.com/MohawkApps/BeerJudge"
        }, {
          title: "Found a bug?",
          subtitle: "Log it here.",
          type: :issue_link,
          image: "issue",
          warn: true,
          value: "https://github.com/MohawkApps/BeerJudge/issues/"
        }, {
          title: "Email me suggestions!",
          subtitle: "I'd love to hear from you",
          type: :email_me,
          image: "email",
          value: {
            to: "mark@mohawkapps.com",
            subject: "#{App.name} App Feedback"
          }
        }]
      }, {
        title: "About #{App.name}:",
        rows: [{
          title: "Version",
          type: :static,
          placeholder: App.info_plist['CFBundleShortVersionString'],
          selection_style: :none
        }, {
          title: "Copyright",
          type: :static,
          font: { name: 'HelveticaNeue', size: 13 },
          placeholder: "#{copyright_year}, Mohawk Apps, LLC",
          selection_style: :none
        }, {
          title: "Flavor Wheel",
          type: :disabled_text,
          font: { name: 'HelveticaNeue', size: 14 },
          placeholder: "Courtesy of beerflavorwheel.com",
          selection_style: :none,
          row_height: 60
        }, {
          title: "Visit MohawkApps.com",
          type: :web_link,
          warn: false,
          value: "http://www.mohawkapps.com"
        }, {
          title: "Made with ♥ in North Carolina",
          type: :static,
          enabled: false,
          selection_style: :none,
          text_alignment: NSTextAlignmentCenter
        },{
          type: :static_image,
          value: "nc",
          enabled: false,
          selection_style: :none
        }]
      }]
    })
    super.initWithForm(@form)
  end

  def copyright_year
    start_year = '2013'
    this_year = Time.now.year

    start_year == this_year ? this_year : "#{start_year}-#{this_year}"
  end

end
