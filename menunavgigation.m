//
//  menunavgigation.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 27.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "menunavgigation.h"

@interface menunavgigation () {
    NSArray *catalog;
    NSArray *image;
}

@end

@implementation menunavgigation

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
   [[self table]setDelegate:self];
   [[self table]setDataSource:self ];
    catalog = [NSArray arrayWithObjects:@"Search",@"My Dictionaries",@"About",nil];
    image = [NSArray arrayWithObjects:@"search",@"My Dictionary",@"Help", nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [catalog count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Cell";
    MyCell *cell= (MyCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.catelogLabel.text = [catalog objectAtIndex:indexPath.row];
    cell.ImageLabel.image = [UIImage imageNamed:[image objectAtIndex:indexPath.row]];
    cell.backgroundColor = [  UIColor colorWithRed:0 green:0 blue:0 alpha:0  ];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
