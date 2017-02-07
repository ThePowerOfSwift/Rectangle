#
# Be sure to run `pod lib lint Rectangle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Rectangle'
  s.version          = '0.1.0'
  s.summary          = 'Information about a rectangular region detected in a still or video image.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A detected rectangle feature is not necessarily rectangular in the plane of the image; rather, the feature identifies a shape that may be rectangular in space but which appears in perspective in the image—for example, a paper or book on a desk. The properties of a CIRectangleFeature object identify its corners in image coordinates.

For example, you can use rectangle feature detection together with the CIPerspectiveCorrection filter to detect rectangular objects in an image or video and transform them to their original orientation.

To detect rectangles in an image or video, choose the CIDetectorTypeRectangle type when initializing a CIDetector object, and use the CIDetectorAspectRatio and CIDetectorFocalLength options to specify the approximate shape of rectangular features to search for. The detector returns at most one rectangle feature, the most prominent found in the image.
                       DESC

  s.homepage         = 'https://github.com/ThePowerOfSwift/Rectangle'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'info@mihailsalari.com' => 'thepowerofswift@mihailsalari.com' }
  s.source           = { :git => 'https://github.com/ThePowerOfSwift/Rectangle.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Rectangle/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Rectangle' => ['Rectangle/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
