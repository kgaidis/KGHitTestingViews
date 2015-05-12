Pod::Spec.new do |s|
  s.name         =  'KGHitTestingViews'
  s.version      =  '0.9'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.summary      =  'A small helper library to effortlessly increase the hit test area of a view or a button.'
  s.author       =  { 'Krisjanis Gaidis' => 'http://www.krisjanisgaidis.com/' }
  s.source       =  { :git => 'https://github.com/kgaidis/KGHitTestingViews.git', :tag => '0.9' }
  s.homepage     =  'http://github.com/kgaidis/KGHitTestingViews'
  s.source_files =  'KGHitTestingViews' 
  s.platform     = :ios, "6.0"
  s.requires_arc =  true