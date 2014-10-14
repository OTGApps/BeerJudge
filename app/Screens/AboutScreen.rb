class AboutScreen < PM::TableScreen
  title "About Beer Judge"
  tab_bar_item item: "tab_about", title: "About"

  def will_appear
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemStop, target:self, action:"close") if Device.ipad?
    Flurry.logEvent "AboutView" unless Device.simulator?
  end

  def table_data
    [{
      title: "Tell Your friends:",
      cells: [{
        title: "Share the app",
        subtitle: "Text, Email, Tweet, or Facebook!",
        action: :share_app,
        image: "share",
      },{
        title: "Rate on iTunes",
        action: :rate_itunes,
        image: "itunes"
      }]
    }, {
      title: "#{App.name} is open source:",
      cells: [{
        title: "View on GitHub",
        action: :launch_github,
        image: "github"
      }, {
        title: "Found a bug?",
        subtitle: "Log it here.",
        action: :launch_bug,
        image: "issue"
      }]
    }, {
      title: "About #{App.name}:",
      cells: [{
        title: "Version",
        subtitle: App.info_plist['CFBundleShortVersionString'],
      }, {
        title: "Copyright",
        subtitle: "#{copyright_year} Mohawk Apps, LLC",
      }, {
        title: "Flavor Wheel",
        subtitle: "Courtesy of beerflavorwheel.com",
      }, {
        title: "Visit MohawkApps.com",
        action: :launch_mohawk
      }]
    }]
  end

  def launch_bug
    Flurry.logEvent("GITHUB_ISSUE_TAPPED") unless Device.simulator?
    open_url('https://github.com/MohawkApps/BeerJudge/issues/')
  end

  def launch_github
    Flurry.logEvent("GITHUB_TAPPED") unless Device.simulator?
    open_url('https://github.com/MohawkApps/BeerJudge')
  end

  def launch_mohawk
    Flurry.logEvent("WEBSITE_TAPPED") unless Device.simulator?
    open_url('http://www.mohawkapps.com')
  end

  def open_url(url)
    App.open_url url
  end

  def rate_itunes
    Appirater.rateApp
    Flurry.logEvent("RATE_ITUNES_TAPPED") unless Device.simulator?
  end

  def share_app
    Flurry.logEvent("SHARE_TAPPED") unless Device.simulator?
    BW::UIActivityViewController.new(
      items: "I'm using the #{App.name} app. Check it out! http://www.mohawkapps.com/app/beerjudge/",
      animated: true,
      excluded: [
        :add_to_reading_list,
        :air_drop,
        :copy_to_pasteboard,
        :print
      ]
    ) do |activity_type, completed|
      if completed
        Flurry.logEvent("SHARE_COMPLETED_#{activity_type.to_s.upcase}") unless Device.simulator?
      else
        Flurry.logEvent("SHARE_CANCELED") unless Device.simulator?
      end
    end
  end

  def copyright_year
    start_year = '2013'
    this_year = Time.now.year

    start_year == this_year ? this_year : "#{start_year}-#{this_year}"
  end

  def close
    dismissModalViewControllerAnimated(true)
  end

end
