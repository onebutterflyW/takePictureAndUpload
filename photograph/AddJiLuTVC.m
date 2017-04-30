//
//  AddJiLuTVC.m
//  photograph
//
//  Created by 415 on 17/4/5.
//  Copyright © 2017年 415. All rights reserved.
//

#import "AddJiLuTVC.h"
#import "AppDelegate.h"
#import "JiuXZhenJiLu.h"


#define boundary @"AaB03x" //设置边界 参数可以随便设置

@interface AddJiLuTVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    AppDelegate *delegate;
    
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *infoLabel;
    UILabel  *contextLabel;
    
    UITextField  *titleTF;
    NSString *strTitle;
    UIButton *takePotoBtn;
    UIButton *successBtn;
    UIButton *editBtn;
    UIButton *deletBtn;
    
    UIActionSheet *action;
    
    
    NSString *currentTime;
    NSDictionary *arr;//临时存信息列表：身体状况等
    NSMutableDictionary *infoDic;//信息列表：身体状况等
    NSMutableDictionary *picturedic;//键为0显示占位图片，
    
    //info中对应的是1的为黑
    UIButton *btn0;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;

    
    NSString *suffix;//后缀
    NSString *sureSuffix;
    NSData  *imageData;
    
    
}

@end

@implementation AddJiLuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    currentTime = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"%@",delegate.isAddTap);
    
    if ([delegate.isAddTap isEqualToString:@"1"]) {
        
        infoDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"绘油彩画",@"0",@"唱老红歌",@"0",@"跳拉丁舞",@"0",@"其他项目",@"0",@"编写代码",@"0",@"外出活动", nil];
        
        
    }else{
    
        NSLog(@"点击记录进入");
       infoDic = [delegate.infoPictureArr objectAtIndex:(NSInteger)delegate.rowOfJiLu];
         NSLog(@"点击");

    
      }

   NSLog(@"%@",[infoDic allKeys]);
    
    
    if ([delegate.isAddTap isEqualToString:@"1"]) {
        
        picturedic = [[NSMutableDictionary alloc] init];
        
        
    }

    
    
    
    
    
    //点击空白处，隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [titleTF resignFirstResponder];
    [delegate.contextTV resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIndentifier=@"cellIndentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    
    tableView.allowsSelection = NO;
    
    if (indexPath.row == 0) {
        NSLog(@"0");
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 30)];
        titleLabel.text=@"标题";
        titleLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
        titleLabel.backgroundColor=delegate.zhuTiColor;
        titleLabel.layer.cornerRadius=10;
        titleLabel.layer.masksToBounds=YES;
        titleLabel.textColor=[UIColor whiteColor];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:titleLabel];
        
        titleTF=[[UITextField alloc] initWithFrame:CGRectMake(120, 5, 200, 30)];
        titleTF.delegate = self;
        if ([delegate.isAddTap isEqualToString:@"1"]){
            
           titleTF.placeholder = @"请输入标题";
        }else{
        
            titleTF.text=[delegate.titlePictureArr objectAtIndex:(NSInteger)delegate.rowOfJiLu];
            strTitle = titleTF.text;
        
        }
        titleTF.font=[UIFont fontWithName:delegate.fontStyle size:18];
        [titleTF setBorderStyle:UITextBorderStyleRoundedRect];
         titleTF.backgroundColor=[UIColor whiteColor];
        [titleTF addTarget:self action:@selector(exitKeyBoard:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview: titleTF];
        
    }
    if (indexPath.row == 1) {
        
        NSLog(@"1");
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 30)];
        timeLabel.text=@"添加时间";
         timeLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
         timeLabel.backgroundColor=delegate.zhuTiColor;
         timeLabel.layer.cornerRadius=10;
         timeLabel.layer.masksToBounds=YES;
         timeLabel.textColor=[UIColor whiteColor];
        [ timeLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview: timeLabel];
        
        delegate.timeTFLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 5, 200, 30)];
        delegate.timeTFLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
        
        if ([delegate.isAddTap isEqualToString:@"1"]){
            
            delegate.timeTFLabel.text = currentTime;
            
        }else{
            
            delegate.timeTFLabel.text=[delegate.timePictureArr objectAtIndex:(NSInteger)delegate.rowOfJiLu];
            
        }
        
        delegate.timeTFLabel.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:delegate.timeTFLabel];
        
    }
    if (indexPath.row == 2) {
         NSLog(@"2");
        
         infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 30)];
         infoLabel.text=@"信息类别";
         infoLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
         infoLabel.backgroundColor=delegate.zhuTiColor;
         infoLabel.layer.cornerRadius=10;
         infoLabel.layer.masksToBounds=YES;
         infoLabel.textColor=[UIColor whiteColor];
        [ infoLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview: infoLabel];
        
    }
    
    if(indexPath.row == 3){
    
         NSLog(@"3");
        UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(30, 3, 80, 30)];
        labelName.text = [infoDic allKeys][0];
        labelName.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:labelName];
        
        btn0=[[UIButton alloc] initWithFrame:CGRectMake(110, 10, 15, 15)];
        btn0.layer.borderColor=[UIColor blackColor].CGColor;
        btn0.layer.borderWidth=1;
        btn0.tag=0;
        
        
        
        //看后台怎么给数据，现在是将每一项以键值对的形式存储
        if ([[infoDic objectForKey:labelName.text] isEqualToString:@"1"]) {
            btn0.backgroundColor=[UIColor blackColor];
        }
        else{
            
            btn0.backgroundColor=[UIColor whiteColor];
        }
        [btn0 addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn0];
        

        
        UILabel *labelName1=[[UILabel alloc] initWithFrame:CGRectMake(170, 3, 80, 30)];
        labelName1.text = [infoDic allKeys][1];
        [cell.contentView addSubview:labelName1];
        
        btn1=[[UIButton alloc] initWithFrame:CGRectMake(240, 10, 15, 15)];
        btn1.layer.borderColor=[UIColor blackColor].CGColor;
        btn1.tag=1;
        btn1.layer.borderWidth=1;
        if ([[infoDic objectForKey:labelName1.text] isEqualToString:@"1"]) {
            btn1.backgroundColor=[UIColor blackColor];
        }
        else{
            
            btn1.backgroundColor=[UIColor whiteColor];
        }
        [btn1 addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn1];
        
    }
    
    if(indexPath.row == 4){
         NSLog(@"4");
        
        UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(30, 3, 80, 30)];
        labelName.text = [infoDic allKeys][2];
        [cell.contentView addSubview:labelName];
        
        btn2=[[UIButton alloc] initWithFrame:CGRectMake(110, 10, 15, 15)];
        btn2.layer.borderColor=[UIColor blackColor].CGColor;
        btn2.layer.borderWidth=1;
        btn2.tag=2;
        if ([[infoDic objectForKey:labelName.text] isEqualToString:@"1"]) {
            btn2.backgroundColor=[UIColor blackColor];
        }
        else{
            
            btn2.backgroundColor=[UIColor whiteColor];
        }
        [btn2 addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn2];
        
        
        
        UILabel *labelName1=[[UILabel alloc] initWithFrame:CGRectMake(170, 3, 80, 30)];
        labelName1.text = [infoDic allKeys][3];
        [cell.contentView addSubview:labelName1];
        
        btn3=[[UIButton alloc] initWithFrame:CGRectMake(240, 10, 15, 15)];
        btn3.layer.borderColor=[UIColor blackColor].CGColor;
        btn3.tag=3;
        btn3.layer.borderWidth=1;
        if ([[infoDic objectForKey:labelName1.text] isEqualToString:@"1"]) {
            btn3.backgroundColor=[UIColor blackColor];
        }
        else{
            
            btn3.backgroundColor=[UIColor whiteColor];
        }
        [btn3 addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn3];
        
    }

    if(indexPath.row == 5){
        
        UILabel *labelName=[[UILabel alloc] initWithFrame:CGRectMake(30, 3, 80, 30)];
        labelName.text = [infoDic allKeys][4];
        [cell.contentView addSubview:labelName];
        
        btn4=[[UIButton alloc] initWithFrame:CGRectMake(110, 10, 15, 15)];
        btn4.layer.borderColor=[UIColor blackColor].CGColor;
        btn4.layer.borderWidth=1;
        btn4.tag=4;
        if ([[infoDic objectForKey:labelName.text] isEqualToString:@"1"]) {
            btn4.backgroundColor=[UIColor blackColor];
        }
        else{
            
            btn4.backgroundColor=[UIColor whiteColor];
        }
        [btn4 addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn4];
        
        
        
        UILabel *labelName1=[[UILabel alloc] initWithFrame:CGRectMake(170, 3, 80, 30)];
        labelName1.text = [infoDic allKeys][5];
        [cell.contentView addSubview:labelName1];
        
        btn5=[[UIButton alloc] initWithFrame:CGRectMake(240, 10, 15, 15)];
        btn5.layer.borderColor=[UIColor blackColor].CGColor;
        btn5.tag=5;
        btn5.layer.borderWidth=1;
        if ([[infoDic objectForKey:labelName1.text] isEqualToString:@"1"]) {
            btn5.backgroundColor=[UIColor blackColor];
        }
        else{
            
            btn5.backgroundColor=[UIColor whiteColor];
        }
        [btn5 addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn5];
        
    }

    
    
    
    
    if (indexPath.row == 6) {
         NSLog(@"6");
        contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 30)];
        contextLabel.text=@"内容";
        contextLabel.font=[UIFont fontWithName:delegate.fontStyle size:18];
        contextLabel.backgroundColor=delegate.zhuTiColor;
        contextLabel.layer.cornerRadius=10;
        contextLabel.layer.masksToBounds=YES;
        contextLabel.textColor=[UIColor whiteColor];
        [contextLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView addSubview:contextLabel];
        
        delegate.contextTV=[[UITextView alloc] initWithFrame:CGRectMake(30,40, self.view.frame.size.width-60, 100)];
        delegate.contextTV.font=[UIFont fontWithName:delegate.fontStyle size:18];
        if ([delegate.isAddTap isEqualToString:@"1"]){
            
         
            
        }else{
            
            delegate.contextTV.text=[delegate.contextPictrueArr objectAtIndex:(NSInteger)delegate.rowOfJiLu];
            
        }
        
        delegate.contextTV.layer.cornerRadius = 10;
        delegate.contextTV.layer.borderWidth = 2.0;
        delegate.contextTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        delegate.contextTV.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:delegate.contextTV];
        
    }
    if (indexPath.row == 7) {
         NSLog(@"7");
        takePotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 80, 30)];
        [takePotoBtn setTitle:@"上传照片" forState:UIControlStateNormal];
        takePotoBtn.font=[UIFont fontWithName:delegate.fontStyle size:18];
        takePotoBtn.backgroundColor=delegate.zhuTiColor;
        takePotoBtn.layer.cornerRadius=10;
        takePotoBtn.layer.masksToBounds=YES;
        [takePotoBtn addTarget:self action:@selector(pikerPicture) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:takePotoBtn];
        
        delegate.pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 40, self.view.frame.size.width-60, 200)];
        delegate.pictureView.layer.cornerRadius = 10;
        delegate.pictureView.layer.borderWidth = 2.0;
        
        if ([delegate.isAddTap isEqualToString:@"1"]){
            
            
            
        }else{
           
            //因为图片可以为空，这里需要看看服务器传过来的是什么样的值，在进行处理,我这里模拟的值是添加的时候传入的@“0”
           picturedic = [delegate.pictureJiLuArr  objectAtIndex:(NSInteger)delegate.rowOfJiLu] ;
            
            NSLog(@"picturedic=%@",picturedic);
            if (picturedic.allKeys[0]== 0) {
               
                NSLog(@"显示默认");
                delegate.pictureView.image = [UIImage imageNamed:@"1.jpg"];
                
            }else{
           
                 NSLog(@"显示％@",[picturedic objectForKey:picturedic.allKeys[0]]);
                delegate.pictureView.image = [picturedic objectForKey:picturedic.allKeys[0]];
            
            }
        }

        
        delegate.pictureView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        delegate.pictureView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:delegate.pictureView];
         NSLog(@"8");
        
    }
    
    if (indexPath.row == 8) {
        
        if ([delegate.isAddTap isEqualToString:@"1"]){
            
            successBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, 30)];
            [successBtn setTitle:@"完成" forState:UIControlStateNormal];
            successBtn.font=[UIFont fontWithName:delegate.fontStyle size:18];
            successBtn.backgroundColor=delegate.zhuTiColor;
            successBtn.layer.cornerRadius=10;
            successBtn.layer.masksToBounds=YES;
            [successBtn addTarget:self action:@selector(successAdd) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:successBtn];

            
        }else{
        
            editBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width/2-40, 30)];
            [editBtn setTitle:@"修改" forState:UIControlStateNormal];
            editBtn.font=[UIFont fontWithName:delegate.fontStyle size:18];
            editBtn.backgroundColor=delegate.zhuTiColor;
            editBtn.layer.cornerRadius=10;
            editBtn.layer.masksToBounds=YES;
            [editBtn addTarget:self action:@selector(editBtnTap) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:editBtn];

        
            deletBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 5, self.view.frame.size.width/2-40, 30)];
            [deletBtn setTitle:@"删除" forState:UIControlStateNormal];
            deletBtn.font=[UIFont fontWithName:delegate.fontStyle size:18];
            deletBtn.backgroundColor=delegate.zhuTiColor;
            deletBtn.layer.cornerRadius=10;
            deletBtn.layer.masksToBounds=YES;
            [deletBtn addTarget:self action:@selector(deletBtnTap) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:deletBtn];

        
        }
   
    
    }
    
    
    
    return cell;
 
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==0||indexPath.row==1||indexPath.row==2||indexPath.row==8) {
        
        return  40;
        
    }else if(indexPath.row ==3||indexPath.row==4||indexPath.row==5){
        
        return  30;

    
    }else if(indexPath.row == 6){
    
        return 150;
    
    }else if (indexPath.row == 7){
        
        return 250;
    
    }
    
    return 80;

}



