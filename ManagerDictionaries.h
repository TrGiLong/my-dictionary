//
//  ManagerDictionaries.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 26.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "createDic.h"
@protocol LoadDictioanryProtocol <NSObject>
-(void)loadDictionaryfile:(NSString *)fileName;
-(void)deleteDictionary;
-(void)changeDictionary:(NSString *)ISDictionaryWasChanging;
@end
@interface ManagerDictionaries : UIViewController <UITableViewDataSource,UITableViewDelegate,createDictioanry> {
    NSInteger indexpathSelf;
}
@property (strong, nonatomic) IBOutlet UITableView *tableOfDictionaries;
@property (nonatomic,strong) NSMutableArray* ListDictionaries;
@property (nonatomic,strong) NSString *patchTimeOpen;
@property (weak, nonatomic) id <LoadDictioanryProtocol> Do;
@end
