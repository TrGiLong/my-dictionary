//
//  ChooseTest.m
//  Mydictionaries
//
//  Created by SYSTEM on 04.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import "ChooseTest.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ChooseTest ()

@end
@implementation ChooseTest
@synthesize scrollView,countTest,listWordsWiithMeaning;
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
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    self.scrollView.contentSize = CGSizeMake(320,850);
    [self.meanlabel1 setFrame:CGRectMake(0, -160, 250, 400)];
    [self.meanlabel2 setFrame:CGRectMake(0, 60, 250, 400)];
     [self.meanlabel3 setFrame:CGRectMake(0, 290, 250, 400)];
     [self.meanlabel4 setFrame:CGRectMake(0, 510, 250, 400)];
    
    [self.button1 setFrame:CGRectMake(250, 20, 73, 44)];
    [self.button2 setFrame:CGRectMake(250, 240, 73, 44)];
    [self.button3 setFrame:CGRectMake(250, 460, 73, 44)];
    [self.button4 setFrame:CGRectMake(250, 700, 73, 44)];
    
    [self.scrollView addSubview:self.button1];
    [self.scrollView addSubview:self.button2];
    [self.scrollView addSubview:self.button3];
    [self.scrollView addSubview:self.button4];
    
    [self.scrollView addSubview:self.meanlabel1];
    [self.scrollView addSubview:self.meanlabel2];
    [self.scrollView addSubview:self.meanlabel3];
    [self.scrollView addSubview:self.meanlabel4];
    
    currentTest = 0;
    [self randomizeWords];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(NextQuestiuon)];
    
   

    
}
-(void)fixSizeofLavel {
    int firstLabel = [self.meanlabel1.text length];
    int staticNumber = 120;
    int characer = 120;
    NSInteger lines = firstLabel / characer;
    lines++;
    [self.meanlabel1 setFrame:CGRectMake(0, -160, lines * staticNumber, 300)];
    
    NSInteger lines2 = ([self.meanlabel2.text length]) / characer;
    lines2++;
    [self.meanlabel2 setFrame:CGRectMake(0, -160 + (lines *staticNumber), lines2*staticNumber, 300)];
      [self.button2 setFrame:CGRectMake(250, 20 + (lines *staticNumber), 73, 44)];
    NSInteger lines3 = ([self.meanlabel3.text length])  / characer;
    lines3++;
    [self.meanlabel3 setFrame:CGRectMake(0, -160 + (lines *staticNumber) +(lines2*staticNumber), lines3*staticNumber, 300)];
    [self.button3 setFrame:CGRectMake(250,  20 + (lines *staticNumber) +(lines2*staticNumber), 73, 44)];
    NSInteger lines4 = ([self.meanlabel4.text length])  / characer;
    lines4++;
    [self.meanlabel4 setFrame:CGRectMake(0, -160 + (lines *staticNumber) +(lines2*staticNumber) + (lines3*staticNumber), lines4 *staticNumber, 300)];
      [self.button4 setFrame:CGRectMake(250, 20+ (lines *staticNumber) +(lines2*staticNumber) + (lines3*staticNumber), 73, 44)];
    NSLog(@"%ld---%ld----%ld----%ld",(long)lines,(long)lines2,(long)lines3,(long)lines4);
}

