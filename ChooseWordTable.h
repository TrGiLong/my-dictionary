//
//  ChooseWordTable.h
//  Mydictionaries
//
//  Created by SYSTEM on 07.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface ChooseWordTable : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
int rightAnswert;
BOOL QuestionWasAnwered;
int currentTest;
BOOL FirstAnswert;
int countRighrANwertWithFirst;

BOOL testWasAnswerted;
    NSMutableArray *mean;
    NSMutableArray *Wrong;
    NSString *previoword;
}
@property (strong, nonatomic) IBOutlet UILabel *tits;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView ;
@property (weak, nonatomic) IBOutlet UITableView *talbe;

@property (strong, nonatomic) IBOutlet UILabel *meanlabel1;
@property (strong, nonatomic) IBOutlet UILabel *meanlabel2;
@property (strong, nonatomic) IBOutlet UILabel *meanlabel3;
@property (strong, nonatomic) IBOutlet UILabel *meanlabel4;


@property (strong, nonatomic) IBOutlet UILabel *word;
- (IBAction)segmentureSwich:(id)sender;

- (IBAction)choose1:(id)sender;
- (IBAction)choose2:(id)sender;
- (IBAction)choose3:(id)sender;
- (IBAction)choose4:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;

@property (nonatomic,strong) NSDictionary *listWordsWiithMeaning;
@property (nonatomic) NSInteger countTest;
@end
