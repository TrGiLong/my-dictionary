//
//  test.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 03.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface test : UIViewController <UIScrollViewDelegate,UIPageViewControllerDelegate,UIAlertViewDelegate>  {
    int rightAnswert;
    BOOL QuestionWasAnwered;
    int currentTest;
    BOOL FirstAnswert;
    int countRighrANwertWithFirst;
    NSString *previoword;
}
@property (strong, nonatomic) IBOutlet UIPageControl *pageoutlet;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *wordLabel;

@property (strong, nonatomic) IBOutlet UITextView *textMean1;
@property (strong, nonatomic) IBOutlet UITextView *textMean2;
@property (strong, nonatomic) IBOutlet UITextView *textMean3;
@property (strong, nonatomic) IBOutlet UITextView *textMean4;
@property (strong, nonatomic) IBOutlet UILabel *Tits;

- (IBAction)rightbutton:(id)sender;


@property (nonatomic,strong) NSDictionary *listWordsWiithMeaning;
@property (nonatomic) NSInteger countTest;

@end
