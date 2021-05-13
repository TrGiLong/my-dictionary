//
//  ChooseWords.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 01.01.14.
//  Copyright (c) 2014 Tran Giang Long. All rights reserved.
//

#import "ChooseWords.h"

@interface ChooseWords ()

@end

@implementation ChooseWords
@synthesize ListWordWithMeaning,listKeyWereChoosen;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return @"";
    } else {
        return @"word";
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroup"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    listKeyWereChoosen =[ [NSMutableArray alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(startText)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else {
  
    return [ListWordWithMeaning count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
        UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        cell.backgroundView = myBackgroundView;
        myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
        cell.textLabel.text= NSLocalizedString(@"Select All", @"");
        cell.textLabel.textColor= [UIColor whiteColor];
        

        return cell;
        
    } else {
    cell.textLabel.text = [[ListWordWithMeaning allKeys]objectAtIndex:indexPath.row];
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
    cell.backgroundView = myBackgroundView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
    cell.textLabel.textColor= [UIColor whiteColor];
    
    return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        NSLog(@"all");
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
            [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
            for (int a = 0; a <[ListWordWithMeaning count]; a++) {
                [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:1]].accessoryType = UITableViewCellAccessoryNone;
                [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:1]].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
                [listKeyWereChoosen removeAllObjects];
            }
        
            
        }else{
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
            for (int a = 0; a <[ListWordWithMeaning count]; a++) {
                [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:1]].accessoryType = UITableViewCellAccessoryCheckmark;
                 [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:1]].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
                listKeyWereChoosen = [[NSMutableArray alloc]initWithArray:[ListWordWithMeaning allKeys]];
            }
        
        }

    }else {
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [listKeyWereChoosen removeObject:[[ListWordWithMeaning allKeys]objectAtIndex:indexPath.row]];
        [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
        
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [listKeyWereChoosen addObject:[[ListWordWithMeaning allKeys]objectAtIndex:indexPath.row]];
        
        [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
     
    }
    }
   
}
 
-(void)startText {
  //  NSLog(@"%@",listKeyWereChoosen );
    if ([listKeyWereChoosen count]== 0) {
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Your does choose words", @"")
                                                      message:NSLocalizedString(@"Please choose as minimun 4 words",@"")
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                            
                                            otherButtonTitles:nil];
        mes.delegate = self;
        [mes show];

        
    } else if ([listKeyWereChoosen count]<4) {
        UIAlertView *mes = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Your  choose words < 4", @"")
                                                      message:NSLocalizedString(@"Please choose as minimun 4 words",@"")
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                            
                                            otherButtonTitles:nil];
        mes.delegate = self;
        [mes show];
    }else{
    
    
    NSMutableDictionary *processChoose = [[NSMutableDictionary alloc]init];
    [processChoose addEntriesFromDictionary:[ListWordWithMeaning dictionaryWithValuesForKeys:listKeyWereChoosen]];
    
    ModeTest *Test = [[ModeTest alloc] initWithNibName:@"ModeTest" bundle:nil];
    Test.listWordsWiithMeaning = [NSDictionary dictionaryWithDictionary:processChoose];
  
  
     [self.navigationController pushViewController:Test animated:YES];
}
}

@end
