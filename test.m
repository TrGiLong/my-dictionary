//
//  test.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 03.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import "test.h"
#import "SWRevealViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface test ()

@end

@implementation test
@synthesize listWordsWiithMeaning,scrollView,pageoutlet,countTest;
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(NextQuestiuon)];
     self.view.backgroundColor =[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   // self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [super viewDidLoad];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        self.scrollView.contentSize = CGSizeMake(4100,290);
        [self.textMean1 setFrame:CGRectMake(0, -60, 1025, 600)];
        [self.textMean2 setFrame:CGRectMake(1025, -60, 1025, 600)];
        [self.textMean3 setFrame:CGRectMake(2050, -60, 1025, 600)];
        [self.textMean4 setFrame:CGRectMake(3075, -60, 1025, 600)];
        [self.scrollView addSubview:self.textMean1];
        [self.scrollView addSubview:self.textMean2];
        [self.scrollView addSubview:self.textMean3];
        [self.scrollView addSubview:self.textMean4];
    } else {
    if(IsIphone5)
    {
       self.scrollView.contentSize = CGSizeMake(1280,290);
        [self.textMean1 setFrame:CGRectMake(0, -60, 320, 400)];
        [self.textMean2 setFrame:CGRectMake(320, -60, 320, 400)];
        [self.textMean3 setFrame:CGRectMake(640, -60, 320, 400)];
        [self.textMean4 setFrame:CGRectMake(960, -60, 320, 400)];
        [self.scrollView addSubview:self.textMean1];
        [self.scrollView addSubview:self.textMean2];
        [self.scrollView addSubview:self.textMean3];
        [self.scrollView addSubview:self.textMean4];
    }
    else
    {
        NSLog(@"3");
        
        scrollView.contentSize = CGSizeMake(1280,200);
        [self.textMean1 setFrame:CGRectMake(0,-60, 320, 300)];
        [self.textMean2 setFrame:CGRectMake(320, -60, 320, 300)];
        [self.textMean3 setFrame:CGRectMake(640, -60, 320, 300)];
        [self.textMean4 setFrame:CGRectMake(960, -60, 320, 300)];
        [self.scrollView addSubview:self.textMean1];
        [self.scrollView addSubview:self.textMean2];
        [self.scrollView addSubview:self.textMean3];
        [self.scrollView addSubview:self.textMean4];
    }
    }
    [self randomizeWords];
    currentTest =1;
    countRighrANwertWithFirst = 0;
    FirstAnswert = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        [[self navigationController] popViewControllerAnimated:YES];
    }
}
-(void)NextQuestiuon {
    
    [self.scrollView setContentOffset:CGPointMake(0, -60) animated:YES];
    FirstAnswert = YES;
    if (currentTest ==countTest) {
        NSString *timeString = [NSString stringWithFormat:NSLocalizedString(@"You have answered %i right from %li", @""),countRighrANwertWithFirst,(long)countTest];
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Your result", @"")
                                                      message:timeString
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                            
                                            otherButtonTitles:nil];
        mes.delegate = self;
        [mes show];
        
    } else {
    
            if ( QuestionWasAnwered == YES) {
                QuestionWasAnwered = NO;
                
                [self randomizeWords];
                currentTest++;
        } else {
            self.Tits.text = [NSString stringWithFormat:NSLocalizedString(@"Choose right answert", @"")];
        
        }
    }
}

-(void)randomizeWords {
    int random = arc4random() % [[listWordsWiithMeaning allKeys]count];
    NSString *timestring = [[NSString alloc] init];
    while ([previoword isEqualToString:timestring]) {
        random = arc4random() % [[listWordsWiithMeaning allKeys]count];
        timestring = [[listWordsWiithMeaning allKeys]objectAtIndex:random];
    }
    self.wordLabel.text = [[listWordsWiithMeaning allKeys]objectAtIndex:random];
    
    int numberswtich = arc4random() % 4;
    
    int f1 =[self processRandomize1:random];
    self.textMean1.textColor = [UIColor colorWithRed:0 green:0.2 blue:0 alpha:1];
    self.textMean1.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f1]];
    if (numberswtich ==0) {
        f1 = random;
    }
    
    int f2 =[self processRandomize1:f1];
    while (f2 ==random || f2 ==f1) {
        f2=[self processRandomize1:random];
    }
    self.textMean2.textColor = [UIColor colorWithRed:0 green:0.2 blue:0 alpha:1];
    self.textMean2.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f2]];
    if (numberswtich ==1) {
        f2 = random;
    }
    
    int f3 =[self processRandomize1:f2];
    while (f3 ==random || f3==f1 || f3==f2 ) {
        f3=[self processRandomize1:random];
    }
    self.textMean3.textColor = [UIColor colorWithRed:0 green:0.2 blue:0 alpha:1];
    self.textMean3.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f3]];
    if (numberswtich ==2) {
        f3 = random;
    }
    
    if (numberswtich!= 3) {
        
        
        int f4 =[self processRandomize1:f3];
        while (f4 ==random || f4==f1 || f4==f2 || f4==f3) {
            f4=[self processRandomize1:random];
        }
        
        self.textMean4.textColor = [UIColor colorWithRed:0 green:0.2 blue:0 alpha:1];
        self.textMean4.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f4]];
        if (numberswtich ==3) {
            
        }
    }

    switch (numberswtich) {
        case 0:
            self.textMean1.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
           rightAnswert = 1;
            break;
            
        case 1:
            self.textMean2.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 2;
            break;
            
        case 2:
            self.textMean3.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 3;
            break;
            
        case 3:
            rightAnswert = 4;
            self.textMean4.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            
            
            
            break;
            
        default:
            break;
            
            
            
    }


}

-(int)processRandomize1:(int)limit1 {
    
    NSInteger random2=  arc4random_uniform([[listWordsWiithMeaning allKeys] count]) ;
    while  (random2 ==limit1) {
        random2=  arc4random_uniform([[listWordsWiithMeaning allKeys] count]) ;
    }
    return random2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
   CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
  self.pageoutlet.currentPage = page;
}
- (IBAction)rightbutton:(id)sender {
    if (self.pageoutlet.currentPage  == rightAnswert -1) {
        self.Tits.text = [NSString stringWithFormat:NSLocalizedString(@"answert true", @"")];
        QuestionWasAnwered =YES;
        if (FirstAnswert == YES) {
            countRighrANwertWithFirst++;
            FirstAnswert = NO;
        }
    } else {
        FirstAnswert = NO;
        self.Tits.text = [NSString stringWithFormat:NSLocalizedString(@"answert false", @"")];
        QuestionWasAnwered =NO;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    }

    
@end

