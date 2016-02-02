class Options < JPanel
  def initialize(tabbar)
    super()
    @path_to_browser = JTextField.new
    @path_to_browser.text = "firefox"
    @path_to_browser_label = JLabel.new "Pfad zum Browser"
    
    @path_to_latex = JTextField.new
    @path_to_latex.text = "pdflatex"
    @path_to_latex_label = JLabel.new "Pfad zu pdflatex"
    
    @path_to_host = JTextField.new
    @path_to_host.text = "https://192.168.1.1"
    @path_to_host_label = JLabel.new "Host für den API-Zugriff"
    
    @path_to_apikey = JTextField.new
    @path_to_apikey.text = "apikey.txt"
    @path_to_apikey_label = JLabel.new "Pfad zu den Zugangsdaten"
    
    @path_to_certfile = JTextField.new
    @path_to_certfile.text = "cert.crt"
    @path_to_certfile_label = JLabel.new "Pfad zum TLS-Zertifikat des Servers"
    
    @button = JButton.new "Übernehmen und Speichern"
    @empty_label = JLabel.new ""
    
    @gl = GridLayout.new 0,2
    setLayout @gl
    
    form = [
        @path_to_browser_label,@path_to_browser,
        @path_to_latex_label,@path_to_latex,
        @path_to_host_label,@path_to_host,
        @path_to_apikey_label,@path_to_apikey,
        @path_to_certfile_label,@path_to_certfile,
        @empty_label, @button
    ]
    
    form.each do |element|
      #p=JPanel.new
      #p.setLayout BoxLayout.new(p,BoxLayout::Y_AXIS)
      add element
      #add p
    end
    
    if tabbar
      tabbar.addTab "Einstellungen", self
    end
  end
end
$windowsizes << java.awt.Dimension.new(550, 250)