#pragma 选照片
-(void)pikerPicture{

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        action = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        action = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    action.tag = 1000;
    [action showInView:self.view];




}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                //图库
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}


#pragma mark UIImagePickerController代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    delegate.pictureView.image = image;
    
   
    
}




-(void)successAdd{
    
   NSLog(@"title=%@",strTitle);
    [self sedImageWithImage];

   
    if ([strTitle isEqualToString:@""]||strTitle.length ==0||[delegate.contextTV.text isEqualToString:@""]) {

        UIAlertView *alertOne=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您有些内容没有添全，请检查!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertOne show];
        
        
    }else{
    
  
        
        if ([delegate.titlePictureArr count] == 0) {
            
            NSLog(@"为空");
          
            
            [delegate.titlePictureArr addObject:strTitle];
            [delegate.timePictureArr addObject:delegate.timeTFLabel.text];
            [delegate.infoPictureArr addObject:infoDic];
            [delegate.contextPictrueArr addObject:delegate.contextTV.text];
            
            //当图片为空时，显示默认图片，存储时，存默认图片且对应的键为@“0”
            if(delegate.pictureView.image ==nil)
            {
              [picturedic setObject:[UIImage imageNamed:@"1.jpg"] forKey:@"0"];
                
            }else{
              [picturedic setObject:delegate.pictureView.image forKey:@"1"];
            }
            NSLog(@"1点击完成＝%@",picturedic);
            
            [delegate.pictureJiLuArr addObject:picturedic];
            
        }else{
            
            NSLog(@"不为空");
            [delegate.titlePictureArr insertObject:strTitle atIndex:0];
            [delegate.timePictureArr insertObject:delegate.timeTFLabel.text atIndex:0];
            [delegate.infoPictureArr insertObject:infoDic atIndex:0];
            [delegate.contextPictrueArr insertObject:delegate.contextTV.text atIndex:0];
            
            if(delegate.pictureView.image ==nil)
            {
                [picturedic setObject:[UIImage imageNamed:@"1.jpg"] forKey:@"0"];
                
            }else{
                [picturedic setObject:delegate.pictureView.image forKey:@"1"];
            }
            NSLog(@"2点击完成＝%@",picturedic);
            [delegate.pictureJiLuArr insertObject:picturedic atIndex:0];
            
        }
      
        [self returnJilu];

    
    }
    
   
}


