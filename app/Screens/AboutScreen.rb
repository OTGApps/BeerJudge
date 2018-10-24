class AboutScreen < PM::TableScreen
  title "About Beer Judge"
  tab_bar_item item: "tab_about", title: "About"

  def will_appear
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemStop, target:self, action:"close") if Device.ipad?
  end

  def table_data
    [{
      title: "Tell Your friends:",
      cells: [{
        title: "Share the app",
        subtitle: "Text, Email, Tweet, or Facebook!",
        action: :share_app,
        image: "share",
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
        subtitle: "#{copyright_year} Off The Grid Apps, LLC",
      }, {
        title: "Flavor Wheel",
        subtitle: "Courtesy of beerflavorwheel.com",
      }, {
        title: "Visit OTGApps.io",
        action: :launch_otg
      }]
    }]
  end

  def launch_bug
    open_url('https://github.com/OTGApps/BeerJudge/issues/')
  end

  def launch_github
    open_url('https://github.com/OTGApps/BeerJudge')
  end

  def launch_otg
    open_url('http://www.otgapps.io')
  end

  def open_url(url)
    App.open_url url
  end

  def share_app
    BW::UIActivityViewController.new(
      items: "I'm using the #{App.name} app. Check it out! http://www.otgapps.io/#beer-judge",
      animated: true,
      excluded: [
        :add_to_reading_list,
        :air_drop,
        :copy_to_pasteboard,
        :print
      ]
    ) do |activity_type, completed|
      # Nothing to see here... please move along
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
