//
//  ChooseWords.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 01.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "test.h"
#import "ModeTest.h"


@interface ChooseWords : UITableViewController <UIAlertViewDelegate>


@property (nonatomic,strong) NSMutableDictionary *ListWordWithMeaning;
@property (nonatomic,strong) NSMutableArray *listKeyWereChoosen;
@end
