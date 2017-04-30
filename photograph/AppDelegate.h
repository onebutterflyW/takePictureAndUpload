//
//  AppDelegate.h
//  photograph
//
//  Created by 415 on 17/4/5.
//  Copyright © 2017年 415. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property NSString *fontStyle;//系统字体样式
@property UIColor *zhuTiColor;//系统主体颜色


//如果为YES表示按下了JiuZhenJiLu的左上角➕按钮,AddJiLuTVC下面应该是完成按钮
@property (strong, nonatomic)NSString *isAddTap;


@property (strong, nonatomic)UILabel *timeTFLabel;
@property (strong, nonatomic)UITextField *infoTF;
@property (strong, nonatomic)UITextView *contextTV;

@property (strong, nonatomic)UIImageView *pictureView;

//就诊图片上传接受数据的数组
@property (strong, nonatomic) NSMutableArray *titlePictureArr;
@property (strong, nonatomic) NSMutableArray *timePictureArr;
@property (strong, nonatomic) NSMutableArray *infoPictureArr;
@property (strong, nonatomic) NSMutableArray *contextPictrueArr;
@property (strong, nonatomic) NSMutableArray *pictureJiLuArr;

//在JiuZhenJiLu中选择哪一行的标志
@property NSInteger *rowOfJiLu;


@end

