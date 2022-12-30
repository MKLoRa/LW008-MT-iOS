# LW008-MT iOS Software Development Kit Guide

* This SDK only support devices based on LW008-MT.

## Design instructions

* We divide the communications between SDK and devices into two stages: Scanning stage, Connection stage.For ease of understanding, let’s take a look at the related classes and the relationships between them.

`MKMTCentralManager`：global manager, check system’s bluetooth status, listen status changes, the most important is scan and connect to devices;

`MKMTInterface`: When the device is successfully connected, the device data can be read through the interface in `MKMTInterface `;

`MKMTInterface+MKMTConfig`: When the device is successfully connected, you can configure the device data through the interface in `MKMTInterface + MKMTConfig `;


## Scanning Stage

in this stage, `MKMTCentralManager` will scan and analyze the advertisement data of LW008-MT devices.


## Connection Stage

The device broadcast information includes whether a password is required when connecting.

1.Enter the password to connect, then call the following method to connect:
`connectPeripheral:password:sucBlock:failedBlock:`
2.You do not need to enter a password to connect, call the following method to connect:
`connectPeripheral:sucBlock:failedBlock:`


# Get Started

### Development environment:

* Xcode9+， due to the DFU and Zip Framework based on Swift4.0, so please use Xcode9 or high version to develop;
* iOS12, we limit the minimum iOS system version to 12.0；

### Import to Project

CocoaPods

SDK-PIR is available through CocoaPods.To install it, simply add the following line to your Podfile, and then import <MKLoRaWAN-MT/MKMTSDK.h>:

**pod 'MKLoRaWAN-MT/SDK'**


* <font color=#FF0000 face="黑体">!!!on iOS 10 and above, Apple add authority control of bluetooth, you need add the string to “info.plist” file of your project: Privacy - Bluetooth Peripheral Usage Description - “your description”. as the screenshot below.</font>

*  <font color=#FF0000 face="黑体">!!! In iOS13 and above, Apple added permission restrictions on Bluetooth APi. You need to add a string to the project’s info.plist file: Privacy-Bluetooth Always Usage Description-“Your usage description”.</font>


## Start Developing

### Get sharedInstance of Manager

First of all, the developer should get the sharedInstance of Manager:

```
MKMTCentralManager *manager = [MKMTCentralManager shared];
```

#### 1.Start scanning task to find devices around you,please follow the steps below:

* 1.Set the scan delegate and complete the related delegate methods.

```
manager.delegate = self;
```

* 2.you can start the scanning task in this way:

```
[manager startScan];
```

* 3.at the sometime, you can stop the scanning task in this way:

```
[manager stopScan];
```

#### 2.Connect to device

The `MKMTCentralManager ` contains the method of connecting the device.



```
/// Connect device function
/// @param peripheral peripheral
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

```
/// Connect device function.
/// @param peripheral peripheral
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

#### 3.Get State

Through the manager, you can get the current Bluetooth status of the mobile phone, and the connection status of the device. If you want to monitor the changes of these two states, you can register the following notifications to achieve:

* When the Bluetooth status of the mobile phone changes，<font color=#FF0000 face="黑体">`mk_mt_centralManagerStateChangedNotification`</font> will be posted.You can get status in this way:

```
[[MKMTCentralManager shared] centralStatus];
```

* When the device connection status changes， <font color=#FF0000 face="黑体"> `mk_mt_peripheralConnectStateChangedNotification` </font> will be posted.You can get the status in this way:

```
[MKMTCentralManager shared].connectState;
```

#### 4.Monitoring device disconnect reason.

Register for <font color=#FF0000 face="黑体"> `mk_mt_deviceDisconnectTypeNotification` </font> notifications to monitor data.


```
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:@"mk_mt_deviceDisconnectTypeNotification"
                                               object:nil];

```

```
- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    /*
    After connecting the device, if no password is entered within one minute, it returns 0x01. After successful password change, it returns 0x02, the device has no data communication for three consecutive minutes, it returns 0x03, and the shutdown protocol is sent to make the device shut down and return 0x04.Reset the device, return 0x05.
    */
}
```


#### 4.Monitor the scan data of the device.

When the device is connected, the developer can monitor the scan data of the device through the following steps:

*  1.Open data monitoring by the following method:

