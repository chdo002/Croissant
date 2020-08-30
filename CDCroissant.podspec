#
# Be sure to run `pod lib lint Croissant.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'CDCroissant'
    s.version          = '0.1.1alpha'
    s.summary          = 'An App Inspector.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/chdo002/Croissant'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'chdo002' => '1107661983@qq.com' }
    s.source           = { :git => 'https://github.com/chdo002/Croissant.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '9.0'
    
    s.source_files = 'Croissant/Classes/**/*'
    
    s.resource_bundles = {
        'Croissant' => ['Croissant/Assets/*.bundle']
    }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    
    s.frameworks = 'Foundation', 'CoreServices'
    
    s.dependency 'GCDWebServer', '3.5.4'
    s.dependency 'fishhook'
    s.dependency 'PocketSocket'
    
end
