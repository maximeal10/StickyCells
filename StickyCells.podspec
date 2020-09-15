Pod::Spec.new do |s|
  s.name             = 'StickyCells'
  s.version          = '0.1.1'
  s.summary          = 'Table View with sticky cells'

  s.description      = <<-DESC
Table View with sticky cells
Allows to set several levels of stickied cells

                       DESC

  s.homepage         = 'https://github.com/maximeal10/StickyCells'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maxime Ashurov' => 'maximeal10@gmail.com' }
  s.source           = { :git => 'https://github.com/maximeal10/StickyCells.git', :tag => s.version.to_s }

  s.swift_version = '5.1'
  s.ios.deployment_target = '9.3'
  s.source_files = 'Source/**/*.swift'

end