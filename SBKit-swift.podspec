Pod::Spec.new do |s|
  s.name             = 'SBKit-swift'
  s.version          = '0.0.1'
  s.summary          = 'A short description of SBKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://www.github.com'
  s.license          = { :type => 'MIT'}
  s.author           = { 'ankang' => 'ankang1943@qq.com' }
  s.source           = { :git => '', :tag => s.version.to_s }
  s.module_name      = 'SBKit'


  s.platform     = :ios, '13.0'
  s.requires_arc = true
  s.source_files = 'sources/Classes/**/*'
#  s.resource = 'sources/Assets/*.*'
  s.resources = 'sources/Assets/*.{xcassets}','sources/Assets/*.{gif}'
  
  # s.prefix_header_contents = '#ifdef __OBJC__','#import "aaa.h"','#import "bbb.h"', '#endif'
  
  # s.dependency ''
  s.dependency "JLRoutes"

  
end
