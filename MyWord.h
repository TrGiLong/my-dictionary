//
//  MyWord.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 26.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddWordWithMean.h"
#import "ManagerDictionaries.h"
#import "ViewWordAndMean.h"
#import "CopyOrMove.h"
@interface MyWord : UIViewController <UIAppearanceContainer,EditWord,AddWordProtocol,LoadDictioanryProtocol,UITableViewDataSource,UITableViewDelegate,UIToolbarDelegate,UISearchBarDelegate>
{
    BOOL Firth;
    BOOL EditMode;
    BOOL SelectMode;
    BOOL *searchBarIsTurning;
    
    NSMutableArray *alfavit;
    NSMutableDictionary *sectionWithKeyWord;
    
    NSMutableDictionary *DictionaryWithSearch;
    NSString *StringInfindBar;
    NSRange alc;
    NSMutableArray *keyWorldSearch;
    
    
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *selectmodeSelectOn;

- (IBAction)SelectMode:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableDictionary *Dict;
@property  (nonatomic,strong) NSString *fileNameGlobal;
- (IBAction)Edit:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *EditAndCancel;
@property (strong ,nonatomic) NSMutableArray *KeyWords;
- (IBAction)Copy:(id)sender;
- (IBAction)Move:(id)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableDictionary *MoveAndCopy;
@end
