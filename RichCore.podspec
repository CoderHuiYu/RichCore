Pod::Spec.new do |s|
  s.name         = "RichCore"
  s.version      = "0.2.0"
  s.summary      = 'The fastest and most convenient conversion between JSON and model'
  s.homepage     = 'https://github.com/CoderHuiYu/RichCore'
  s.license      = 'MIT'
  s.author       = { 'Jeffery Yu' => '171364980@qq.com' }
  s.platform     = :ios, '13.0'
  s.source       = { :git => 'https://github.com/CoderHuiYu/RichCore.git', :tag => s.version }
  s.source_files  = 'RichCore/**/*.{h,m,swift}'
  s.swift_versions = '5.0'
end
