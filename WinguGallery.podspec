#
# Be sure to run `pod lib lint WinguGallery.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WinguGallery'
  s.version          = '0.1.6'                  #sh_replace_version
  s.summary          = 'Gallery component inside wingu SDK'
  s.description      = <<-DESC
Swipeable gallery component for iOS apps. 
                       DESC

  s.homepage         = 'https://github.com/wingu-GmbH/WinguGallery'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JakubMazur' => 'jakub.mazur@wingu.de' }
  s.source           = { :git => 'https://github.com/wingu-GmbH/WinguGallery.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/@jkmazur'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  s.source_files = 'WinguFullscreenGallery/**/*'
  
  # s.resource_bundles = {
  #   'WinguGallery' => ['WinguGallery/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end









