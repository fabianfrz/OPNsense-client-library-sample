class Options < JPanel
  def initialize(tabbar)
    super()
    @path_to_library = JTextField.new
    @path_to_library.text = $configuration['opnsense_lib']
    @path_to_library_label = JLabel.new "Pfad zur Bibliothek"
    
    @path_to_browser = JTextField.new
    @path_to_browser.text = $configuration['browser']
    @path_to_browser_label = JLabel.new "Pfad zum Browser"
    
    @path_to_host = JTextField.new
    @path_to_host.text = $configuration['base_url']
    @path_to_host_label = JLabel.new "Basis-URL für den API-Zugriff"
    
    @path_to_apikey = JTextField.new
    @path_to_apikey.text = $configuration['api_credential_file']
    @path_to_apikey_label = JLabel.new "Pfad zu den Zugangsdaten"
    
    @path_to_certfile = JTextField.new
    @path_to_certfile.text = $configuration['ca_file']
    @path_to_certfile_label = JLabel.new "Pfad zum TLS-Zertifikat der CA des Servers"
    
    @button = JButton.new "Übernehmen und Speichern"
    @empty_label = JLabel.new ""
    
    @gl = GridLayout.new 0,2
    setLayout @gl
    
    form = [
        @path_to_library_label,@path_to_library,
        @path_to_browser_label,@path_to_browser,
        @path_to_host_label,@path_to_host,
        @path_to_apikey_label,@path_to_apikey,
        @path_to_certfile_label,@path_to_certfile,
        @empty_label, @button
    ]
    
    form.each do |element|
      add element
    end
    
    @button.add_action_listener do |event|
      $configuration['opnsense_lib'] = @path_to_library.text
      $configuration['browser'] = @path_to_browser.text
      $configuration['base_url'] = @path_to_host.text
      $configuration['api_credential_file'] = @path_to_apikey.text
      $configuration['ca_file'] = @path_to_certfile.text
      
      File.open('configuration.yml','wb') do |f|
        f.write $configuration.to_yaml
      end
      
      initialize_client_library
      
    end
    
    if tabbar
      tabbar.addTab "Einstellungen", self
    end
  end
end
$windowsizes << java.awt.Dimension.new(550, 250)
Options.new($tab_pane)

