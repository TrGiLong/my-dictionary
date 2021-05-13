//
//  ChooseWordTable.m
//  Mydictionaries
//
//  Created by SYSTEM on 07.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import "ChooseWordTable.h"
#import "CellTest.h"
@interface ChooseWordTable ()

@end

@implementation ChooseWordTable
@synthesize listWordsWiithMeaning,countTest;
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
    [self randomizeWords];
    [super viewDidLoad];
    
    [[self talbe]setDelegate:self];
    [[self talbe]setDataSource:self ];
   [self.talbe reloadData];
     self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    QuestionWasAnwered = NO;
    currentTest = 1;
    FirstAnswert = YES;
    countRighrANwertWithFirst=0;
    Wrong = [NSMutableArray alloc];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(NextQuestiuon)];
    
    
    self.tits.text =NSLocalizedString(@"Choose right answert", @"");
    self.tits.textColor = [UIColor whiteColor];
}
-(void)NextQuestiuon {
    if (countTest == currentTest) {
        NSString *timeString = [NSString stringWithFormat:NSLocalizedString(@"You have answered %i right from %li", ""),countRighrANwertWithFirst,(long)countTest];
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"result", @"")
                                                      message:timeString
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                            
                                            otherButtonTitles:nil];
        mes.delegate = self;
        [mes show];
    }else {
        if (QuestionWasAnwered ==YES) {
            
            QuestionWasAnwered=NO;
            FirstAnswert =YES;
        currentTest++;
        [self randomizeWords];
        [self.talbe reloadData];
            self.tits.text =NSLocalizedString(@"Choose right answert", @"");
            self.tits.textColor = [UIColor whiteColor];
        }else {
            self.tits.text = NSLocalizedString(@"Choose right answert", @"");
            self.tits.textColor = [UIColor whiteColor];
        }
}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        [[self navigationController] popViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"CellTest";
    
    CellTest *cell = (CellTest *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.Meaning.text = [mean objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    int numLines = cell.Meaning.contentSize.height / 16.0;
    NSLog(@"%i   lines , %f / %f",numLines,cell.Meaning.contentSize.height,cell.Meaning.font.lineHeight );
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    CGRect frame = CGRectMake(255, 50,70, 40);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        /* Device is iPad */
        frame = CGRectMake(960, 50,70, 40);
    } else {
       frame = CGRectMake(255, 50,70, 40);
    }
   
    button.frame = frame;   // match the button's size with the image size
   // [button setBackgroundImage:[UIImage imageNamed:@"arrow icon view detail"] forState:UIControlStateNormal];
    [button setTitle:@"choose" forState:UIControlStateNormal];
    // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
    
   [ cell.Meaning  setFont:[UIFont systemFontOfSize:16]];

    return cell;
    

}

- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.talbe];
    NSIndexPath *indexPath = [self.talbe indexPathForRowAtPoint: currentTouchPosition];
    
    
    if (rightAnswert-1 == indexPath.row ) {
       self.tits.text = NSLocalizedString(@"answert true", @"");
        self.tits.textColor = [UIColor greenColor];
        QuestionWasAnwered = YES;
        if (FirstAnswert == YES) {
           countRighrANwertWithFirst++;
            FirstAnswert = NO;
        }
    } else {
         AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        self.tits.text= NSLocalizedString(@"answert false", @"");
        self.tits.textColor = [UIColor redColor];
    
        FirstAnswert = NO;
        [self.talbe reloadData];
    }
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(int)processRandomize1:(int)limit1 {
    
    NSInteger random2=  arc4random_uniform([[listWordsWiithMeaning allKeys] count]) ;
    while  (random2 ==limit1) {
        random2=  arc4random_uniform([[listWordsWiithMeaning allKeys] count]) ;
    }
    return random2;
}


-(void)randomizeWords {
    NSString *t1 = [NSString alloc];
    NSString *t2 = [NSString alloc];
    NSString *t3 = [NSString alloc];
    NSString *t4 = [NSString alloc];
    int random = arc4random() % [[listWordsWiithMeaning allKeys]count];
    NSString *timestring = [[NSString alloc] init];
    while ([previoword isEqualToString:timestring]) {
        random = arc4random() % [[listWordsWiithMeaning allKeys]count];
        timestring = [[listWordsWiithMeaning allKeys]objectAtIndex:random];
    }
    
    self.word.text = [[listWordsWiithMeaning allKeys]objectAtIndex:random];
    self.title = [[listWordsWiithMeaning allKeys]objectAtIndex:random];
    int numberswtich = arc4random() % 4;
    previoword = [NSString stringWithString:self.title];
    int f1 =[self processRandomize1:random];
    
    t1 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f1]];
    if (numberswtich ==0) {
        f1 = random;
    }
    
    int f2 =[self processRandomize1:f1];
    while (f2 ==random || f2 ==f1) {
        f2=[self processRandomize1:random];
    }
    t2 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f2]];
    if (numberswtich ==1) {
        f2 = random;
    }
    
    int f3 =[self processRandomize1:f2];
    while (f3 ==random || f3==f1 || f3==f2 ) {
        f3=[self processRandomize1:random];
    }
    t3 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f3]];
    if (numberswtich ==2) {
        f3 = random;
    }
    
    if (numberswtich!= 3) {
        
        
        int f4 =[self processRandomize1:f3];
        while (f4 ==random || f4==f1 || f4==f2 || f4==f3) {
            f4=[self processRandomize1:random];
        }
        
        t4 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:f4]];
        if (numberswtich ==3) {
            
        }
    }
    
    switch (numberswtich) {
        case 0:
            t1 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 1;
            break;
            
        case 1:
            t2 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 2;
            break;
            
        case 2:
            t3 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            rightAnswert = 3;
            break;
            
        case 3:
            rightAnswert = 4;
            t4 = [listWordsWiithMeaning objectForKey:[[listWordsWiithMeaning allKeys]objectAtIndex:random]];
            
            
            
            break;
            
        default:
            break;
            
            
            
    }
  
    
    mean = [NSMutableArray arrayWithObjects:t1,t2,t3,t4, nil];
   
    [self.talbe reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
   
}
@end
