//
//  DBPersonalViewController.m
//  Ji
//
//  Created by ssgm on 16/5/24.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPersonalViewController.h"
#import "DBPersonUpCell.h"
#import "DBPersionDownCell.h"
#import "DBGoodsAddressViewController.h"
#import "SexSheetView.h"
#import "ActionSheetView.h"
#import "DBMineService.h"
#import "DBUserInfo.h"
@interface DBPersonalViewController ()<UITableViewDelegate,UITableViewDataSource,SexSheetDelegate,ActionDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *sex;//性别字段
    UIImagePickerController *imagePicker;
    NSString *imageFilePath;
    DBUserInfo *userInfoModel;
}
@property (nonatomic, weak) UITableView *tableView;
@property(nonatomic,strong)SexSheetView *sexSheetView;
@property(nonatomic,strong)ActionSheetView *actionSheetView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation DBPersonalViewController
-(void)o_load{
    self.title = @"个人信息";
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
}
-(void)o_configDatas{
    _datas = @[@"头像",@"性别",@"我的收货地址"];
    

    [self getUserInfo];
    
}

-(void)getUserInfo{
    [DBMineService getUserInfoWithUid:UidStr block:^(BOOL success, id result) {
        if (success) {
            
            userInfoModel = [[DBUserInfo alloc]initWithDic:result[@"user"]];
            if (userInfoModel.sex==nil) {
                sex = @"";
            }
            if ([userInfoModel.sex integerValue]==0) {
                sex = @"男神";
            }
            if ([userInfoModel.sex integerValue]==1) {
                sex = @"女神";
            }
            if ([userInfoModel.sex integerValue]==2) {
                sex = @"保密";
            }
        }else{
            [self showCustomHudSingleLine:result];
        }
        [self.tableView reloadData];
    }];
}

-(void)o_configViews{
    self.view.backgroundColor            = EL_BackGroundColor;
    
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBPersonUpCell",@"DBPersionDownCell"]];
    tableView.estimatedRowHeight         = 44;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-49);
    }];

}
#pragma mark - UITableViewDelegate UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        DBPersonUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBPersonUpCell"];
        [cell setTitle:self.datas[indexPath.row]];
        [cell setImageWithUrl:userInfoModel.avatarUrl];//默认头像

        return cell;
    }else{
        DBPersionDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBPersionDownCell"];
        [cell setTitle:self.datas[indexPath.row]];
        if (indexPath.row==1) {
            NSLog(@"%@",userInfoModel.sex);
            [cell setRightLabel:sex];
        }
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   // [self setHidesBottomBarWhenPushed:YES];
    if (indexPath.row==0) {
        self.actionSheetView = [[ActionSheetView alloc]initActionViewWithCancelMessage:@"取消" ok1Message:@"从相册选择" ok2Message:@"拍照"];
        self.actionSheetView.delegate = self;
        //[self.view addSubview:self.actionSheetView];
        [[[UIApplication sharedApplication].delegate window] addSubview:self.actionSheetView];
    }
    if (indexPath.row==1) {
        self.sexSheetView = [[SexSheetView alloc]initActionViewWithCancelMessage:@"取消" ok1Message:@"男神" ok2Message:@"女神" ok3Message:@"保密"];
        self.sexSheetView.delegate = self;
        [[[UIApplication sharedApplication].delegate window] addSubview:self.sexSheetView];
    }
    if (indexPath.row==2) {
        DBGoodsAddressViewController *vc = [[DBGoodsAddressViewController alloc]init];
        vc.notSelect = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)actionSexSheet:(SexSheetView *)actionSheetView clickAtIndex:(TapIndex)index{
    switch (index) {
        case CancelIndex://点击取消
        {
            break;
        }
        case Ok1Index://点击男神
        {
            [self submitOperation:@"0"];
            break;
        }
        case Ok2Index://点击女神
        {


            [self submitOperation:@"1"];
            break;
        }
        case Ok3Index://点击保密
        {
            [self submitOperation:@"2"];
            break;
        }
            
            
        default:
            break;
    }
    
}

-(void)submitOperation:(NSString*)sexIndex{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    DBPersionDownCell *cell = (DBPersionDownCell*)[_tableView cellForRowAtIndexPath:indexPath];
    [DBMineService updateSexWithUid:UidStr sex:sexIndex block:^(BOOL success, id result) {
        if (success) {
            if ([sexIndex isEqualToString:@"0"]) {
                [cell setRightLabel:@"男神"];
            }
            if ([sexIndex isEqualToString:@"1"]) {
                [cell setRightLabel:@"女神"];
            }
            if ([sexIndex isEqualToString:@"2"]) {
                [cell setRightLabel:@"保密"];
            }
        }
    }];

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
                DBPersonUpCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
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