-(void)returnJilu{

    [self.navigationController popViewControllerAnimated:NO];

}


//处理删除
-(void)deletBtnTap{

     [delegate.titlePictureArr removeObjectAtIndex:(NSInteger)delegate.rowOfJiLu];
     [delegate.timePictureArr removeObjectAtIndex:(NSInteger)delegate.rowOfJiLu];
     [delegate.infoPictureArr removeObjectAtIndex:(NSInteger)delegate.rowOfJiLu];
     [delegate.contextPictrueArr removeObjectAtIndex:(NSInteger)delegate.rowOfJiLu];
     [delegate.pictureJiLuArr removeObjectAtIndex:(NSInteger)delegate.rowOfJiLu];
    
    NSLog(@"delegate.titlePictureArr=%@",delegate.titlePictureArr);

    [self returnJilu];
    
}

//处理修改
//如果是添加记录,将最后的类别数组添加到infoPictureArr中
//如果是修改则将上面已经修改了添加到对应的位置
-(void)editBtnTap{
   
    if ([strTitle isEqualToString:@""]||[delegate.contextTV.text isEqualToString:@""]) {
        
        UIAlertView *alertOne=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您有些内容没有添全，请检查!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertOne show];
        
        
    }else{
    
       if ([delegate.titlePictureArr count]== 0){
        
           [delegate.titlePictureArr addObject:strTitle];
           [delegate.timePictureArr addObject:delegate.timeTFLabel];
           [delegate.infoPictureArr addObject:infoDic];
           [delegate.contextPictrueArr addObject:delegate.contextTV.text];
           
           if(delegate.pictureView.image ==nil)
           {
               [picturedic setObject:[UIImage imageNamed:@"1.jpg"] forKey:@"0"];
               
           }else{
               [picturedic setObject:delegate.pictureView.image forKey:@"1"];
           }
        
           [delegate.pictureJiLuArr addObject:picturedic];
       
       }else{
    
    
           [delegate.titlePictureArr replaceObjectAtIndex:(NSInteger)delegate.rowOfJiLu withObject:strTitle];
           
           NSLog(@"1");
           [delegate.timePictureArr replaceObjectAtIndex:(NSInteger)delegate.rowOfJiLu withObject:delegate.timeTFLabel.text];
           NSLog(@"2");
           [delegate.infoPictureArr replaceObjectAtIndex:(NSInteger)delegate.rowOfJiLu withObject:infoDic];
           [delegate.contextPictrueArr replaceObjectAtIndex:(NSInteger)delegate.rowOfJiLu withObject:delegate.contextTV.text];
           NSLog(@"3");
           if(delegate.pictureView.image ==nil)
           {
               [picturedic setObject:[UIImage imageNamed:@"1.jpg"] forKey:@"0"];
               
           }else{
               [picturedic setObject:delegate.pictureView.image forKey:@"1"];
           }
           NSLog(@"2修改点击完成＝%@",picturedic);
           [delegate.pictureJiLuArr replaceObjectAtIndex:(NSInteger)delegate.rowOfJiLu withObject:picturedic];
          NSLog(@"4");
        }
    
        
       [self returnJilu];
        
    }

}


