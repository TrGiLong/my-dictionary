//
//  FashSearch.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 28.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "FashSearch.h"
#import "SWRevealViewController.h"
@interface FashSearch ()

@end

@implementation FashSearch
@synthesize AllDict,ListDictionaries;
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
     [self.refreshControl endRefreshing];
}
- (void)viewDidLoad
{
   //  self.tableView.backgroundView.layer.zPosition -= 1;
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    
    
    [self.refreshControl setTintColor:[UIColor redColor]];
    [refresh addTarget:self action:@selector(refrest)
     
      forControlEvents:UIControlEventValueChanged];
    
    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);

    
    self.refreshControl = refresh;

    [super viewDidLoad];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self loadAllDictionary];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroup"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationWithLogo" ]  forBarMetrics:UIBarMetricsDefault];
   self.title= @"";
    self.fastSearch.delegate= self;
    self.tableView.backgroundView.layer.zPosition -= 1;
    self.fastSearch.placeholder = NSLocalizedString(@"Search", @"");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length ==0) {
        searchBarIsTurning = NO;
    }
    else {
        
        searchBarIsTurning = YES;
        DictionaryWithSearch =[[NSMutableDictionary alloc]init];
        
        for (StringInfindBar in [AllDict allKeys]) {    //find Words and Means
            alc =[StringInfindBar rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (alc.location != NSNotFound) {
                [  DictionaryWithSearch setObject:[AllDict objectForKey:StringInfindBar] forKey:StringInfindBar];
                keyWorldSearch = [NSMutableArray arrayWithArray:[DictionaryWithSearch allKeys]];
                NSLog(@"ok");
            }
            
        }
        
    }
    
    [self.tableView reloadData];
    
    
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

    // Return the number of rows in the section.
    if (searchBarIsTurning == NO) {
        
    
    return 0;
    } else {
        return [DictionaryWithSearch count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (searchBarIsTurning == YES) {
        cell.textLabel.text = [keyWorldSearch objectAtIndex:indexPath.row];
    }
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
    cell.backgroundView = myBackgroundView;
    cell.textLabel.textColor =[ UIColor whiteColor];
    return cell;
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


-(void)loadAllDictionary{
    AllDict = [[NSMutableDictionary alloc]init];
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
    for (int a=0;a<[ListDictionaries count] ; a++) {
        NSMutableDictionary *timeDic = [[NSMutableDictionary alloc]init];
        Filename = [NSString stringWithFormat:@"%@/%@",documentsDirectory,[ListDictionaries objectAtIndex:a ]];
        timeDic = [NSDictionary dictionaryWithContentsOfFile:Filename];
        [AllDict addEntriesFromDictionary:timeDic];
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewFromFastSearch *ToviewWord = [[ViewFromFastSearch alloc] initWithNibName:@"ViewWordAndMean" bundle:nil];
//    ToviewWord.Do = self;  //protocol
    ToviewWord.word = [keyWorldSearch objectAtIndex:indexPath.row];
    ToviewWord.mean = [AllDict objectForKey:[keyWorldSearch objectAtIndex:indexPath.row]];
  //  ToviewWord.dict = [NSMutableDictionary dictionaryWithDictionary:Dict];
    [self.navigationController pushViewController:ToviewWord animated:YES];
}
@end