-(void)NextQuestiuon {
    
    [self.scrollView setContentOffset:CGPointMake(0, -60) animated:YES];
    FirstAnswert = YES;
    if (currentTest ==countTest) {
        NSString *timeString = [NSString stringWithFormat:@"You have answered %i right from %li",countRighrANwertWithFirst,(long)countTest];
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Your result", @"")
                                                      message:timeString
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                            
                                            otherButtonTitles:nil];
        mes.delegate = self;
        [mes show];
       
    } else {
        
        if (testWasAnswerted ==YES) {
            [self randomizeWords];
            testWasAnswerted = NO;
            currentTest++;
            FirstAnswert = YES;
        }
    
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        [[self navigationController] popViewControllerAnimated:YES];
    }
}
-(void)randomizeWords {
    int random = arc4random() % [[listWordsWiithMeaning allKeys]count];
    self.word.text = [[listWordsWiithMeaning allKeys]objectAtIndex:random];
    
    int numberswtich = arc4random() % 4;
    
    int f1 =[self processRandomize1:random];
    self.meanlabel1.textColor = [UIColor colorWithRed:214.0f/255.0f green:229.0f/255.0f blue:62.0f/255.0f alpha:1.0];
    self.meanlabel1.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f1]];
    if (numberswtich ==0) {
        f1 = random;
    }
    
    int f2 =[self processRandomize1:f1];
    while (f2 ==random || f2 ==f1) {
        f2=[self processRandomize1:random];
    }
    self.meanlabel2.textColor = [UIColor colorWithRed:89.0f/255.0f green:208.0f/255.0f blue:204.0f/255.0f alpha:1.0];
    self.meanlabel2.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f2]];
    if (numberswtich ==1) {
        f2 = random;
    }
    
    int f3 =[self processRandomize1:f2];
    while (f3 ==random || f3==f1 || f3==f2 ) {
        f3=[self processRandomize1:random];
    }
    self.meanlabel3.textColor = [UIColor colorWithRed:61.0f/255.0f green:104.0f/255.0f blue:238.0f/255.0f alpha:1.0];
    self.meanlabel3.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f3]];
    if (numberswtich ==2) {
        f3 = random;
    }
    
    if (numberswtich!= 3) {
        
        
        int f4 =[self processRandomize1:f3];
        while (f4 ==random || f4==f1 || f4==f2 || f4==f3) {
            f4=[self processRandomize1:random];
        }
        
        self.meanlabel4.textColor = [UIColor colorWithRed:225.0f/255.0f green:61.0f/255.0f blue:238.0f/255.0f alpha:1.0];
        self.meanlabel4.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f4]];
        if (numberswtich ==3) {
            
        }
    }
    
    switch (numberswtich) {
        case 0:
            self.meanlabel1.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 1;
            break;
            
        case 1:
            self.meanlabel2.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 2;
            break;
            
        case 2:
            self.meanlabel3.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 3;
            break;
            
        case 3:
            rightAnswert = 4;
            self.meanlabel4.text = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            
            
            
            break;
            
        default:
            break;
            
            
            
    }
    NSLog(@"%i",rightAnswert);
    
    [self fixSizeofLavel];
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



- (IBAction)choose1:(id)sender {
    if (1 == rightAnswert) {
        self.tits.text = NSLocalizedString(@"answert true", @"");
        self.tits.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1]; /*#73fb76*/
        testWasAnswerted = YES;
        self.meanlabel1.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1];/*#73fb76*/
        if (FirstAnswert ==YES) {
            countRighrANwertWithFirst++;
        }
    } else {
        self.tits.text = NSLocalizedString(@"answert false", @"false");
        self.tits.textColor = [UIColor redColor];
        testWasAnswerted = NO;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        FirstAnswert =NO;
    }
}

- (IBAction)choose2:(id)sender {
    if (2 == rightAnswert) {
        self.tits.text = NSLocalizedString(@"answert true", @"");
        self.tits.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1]; /*#73fb76*/
        testWasAnswerted = YES;
        self.meanlabel2.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1];/*#73fb76*/
        if (FirstAnswert ==YES) {
            countRighrANwertWithFirst++;
        }
    } else {
        self.tits.text = NSLocalizedString(@"answert false", @"false");
        self.tits.textColor = [UIColor redColor];
        testWasAnswerted = NO;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        FirstAnswert =NO;
    }
}

- (IBAction)choose3:(id)sender {
    if (3 == rightAnswert) {
        self.tits.text = NSLocalizedString(@"answert true", @"");
        self.tits.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1]; /*#73fb76*/
        testWasAnswerted = YES;
        self.meanlabel3.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1];/*#73fb76*/
        if (FirstAnswert ==YES) {
            countRighrANwertWithFirst++;
        }
    } else {
        self.tits.text = NSLocalizedString(@"answert false", @"false");
        self.tits.textColor = [UIColor redColor];
        testWasAnswerted = NO;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        FirstAnswert =NO;
    }
}

- (IBAction)choose4:(id)sender {
    if (4 == rightAnswert) {
        self.tits.text = NSLocalizedString(@"answert true", @"");
        self.tits.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1]; /*#73fb76*/
        testWasAnswerted = YES;
        self.meanlabel4.textColor = [UIColor colorWithRed:0 green:0.698 blue:0 alpha:1];/*#73fb76*/
        if (FirstAnswert ==YES) {
            countRighrANwertWithFirst++;
        }
    } else {
        self.tits.text = NSLocalizedString(@"answert false", @"false");
        self.tits.textColor = [UIColor redColor];
        testWasAnswerted = NO;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        FirstAnswert =NO;
    }
}


@end
