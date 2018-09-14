

Pod::Spec.new do |s|
  s.name             = 'WLMElectronicInvoice'
  s.version          = '0.0.5'
  s.summary          = '电子发票业务功能组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/guangqiang-liu/GQ-MVVM-RAC'
  s.license          = "MIT"
  s.author           = { 'guangqiang' => '1126756952@qq.com' }
  s.source           = { :git => 'git@github.com:guangqiang-liu/GQ-MVVM-RAC.git', :tag => s.version.to_s }

  s.platform         = :ios, "8.0"

  s.requires_arc     = true

  s.prefix_header_file = "WLMElectronicInvoice/WLMElectronicInvoice.pch"

  s.default_subspec = 'Code'

  s.subspec 'Code' do |ss|
        ss.source_files = "WLMElectronicInvoice/Categorys/**/*.{h,m}", "WLMElectronicInvoice/ElectronicInvoiceApply/**/*.{h,m}", "WLMElectronicInvoice/ElectronicInvoiceDetail/**/*.{h,m}", "WLMElectronicInvoice/ElectronicInvoiceManager/**/*.{h,m}", "WLMElectronicInvoice/ElectronicInvoiceSearch/**/*.{h,m}", "WLMElectronicInvoice/ElectronicInvoiceQRCodeManager/**/*.{h,m}", "WLMElectronicInvoice/Tools/**/*.{h,m}", "WLMElectronicInvoice/Target/**/*.{h,m}"
    end

  s.resources = "WLMElectronicInvoice/Resources/*.png"
  
  s.dependency 'WLIconFont'
  s.dependency 'WLForm'
  s.dependency 'WLBaseView'
  s.dependency 'WLModal'
  s.dependency 'WLWidget'
  s.dependency 'WLPickerView'
  s.dependency 'Masonry'
  s.dependency 'ReactiveObjC'
  s.dependency 'MJExtension'

end
