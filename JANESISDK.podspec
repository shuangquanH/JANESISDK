
Pod::Spec.new do |s|
  s.name             = 'JANESISDK'
  s.version          = '0.1.5'
  s.summary          = 'A short description of JANESISDK.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/shuangquanH/JANESISDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shuangquanH' => 'butrys@163.com' }
  s.source           = { :git => 'https://github.com/shuangquanH/JANESISDK.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.source_files = 'JANESISDK/Classes/**/*'
  #如果有bundle文件，使用这个方法导入
  s.resources    = 'JANESISDK/Classes/Images/JSCOVERIMG.bundle'
  s.requires_arc = true
  #如果有头文件使用这个方法导入
  s.prefix_header_file = 'JANESISDK/Classes/JSTFPrefixHeader.pch'
  #  s.vendored_frameworks = 'JANESISDK.framework'
  #系统自带库
  s.frameworks = 'UIKit'
  
  #依赖第三方库
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'SVProgressHUD'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'YYModel'
  s.dependency 'SDCycleScrollView'
  s.dependency 'TZImagePickerController'
  s.dependency 'MJRefresh'
  
  
  
  
  
  
end
