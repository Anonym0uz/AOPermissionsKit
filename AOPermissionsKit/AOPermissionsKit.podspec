Pod::Spec.new do |spec|
  spec.name         = "AOPermissionsKit"
  spec.version      = "0.0.1"
  spec.summary      = "AOPermissionsKit lightweight library for manage permissions on iOS."
  spec.homepage     = "https://github.com/Anonym0uz/AOPermissionsKitBeta"
  spec.license      = "MIT"
  spec.author       = { "Alexander Orlov" => "kimase1@yandex.ru" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "https://github.com/Anonym0uz/AOPermissionsKitBeta.git", :tag => spec.version.to_s }
  spec.source_files = "AOPermissionsKit", "AOPermissionsKit/**/*.{h,m}"

end
