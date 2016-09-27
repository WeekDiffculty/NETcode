//
//  DownloadFile.h
//  NSOperationDemo
//
//  Created by qingyun on 16/7/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^BlockImage)(UIImage *image);
@interface DownloadFile : NSOperation{
    NSURL *download_URL;
}
@property(nonatomic,strong) BlockImage block;
-(instancetype) initWithDownloadUrl:(NSString *)url;
@end
