#
# Be sure to run `pod lib lint ZHTableViewGroup.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZHTableViewGroupObjc'
  s.version          = '3.0.2'
  s.summary          = 'Manger UITableView DataSource More Cell Style'

  s.homepage         = 'https://github.com/josercc/ZHTableViewGroup'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15038777234' => '15038777234@163.com' }
  s.source           = { :git => 'https://github.com/josercc/ZHTableViewGroup.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ZHTableViewGroup/Classes/**/*'
  # s.resource_bundles = {
  #   'ZHTableViewGroup' => ['ZHTableViewGroup/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
