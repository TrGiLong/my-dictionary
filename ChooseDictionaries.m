//
//  ChooseDictionaries.m
//  Mydictionaries
//
//  Created by SYSTEM on 31.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "ChooseDictionaries.h"
#import "ChooseWords.h"
@interface ChooseDictionaries ()

@end

@implementation ChooseDictionaries
-(void)loadAllDictionary{
    
    ListDictionaries =[ [NSMutableArray alloc]init];
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [[NSString alloc] init];
    NSString *file;
    
    while ((file = [dirEnum nextObject])) {
        if ([[file pathExtension] isEqualToString: @"Mydictionary"]) {
            [ListDictionaries addObject:file];
        }
    }
  
        
    
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)refrest {
    NSLog(@"refrest");
    
    [self.refreshControl beginRefreshing];
    [self loadAllDictionary];
    [self.tableView reloadData];
    listDictionariesHaveChoosen = [[NSMutableArray alloc]init];
    [self.refreshControl endRefreshing];
}
- (void)viewDidLoad
{
      self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //  self.tableView.backgroundView.layer.zPosition -= 1;
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    
    
    [self.refreshControl setTintColor:[UIColor redColor]];
    [refresh addTarget:self action:@selector(refrest) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(nextPage)];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    [barButton setImage:[UIImage imageNamed:@"menu"]];
    [self.navigationItem setLeftBarButtonItem:barButton];
    
    
     self.refreshControl = refresh;
    [super viewDidLoad];
    ListDictionaries = [[NSMutableArray alloc]init];
    listDictionariesHaveChoosen = [[NSMutableArray alloc]init];
    self.title =@"";
     [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self loadAllDictionary];
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroup"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    self.tableView.backgroundView.layer.zPosition -= 1;
    
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navation bar withoutLogo" ]  forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextPage{
    ChooseWords *TochooseWOrd = [[ChooseWords alloc] initWithNibName:@"ChooseWords" bundle:nil];
    NSMutableDictionary *listWordWithMeaning =[[NSMutableDictionary alloc]init];
    for (NSString *dictionary in listDictionariesHaveChoosen) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory, dictionary];
        NSMutableDictionary *timeAllword = [[NSMutableDictionary alloc]init];
        timeAllword = [NSMutableDictionary dictionaryWithContentsOfFile:Filename];
        [listWordWithMeaning addEntriesFromDictionary:timeAllword];
    }
    TochooseWOrd.ListWordWithMeaning= [NSMutableDictionary dictionaryWithDictionary:listWordWithMeaning];

    [self.navigationController pushViewController:TochooseWOrd animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [ListDictionaries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    cell.textLabel.text= [[ListDictionaries objectAtIndex:indexPath.row] stringByDeletingPathExtension];
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
    cell.backgroundView = myBackgroundView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor= [UIColor whiteColor];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [listDictionariesHaveChoosen removeObject:[ListDictionaries objectAtIndex:indexPath.row]];
         [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
      
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [listDictionariesHaveChoosen addObject:[ListDictionaries objectAtIndex:indexPath.row]];
          [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];

    }
  
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
