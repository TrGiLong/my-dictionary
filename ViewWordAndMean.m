//
//  ViewWordAndMean.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 27.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "ViewWordAndMean.h"

@interface ViewWordAndMean ()

@end

@implementation ViewWordAndMean
@synthesize word,mean,dict;
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
    self.view.backgroundColor =[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    [super viewDidLoad];
   
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.MeanLabel.delegate = self;
    self.WordLabel.text =word;
    self.MeanLabel.text =mean;
    self.title = word;
    self.MeanLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"6"]];
   // self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.WordLabel.placeholder = NSLocalizedString(@"Write word", @"");
  
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.MeanLabel resignFirstResponder];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	textView.frame = CGRectMake(textView.frame.origin.x, (textView.frame.origin.y - 50.0), textView.frame.size.width, (textView.frame.size.height-160));
   self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [UIView commitAnimations];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	textView.frame = CGRectMake(textView.frame.origin.x, (textView.frame.origin.y + 50.0), textView.frame.size.width, (textView.frame.size.height +160));
	[UIView commitAnimations];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

-(void)save {
    
  
    if (![self.WordLabel.text isEqualToString:word]) {
        
    
    BOOL flag = NO;
    for (NSString *element in [dict allKeys]) {
        if ([element isEqualToString:self.WordLabel.text]) {
            flag = YES;
        }
    }
    
    if ([self.WordLabel.text isEqualToString:@""]) {
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You do not write word", @"")  message:NSLocalizedString(@"Write word", @"") delegate:nil
                                            cancelButtonTitle:@"OK"  otherButtonTitles:nil];
        
        mes.delegate = self;
        [mes show];
    } else {
        if (flag==YES) {
            UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"This word was in dictionary", @"")
                                                          message:NSLocalizedString(@"Write other word", @"")
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                
                                                otherButtonTitles:nil];
            mes.delegate = self;
            [mes show];
        } else {
            [dict removeObjectForKey:word];
            [dict setObject:self.MeanLabel.text forKey:self.WordLabel.text];
            [self.Do editWordWithMean:dict];
            [self.Do closesearch];        }
    }
    
    } else {
        [dict removeObjectForKey:word];
        [dict setObject:self.MeanLabel.text forKey:self.WordLabel.text];
        [self.Do editWordWithMean:dict];
        [self.Do closesearch];
        
    }
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
