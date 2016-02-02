#!jruby

require 'java'
require 'date'

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
tab_pane = JTabbedPane.new;
$windowsizes = []
tab_pane.add_change_listener do |x|
  idx = x.get_source.get_selected_index
  window.size = $windowsizes[idx]
end

##########################################################

require_relative './modules/voucher'
VoucherCreator.new(tab_pane)

require_relative './modules/options'
Options.new(tab_pane)

##########################################################

# finally show the window
window.add tab_pane
window.visible = true
