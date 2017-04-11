#
#  Be sure to run `pod spec lint CLCore.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name = 'CLCore'
  s.version = '1.0.7'
  s.license = 'MIT'
  s.summary = 'CL frame core method'
  s.homepage = 'http://chenliang2016.github.io/'
  s.authors = { "chenliang" => "appleidofcl@163.com" }
  s.source = { :git => 'https://github.com/chenliang2016/CLCore.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CLCore/*.swift'

end
