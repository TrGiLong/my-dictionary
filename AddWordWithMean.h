//
//  AddWordWithMean.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 26.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddWordProtocol <NSObject>
-(void)addWord:(NSString *)word:(NSString *)Mean;
@end
@interface AddWordWithMean : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) id <AddWordProtocol,UITextViewDelegate> Do;
@property (strong, nonatomic) IBOutlet UITextView *MeanLabel;
@property (strong, nonatomic) IBOutlet UITextField *WordLabel;
@property (nonatomic,strong) NSArray *listWord;
@end