```
[[MKMTCentralManager shared] notifyStorageDataData:YES];
```


*  2.Set the delegate and complete the related delegate methods.

```

[MKMTCentralManager shared].dataDelegate = self;
                                               
```

* 3.Data Format Description

The maximum length of each packet of data is 176 bytes, and the data format is shown in the following table:

|  data content   | length (bytes) | data description |
| ---- | ---- | ---- |
| HEAD  | 1 | data frame header(0xED) |
| FLAG  | 1 | notify(0x02) |
| CMD  | 1 | CMD(0x01) |
| LEN  | 1 | data length |
| The data content is as follows |
| Number  | 1 | The number of Datas in this package |
| Data0 Len  | 1 | The total data length of the first Data |
| Data0 Timestamp  | 4 | Time to scan to the first Data |
| Timezone | 1 | The time zone of the current device |
| LoRaWAN Port/Type  | 1 | LoRaWAN Port/Type |
| LoRaWAN Data  | Data0 Len - 4(Data0 Timestamp) - 1(Timezone) - 1(LoRaWAN Port/Type) | LoRaWAN Data |
| ....... |
| DataN Len  | 1 | The total data length of the Nth Data |
| DataN Timestamp  | 4 | Time to scan to the Nth Data. |
| Timezone | 1 | The time zone of the current device |
| LoRaWAN Port/Type  | 1 | LoRaWAN Port/Type |
| LoRaWAN Data  | DataN Len - 4(DataN Timestamp) - 1(Timezone) - 1(LoRaWAN Port/Type) | LoRaWAN Data |

* 4.Data parsing example:

```
#pragma mark - mk_mt_storageDataDelegate
- (void)mk_mt_receiveStorageData:(NSString *)content {
    NSInteger number = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(8, 2)];
    if (number == 0) {
        //The last piece of data, you can get the total number of stored data.
        NSString  *sum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
        return;
    }
    
    NSArray *list = [self parseSynData:content];
}
```

```

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"YYYY/MM/dd hh:mm:ss";
    }
    return _formatter;
}

- (NSArray *)parseSynData:(NSString *)content {
    content = [content substringFromIndex:10];
    
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        
        NSInteger time = [MKBLEBaseSDKAdopter getDecimalWithHex:subContent range:NSMakeRange(0, 8)];
        NSNumber *timezone = [MKBLEBaseSDKAdopter signedHexTurnString:[subContent substringWithRange:NSMakeRange(8, 2)]];
        self.formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:([timezone integerValue] * 0.5 * 60 * 60)];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSString *timestamp = [self.formatter stringFromDate:date];
        NSString *port = [subContent substringWithRange:NSMakeRange(10, 2)];
        NSString *rawData = [subContent substringFromIndex:12];
        
        index += subLen * 2;
        NSDictionary *dic = @{
            @"timestamp":timestamp,
            @"timezone":[NSString stringWithFormat:@"%@",timezone],
            @"port": port,
            @"macAddress":macAddress,
            @"rawData": rawData,
        };
        [dataList addObject:dic];
    }
    return dataList;
}

```




#### 5.Monitoring device disconnect reason.

Register for <font color=#FF0000 face="黑体"> `mk_mt_deviceDisconnectTypeNotification` </font> notifications to monitor data.

```
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:@"mk_mt_deviceDisconnectTypeNotification"
                                               object:nil];

```

```
- (void)disconnectTypeNotification:(NSNotification *)note {
    /*After connecting the device, if no password is entered within one minute, it returns 0x01. After successful password change, it returns 0x02, the device has no data communication for three consecutive minutes, it returns 0x03, and the shutdown protocol is sent to make the device shut down and return 0x04.Reset the device, return 0x05.*/
}
```

#### 6.Monitor the log of device operation

When the device is connected, you can monitor the log information of the device operation through the following steps:

*  1.Enable the log data monitoring function.

```
[[MKMTCentralManager shared] notifyLogData:YES];
```


*  2.Set the data proxy and implement the related proxy methods:

```

[MKMTCentralManager shared].logDelegate = self;
                                               
```

* 3.Data Example Explanation

```
 #pragma mark - mk_mt_centralManagerLogDelegate
- (void)mk_mt_receiveLog:(NSString *)deviceLog {
    //deviceLog is an ASCII string.
}
```

# Change log

* 20221230 first version;