//小方框的变黑标志
-(void)selectTap:(UIButton*)sender{

    NSLog(@"%@",infoDic);
    if (sender.tag == 0) {
    
      
        NSString *key0 = [infoDic allKeys][0];
        NSLog(@"btn=%ld,%@",(long)sender.tag,[infoDic objectForKey:key0]);
        if ([[infoDic objectForKey:key0] isEqualToString:@"1"]) {
            
            btn0.backgroundColor=[UIColor whiteColor];
            [infoDic setValue:@"0" forKey:[infoDic allKeys][0]];
        }
        else{
            
            btn0.backgroundColor=[UIColor redColor];
            [infoDic setValue:@"1" forKey:[infoDic allKeys][0]];
        }

       
    }
    
    if (sender.tag == 1) {
        
        
        NSString *key0 = [infoDic allKeys][1];
        NSLog(@"btn=%ld,%@",(long)sender.tag,[infoDic objectForKey:key0]);
        if ([[infoDic objectForKey:key0] isEqualToString:@"1"]) {
            
            btn1.backgroundColor=[UIColor whiteColor];
            [infoDic setValue:@"0" forKey:[infoDic allKeys][1]];
        }
        else{
            
            btn1.backgroundColor=[UIColor redColor];
            [infoDic setValue:@"1" forKey:[infoDic allKeys][1]];
        }
       
    }else if (sender.tag == 2) {
        
      
        NSString *key0 = [infoDic allKeys][2];
        NSLog(@"btn=%ld,%@",(long)sender.tag,[infoDic objectForKey:key0]);
        if ([[infoDic objectForKey:key0] isEqualToString:@"1"]) {
            
            btn2.backgroundColor=[UIColor whiteColor];
            [infoDic setValue:@"0" forKey:[infoDic allKeys][2]];
        }
        else{
            
            btn2.backgroundColor=[UIColor blackColor];
            [infoDic setValue:@"1" forKey:[infoDic allKeys][2]];
        }
        
    }

    if (sender.tag == 3) {
        
        
        NSString *key0 = [infoDic allKeys][3];
        NSLog(@"btn=%ld,%@",(long)sender.tag,[infoDic objectForKey:key0]);
        if ([[infoDic objectForKey:key0] isEqualToString:@"1"]) {
            
            btn3.backgroundColor=[UIColor whiteColor];
            [infoDic setValue:@"0" forKey:[infoDic allKeys][3]];
        }
        else{
            
            btn3.backgroundColor=[UIColor blackColor];
            [infoDic setValue:@"1" forKey:[infoDic allKeys][3]];
        }
        
        NSLog(@"%@",infoDic);
    }

    if (sender.tag == 4) {
        
      
        NSString *key0 = [infoDic allKeys][4];
         NSLog(@"btn=%ld,%@",(long)sender.tag,[infoDic objectForKey:key0]);
        if ([[infoDic objectForKey:key0] isEqualToString:@"1"]) {
            
            btn4.backgroundColor=[UIColor whiteColor];
            [infoDic setValue:@"0" forKey:[infoDic allKeys][4]];
        }
        else{
            
            btn4.backgroundColor=[UIColor blackColor];
            [infoDic setValue:@"1" forKey:[infoDic allKeys][4]];
        }
        
        NSLog(@"%@",infoDic);
    }

    if (sender.tag == 5) {
        
        
        NSString *key0 = [infoDic allKeys][5];
        NSLog(@"btn=%ld,%@",(long)sender.tag,[infoDic objectForKey:key0]);
        if ([[infoDic objectForKey:key0] isEqualToString:@"1"]) {
            
            btn5.backgroundColor=[UIColor whiteColor];
            [infoDic setValue:@"0" forKey:[infoDic allKeys][5]];
        }
        else{
            
            btn5.backgroundColor=[UIColor blackColor];
            [infoDic setValue:@"1" forKey:[infoDic allKeys][5]];
        }
        
    }

  
        NSLog(@"%@",infoDic);

}

