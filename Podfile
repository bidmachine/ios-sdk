platform :ios, '10.0'
workspace 'BidMachine.xcworkspace'

source 'https://github.com/appodeal/CocoaPods.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
install! 'cocoapods', :deterministic_uuids => false, :warn_for_multiple_pod_sources => false

$IABVersion = '~> 1.4.0'
$APIVersion = '~> 0.6.0'
$STKModuleVersion = '~> 1.1.0'

$VungleVersion = '6.9.2'
$AdcolonyVersion = '4.6.1'
$MytargetVersion = '5.12.0'
$TapjoyVersion = '12.7.0'
$FacebookVersion = '6.5.1'
$CriteoVersion = '4.3.3'
$AmazonVersion = '3.3.0'
$SmaatoVersion = '21.6.15'
$ApprollVersion = '3.1.2'
$PangleVersion = '3.5.1.2'

# Modules

def iabNast
	pod 'StackIAB/StackNASTKit', $IABVersion
  	pod 'StackIAB/StackRichMedia', $IABVersion
end

def iabMRAID
	pod 'StackIAB/StackMRAIDKit', $IABVersion
end

def iabVAST
	pod 'StackIAB/StackVASTKit', $IABVersion
end

def protobuf
	pod 'StackAPI/BidMachine', $APIVersion, :inhibit_warnings => true
  	pod 'Protobuf', :inhibit_warnings => true
end

def stack_modules
	pod "StackModules", $STKModuleVersion
end

# Network

def vungle
  	pod 'VungleSDK-iOS', $VungleVersion
end

def adcolony
  	pod 'AdColony', $AdcolonyVersion
end

def my_target 
  	pod 'myTargetSDK', $MytargetVersion
end

def tapjoy
  	pod 'TapjoySDK', $TapjoyVersion
end

def facebook
  	pod 'FBAudienceNetwork', $FacebookVersion
end

def criteo
  	pod 'CriteoPublisherSdk', $CriteoVersion
end

def amazon
  	pod 'AmazonPublisherServicesSDK', $AmazonVersion
end

def smaato
  	pod 'smaato-ios-sdk', $SmaatoVersion
  	pod 'smaato-ios-sdk/Modules/UnifiedBidding', $SmaatoVersion
end

def approll
  	pod 'AppRollSDK', $ApprollVersion
end

def pangle
  	pod 'Ads-Global', $PangleVersion
end

# Targets configuration

target 'BidMachine' do
  project 'BidMachine/BidMachine.xcodeproj'
  protobuf
  stack_modules
end

target 'BDMMRAIDAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  iabMRAID
end

target 'BDMVASTAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  iabVAST
end

target 'BDMNASTAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  iabNast
end

target 'BDMCriteoAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  criteo
end

target 'BDMMyTargetAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  my_target
end

target 'BDMAdColonyAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  adcolony
end

target 'BDMVungleAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  vungle
end

target 'BDMTapjoyAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  tapjoy
end

target 'BDMFacebookAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  facebook
end

target 'BDMAmazonAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  amazon
end

target 'BDMSmaatoAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  smaato
end

target 'BDMAppRollAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  approll
end

target 'BDMPangleAdapter' do
  project 'BidMachine-iOS-Adaptors/Adaptors.xcodeproj'
  stack_modules
  pangle
end

target 'Sample' do
  project 'BidMachineSample/Sample.xcodeproj'
  stack_modules
  protobuf
  iabMRAID
  iabVAST
  iabNast
  my_target
  adcolony
  vungle
  tapjoy
  facebook
  amazon
  smaato
  criteo
  approll
  pangle

  pod 'Toast-Swift', '~> 4.0.0', :inhibit_warnings => true
end

target 'BidMachineTests' do
  project 'BidMachine/BidMachine.xcodeproj'
  stack_modules
  pod "Kiwi"
end
