//
//  ModeTest.m
//  Mydictionaries
//
//  Created by SYSTEM on 04.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import "ModeTest.h"
#import "test.h"
#import "ChooseTest.h"
#import "ChooseWordTable.h"
@interface ModeTest ()

@end

@implementation ModeTest
@synthesize picker,listWordsWiithMeaning,sliderQuestion;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(startText)];
    mode = [[NSArray alloc]initWithObjects:@"switch",@"choose", nil];
    modeTestSwtitchOrChoose = 0;
   self.view.backgroundColor =[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    sliderQuestion.minimumValue = 1;
    sliderQuestion.maximumValue = 50;
    sliderchoose = 10.0f;
    
    
    self.someQuestion.text = [NSString stringWithFormat:@"%0.f questions",sliderchoose];
    
    [self.sliderQuestion setValue:sliderchoose];
    self.label1.text = NSLocalizedString(@"Choose mode of teset", @"");
    self.label2.text = NSLocalizedString(@"choose %i test", @"");
    self.label2.textColor = [UIColor whiteColor];
    self.label1.textColor = [UIColor whiteColor];
    
    UIImage *buttonslieder = [UIImage imageNamed:@"slider button"];
  
    [[UISlider appearance] setThumbImage:buttonslieder forState:UIControlStateNormal];
    self.someQuestion.textColor = [UIColor whiteColor];
    NSLog(@"%@",listWordsWiithMeaning);
}
-(void)startText {

    if (modeTestSwtitchOrChoose ==0) {
        
    
    test *Test = [[test alloc] initWithNibName:@"test" bundle:nil];
    Test.listWordsWiithMeaning = [NSDictionary dictionaryWithDictionary:listWordsWiithMeaning];
        Test.countTest = (int) sliderchoose;
    
    [self.navigationController pushViewController:Test animated:YES];
    } else {
        /*
        ChooseTest *chooseTestView = [[ChooseTest alloc]initWithNibName:@"ChooseTest" bundle:nil];
        chooseTestView.listWordsWiithMeaning = [NSDictionary dictionaryWithDictionary:listWordsWiithMeaning];
        chooseTestView.countTest = (int) sliderchoose;
        [self.navigationController pushViewController:chooseTestView animated:YES];
        */
        ChooseWordTable *choose = [[ChooseWordTable alloc]initWithNibName:@"ChooseWordTable" bundle:nil];
        choose.listWordsWiithMeaning = [NSDictionary dictionaryWithDictionary:listWordsWiithMeaning];
        choose.countTest = (int)sliderchoose;
        [self.navigationController pushViewController:choose animated:YES];
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [mode count];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mode objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    if (row == 0) {
        modeTestSwtitchOrChoose =0;
        
    } else {
         modeTestSwtitchOrChoose =1;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)slider:(id)sender {
   
    sliderchoose = self.sliderQuestion.value;
    int testInteger = (int) sliderchoose;
    self.someQuestion.text = [NSString stringWithFormat:@"%i questions",testInteger];
}
@end
