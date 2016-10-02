//
//  DBPingjiaViewController.m
//  Ji
//
//  Created by ssgm on 16/6/3.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBPingjiaViewController.h"
#import "DBMineService.h"
#import "DBOrder.h"
#import "DBOrderDetialModel.h"
#import "DBPingjiaHeadCell.h"
#import "DBPingjiaContentCell.h"
#import "DBPingjiaAddPicCell.h"
#import "ELNextView.h"//借用 下一步
#import "ActionSheetView.h"

@interface DBPingjiaViewController ()<UITableViewDelegate,UITableViewDataSource,AddPicDelegate,ActionDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    DBPingjiaContentCell *_pingjiaCell;
    UIImage *_pic;
    ELNextView *_footerView;
    NSString *_text;
    UIImagePickerController *imagePicker;
    NSString *imageFilePath;
}

@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ActionSheetView *actionSheetView;

//@property(nonatomic,strong)DBOrderDetialModel *orderDetialModel;
//@property(nonatomic,strong)NSMutableArray *timeArray;

@end

@implementation DBPingjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    self.title = @"评价中心";
}
-(void)o_load{
    self.datas = [NSMutableArray arrayWithCapacity:0];
//        WS(ws);
//        [DBMineService orderDetailUid:UidStr orderId:self.orderId block:^(BOOL success, id result) {
//            [self p_endRefresh];
//            if (success) {
//                self.orderDetialModel = [DBOrderDetialModel mj_objectWithKeyValues:result];
//                self.timeArray  = [self getTimeArray];
//                [ws.tableView reloadData];
//            }
//        }];
}

- (void)o_configViews {

    self.view.backgroundColor            = EL_BackGroundColor;
    UITableView *tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate                   = self;
    tableView.dataSource                 = self;
    tableView.separatorStyle             = UITableViewCellSeparatorStyleNone;
    [tableView registerClasses:@[@"DBPingjiaHeadCell",@"DBPingjiaContentCell",@"DBPingjiaAddPicCell"]];
    tableView.estimatedRowHeight         = 30;
    tableView.backgroundColor            = EL_BackGroundColor;
    [self.view addSubview:self.tableView = tableView ];
    
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    _footerView.tipLabel.hidden = YES;
    [_footerView.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView.okBtn setTitle:@"保存" forState:UIControlStateNormal];
    tableView.tableFooterView = _footerView;
    
    
    
    WS(ws);
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
    
}




#pragma mark - UITableViewDelegate UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ELRootCell *cell = nil;
    if (indexPath.row==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBPingjiaHeadCell"];
        [cell setData:self.goods];
    }else if (indexPath.row==1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBPingjiaContentCell"];
        
        _pingjiaCell = (DBPingjiaContentCell*)cell;
        _pingjiaCell.pinglunImageView.image = _pic;
        _pingjiaCell.textView.text = _text;
        [_pingjiaCell remakeConstraints];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"DBPingjiaAddPicCell"];
        cell.delegate  = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    if (section==2) {
        return 15;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   // [self setHidesBottomBarWhenPushed:YES];
    ELRootCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if ([cell isKindOfClass:[DBContentCell class]]) {
//        //进去商品详情页
//    }
}


#pragma mark---PingjiaCellDelegate

-(void)cell:(DBPingjiaAddPicCell *)cell addBtnClick:(UIButton *)btn{
    _text = _pingjiaCell.textView.text;
    //点击调用图片
    [self avatarTaps];
//    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
//    
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        
//        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
//        
//    }
//    pickerImage.delegate = self;
//    pickerImage.allowsEditing = YES;
//    [self presentViewController:pickerImage animated:YES completion:nil];

}

-(void)okBtn:(UIButton*)btn{
    
    if (_pingjiaCell.textView.text.length==0) {
        [self.view el_makeToast:@"商品评价不能为空"];
        return;
    }
    
    if (_pingjiaCell.pinglunImageView.image==nil) {
        [DBMineService saveCommentWithUid:UidStr goodsContent:_pingjiaCell.textView.text goodsId:integerToString(self.goods.id) goodImage:@"" orderId:integerToString(self.order.orderId) block:^(BOOL success, id result) {
            if (success) {
                [self.view el_makeToast:@"保存成功"];
                [self performSelector:@selector(pop) withObject:nil afterDelay:1];

            }else{
                [self.view el_makeToast:@"保存失败"];
            }
        }];
    }else{
        
        NSData *data = UIImageJPEGRepresentation(_pingjiaCell.pinglunImageView.image, 0.5);
        [DBMineService commentImgWithUid:UidStr imageData:data block:^(BOOL success, id result) {
            if (success) {
               NSString *picImageUrl = result[@"results"];
                [DBMineService saveCommentWithUid:UidStr goodsContent:_pingjiaCell.textView.text goodsId:integerToString(self.goods.id) goodImage:picImageUrl orderId:integerToString(self.order.orderId) block:^(BOOL success, id result) {
                    if (success) {
                        [self.view el_makeToast:@"保存成功"];
                        [self performSelector:@selector(pop) withObject:nil afterDelay:1];
                    }else{
                        [self.view el_makeToast:@"保存失败"];
                    }
                }];
            }else{
                [self.view el_makeToast:@"上传图片失败"];
            }

        }];

    }
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];

}
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
    
//    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
//
//    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        _pic= img;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)saveImage:(UIImage *)image {
    
//    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(260, 260)];
    
//    NSData *data = UIImageJPEGRepresentation(image, 1);
    _pic= image;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    [DBMineService accFaceWithUid:UidStr imageData:data block:^(BOOL success, id result) {
//        if (success) {
//            NSString *pathString = result[@"results"];
//            
//            NSLog(@"%@",pathString);
//            if (pathString !=nil && [pathString length]>0) {
//                //存起来，并且替换了新的照片
//                [[NSUserDefaults standardUserDefaults]setObject:pathString forKey:@"avatarurlKey"];
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//                ELMineTopCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
//                [cell setImageWithUrl:pathString ];
//            }
//        }else{
//            [self showCustomHudSingleLine:result];
//            
//        }
//    }];
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

