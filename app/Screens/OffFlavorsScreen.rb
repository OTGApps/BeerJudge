class OffFlavorsScreen < MasterTableScreen
  title "Common Off Flavors"
  tab_bar_item item: "tab_bandaid", title: "Off Flavors"
  searchable

  def on_load
    set_nav_bar_button :back, title: ""
  end

  def will_appear
    @will_appear_done ||= begin
      table_view.tableHeaderView.tintColor = UIColor.blackColor
    end
  end

  def on_appear
    hide_toolbar
  end

  def stopped_searching
    hide_toolbar
  end

  def hide_toolbar
    self.navigationController.setToolbarHidden(true, animated:false)
  end

  def table_cells
    c = []
    OffFlavorsData.sharedData.json.each do |flavor|
      c << cell(flavor[:title], flavor[:description])
    end
    c
  end

  def table_data
    @table_setup ||= begin
      [{
        title: nil,
        cells: table_cells
      }]
    end
  end

  def cell(title, description)
    c = {
      title: title,
      subtitle: description,
      cell_style: UITableViewCellStyleSubtitle,
      search_text: description.split(/\W+/).uniq.join(" ")
    }

    char_length = Device.ipad? ? 115 : 45

    if description.length < char_length
      c.merge!({
        selection_style: UITableViewCellSelectionStyleNone,
        accessory_type: UITableViewCellAccessoryNone
      })
    else
      c.merge!({
        action: :tapped_cell,
        arguments: { description: description, title: title },
        selection_style: UITableViewCellSelectionStyleGray,
        accessory_type: UITableViewCellAccessoryDisclosureIndicator
      })
    end
    c
  end

  def tapped_cell(args={})
    open_args = args
    open_args = args.merge({search_string: search_string}) if searching?
    open DetailScreen.new(open_args)
  end

end
