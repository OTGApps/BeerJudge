class OffFlavorsData

  def self.sharedData
    Dispatch.once { @instance ||= new }
    @instance
  end

  def location
    use_default? ? resources : documents
  end

  def json
    BW::JSON.parse(File.read(location))
  end

  def use_default?
    !File.exist? documents
  end

  def resources
    File.join(App.resources_path, "off_flavors.json")
  end

  def documents
    File.join(App.documents_path, "off_flavors.json")
  end

end
