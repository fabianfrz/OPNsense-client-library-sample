#!jruby

require 'java'
require 'date'
require 'erb'
require 'yaml'

$path = File.dirname(File.expand_path(__FILE__))

ConfigurationFile = "configuration.yml"
$configuration = {"opnsense_lib"=>"", "browser"=>"/usr/bin/firefox", "base_url"=>"https://192.168.1.1/api/", "api_credential_file"=>"apikey.txt", "ca_file"=>"cert.crt"}
if File.exist? ConfigurationFile
  $configuration = $configuration.merge YAML.load(File.read(ConfigurationFile))
end

require ($configuration['opnsense_lib'] + '/requireall')

def initialize_client_library
  cred = OPNsense::APICredentials.create_from_file($configuration['api_credential_file'])
  cred.ca_file = $configuration['ca_file']
  cred.base_url = $configuration['base_url']
  OPNsense::Request.new(cred)
end

initialize_client_library

# all imports from Java packages
java_import javax.swing.JFrame
java_import javax.swing.JTabbedPane
java_import java.awt.Dimension
java_import javax.swing.JPanel
java_import javax.swing.JButton
java_import javax.swing.JSpinner
java_import javax.swing.JLabel
java_import javax.swing.JTextField
java_import java.awt.GridLayout
java_import javax.swing.BoxLayout
java_import javax.swing.JComboBox

# create a main window
window = JFrame.new("OPNsense Client");
window.size = java.awt.Dimension.new(550, 300)
window.location_relative_to = nil
window.defaultCloseOperation = JFrame::EXIT_ON_CLOSE
window.resizable = false
$tab_pane = JTabbedPane.new;
$windowsizes = []
$tab_pane.add_change_listener do |x|
  idx = x.get_source.get_selected_index
  window.size = $windowsizes[idx]
end

##########################################################
if $configuration['opnsense_lib'].length > 0
begin
  require_relative './modules/voucher'
rescue
end
end
require_relative './modules/options'

##########################################################

# finally show the window
window.add $tab_pane
window.visible = true
