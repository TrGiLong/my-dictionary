//
//  ViewWordAndMean.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 27.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditWord <NSObject>
-(void)editWordWithMean:(NSMutableDictionary *)newdict;
-(void)closesearch;

@end
@interface ViewWordAndMean : UIViewController <UIAppearanceContainer,UITextViewDelegate> {
   BOOL editMode;
    
}
@property (strong, nonatomic) IBOutlet UITextField *WordLabel;
@property (strong, nonatomic) IBOutlet UITextView *MeanLabel;
@property (nonatomic,weak) id <EditWord> Do;
@property (nonatomic,strong) NSString *word;
@property (nonatomic,strong) NSString *mean;
@property (nonatomic,strong) NSMutableDictionary *dict;
@end
