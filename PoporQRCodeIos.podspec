#
# Be sure to run `pod lib lint PoporQRCodeIos.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'PoporQRCodeIos'
    s.version          = '0.0.5'
    s.summary          = '生成二维码代码,iOS版本.'
    
    s.homepage         = 'https://github.com/popor/PoporQRCodeIos'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'popor' => '908891024@qq.com' }
    s.source           = { :git => 'https://github.com/popor/PoporQRCodeIos.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '8.0'
    s.tvos.deployment_target = '9.0'
    #s.watchos.deployment_target = '2.0' #好像不支持二维码,先放弃了.
    
    
    s.source_files = 'PoporQRCodeIos/Classes/**/*'
    
    
end
