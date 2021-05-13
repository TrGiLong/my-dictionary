//
//  ViewFromFastSearch.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 29.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFromFastSearch : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *wordLabel;
@property (strong, nonatomic) IBOutlet UITextView *MeanLabel;
@property (nonatomic,strong) NSString *word;
@property (nonatomic,strong) NSString *mean;
@end
