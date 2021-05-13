//
//  ModeTest.h
//  Mydictionaries
//
//  Created by SYSTEM on 04.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModeTest : UIViewController  <UIPickerViewDelegate,UIPickerViewDataSource> {
    BOOL modeTestSwtitchOrChoose ;//1- choose 0-swife
    NSArray *mode;
    float sliderchoose;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;


@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic,strong) NSDictionary *listWordsWiithMeaning;
@property (weak, nonatomic) IBOutlet UISlider *sliderQuestion;
- (IBAction)slider:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *someQuestion;

@end
