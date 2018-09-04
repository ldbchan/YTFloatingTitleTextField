Pod::Spec.new do |s|
  s.name             = 'YTFloatingTitleTextField'
  s.version          = '0.1.1'
  s.summary          = 'A UITextField subclass with floating title and bottom line.'
  s.homepage         = 'https://github.com/ldbchan/YTFloatingTitleTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ldbchan' => 'ldb.chan@gmail.com' }
  s.source           = { :git => 'https://github.com/ldbchan/YTFloatingTitleTextField.git', :tag => "v#{s.version}" }
  s.ios.deployment_target = '8.0'
  s.source_files = 'YTFloatingTitleTextField/Classes/**/*'
end
