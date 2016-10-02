//
//  DBCodeSearchViewController.m
//  Ji
//
//  Created by ssgm on 16/5/25.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBCodeSearchViewController.h"
#import "FXBlurView.h"
#import "DBMineService.h"
@interface DBCodeSearchViewController ()
{
    AVCaptureSession * _AVSession;//调用闪光灯的时候创建的类
    BOOL isOpenLight;
}
@property(nonatomic,strong)AVCaptureSession *lightSession;
@end

@implementation DBCodeSearchViewController{
    UIButton *backBtn,*lightBtn,*editBtn;
    UIImageView * imageView;
    UIView *topBlur,*leftBlur,*rightBlur,*bottomBlur;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)o_configViews{
    [self createScanItems];
    [self createBlurView];
    [self createBackAndLightBtn];
}

-(void)createBackAndLightBtn{
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"ic_arrow_left_back.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(20, 30, 40, 40);
    [backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightBtn setImage:[UIImage imageNamed:@"scanLightIcon.png"] forState:UIControlStateNormal];
    lightBtn.frame = CGRectMake(SCREEN_WIDTH-backBtn.frame.size.width-20, backBtn.frame.origin.y, backBtn.frame.size.width, backBtn.frame.size.height);
    [lightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:lightBtn];
}

-(void)createScanItems{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-95, SCREEN_WIDTH-95)];
    imageView.image = [UIImage imageNamed:@"ic_code_fang"];
    imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-60);
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-140, 2)];
    _line.image = [UIImage imageNamed:@"ic_code_line.png"];
    
    [imageView addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(imageView.frame), imageView.frame.size.width, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = kFont_System(13);
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将设备条形码图像置于扫描框内，即可自动扫描。";
    [self.view addSubview:labIntroudction];
}



-(void)createBlurView{
    
    topBlur = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMinY(imageView.frame))];
    topBlur.backgroundColor = [UIColor blackColor];
    topBlur.alpha = 0.2;
    [self.view addSubview:topBlur];
    
    leftBlur = [[FXBlurView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(imageView.frame), CGRectGetMinX(imageView.frame), imageView.frame.size.height)];
    leftBlur.backgroundColor = [UIColor blackColor];
    leftBlur.alpha = 0.2;
    [self.view addSubview:leftBlur];
    
    rightBlur = [[FXBlurView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), CGRectGetMinY(imageView.frame), SCREEN_WIDTH-CGRectGetMaxX(imageView.frame), imageView.frame.size.height)];
    rightBlur.backgroundColor = [UIColor blackColor];
    rightBlur.alpha = 0.2;
    [self.view addSubview:rightBlur];
    
    bottomBlur = [[FXBlurView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(imageView.frame))];
    bottomBlur.backgroundColor = [UIColor blackColor];
    bottomBlur.alpha = 0.2;
    [self.view addSubview:bottomBlur];
    
}




-(void)btnAction:(UIButton*)btn{
    if (backBtn==btn) {
        [timer invalidate];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
//    if (lightBtn==btn) {
//        if (isOpenLight) {
//            [self closeFlashlight];
//        }else{
//            [self openFlashlight ];
//        }
//        isOpenLight = !isOpenLight;
//    }

}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(20, 2*num+20, SCREEN_WIDTH-140, 2);
        if (2*num == SCREEN_WIDTH-140) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(20, 2*num+20, SCREEN_WIDTH-140, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
    
}
- (void)setupCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机未授权,请在设备的\"设置-隐私-相机\"中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];

        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];

        return;
    }
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    NSError *error = nil;
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];

    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeQRCode];
    //_output.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //_preview.frame =CGRectMake(30+4, SCREEN_HEIGHT/2-(SCREEN_WID-60)/2+4-60, SCREEN_WID-60-8, SCREEN_WID-60-8);
    
    [ _output setRectOfInterest : CGRectMake (((SCREEN_HEIGHT-(SCREEN_WIDTH-100))/2-60)/SCREEN_HEIGHT ,50/SCREEN_WIDTH , (SCREEN_WIDTH-100)/SCREEN_HEIGHT , (SCREEN_WIDTH-100)/SCREEN_WIDTH )];
    
    _preview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
    
    
    NSString *  sellerId = @"";
    NSArray *tmp = [stringValue componentsSeparatedByString:@"/"];
    if (tmp.count>0) {
        sellerId = tmp.lastObject;
        [DBMineService bindWithUid:UidStr sellerId:sellerId block:^(BOOL success, id result) {
            if (success) {
                DDLog(@"绑定成功");
                [self dismissViewControllerAnimated:YES completion:nil];
                [self showCustomHudSingleLine:@"绑定成功"];
            }
        }];

    }
}





//以下暂时废掉
//打开闪光灯
-(void)openFlashlight
{
    if (_device.torchMode == AVCaptureTorchModeOff) {
        // Start session configuration
        [_session beginConfiguration];
        [_device lockForConfiguration:nil];
        
        // Set torch to on
        [_device setTorchMode:AVCaptureTorchModeOn];
        [_device unlockForConfiguration];
        [_session commitConfiguration];
    }
    
}
-(void)closeFlashlight
{
    if (_device.torchMode==AVCaptureTorchModeOn) {
        [_session beginConfiguration];
        [_device lockForConfiguration:nil];
        // Set torch to on
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
    }
}
-(void)leftClick{
    if (_device.torchMode==AVCaptureTorchModeOn) {
        [_session beginConfiguration];
        [_device lockForConfiguration:nil];
        // Set torch to on
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
    }
}
@end
