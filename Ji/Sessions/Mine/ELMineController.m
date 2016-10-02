//
//  ELMineController.m
//  Ji
//
//  Created by evol on 16/5/18.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "ELMineController.h"
#import "ELRegisterViewController.h"
#import "ELLoginViewController.h"
#import "ELMineOrderCell.h"
#import "ELMineTopCell.h"
#import "DBGoodsAddressViewController.h"
#import "DBMineService.h"
#import "DBSetViewController.h"
#import "DBCodeSearchViewController.h"
#import "DBZeroViewController.h"
#import "DBUserInfo.h"
#import "DBGoodsSaveViewController.h"
#import "DBShopSaveViewController.h"
#import "DBAllOrderViewController.h"
#import "ELMessageService.h"
#import "ELMessageListModel.h"
#import "ELMineNormalCell.h"
#import "ActionSheetView.h"
#import "VouchersViewController.h"
#import "ELMainService.h"
#import "ELMainShopController.h"
//用于做网络判断
@interface ELMineController ()<UITableViewDelegate,UITableViewDataSource,ELMineOrderCellDelegate,ELMineTopCellDelegate,ActionDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    DBUserInfo *_userInfoModel;
    NSString *_shopName;
    UIImagePickerController *imagePicker;
    NSString *imageFilePath;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@property(nonatomic,strong)ActionSheetView *actionSheetView;
@property (nonatomic, strong) UIBarButtonItem *notiItems;


@end

@implementation ELMineController


- (void)o_viewLoad
{
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
//    [[UIBarButtonItem appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = nil;
    self.navigationController.tabBarItem.title = @"我的";
    self.navigationItem.rightBarButtonItem = self.notiItems;
    
    
 



}
- (UIBarButtonItem *)notiItems{
    if (_notiItems == nil) {
        UIImage *image  = [[UIImage imageNamed:@"ic_notice"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _notiItems = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(o_onNotiTap)];
    }
    return _notiItems;
}



- (void)p_loadDatas {
    WS(ws);
    [ELMessageService getAllMessageWithPageNum:1 block:^(BOOL success, id result) {
        if (success) {
            ELMessageListModel *model = [ELMessageListModel mj_objectWithKeyValues:result];
            NSArray *tmp = model.results;
    
          __block  BOOL have = NO;
            [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ELMessageModel class]]) {
            ELMessageModel *model = obj;
            if (model.readStatus ==0) {
                have = YES;
                ws.notiItems.image = [[UIImage imageNamed:@"ic_notice_have"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                return ;
            }
            if (have==NO) {
                ws.notiItems.image  = [[UIImage imageNamed:@"ic_notice"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
        }
    }];
            
        }
    }];
}



- (void)o_viewAppear {
 //监听一下网络状态
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                [self showCustomHudSingleLine:@"您的网络未识别，请检查网络连接"];
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                [self showCustomHudSingleLine:@"您的网络连接异常，请检查网络连接"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                // [self.view setNeedsDisplay];
//                [_tableView reloadData];
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                // [self.view setNeedsDisplay];
//                [_tableView reloadData];
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];

    
    
    
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:imageWithColor([UIColor clearColor], 1, 1) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    NSString *uids = [NSString stringWithFormat:@"%lu",(long)Uid];
    NSLog(@"uids====%@",uids);
    NSLog(@"饿了%ld",(long)Uid);
   
    [DBMineService getUserInfoWithUid:uids block:^(BOOL success, id result) {
        if (success) {
            _userInfoModel = [[DBUserInfo alloc]initWithDic:result[@"user"]];
            //将数据进行保存
            [[NSUserDefaults standardUserDefaults]setObject:_userInfoModel.mobile forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            if ([result[@"shop"] isKindOfClass:[NSNull class]]) {
                _shopName = @"";
            }else{
                _shopName = result[@"shop"][@"name"];
                
            }
        }
        [self.tableView reloadData];
    }];
    if (UidStr.length==0) {
        self.tabBarController.selectedIndex = 0;
    }
    
    //
    [self p_loadDatas];
    
    
    
}



- (void)o_configDatas{
    _datas = @[@[
                   @{
                       @"cellClass":@"ELMineTopCell"
                       }
                   ],
               @[
                   @{
                       @"title":@"我的订单",
                       @"subTitle":@"查看全部订单",
                       @"image":@"ic_order_icon",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"cellClass":@"ELMineOrderCell"
                       }
                   ],
               @[
                   @{
                       @"title":@"收货地址管理",
                       @"image":@"ic_person_shipping_addres",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"title":@"用户设置",
                       @"image":@"ic_person_set",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"title":@"扫码加入会员",
                       @"image":@"ic_person_richscan",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"title":@"我的0元购",
                       @"image":@"ic_person_quan",
                       @"cellClass":@"ELMineNormalCell"
                       },
                   @{
                       @"title":@"我的代金券",
                       @"image":@"ic_voucher_icon",
                       @"cellClass":@"ELMineNormalCell"
                       }

                   ],
               ];
    
}

- (void)o_configViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor            = EL_BackGroundColor;
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"ELMineTopCell",@"ELMineOrderCell",@"ELMineNormalCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = EL_BackGroundColor;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(-1);
        make.bottom.equalTo(ws.view).offset(-49);
    }];
    

}

