Pod::Spec.new do |s|
    s.name         = 'MGActionSheet'
    s.version      = '1.0.1'
    s.summary      = 'A simple, A customizable, ActionSheet.'
    s.homepage     = 'https://github.com/MangoHome/MGActionSheet'
    s.license      = 'MIT'
    s.authors      = {'Luqiang' => 'china.zhangluqiang@gmail.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/MangoHome/MGActionSheet.git', :tag => s.version}
    s.source_files = 'MGActionSheet/**/*.{h,m}'
    s.requires_arc = true
end
