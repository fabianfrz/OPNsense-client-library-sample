class VoucherCreator < JPanel
  def initialize(tabbar)
    super()
    @amount_of_vouchers = JSpinner.new
    @amount_of_vouchers_label = JLabel.new "Anzahl Voucher"
    
    @roll_name = JTextField.new
    @roll_name.text = Date.today.to_s
    @roll_name_label = JLabel.new "Rollenname"
    
    @button = JButton.new "Generieren"
    @empty_label = JLabel.new ""
    
    @output_formats = ["HTML"].to_java
    @output_format = JComboBox.new @output_formats
    @output_format_label = JLabel.new "Ausgabeformat"
    
    @voucher_providers = ::OPNsense::Voucher.list_providers.to_java
    @voucher_provider = JComboBox.new @voucher_providers
    @voucher_provider_label = JLabel.new "Voucher Provoider"
    
    @gl = GridLayout.new 0,2
    setLayout @gl
    
    form = [
        @amount_of_vouchers_label,@amount_of_vouchers,
        @roll_name_label,@roll_name,
        @output_format_label,@output_format,
        @voucher_provider_label, @voucher_provider,
        @empty_label, @button
    ]
    
    form.each do |element|
      #p=JPanel.new
      #p.setLayout BoxLayout.new(p,BoxLayout::Y_AXIS)
      add element
      #add p
    end

    @button.add_action_listener do |event|
      format = @output_format.get_selected_item.downcase
      path = $path + '/libs/print/template.' + format
      File.open(path, "wb") do |f|
        f.write render_template(format, download_voucher)
      end
      system('"%s" "%s"' % [$configuration['browser'],path])
      File.delete(path)
    end
    
    if tabbar
      tabbar.addTab "Voucher", self
    end
  end
  
  def download_voucher
    ::OPNsense::Voucher.create! @voucher_provider.get_selected_item, @amount_of_vouchers.value, 10, @roll_name.text
  end

  def render_template(template, voucher)
    data_template = File.read($path + '/libs/print/template.' + template + '.erb')
    rendered_template = ERB.new(data_template).result(binding)
    return rendered_template
  end
end
$windowsizes << java.awt.Dimension.new(550, 200)
VoucherCreator.new($tab_pane)

