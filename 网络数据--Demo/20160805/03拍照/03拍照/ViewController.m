//
//  ViewController.m
//  03拍照
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initImgPickerController];
}
-(void) initImgPickerController{
    imgPickerController=[[UIImagePickerController alloc] init];
    //设置照片的来源 此处设置来源摄像头
    imgPickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    //设置使用哪个摄像头
    imgPickerController.cameraDevice=UIImagePickerControllerCameraDeviceRear;
    imgPickerController.delegate=self;
    //是否允许编辑 允许用户选择照片的指定区域
    imgPickerController.allowsEditing=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//拍照的按钮方法
-(IBAction)captureBtn:(id)sender{
    //打开摄像头进行拍照
    [self presentViewController:imgPickerController animated:YES completion:nil];
}
//取消
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"拍照取消");
    [imgPickerController dismissViewControllerAnimated:YES completion:nil];
}
//拍照结束后获取图片
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"拍照结束");
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断是否是拍照图片模式还是视频拍摄的模式
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        if (imgPickerController.allowsEditing) {
            //获取编辑的图片,并显示到图像视图中
            imgView.image=[info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            //获取拍照的原始图片
            UIImage *img=[info objectForKey:UIImagePickerControllerOriginalImage];
            imgView.image=img;
        
        }
    }
    [imgPickerController dismissViewControllerAnimated:YES completion:nil];
}
@end
