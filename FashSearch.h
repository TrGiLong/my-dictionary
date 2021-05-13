//
//  FashSearch.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 28.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFromFastSearch.h"
@interface FashSearch : UITableViewController <UISearchBarDelegate> {
    NSMutableDictionary *DictionaryWithSearch;
    NSString *StringInfindBar;
    NSRange alc;
    NSMutableArray *keyWorldSearch;
    
     BOOL *searchBarIsTurning;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;
@property (strong, nonatomic) IBOutlet UISearchBar *fastSearch;
@property (nonatomic,strong) NSMutableDictionary *AllDict;
@property (nonatomic,strong) NSMutableArray* ListDictionaries;
@end
