class VoucherCreator < JPanel
  def initialize(tabbar)
    super()
    @amount_of_vouchers = JSpinner.new
    @amount_of_vouchers_label = JLabel.new "Anzahl Voucher"
    
    @roll_name = JTextField.new
    @roll_name.text = Date.today.to_s
    @roll_name_label = JLabel.new "Rollenname"
    
    @button = JButton.new "Generate"
    @empty_label = JLabel.new ""
    
    @output_formats = ["HTML","PDF"].to_java
    @output_format = JComboBox.new @output_formats
    @output_format_label = JLabel.new "Ausgabeformat"
    
    # TODO download from OPNsense Box
    @voucher_prividers = ["test"].to_java
    @voucher_privider = JComboBox.new @voucher_prividers
    @voucher_privider_label = JLabel.new "Voucher Provoider"
    
    @gl = GridLayout.new 0,2
    setLayout @gl
    
    form = [
        @amount_of_vouchers_label,@amount_of_vouchers,
        @roll_name_label,@roll_name,
        @output_format_label,@output_format,
        @voucher_privider_label, @voucher_privider,
        @empty_label, @button
    ]
    
    form.each do |element|
      #p=JPanel.new
      #p.setLayout BoxLayout.new(p,BoxLayout::Y_AXIS)
      add element
      #add p
    end
    
    if tabbar
      tabbar.addTab "Voucher", self
    end
  end
end
$windowsizes << java.awt.Dimension.new(550, 200)