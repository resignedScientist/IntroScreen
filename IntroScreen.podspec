#
# Be sure to run `pod lib lint IntroScreen.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IntroScreen'
  s.version          = '1.0.4'
  s.summary          = 'A beautiful intro screen for iOS written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pod is an Intro Screen for iOS for discribing beautifully what the app you are building does. It uses color shifting between each intro page and is highly customizable. You can use the default intro page with image, title & subtitle or can use your own intro page.
                       DESC

  s.homepage         = 'https://github.com/P1xelfehler/IntroScreen'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'P1xelfehler' => 'norman.laudien1996@gmail.com' }
  s.source           = { :git => 'https://github.com/P1xelfehler/IntroScreen.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'IntroScreen/Classes/**/*'
  
  # s.resource_bundles = {
  #   'IntroScreen' => ['IntroScreen/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
