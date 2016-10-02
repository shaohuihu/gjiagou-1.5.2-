//
//  DBCodeSearchViewController.h
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELBasicViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface DBCodeSearchViewController : ELBasicViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;


////修改专用
//@property(nonatomic,strong)NSString *modifyName;
//@property(nonatomic,strong)NSString *modifyID;
//@property(nonatomic,strong)NSString *bangdingID;
@end
