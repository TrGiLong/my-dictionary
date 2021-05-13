//
//  CopyOrMove.m
//  Mydictionaries
//
//  Created by SYSTEM on 28.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "CopyOrMove.h"
#import "MyCell.h"
@interface CopyOrMove ()

@end

@implementation CopyOrMove
@synthesize ListDictionaries,MoveAndCopy,modeInteger;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)showfileWithMydictionary {
    
    ListDictionaries =[ [NSMutableArray alloc]init];
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
    
    NSString *file;
    while ((file = [dirEnum nextObject])) {
        if ([[file pathExtension] isEqualToString: @"Mydictionary"]) {
            [ListDictionaries addObject:file];
        }
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.459 blue:0.067 alpha:1]};
 [self showfileWithMydictionary];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navation bar withoutLogo" ]  forBarMetrics:UIBarMetricsDefault];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroup"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;

    if (modeInteger ==1) {
        self.title= NSLocalizedString(@"copy", @"");
    } else {
        self.title =NSLocalizedString(@"Move", @"");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [ListDictionaries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyCell";
    
    MyCell *cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier] ;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [  UIColor colorWithRed:0 green:0 blue:0 alpha:0  ];
    cell.Count.text = [NSString stringWithFormat:@"%li words",(long)[self countWord:[ListDictionaries objectAtIndex:indexPath.row]]];
    cell.catelogLabel.text = [[ListDictionaries objectAtIndex:indexPath.row]stringByDeletingPathExtension];
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
    cell.backgroundView = myBackgroundView;
    return cell;
}

-(NSInteger)countWord:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    NSDictionary *timeDict = [NSDictionary dictionaryWithContentsOfFile:Filename];
    
    return [timeDict count];
}
-(void)save {
    [  self.long2  deleleAfterMove ];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[ListDictionaries objectAtIndex:indexPath.row]];
    NSLog(@"%@",Filename);
    if (modeInteger == 1) {
        NSLog(@"Copy begin");
        NSMutableDictionary *timeDict = [NSMutableDictionary dictionaryWithContentsOfFile:Filename];
        NSArray *words = [NSArray arrayWithArray:[MoveAndCopy allKeys]];
        NSArray *mean =[NSArray arrayWithArray:[MoveAndCopy allValues]];
        for (int a= 0; a<[words count]; a++) {
            [timeDict setObject:[mean objectAtIndex:a] forKey:[words objectAtIndex:a]];
        }
        [timeDict writeToFile:Filename atomically:YES];
    }
    if (modeInteger == 2) {
        NSLog(@"Copy begin");
        NSMutableDictionary *timeDict = [NSMutableDictionary dictionaryWithContentsOfFile:Filename];
        NSArray *words = [NSArray arrayWithArray:[MoveAndCopy allKeys]];
        NSArray *mean =[NSArray arrayWithArray:[MoveAndCopy allValues]];
        for (int a= 0; a<[words count]; a++) {
            [timeDict setObject:[mean objectAtIndex:a] forKey:[words objectAtIndex:a]];
        }
        [timeDict writeToFile:Filename atomically:YES];
        [self.long2 deleleAfterMove];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
 


@end
