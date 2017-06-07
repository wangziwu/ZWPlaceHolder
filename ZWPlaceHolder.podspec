Pod::Spec.new do |s|

  s.name    = 'ZWPlaceHolder'
  s.version = '0.0.1'
  s.summary = '快速实现UITextView的placeholder'
  s.homepage  = 'https://github.com/wangziwu/ZWPlaceHolder'
  s.license = 'MIT'
  s.authors = {'wangziwu' =>  'wang_ziwu@126.com'}
  s.platform  = :ios,'7.0'
  s.ios.deployment_target = '7.0'
  s.source  = {:git => 'https://github.com/wangziwu/ZWPlaceHolder.git',:tag => s.version}
  s.source_files  = 'ZWPlaceHolder/*.{h,m}'
  s.requires_arc  = true
end