#pragma mark--UITextField代理方法
-(void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"UITextField代理方法");
     strTitle = titleTF.text;

}


-(void)exitKeyBoard:(id)sender{

    strTitle = titleTF.text;
    
    //NSLog(@"标题%@",strTitle);
    [titleTF resignFirstResponder];

}

//图片类型，确定上传图片时setBodydata函数中的拼接固定格式时使用
-(void ) imageType{
   
    
    if (UIImagePNGRepresentation(delegate.pictureView.image) ||UIImageJPEGRepresentation(delegate.pictureView.image,0.5)) {
      
        if (UIImagePNGRepresentation(delegate.pictureView.image)) {
            
            sureSuffix = [self typeReturnBaseData:UIImagePNGRepresentation(delegate.pictureView.image)];
            imageData =UIImagePNGRepresentation(delegate.pictureView.image);
            
        }else{
        
            sureSuffix = [self typeReturnBaseData:UIImageJPEGRepresentation(delegate.pictureView.image,1.0)];
            imageData =UIImageJPEGRepresentation(delegate.pictureView.image,1.0);
        }
        
        
    }else {
        
    
        //给出提示只允许png和jpg
        UIAlertView *alertOne=[[UIAlertView alloc] initWithTitle:@"提示" message:@"只允许上传png和jpg" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertOne show];
        
        delegate.pictureView.image = nil;
        
    }
}



    



