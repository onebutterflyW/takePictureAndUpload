//
//  JiuXZhenJiLu.m
//  photograph
//
//  Created by 415 on 17/4/5.
//  Copyright © 2017年 415. All rights reserved.
//

#import "JiuXZhenJiLu.h"
#import "AppDelegate.h"
#import "AddJiLuTVC.h"

@interface JiuXZhenJiLu ()<UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *delegate;

    
    UILabel *categoryLabel;
    UILabel *infoLabel;
    UILabel *timeLabel;
    
    UITextField *categoryTF;//类别：个人加的、医生、监护人
    UITextField *infoTF;//身体状况、用餐等
    UITextField *timeTF;//按时间段
    
    
    UITableView *tableOfJiLu;
    
    UIView *viewOfTable;
    UILabel *titleOfTable;
    UILabel *timeOfTable;


}
@end

@implementation JiuXZhenJiLu

-(void)viewDidAppear:(BOOL)animated{

    [tableOfJiLu reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];

    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //添加按钮
    UIButton *addBtn = [[UIButton alloc]init];
    addBtn.frame = CGRectMake(0, 0, 50, 40);
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.tintColor = [UIColor whiteColor];
    addBtn.backgroundColor = delegate.zhuTiColor;
    addBtn.layer.cornerRadius = 10;
    [addBtn addTarget:self action:@selector(addBtnTap) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
 
    
    [self createUI];
    

    
    
}


-(void)createUI{
    
    
    categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 120, 30)];
    categoryLabel.text=@"记录类别";
    categoryLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
    categoryLabel.backgroundColor=delegate.zhuTiColor;
    categoryLabel.layer.cornerRadius=10;
    categoryLabel.layer.masksToBounds=YES;
    categoryLabel.textColor=[UIColor whiteColor];
    [categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:categoryLabel];
    
    categoryTF=[[UITextField alloc] initWithFrame:CGRectMake(160, 100, 200, 30)];
    categoryTF.placeholder=@"请选择记录类别";
    categoryTF.font=[UIFont fontWithName:delegate.fontStyle size:18];
    [categoryTF setBorderStyle:UITextBorderStyleRoundedRect];
    categoryTF.backgroundColor=[UIColor whiteColor];
    categoryTF.secureTextEntry=YES;
    [categoryTF addTarget:self action:@selector(exitKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:categoryTF];

    
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 120, 30)];
    infoLabel.text=@"信息类别";
    infoLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
    infoLabel.backgroundColor=delegate.zhuTiColor;
    infoLabel.layer.cornerRadius=10;
    infoLabel.layer.masksToBounds=YES;
    infoLabel.textColor=[UIColor whiteColor];
    [infoLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:infoLabel];
    
    infoTF=[[UITextField alloc] initWithFrame:CGRectMake(160, 150, 200, 30)];
    infoTF.placeholder=@"请选择类别";
    infoTF.font=[UIFont fontWithName:delegate.fontStyle size:18];
    [infoTF setBorderStyle:UITextBorderStyleRoundedRect];
    infoTF.backgroundColor=[UIColor whiteColor];
    infoTF.secureTextEntry=YES;
    [infoTF addTarget:self action:@selector(exitKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:infoTF];
    
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 120, 30)];
    timeLabel.text=@"时  间";
    timeLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
    timeLabel.backgroundColor=delegate.zhuTiColor;
    timeLabel.layer.cornerRadius=10;
    timeLabel.layer.masksToBounds=YES;
    timeLabel.textColor=[UIColor whiteColor];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:timeLabel];
    
    
    timeTF=[[UITextField alloc] initWithFrame:CGRectMake(160,200, 200, 30)];
    timeTF.placeholder=@"请选择时间段";
    timeTF.font=[UIFont fontWithName:delegate.fontStyle size:18];
    [timeTF setBorderStyle:UITextBorderStyleRoundedRect];
    timeTF.backgroundColor=[UIColor whiteColor];
    timeTF.secureTextEntry=YES;
    [timeTF addTarget:self action:@selector(exitKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:timeTF];
    
    //病历记录table的标题
    
    viewOfTable = [[UIView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 40)];
    viewOfTable.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:viewOfTable];
    
    titleOfTable = [[UILabel alloc]initWithFrame:CGRectMake(40, 3, 80, 40)];
    titleOfTable.text =@"标题";
    [viewOfTable addSubview:titleOfTable];
    
    timeOfTable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, 3, 80, 40)];
    timeOfTable.text =@"添加时间";
    [viewOfTable addSubview:timeOfTable];
    
    //病历记录table
    tableOfJiLu = [[UITableView alloc]initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 200) style:UITableViewStylePlain];
    tableOfJiLu.delegate = self;
    tableOfJiLu.dataSource = self;
    tableOfJiLu.scrollEnabled = YES;
    [self.view addSubview:tableOfJiLu];

}


#pragma mark  UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    
    if ([delegate.timePictureArr count] == 0) {
        NSLog(@"无数据");
        return 1;
        
    }else{
        
        NSLog(@"有数据");
        return  [delegate.timePictureArr count];
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *cellIndentifier=@"cellIndentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    
    
    if ([delegate.timePictureArr count]==0) {
        
        cell.textLabel.text = @"当前没有记录";
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.allowsSelection = NO;
        
    }else{
    
        tableView.allowsSelection = YES;
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        titleLab.text= [delegate.titlePictureArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:titleLab];
        
        
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-180, 5, 100, 30)];
        timeLab.text= [delegate.timePictureArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:timeLab];
        
    }
    
      return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    delegate.rowOfJiLu = (NSInteger *)indexPath.row;
    delegate.isAddTap = @"0";
    AddJiLuTVC *jiTVC = [[AddJiLuTVC alloc]init];
    [self.navigationController pushViewController:jiTVC animated:NO];
}



//按钮系列方法
-(void)addBtnTap{
    //设置isAddTap为1表示,进入add页面，按钮名为完成
    delegate.isAddTap = @"1";
    
    AddJiLuTVC *vc = [[AddJiLuTVC alloc]init];
    [self.navigationController pushViewController:vc animated:NO];

}

//点空白处键盘消失
-(void)exitKeyBoard{

    [categoryTF resignFirstResponder];
    [infoTF     resignFirstResponder];
    [timeTF     resignFirstResponder];

}

@end
