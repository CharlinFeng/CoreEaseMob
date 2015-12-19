<br/><br/><br/>
环信
==========

#### Xcode 7.0

#### Objective-C



<br/><br/><br/>
一、环信导入
==========
1. 到官网[http://www.easemob.com/downloads](http://www.easemob.com/downloads)下载`最新SDK`<br/>

2. 下载后，删除`Lib文件夹`中的`libEaseMobClientSDKLite.a`，并拖拽`Lib文件夹`到项目中。<br/>

3. 添加以下依赖库<br/>

        . CFNetwork.framework
        . MobileCoreServices.framework
        . libxml2.tbd
        . libresolv.tbd
        . libsqlite3.tbd
        . libiconv.tbd
        . libstdc++.6.0.9.tbd
        . libz.tbd
4. Targets -> Build Settings -> Other Linker Flags 增加值`-ObjC`

5. 拖拽`FrameWorks`到您的项目中。<br/>

6. 拖拽`CoreEaseMob`到您的项目中。<br/>

7. Command + B编译通过，在AppDelegate复制以下代码测试，如果打印成功则集成成功。

        
            [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:@"chatdemoui_dev"];
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"charlin" password:@"841120" completion:^(NSDictionary *loginInfo, EMError *error) {
                NSLog(@"登陆成功：%@",loginInfo);
                
            } onQueue:nil];


<br/><br/><br/>

二、群聊, 实时语音, 实时视频
==========
已全面更新，并更新到EaseUI 3.0，详细使用方法仅供时点软件内部使用。