//修改成功,并上传服务器
-(void)sedImageWithImage{
    NSLog(@"开始sedImageWithImage");
    NSString *str=@"";//服务器的url需要的NSString
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:str];
    
    //2、创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //3、设置
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:120];
    [request setCachePolicy:0];
    
    //4、设置请求头(multipart/form-data;charset=utf-8;boundary=AaB03x)上传数据类型 必须要设置其类型
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8;boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
   
    NSData *bodyData = [self setBodydata:imageData];
    NSLog(@"bodyData=%@",bodyData);
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *dataTask = [session uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        
        
        if (error==nil) {
            
            NSLog(@"成功%@",response);//202及是发布成功
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if ([dictionary objectForKey:@"success"]) {
                NSLog(@"%@",response);//202及是发布成功
                NSLog(@"上传成功");
            }else{
                NSLog(@"上传失败");
            }

        }else{
        
            
        
        };
        
    }];
    
    //5.发送网络任务
    [dataTask resume];
    NSLog(@"结束sedImageWithImage");
    
}



- (NSData *)setBodydata:(NSData *)data
{
    
    [self imageType];
    
    
    //1.构造body string
    NSMutableString *bodyString = [[NSMutableString alloc] init];
    
    //2.拼接body string－－pic
    /*
     --AaB03x
     Content-disposition: form-data; name="pic"; filename="file"
     Content-Type: application/octet-stream
     */
    [bodyString appendFormat:@"--%@\r\n", boundary];//（一开始的 --也不能忽略）
    [bodyString appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"22.%@\"\r\n",sureSuffix];
    [bodyString appendFormat:@"Content-Type: application/x－www-form-urlencoded\r\n\r\n"];
    
    
    //3.string --> data
    NSMutableData *bodyData = [NSMutableData data];
    //拼接的过程
    //前面的bodyString, 其他参数
    [bodyData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    //图片数据
    [bodyData appendData:data];
    
    //4.结束的分隔线
    NSString *endStr = [NSString stringWithFormat:@"\r\n--%@--\r\n",boundary];
    //拼接到bodyData最后面
    [bodyData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    return bodyData;
}

//判断图片格式
-(NSString *)typeReturnBaseData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    if (c==0xff||c==0x89) {
        
        //png和jpg允许上传
        if (c==0xff) {
            
            suffix=@"jpg";
            
        }else{
        
            suffix=@"png";
        
        }
        
    }
    NSLog(@"suffix=%@",suffix);
        return suffix;
   
    
}






@end
