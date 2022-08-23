#
# Be sure to run `pod lib lint MKLoRaWAN-MT.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-MT'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKLoRaWAN-MT.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aadyx2007@163.com/MKLoRaWAN-MT'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/aadyx2007@163.com/MKLoRaWAN-MT.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'MKLoRaWAN-MT/Classes/**/*'
  
  s.resource_bundles = {
    'MKLoRaWAN-MT' => ['MKLoRaWAN-MT/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-MT/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.subspec 'SyncDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-MT/Classes/DatabaseManager/SyncDatabase/**'
    end
    
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-MT/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-MT/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-MT/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-MT/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-MT/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-MT/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'TextButtonCell' do |sss|
      sss.source_files = 'MKLoRaWAN-MT/Classes/Expand/TextButtonCell/**'
    end
    
    ss.subspec 'FilterCell' do |sss|
      sss.subspec 'FilterBeaconCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Expand/FilterCell/FilterBeaconCell/**'
      end
      
      sss.subspec 'FilterByRawDataCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Expand/FilterCell/FilterByRawDataCell/**'
      end
      
      sss.subspec 'FilterEditSectionHeaderView' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Expand/FilterCell/FilterEditSectionHeaderView/**'
      end
      
      sss.subspec 'FilterNormalTextFieldCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Expand/FilterCell/FilterNormalTextFieldCell/**'
      end
      
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'ActiveStatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ActiveStatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/ActiveStatePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ActiveStatePage/Model/**'
      end
    end
    
    ss.subspec 'AuxiliaryPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/AuxiliaryPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/DownlinkPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/VibrationPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/ManDownPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/ActiveStatePage/Controller'
      end
    end
    
    ss.subspec 'AxisSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/AxisSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/AxisSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/AxisSettingPage/Model/**'
      end
    end
    
    ss.subspec 'BleFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/BleFixPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-MT/Functions/BleFixPage/Model'
        ssss.dependency 'MKLoRaWAN-MT/Functions/BleFixPage/View'
      
        ssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/BleFixPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/BleFixPage/View/**'
      end
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/BleSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-MT/Functions/BleSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/BleSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/BleSettingsPage/View/**'
      end
      
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DebuggerPage/View/**'
      end
      
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/SelftestPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/DebuggerPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DeviceInfoPage/Model/**'
      end
      
    end
    
    ss.subspec 'DeviceModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DeviceModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/TimingModePage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/PeriodicModePage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/MotionModePage/Controller'
      end
    end
    
    ss.subspec 'DeviceSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DeviceSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/DeviceSettingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/SynDataPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/IndicatorSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/DeviceInfoPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DeviceSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'DownlinkPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/DownlinkPage/Controller/**'
      end
    end
    
    ss.subspec 'FilterPages' do |sss|
      
      sss.subspec 'FilterByAdvNamePage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByAdvNamePage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByAdvNamePage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBeaconPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBeaconPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBeaconPage/Header'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBeaconPage/Model'
          
        end
        
        ssss.subspec 'Header' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBeaconPage/Header/**'
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBeaconPage/Model/**'
          
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBeaconPage/Header'
        end
      end
      
      sss.subspec 'FilterByMacPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByMacPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByMacPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByMacPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByOtherPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByOtherPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByOtherPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByOtherPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByRawDataPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByRawDataPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByRawDataPage/Model'
          
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBeaconPage/Controller'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByUIDPage/Controller'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByURLPage/Controller'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByTLMPage/Controller'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBXPButtonPage/Controller'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBXPTagPage/Controller'
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByOtherPage/Controller'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByRawDataPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByTLMPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByTLMPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByTLMPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByTLMPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByUIDPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByUIDPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByUIDPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByUIDPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByURLPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByURLPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByURLPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByURLPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBXPButtonPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBXPButtonPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBXPButtonPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBXPButtonPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBXPTagPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBXPTagPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-MT/Functions/FilterPages/FilterByBXPTagPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/FilterPages/FilterByBXPTagPage/Model/**'
        end
      end
      
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/DeviceModePage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/AuxiliaryPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/BleSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/AxisSettingPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/IndicatorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/IndicatorSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/IndicatorSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'LCGpsFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LCGpsFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LCGpsFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LCGpsFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LoRaApplicationPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'LRGpsFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LRGpsFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LRGpsFixPage/Model'
        ssss.dependency 'MKLoRaWAN-MT/Functions/LRGpsFixPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LRGpsFixPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/LRGpsFixPage/View/**'
      end
      
    end
    
    ss.subspec 'ManDownPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ManDownPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/ManDownPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ManDownPage/Model/**'
      end
      
    end
    
    ss.subspec 'MotionModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/MotionModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/MotionModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/MotionModePage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/PeriodicModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/PeriodicModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/PeriodicModePage/Model/**'
      end
      
    end
    
    ss.subspec 'PositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/PositionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/PositionPage/Model'
                
        ssss.dependency 'MKLoRaWAN-MT/Functions/WifiFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/BleFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/LCGpsFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/LRGpsFixPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/PositionPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-MT/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-MT/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/SelftestPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/SelftestPage/View'
        ssss.dependency 'MKLoRaWAN-MT/Functions/SelftestPage/Model'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/SelftestPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'SynDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/SynDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/SynDataPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/SynDataPage/View/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/PositionPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-MT/Functions/DeviceSettingPage/Controller'
      end
    end
    
    ss.subspec 'TimingModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/TimingModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/TimingModePage/Model'
        ssss.dependency 'MKLoRaWAN-MT/Functions/TimingModePage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/TimingModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/TimingModePage/View/**'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.subspec 'VibrationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/VibrationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/VibrationPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/VibrationPage/Model/**'
      end
    end
    
    ss.subspec 'WifiFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/WifiFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-MT/Functions/WifiFixPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-MT/Classes/Functions/WifiFixPage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-MT/SDK'
    ss.dependency 'MKLoRaWAN-MT/DatabaseManager'
    ss.dependency 'MKLoRaWAN-MT/CTMediator'
    ss.dependency 'MKLoRaWAN-MT/ConnectModule'
    ss.dependency 'MKLoRaWAN-MT/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary'
    
  end
  
end
