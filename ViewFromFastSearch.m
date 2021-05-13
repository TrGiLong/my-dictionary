//
//  ViewFromFastSearch.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 29.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "ViewFromFastSearch.h"

@interface ViewFromFastSearch ()

@end

@implementation ViewFromFastSearch

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
    self.MeanLabel.editable =NO;
       [super viewDidLoad];
    self.wordLabel.text = _word;
    self.MeanLabel.text = _mean;
  //  self.title = _word;
    self.MeanLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"6"]];
      self.view.backgroundColor =[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    // Do any additional setup after loading the view from its nib.
    [self.wordLabel setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
