platform :ios, '11.0'
workspace 'MyName'

inhibit_all_warnings!
use_frameworks!

def app

  # Architecture
  pod 'ReactorKit'

  # Base
  pod 'RomanticBase', :git => 'https://github.com/hb1love/romantic-base.git', :branch => 'develop'

  # Networking
  pod 'Alamofire'
  pod 'Moya'
  pod 'Moya/RxSwift'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxCodable'
  pod 'RxDataSources'
  pod 'Differentiator'

  # UI
  pod 'SnapKit'
  pod 'SideMenu'

  # Logging
  pod 'SwiftyBeaver'
  pod 'Umbrella'
  pod 'Umbrella/Firebase'

  # Transition
  pod 'Hero'

  # SDK
  pod 'Firebase/Core'
  pod 'Fabric'
  pod 'Crashlytics'

  # OAuth
  pod 'FBSDKLoginKit'

  # Misc.
  pod 'Scope'
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'KeychainAccess'
end

def spec
  pod 'Quick'
  pod 'Nimble'
  pod 'Stubber'
end

target 'MyName' do
  app
end

target 'MyNameTests' do
  spec
end
