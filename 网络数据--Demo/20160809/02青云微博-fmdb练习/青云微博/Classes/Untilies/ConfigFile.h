//
//  ConfigFile.h
//  青云微博
//
//  Created by qingyun on 16/7/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef ConfigFile_h
#define ConfigFile_h


#endif /* ConfigFile_h */


//appKey
#define APPKEY @"644299207"
//appSecret
#define APPSECRET @"7508605ad3e4cc4c2f59502db2a21428"

//服务器地址
//请求的服务器地址
#define BASEURL @"https://api.weibo.com"
//微博ap88i接口
//请求用户授权Token
#define AUTHORIZE @"oauth2/authorize"
//请求访问授权
#define ACCESSTOKEN @"oauth2/access_token"
#define DIRPATH @"http://www.hnqingyun.com"

//向服务器请求数据的接口 微博列表
#define  HOMELIST @"/2/statuses/home_timeline.json"
//转发微博的接口
#define REPOSTMESSAGE @"/2/statuses/repost.json"
//发微博
#define ADDMESSAGE @"/2/statuses/update.json"
