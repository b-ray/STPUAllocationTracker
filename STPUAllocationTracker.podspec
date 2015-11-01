Pod::Spec.new do |s|
  s.name             = "STPUAllocationTracker"
  s.version          = "0.1.0"
  s.summary          = "Easily keep track of allocated object in iOS."

  s.description      = <<-DESC
  A zero-configuration library to keep track of the lifetime of allocated objects in iOS. Just install the pod
  and the count of all living objects will automatically be written to the documents folder whenever the app is
  pushed to the background or terminated.
  Although the library is optimized for performance, it is only intended to be used during development.
  Heavily based on a blog-post by Facebook: http://code.facebook.com/posts/1146930688654547
                       DESC

  s.homepage         = "https://github.com/b-ray/STPUAllocationTracker"
  s.license          = 'MIT'
  s.author           = { "Stefan Puehringer" => "me@stefanpuehringer.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/STPUAllocationTracker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stpue'

  s.platform     = :ios, '7.0'
  s.requires_arc = 'Pod/Classes/Arc/**/*'

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = ''
  s.frameworks = 'UIKit'

end
