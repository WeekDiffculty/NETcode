//
//  ViewController.m
//  AFNetworking的使用
//
//  Created by 青云 on 16/7/23.
//  Copyright © 2016年 青云. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "StoryEntity.h"
#define BASE_URL @"http://afnetworking.sinaapp.com/request_get.json"
#define Server_Zhihu_Last @"http://news-at.zhihu.com/api/4/news/latest"
@interface ViewController ()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
//懒加载初始化一个对象
- (AFHTTPSessionManager *) manager{
    if(_manager)
        return _manager;
    //1.创建manager对象
    _manager=[AFHTTPSessionManager manager];
   // _manager.responseSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}
//Get方式向服务器请求数据
-(IBAction)getBtn:(id)sender{
//方式1：通过字典的形式以参数传值
//     //1.设置请求参数
//    //NSDictionary *pars=@{@"page":@"1"};
//    NSDictionary *pars=@{@"foo":@"bar"};
//    //2.设置响应接收的类型
//    [self.manager GET:BASE_URL parameters:pars progress:^(NSProgress * progress){
//        
//    }  success:^(NSURLSessionDataTask * task,id responseObject){
//        NSLog(@"数据请求成功%@",responseObject);
//        //下一步要做的工作是json数据的解析 到Model层
//    } failure:^(NSURLSessionDataTask * task,NSError *error){
//        NSLog(@"网络错误 %@",error);
//    }];
//
    //方式2.通过接口的方式 传值参数
    //1.设置请求参数
    //NSDictionary *pars=@{@"page":@"1"};
  //  NSDictionary *pars=@{@"foo":@"bar"};
    //2.设置响应接收的类型
//    NSString *strUrl=[NSString stringWithFormat:@"%@?foo=%@",BASE_URL,@"bar"];
    [self.manager GET:Server_Zhihu_Last parameters:nil progress:^(NSProgress * progress){
        
    }  success:^(NSURLSessionDataTask * task,id responseObject){
        NSLog(@"数据请求成功%@",responseObject);
        //下一步要做的工作是json数据的解析 到Model层
      //  NSString *strObject=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //手动解析Json
        
//        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict=(NSDictionary *) responseObject;
       // NSLog(@"%@",dict);
//      NSMutableArray *storyArr  =[StoryEntity  parseJson:dict];
//        NSLog(@"解析数据的元素个数%ld",storyArr.count);
        NSDictionary *dDict=[StoryEntity parse:dict];
        NSLog(@"%ld",dDict.count);
    } failure:^(NSURLSessionDataTask * task,NSError *error){
        NSLog(@"网络错误 %@",error);
    }];
    
}
//POST请求向服务器提交数据
-(IBAction)postBtn:(id)sender{

    //1.设置请求参数
    //NSDictionary *pars=@{@"page":@"1"};
    NSDictionary *pars=@{@"foo":@"bar"};
    //2.设置响应接收的类型
    [self.manager POST:BASE_URL parameters:pars progress:^(NSProgress * progress){
        
    }  success:^(NSURLSessionDataTask * task,id responseObject){
        NSLog(@"数据请求成功%@",responseObject);
        //下一步要做的工作是json数据的解析 到Model层
    } failure:^(NSURLSessionDataTask * task,NSError *error){
        NSLog(@"网络错误 %@",error);
    }];

}
//向服务器提交多个文件
-(IBAction) multiUploadFileBtn:(id) sender{
    
    //1.设置请求参数
    //NSDictionary *pars=@{@"page":@"1"};
 //   NSDictionary *pars=@{@"foo":@"bar"};
    //2.设置响应接收的类型
    
    [self.manager POST:BASE_URL parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData){
            //向formData添加数据
        //img1.jpg文件添加到fromData
        NSData *data1=[NSData dataWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"img1" ofType:@"jpg"] ];
    
      //  NSData *data1=[NSData dataWithContentsOfFile:imgPath];
        [formData appendPartWithFormData:data1 name:@"image1"];
        
        NSData *data2=[NSData dataWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:@"logo_news" ofType:@"png"]];
        [formData appendPartWithFormData:data2 name:@"logo_news"];
        
        
    }  progress: ^(NSProgress * _Nonnull uploadProgress){
    
    } success:^(NSURLSessionDataTask * task,id responseObject){
        NSLog(@"数据请求成功%@",responseObject);
        //下一步要做的工作是json数据的解析 到Model层
    } failure:^(NSURLSessionDataTask * task,NSError *error){
        NSLog(@"网络错误 %@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
