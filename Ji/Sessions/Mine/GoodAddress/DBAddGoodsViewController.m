//
//  DBAddGoodsViewController.m
//  Ji
//
//  Created by sbq on 16/5/22.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "DBAddGoodsViewController.h"
#import "ELNextView.h"
#import "DBAddressCell.h"
#import "DBCommonCell.h"
#import "DBZoomCell.h"
#import "DBMineService.h"
#import "CityListModel.h"
#import "CountryView.h"
#import "DBAreaModel.h"
#define NUMBERS @"0123456789\n"
@interface DBAddGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    ELNextView *_footerView;
    DBAddressCell *_oneCell;//普通cell
    DBAddressCell *_twoCell;//普通cell
    DBZoomCell *_thrCell;   //所在地区cell
    DBAddressCell *_furCell;//普通cell，命名名反了
    DBCommonCell *_fivCell; //详细地址cell，命名名反了
    
    DBAddressCell *_teleCell;//添加的那个cell
    
    NSString *_province;
    NSString *_city;
    NSString *_country;
    

}
@property (weak, nonatomic) IBOutlet UITableView *table;

@property(nonatomic,strong)CountryView *countryView;

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)DBAreaModel *areaModel;

@property(nonatomic,strong)NSMutableArray *stateArray;

@end

@implementation DBAddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增收货地址";
    self.stateArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    [self el_setLeftNaviImage:[UIImage imageNamed:@"ic_back_button"]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityListModelCome:) name:@"area" object:nil];

    // Do any additional setup after loading the view from its nib.
}


-(void)cityListModelCome:(NSNotification*)notice{
    self.areaModel = [notice object];
    NSString *cityString = [NSString stringWithFormat:@"%@ %@ %@",self.areaModel.countryName,self.areaModel.provinceName,self.areaModel.cityName];
    if (cityString!=nil) {
        _thrCell.rightLabel.text = cityString;
    }
}


-(void)o_configDatas{
    self.dataArray = @[
                        @{@"name":@"收货人姓名(必填)",
                             @"place":@""},
                        @{@"name":@"电话号码",
                          @"place":@""},
                        @{@"name":@"手机号码(必填)",
                             @"place":@""},
                        @{@"name":@"所在地区",
                             @"place":@""},
                        @{@"name":@"邮政编码",
                             @"place":@""},
                        @{@"name":@"详细地址(必填)",
                             @"place":@""}
                       ];
    
}

-(void)o_configViews{
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = EL_BackGroundColor;
    
    self.table.estimatedRowHeight = 45;
    self.table.rowHeight = UITableViewAutomaticDimension;
    
    _footerView = [[ELNextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRadioValue(205))];
    [_footerView.okBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_footerView.okBtn addTarget:self action:@selector(touchWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    _footerView.tipLabel.text = @"详细地址最长不超过50个字";
    self.table.tableFooterView = _footerView;
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.table addGestureRecognizer:tableViewGesture];
    
    [self createCells];
}

-(void)createCells{

    _thrCell = [[[NSBundle mainBundle]loadNibNamed:@"DBZoomCell" owner:self options:nil]lastObject];
    _thrCell.contentView.backgroundColor = [UIColor whiteColor];
    _thrCell.backgroundColor = [UIColor whiteColor];
    
    
    _fivCell = [[[NSBundle mainBundle]loadNibNamed:@"DBCommonCell" owner:self options:nil]lastObject];
    _fivCell.contentView.backgroundColor = [UIColor whiteColor];
    _fivCell.backgroundColor = [UIColor whiteColor];
    _fivCell.addressTextView.delegate = self;
    
    
    for (NSInteger i = 0; i<4; i++) {
        DBAddressCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"DBAddressCell" owner:self options:nil]lastObject];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.rightField.delegate  = self;
        if (i==0 ) {
            _oneCell = cell;
            _oneCell.leftLabel.text = @"收货人姓名(必填)";
        }else if (i==1 ){
            _teleCell = cell;
            _teleCell.leftLabel.text = @"电话号码";
        }else if (i==2 ){
            _twoCell = cell;
            _twoCell.leftLabel.text = @"手机号码(必填)";
        }
        else{
            _furCell = cell;
            _furCell.leftLabel.text = @"邮政编码";
            _furCell.rightField.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
}
- (void)tableViewTouchInSide{
    [_oneCell.rightField resignFirstResponder];
    [_teleCell.rightField resignFirstResponder];
    [_twoCell.rightField resignFirstResponder];
    [_furCell.rightField resignFirstResponder];
    [_fivCell.addressTextView resignFirstResponder];
    WS(ws);
    [UIView animateWithDuration:0.3 animations:^{
        ws.table.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    }];

}
#pragma mark---table代理们


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 11;
    }
    return 0.01;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0 ) {
        return  _oneCell ;
    }else if (indexPath.row==1 ){
        return _teleCell;
    }else if (indexPath.row==2 ){
        return _twoCell;
    }else if (indexPath.row==3){
        return _thrCell;
    }else if (indexPath.row==4){
        return _furCell;
    }else{
        return _fivCell;
    }
    