-(void)messageClick{

    [self o_onNotiTap];
}
#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _datas[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = _datas[indexPath.section][indexPath.row];
    ELRootCell *cell = [tableView dequeueReusableCellWithIdentifier:data[@"cellClass"]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((indexPath.row==0 && indexPath.section==0 )|| (indexPath.row==1 && indexPath.section==1)) {
        [cell setData:_userInfoModel];
    }

    [cell setData:data];
    //设置shop标题
    if (indexPath.section==2 && indexPath.row==2 &&_shopName.length>0) {
        ELMineNormalCell *normal = (ELMineNormalCell*)cell;
        [normal resetTitle:_shopName];
    }
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    bgView.backgroundColor = EL_BackGroundColor;
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1 && indexPath.row == 0) {
        DBAllOrderViewController *vc = [[DBAllOrderViewController alloc]init];
        vc.vcTitle = @"全部订单";
        vc.orderType = @"whole";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        if (indexPath.row==0) {
            DBGoodsAddressViewController *vc = [[DBGoodsAddressViewController alloc]init];
            vc.notSelect = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==1) {
            DBSetViewController *set = [[DBSetViewController alloc]init];
            [self.navigationController pushViewController:set animated:YES];
        }
        if (indexPath.row==2 ) {
            if (_shopName.length>0 ) {
                [self.view el_makeToast:@"您已经绑定店铺"];
            }else{
                DBCodeSearchViewController *code = [[DBCodeSearchViewController alloc]init];
                [self presentViewController:code animated:YES completion:nil];
            }

        }
        if (indexPath.row==3) {
            DBZeroViewController *zero = [[DBZeroViewController alloc]init];
            [self.navigationController pushViewController:zero animated:YES];
            
          
        }
        if (indexPath.row==4) {
            //直接跳转到我的代金券的页面
           
            
            [[AFAppDotNetAPIClient sharedClient] POST:DMURL(@"user/vouchers") parameters:jsonDict(@{@"uid":@(Uid)})
                                             progress:nil
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                  
                                            
                                                  
                                                  ELStatus *status = [ELStatus mj_objectWithKeyValues:responseObject[@"status"]];
                                                  
                                                  if (status.succeed != 1) {
                                                      [self showCustomHudSingleLine:@"网络错误"];
                                                      return ;
                                                  }
                                                  
                                                  DDLog(@"代金券圈圈圈:%@",responseObject);
                                                NSArray* dataS=responseObject[@"data"];
                                                  DDLog(@"困死了起来工作了%@",dataS);
#warning 8/25
                                                  /**
                                                   *  8/25:如果没有代金券，就不进入代金券界面
                                                   */
                                                  if (![dataS isEqual:[NSNull null]]) {
                                                      VouchersViewController*Vouchers = [[VouchersViewController alloc]init];
                                                      Vouchers.temArray               = dataS;
                                                      [self.navigationController pushViewController:Vouchers animated:YES];
                                                  } else {
                                                      VouchersViewController*Vouchers = [[VouchersViewController alloc]init];
                                                      Vouchers.temArray               = nil;
                                                      [self.navigationController pushViewController:Vouchers animated:YES];
                                                       [self showCustomHudSingleLine:@"你没有可用的代金卷"];
                                                      
                                                      //[self showCustomHudSingleLine:@"你还没有代金卷"];
                                                  }
                                                  
                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                  DDLog(@"代金券获取失败");
                                                  VouchersViewController*Vouchers = [[VouchersViewController alloc]init];
                                                  Vouchers.temArray               = nil;
                                                  [self.navigationController pushViewController:Vouchers animated:YES];
                                                  
                                                  
                                                 // [self showCustomHudSingleLine:@"你还没有代金卷"];
[self showCustomHudSingleLine:@"代金券获取失败"];
                                                  
                                                 // [self showCustomHudSingleLine:@"代金券获取失败"];
                                }];
        }
        
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    //[self setHidesBottomBarWhenPushed:NO];
    
    [super viewDidDisappear:animated];
    
    
}

