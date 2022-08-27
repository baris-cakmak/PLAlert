Pod::Spec.new do |s|
    s.name             = 'PLAlert'
    s.version          = '1.0.1'
    s.summary          = 'Simple Interactive Transitionable Alert.'
    s.homepage         = 'https://github.com/baris-cakmak/PLAlert'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'Baris Cakmak' => 'bariscakmak26@gmail.com' }
    s.source           = { :git => 'https://github.com/baris-cakmak/PLAlert.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '11.0'
    s.swift_version = '5.0'
  
    s.source_files = 'Sources/PLAlert/**/*'
  end