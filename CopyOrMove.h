//
//  CopyOrMove.h
//  Mydictionaries
//
//  Created by SYSTEM on 28.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoveDelet <NSObject>
-(void)deleleAfterMove;
@end
@interface CopyOrMove : UITableViewController
@property (nonatomic,strong) NSMutableArray* ListDictionaries;
@property (nonatomic) NSInteger *modeInteger;   //1-copy 2-Move
@property (weak, nonatomic) id <MoveDelet> long2;
@property (nonatomic,strong) NSMutableDictionary *MoveAndCopy;
@end
