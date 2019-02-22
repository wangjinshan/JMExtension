
Pod::Spec.new do |s|

  s.name         = "JMExtension"
  s.version      = "0.0.2"
  s.summary      = "积木仓库"
  s.description  = '积木仓库分类代码实现'
  s.ios.deployment_target = "8.0"
  s.requires_arc = true

  s.homepage     = "https://github.com/wangjinshan"
  s.license      = "MIT"
  s.author             = { "1096452045" => "1096452045@qq.com" }
  s.source       = { :git => "https://github.com/wangjinshan/JMExtension.git", :tag => "#{s.version}" }


  s.source_files  = "SDK/*.{h,m}"
 
end
