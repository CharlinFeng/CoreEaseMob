环信
==========

#### Xcode 7.0

#### Objective-C



<br/><br/><br/>
一、环信导入
==========
1. 到官网[http://www.easemob.com/downloads](http://www.easemob.com/downloads)下载最新SDK<br/>
2. 下载后，删除Lib文件夹中的libEaseMobClientSDKLite.a，并拖拽Lib到项目中。<br/>
3. 添加以下依赖库<br/>

        . CFNetwork.framework
        . MobileCoreServices.framework
        . libxml2.tbd
        . libresolv.tbd
        . libsqlite3.tbd
        . libiconv.tbd
        . libstdc++.6.0.9.tbd
        . libz.tbd

4. 拖拽FrameWorks到您的项目中。<br/>
5. 
5. 拖拽CoreEaseMob到您的项目中。<br/>

6. Command + B编译通过，在AppDelegate复制以下代码测试，如果打印成功则集成成功。

    [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:@"chatdemoui_dev"];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"charlin" password:@"841120" completion:^(NSDictionary *loginInfo, EMError *error) {
        NSLog(@"登陆成功：%@",loginInfo);
        
    } onQueue:nil];


<br/><br/><br/>

二、群聊,实时语音，实时视频
==========
更新中，敬请期待！
