#
# Be sure to run `pod lib lint Requests.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Requests'
  s.version          = '5.1'
  s.summary          = 'A short description of Requests.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Request HTTP Like Python's Request Framework
                       DESC
  s.homepage         = 'https://github.com/lovesunstar/Requests'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovesunstar' => 'sunjiangting@maetimes.com' }
  s.source           = { :git => 'https://github.com/lovesunstar/Requests.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/lovesunstar'
   

  s.ios.deployment_target = '10.0'

  s.source_files = 'Requests/Classes/**/*'
  s.frameworks = 'Foundation'
  s.dependency 'Alamofire', '5.4.4'
end
