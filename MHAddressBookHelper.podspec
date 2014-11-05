Pod::Spec.new do |s|
s.name      = 'MHAddressBookHelper'
s.version   = '0.0.1'
s.license   = 'MIT'
s.summary   = 'A helper for addressbook.'
s.homepage  = 'https://github.com/lvjg/MHAddressBookHelper'
s.authors   = { 'lvjigen' => 'lvjg0304@gmail.com' }
s.source    = { :git => 'https://github.com/lvjg/MHAddressBookHelper.git', :tag => s.version.to_s }
s.requires_arc = true

s.ios.deployment_target = '6.0'

s.source_files = '*.{h,m}'

end
