
Pod::Spec.new do |s|

  s.name         = "ShareActivity"
  s.version      = "0.0.2"
  s.summary      = "一个底部弹框"
  s.description  = <<-DESC
                    一个底部弹框
                   DESC
  s.homepage     = "https://github.com/duxinfeng/ShareActivity"
  
  s.license      = 'MIT'
  s.author       = { "duxinfeng" => "duxinfeng99@gmail.com" }
  s.social_media_url = "http://twitter.com/iduxinfeng"
  s.source       = { :git => "https://github.com/duxinfeng/ShareActivity.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'ShareActivity/*'
  s.frameworks = 'Foundation', 'UIKit'

end 