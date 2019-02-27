#
# Be sure to run `pod lib lint PickerButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "PickerButton"

s.version          = "0.1.3"

s.summary          = "PickerButton is subclass of UIButton that presents UIPickerView in keyboard."

s.homepage         = "https://github.com/marty-suzuki/PickerButton"

s.license          = 'MIT'
s.author           = { "Taiki Suzuki" => "s1180183@gmail.com" }
s.source           = { :git => "https://github.com/marty-suzuki/PickerButton.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/marty_suzuki'

s.ios.deployment_target  = "10.0"
s.requires_arc = true
s.swift_version = '4.2'

s.source_files = 'PickerButton/**/*.{swift}'
end