#pragma mark - ELMineOrderCellDelegate
#pragma mark-这里面所有的待付款订单，待发货订单，待收货订单，待评价订单，退款订单
- (void)orderCellDidSelectIndex:(NSInteger)index{
//type:whole--全部订单，await_pay--未付款，await_ship--代发货，shipped--代收货
    NSArray *array = @[@{@"vcTitle":@"待付款订单",@"type":@"await_pay"},
                       @{@"vcTitle":@"待发货订单",@"type":@"await_ship"},
                       @{@"vcTitle":@"待收货订单",@"type":@"shipped"},
                       @{@"vcTitle":@"待评价订单",@"type":@"finished"},
                       @{@"vcTitle":@"退款订单",@"type":@"refund"}];
    
    //循环遍历， 创建几个视图控制器
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index==idx) {
#pragma mark-判断是不是有网络连接
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                switch (status) {
                    case AFNetworkReachabilityStatusUnknown:
                        NSLog(@"未识别的网络");
                        [self showCustomHudSingleLine:@"您的网络未识别，请检查网络连接"];
                        
                        break;
                        
                    case AFNetworkReachabilityStatusNotReachable:
                        NSLog(@"不可达的网络(未连接)");
                        [self showCustomHudSingleLine:@"您的网络连接异常，请检查网络连接"];
                        break;
                        
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                        NSLog(@"2G,3G,4G...的网络");
                        [self.view setNeedsDisplay];
                        [_tableView reloadData];
                        
                        break;
                        
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                        NSLog(@"wifi的网络");
                        //[self.view setNeedsDisplay];
                        [_tableView reloadData];
                        
                        break;
                    default:
                        break;
                }
            }];
            //开始监听
            [manager startMonitoring];
            
            
            
            
            
            
            
            
#pragma mark-上面是判断网络是不是连接的代码
            DBAllOrderViewController *vc = [[DBAllOrderViewController alloc]init];
            vc.vcTitle   = obj[@"vcTitle"];
            vc.orderType = obj[@"type"];
            [self.navigationController pushViewController:vc animated:YES];

           
        }
    }];
}

#pragma --ELMineTopCellDelegate

-(void)clickGoodsAtIndex:(NSInteger)index{
    //[self setHidesBottomBarWhenPushed:YES];

    if (index==0) {
        DBGoodsSaveViewController *vc = [[DBGoodsSaveViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DBShopSaveViewController *vc =[[DBShopSaveViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


-(void)avatarTaps{

    NSLog(@"点击头像");
    self.actionSheetView = [[ActionSheetView alloc]initActionViewWithCancelMessage:@"取消" ok1Message:@"从相册选择" ok2Message:@"拍照"];
    self.actionSheetView.delegate = self;
    //[self.view addSubview:self.actionSheetView];
    [[[UIApplication sharedApplication].delegate window] addSubview:self.actionSheetView];

}



//头像上传
//相册选择
- (void)headClick
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];
    
}

//拍照选择
- (void)photoClick
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        DDLog("该设备无摄像头");
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    //初始化
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //设置可编辑
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = sourceType;
    //进入照相界面
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

#pragma mark---代理区

-(void)actionSheet:(ActionSheetView *)actionSheetView clickAtIndex:(TapIndex)index{
    if (index==CancelIndex) {
        NSLog(@"取消");
    }
    if (index==Ok1Index) {
        NSLog(@"从相册中选择");
        [self headClick];
    }
    if (index==Ok2Index) {
        NSLog(@"相机");
        [self photoClick];
    }
}


#pragma UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(260, 260)];
    
    NSData *data = UIImageJPEGRepresentation(smallImage, 1);
    
    
    [DBMineService accFaceWithUid:UidStr imageData:data block:^(BOOL success, id result) {
        if (success) {
            NSString *pathString = result[@"results"];
            
            NSLog(@"%@",pathString);
            if (pathString !=nil && [pathString length]>0) {
                //存起来，并且替换了新的照片
                [[NSUserDefaults standardUserDefaults]setObject:pathString forKey:@"avatarurlKey"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                ELMineTopCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                [cell setImageWithUrl:pathString ];
            }
        }else{
            [self showCustomHudSingleLine:result];
            
        }
    }];
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}


@end
