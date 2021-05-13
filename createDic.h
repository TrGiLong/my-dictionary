//
//  createDic.h
//  Mydictionaries
//
//  Created by SYSTEM on 28.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol createDictioanry <NSObject>
-(void)createDic:(NSString *)Name;
-(void)changeDic:(NSString *)OldName:(NSString *)NewName;
@end
@interface createDic : UIViewController <UIAlertViewDelegate>
@property (strong,nonatomic) NSArray *Test;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (nonatomic,weak) id <createDictioanry> Do;
@property (nonatomic,strong) NSString *nameDictCurrent;
@property (nonatomic) NSInteger mode; //1 new 2 change
@property (nonatomic,strong) NSDictionary *listDict;
@end