//    if (indexPath.row==3) {
//        DBZoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBZoomCell"];
//        if (cell==nil) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"DBZoomCell" owner:self options:nil]lastObject];
//
//        }
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//        cell.backgroundColor = [UIColor whiteColor];
//       //NSDictionary *dic = self.dataArray[indexPath.row];
//
//        _thrCell = cell;
// //       cell.rightLabel.text = self.stateArray[indexPath.row];
//        return cell;
//    }
//    if (indexPath.row==5 ) {
//        DBCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBCommonCell"];
//        
//        if (cell==nil) {
//           cell = [[[NSBundle mainBundle]loadNibNamed:@"DBCommonCell" owner:self options:nil]lastObject];
//        }
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//        cell.backgroundColor = [UIColor whiteColor];
//  
//        //NSDictionary *dic = self.dataArray[indexPath.row];
//        cell.addressTextView.delegate = self;
//        _fivCell = cell;
////        cell.addressTextView.text = self.stateArray[indexPath.row];
//        return cell;
        
//    }else{
        
//        DBAddressCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"DBAddressCell"];
//        if (cell==nil) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"DBAddressCell" owner:self options:nil]lastObject];
//            cell.contentView.backgroundColor = [UIColor whiteColor];
//            cell.backgroundColor = [UIColor whiteColor];
//
//        }
//        NSDictionary *dic = self.dataArray[indexPath.row];
//        cell.leftLabel.text = dic[@"name"];
//        cell.rightField.delegate = self;

//        else{
//            _furCell = cell;
//        }
//        cell.rightField.text = self.stateArray[indexPath.row];
//        return cell;
        
//    }
}

-(void)touchWithBtn:(UIButton *)btn{
    NSLog(@"保存了");
    if (_oneCell.rightField.text.length==0) {
        [self showCustomHudSingleLine:@"请输入收货人姓名"];
        return;
    }
    if (_oneCell.rightField.text.length>20) {
        [self showCustomHudSingleLine:@"收货人姓名最长不超过20个字"];
        return;
    }
    
    if (_teleCell.rightField.text.length==0) {
        _teleCell.rightField.text = @"";
    }
    if (_twoCell.rightField.text.length==0) {
        [self showCustomHudSingleLine:@"请输入手机号码"];
        return;
    }
    if (![DBHandel isValidateMobile:_twoCell.rightField.text]) {
        [self showCustomHudSingleLine:@"请输入正确的手机号码"];
        return;
    }
    if (_thrCell.rightLabel.text.length==0 || _areaModel.provinceName.length==0 ||_areaModel.cityName.length==0 ||_areaModel.countryName.length==0) {
        [self showCustomHudSingleLine:@"请选择所在地区"];
        return;
    }

    if (_furCell.rightField.text.length==0) {
        _furCell.rightField.text = @"";
    }
    if (_furCell.rightField.text.length!=6) {
        [self showCustomHudSingleLine:@"请输入合法邮政编码"];
        return;
    }
    
    
    
    if (_fivCell.addressTextView.text.length==0) {
        [self showCustomHudSingleLine:@"请输入详细地址"];
        return;
    }
    if (_fivCell.addressTextView.text.length>50) {
        [self showCustomHudSingleLine:@"地址详情最多50个字符"];
        return;
    }
    
    
//    {"provinceId":370000,"cityId":370800,"cityName":"济宁市","provinceName":"山东省",,"country":"1",,"countyName":"邹城市",,,"countyId":370883}
    NSDictionary *addressDic = @{@"userId":UidStr,@"userName":_oneCell.rightField.text,@"telePhone":_teleCell.rightField.text,@"phone":_twoCell.rightField.text,@"zipCode":_furCell.rightField.text,@"addressDetail":_fivCell.addressTextView.text,@"isDefault":@"1",@"country":@"1",@"provinceId":_areaModel.countryId,@"provinceName":_areaModel.countryName,@"cityId":_areaModel.provinceId,@"cityName":_areaModel.provinceName,@"countyId":_areaModel.cityId,@"countyName":_areaModel.cityName};
    
    
    [DBMineService saveAddressWithAddressDic:addressDic block:^(BOOL success, id result) {
        if (success) {
            [self showCustomHudSingleLine:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [self showCustomHudSingleLine:result];
        }
    }];
    
}

//键盘

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==_oneCell.rightField) {
        [_teleCell.rightField becomeFirstResponder];
    }
    if (textField==_teleCell.rightField) {
        [_twoCell.rightField becomeFirstResponder];
    }
    if (textField==_twoCell.rightField) {
        [_furCell.rightField becomeFirstResponder];
    }
    if (textField==_furCell.rightField) {
        [_fivCell.addressTextView becomeFirstResponder];
    }
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    WS(ws);
    [UIView animateWithDuration:0.3 animations:^{
        ws.table.frame = CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        WS(ws);
        [UIView animateWithDuration:0.3 animations:^{
            ws.table.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        }];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==3) {//点击地址选器，参考kegoal
        
        [self keyBoardHide];
        
        
        [DBMineService regionWithParentId:@"1" block:^(BOOL success, id result) {
            if (success) {
                NSArray *areaList = [CityListModel mj_objectArrayWithKeyValuesArray:result[@"regions"]];
                self.countryView =[[CountryView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) andArray:areaList];
                [self.view addSubview:self.countryView];
                
                //出现
                [UIView animateWithDuration:0.5 animations:^{
                    self.countryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        self.countryView.backgroundColor = RGBA(40, 40, 40, 0.6);
                    }];

                }];

            }
        }];
    }

}


-(void)keyBoardHide{

    [_oneCell.rightField resignFirstResponder];
    
    [_teleCell.rightField resignFirstResponder];
    [_twoCell.rightField resignFirstResponder];

    [_furCell.rightField resignFirstResponder];

    [_fivCell.addressTextView resignFirstResponder];

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == _furCell.rightField)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
}
@end
