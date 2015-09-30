环信
==========

#### Xcode 7.0<br/>

#### Objective-C<br/>



<br/><br/><br/>
一、环信导入
==========
1. 到官网http://www.easemob.com/downloads下载最新SDK<br/>
2. 下载后，删除Lib文件夹中的libEaseMobClientSDKLite.a，并拖拽Lib到项目中。<br/>
3. 添加以下依赖库<br/>
. CFNetwork.framework<br/>
. MobileCoreServices.framework<br/>
. libxml2.tbd<br/>
. libresolv.tbd<br/>
. libsqlite3.tbd<br/>
. libiconv.tbd<br/>
. libstdc++.6.0.9.tbd<br/>
. libz.tbd<br/>
4. 拖拽FrameWorks到您的项目中。<br/>
5. 拖拽CoreEaseMob到您的项目中。<br/>
6.Command + B编译通过，在AppDelegate复制以下代码测试，如果打印成功则集成成功。


    [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:@"chatdemoui_dev"];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"charlin" password:@"841120" completion:^(NSDictionary *loginInfo, EMError *error) {
        NSLog(@"登陆成功：%@",loginInfo);
        
    } onQueue:nil];


<br/><br/><br/>
二、群聊
==========
更新中，敬请期待！
