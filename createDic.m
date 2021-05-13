//
//  createDic.m
//  Mydictionaries
//
//  Created by SYSTEM on 28.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "createDic.h"

@interface createDic ()

@end

@implementation createDic
@synthesize Test,nameDictCurrent,mode;
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navation bar withoutLogo" ]  forBarMetrics:UIBarMetricsDefault];
      self.view.backgroundColor =[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    
    
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    if (mode ==2) {
        self.name.text = [nameDictCurrent stringByDeletingPathExtension];
    }
    self.name.placeholder =NSLocalizedString(@"Put the name dictionary", @"");
}
-(void)save {
    
    if (mode == 1) {  //create
        
    
    BOOL flag=NO;
    NSString *cv = [NSString stringWithFormat:@"%@.Mydictionary",self.name.text];// NSString *textload = [[NSString alloc] init];
    
    for (NSString *elemrnt  in Test) {
        
        if ([cv isEqualToString:elemrnt]) {
            flag = YES;
            break;
        }
    }
    if (flag==NO) {
        [self.Do createDic:self.name.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else{
    
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"this dictionary already exists", @"")
                                                      message:NSLocalizedString(@"Please to write other dictionary", @"")
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
        mes.delegate = self;
        [mes show];
    }
        
        
    }
    else {  //change
        
        BOOL flag=NO;
        NSString *cv = [NSString stringWithFormat:@"%@.Mydictionary",self.name.text];// NSString *textload = [[NSString alloc] init];
        
        for (NSString *elemrnt  in Test) {
            
            if ([cv isEqualToString:elemrnt]) {
                flag = YES;
                break;
            }
        }
        if (flag==NO) {
         NSString *cv = [NSString stringWithFormat:@"%@",nameDictCurrent]; //old with espation
        NSString *cv2 = [NSString stringWithFormat:@"%@.Mydictionary",self.name.text];
        [self.Do changeDic:cv :cv2 ];
       [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"this dictionary already exists", @"")
                                                          message:NSLocalizedString(@"Please to write other dictionary", @"")
                                                         delegate:nil
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil];
            mes.delegate = self;
            [mes show];
        }
    }
}
-(void)cancel {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
