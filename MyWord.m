//
//  MyWord.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 26.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "MyWord.h"
#import "SWRevealViewController.h"

@interface MyWord () {
    NSMutableArray *ListDictionaries;
}
@property(nonatomic,strong) AddWordWithMean *ViewAddWord;
@property(nonatomic,strong) ManagerDictionaries *loadDictionary;
@property(nonatomic,strong) CopyOrMove *CopyMOv;
//@property(nonatomic,strong) ViewWordAndMean *viewWord;
@end

@implementation MyWord
@synthesize Dict,ViewAddWord,loadDictionary,fileNameGlobal,KeyWords,MoveAndCopy,CopyMOv;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (searchBarIsTurning ==NO) {
        NSArray *timeArray = [[NSArray alloc]initWithArray:[sectionWithKeyWord allKeys]];
        timeArray = [NSArray arrayWithArray:[timeArray sortedArrayUsingSelector:@selector(compare:)]];
    
    return [timeArray objectAtIndex:section];
    } else {
        return nil;
    }
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,60)];

    return customView;
} */
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *time = [[NSMutableArray alloc]initWithArray:[sectionWithKeyWord allKeys]];
    
    time =[NSArray arrayWithArray:[time sortedArrayUsingSelector:@selector(compare:)]];
    return time;
}
-(void)LoadFirtthCharacter{
    alfavit = [[NSMutableArray alloc]init];
    
    sectionWithKeyWord = [[NSMutableDictionary alloc]init];
    NSMutableArray *timeArray = [[NSMutableArray alloc]initWithArray:[Dict allKeys]];
    [timeArray sortUsingSelector:@selector(compare:)];
    for (NSString *word in timeArray) {
        
        
        [alfavit addObject:[[word substringWithRange:NSMakeRange(0, 1)] uppercaseString]];
       
        
    }
    for (NSString *go in alfavit) {
         NSMutableArray *timeWordWillTOSetObject = [[NSMutableArray alloc]init];
        for (NSString *go2 in timeArray) {
            if ([go2 length] ==0) {
                
            } else {
            if ([ [[go2 substringWithRange:NSMakeRange(0, 1)]uppercaseString] isEqualToString:[go uppercaseString]]) {
                [timeWordWillTOSetObject addObject:go2];
                [sectionWithKeyWord setObject:timeWordWillTOSetObject forKeyedSubscript:go];
                NSLog(@"%@----",go2);
                
            }
        }
    }
    }
   
}

-(void)Hello {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/My Dictionary.Mydictionary", documentsDirectory];
    NSMutableDictionary *test = [[NSMutableDictionary alloc]init];
    
    [test writeToFile:Filename atomically:YES];
    Dict = [[NSMutableDictionary alloc]initWithDictionary:test];
    NSString *tit =[NSString stringWithString:Filename];
    tit= [NSString stringWithFormat:@"%@",[tit lastPathComponent]];
    tit= [NSString stringWithFormat:@"%@",[tit stringByDeletingPathExtension]];
    fileNameGlobal = Filename;
    self.title = tit;
    [self LoadfitthWithMydictionary];
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"My Dictionary.Mydictionary" forKey:@"last open dictionary"];
    [userDefaults synchronize];
}

-(void)LoadfitthWithMydictionary {
    
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
-(void)loadgesture {
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
   // [refresh addTarget:self
   //             action:@selector(refreshView:)
   //   forControlEvents:UIControlEventValueChanged];
   // self.refreshControl = refresh;
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}
-(BOOL)readDataFromFile:(NSString *)fileName {
//    NSString *bundlePathofPlist = [[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"];
    Dict =[[NSMutableDictionary alloc]init];
    Dict= [NSDictionary dictionaryWithContentsOfFile:fileName];
    KeyWords = [NSMutableArray arrayWithArray:[Dict allKeys]];
    return YES;
}

- (void)loadDictionaryfile:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileName];
   
    fileNameGlobal = [NSString stringWithString:Filename];
    Dict =[[NSMutableDictionary alloc]init];
    Dict= [NSDictionary dictionaryWithContentsOfFile:Filename];
    KeyWords = [[NSMutableArray alloc]init];
    KeyWords = [NSMutableArray arrayWithArray:[Dict allKeys]];
    [self LoadFirtthCharacter];
    [self.table reloadData];
    NSString *tit =[NSString stringWithString:Filename];
    tit= [NSString stringWithFormat:@"%@",[tit lastPathComponent]];
    tit= [NSString stringWithFormat:@"%@",[tit stringByDeletingPathExtension]];
    
     self.title = tit;
   
    [self clickedResetButton];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:fileName forKey:@"last open dictionary"];
   
    [userDefaults synchronize];
}

- (void)viewDidLoad
{
 
    ListDictionaries = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.459 blue:0.067 alpha:1]};
     searchBarIsTurning =NO;
    /*
	Firth= [self readDataFromFile:@"MyDictionary"];
    [
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *filename = [NSString stringWithFormat:@"%@/test.Mydictionary", documentsDirectory];
    fileNameGlobal = [[NSString alloc]initWithString:filename];
    NSLog(@"%@",filename);
    [self readDataFromFile:filename];  */
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
  
   [self LoadfitthWithMydictionary];
    

    [self loadgesture];
        NSLog(@"*(*(*(*(*(*(");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([ListDictionaries count]== 0) {
        [self Hello];
    }
     NSLog(@"suscessful");
    NSString  *filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[userDefaults objectForKey:@"last open dictionary"]];
    fileNameGlobal = [[NSString alloc]initWithString:filename];
 
    [self readDataFromFile:filename];

    [[self table]setDelegate:self];
    [[self table]setDataSource:self ];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(callViewofCreateWord)];
  // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button add"] style:UIBarButtonItemStylePlain target:self action:@selector(callViewofCreateWord)];
  //  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
    
    
    
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(ManagerDictionary)];
    EditMode = NO;
    SelectMode= NO;
    KeyWords = [[NSMutableArray alloc]init];
    KeyWords =[[NSMutableArray alloc] initWithArray:[Dict allKeys]];
    
    MoveAndCopy = [[NSMutableDictionary alloc]init];
    self.title = [[fileNameGlobal lastPathComponent] stringByDeletingPathExtension];
    UIImage *image = [UIImage imageNamed:@"Tool Bar" ];
    [[self toolbar]setDelegate:self];
  [[UIToolbar appearance] setBackgroundImage:image forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
   // [UIToolbar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navation bar withoutLogo" ]  forBarMetrics:UIBarMetricsDefault];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroup"]];
    [tempImageView setFrame:self.table.frame];
    self.table.backgroundView = tempImageView;
    self.searchBar.delegate = self;
    [self LoadFirtthCharacter];
  //  [self.table setSectionIndexBackgroundColor:[UIColor whiteColor]];
  
   self.searchBar.placeholder = NSLocalizedString(@"Search", @"");
   
}


-(void)ManagerDictionary {
    loadDictionary = [[ManagerDictionaries alloc]initWithNibName:@"ManagerDictionaries" bundle:nil];
    loadDictionary.Do =self;
    loadDictionary.patchTimeOpen = fileNameGlobal;
    UINavigationController *navcontroler = [[UINavigationController alloc]initWithRootViewController:loadDictionary];
    [self presentViewController:navcontroler animated:YES completion:nil];
}


-(void)callViewofCreateWord {
    ViewAddWord = [[AddWordWithMean alloc] initWithNibName:@"AddWordWithMean" bundle:nil];
    ViewAddWord.Do= self;
    ViewAddWord.listWord = [NSArray arrayWithArray:[Dict allKeys]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController :ViewAddWord];
   
    
    [self presentViewController:navController animated:YES completion:nil];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (searchBarIsTurning == NO) {
    
    return [[sectionWithKeyWord allKeys]count];
        
    } else {
        return 1;
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchBarIsTurning == NO) {
        NSArray *timeKey = [sectionWithKeyWord allKeys];
    timeKey = [NSArray arrayWithArray:[timeKey sortedArrayUsingSelector:@selector(compare:)]];
    NSArray *word = [sectionWithKeyWord objectForKey:[timeKey objectAtIndex:section]];
       
        return [word count];
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
    if (searchBarIsTurning == NO) {
        
        NSArray *TIMEArray = [[NSArray alloc]initWithArray:[sectionWithKeyWord allKeys]];
    TIMEArray = [NSArray arrayWithArray:[TIMEArray sortedArrayUsingSelector:@selector(compare:)]];
       
        NSString *key= [TIMEArray objectAtIndex:indexPath.section];
     
        NSArray *timeArray =[NSArray arrayWithArray:[sectionWithKeyWord objectForKey:key]];
      
        cell.textLabel.text = [timeArray objectAtIndex:indexPath.row];
        
        
    }else {
       // cell.backgroundColor = [UIColor colorWithRed:64/255.0f green:95/255.0f blue:254/255.0f alpha:1.0f];
        cell.textLabel.text = [keyWorldSearch objectAtIndex:indexPath.row];
    }
    cell.accessoryType =UITableViewCellAccessoryNone;
   cell.accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
    
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
    cell.backgroundView = myBackgroundView;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
 //   cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell"]];
 //  cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
  //  UIColor * color = [UIColor colorWithRed:64/255.0f green:95/255.0f blue:254/255.0f alpha:1.0f];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (searchBarIsTurning ==NO) {
        
    
    if (SelectMode ==NO) {
        
        
    ViewWordAndMean *ToviewWord = [[ViewWordAndMean alloc] initWithNibName:@"ViewWordAndMean" bundle:nil];
    ToviewWord.Do = self;
        NSString *word = [[[sectionWithKeyWord allKeys] sortedArrayUsingSelector:@selector(compare:)]objectAtIndex:indexPath.section];
        NSString *keytime2 = [[sectionWithKeyWord objectForKey:word]objectAtIndex:indexPath.row];
       
        ToviewWord.word = keytime2;
        ToviewWord.mean = [Dict objectForKey:keytime2];
    ToviewWord.dict = [NSMutableDictionary dictionaryWithDictionary:Dict];
    [self.navigationController pushViewController:ToviewWord animated:YES];
        
        
    } else {
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
            NSString *word = [[[sectionWithKeyWord allKeys] sortedArrayUsingSelector:@selector(compare:)]objectAtIndex:indexPath.section];
            NSString *keytime2 = [[sectionWithKeyWord objectForKey:word]objectAtIndex:indexPath.row];
             [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
            [MoveAndCopy removeObjectForKey:keytime2];
        }else{
            NSString *word = [[[sectionWithKeyWord allKeys] sortedArrayUsingSelector:@selector(compare:)]objectAtIndex:indexPath.section];
            NSString *keytime2 = [[sectionWithKeyWord objectForKey:word]objectAtIndex:indexPath.row];
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
             [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
            [MoveAndCopy setObject:[Dict objectForKey:keytime2] forKey:keytime2];
          
        }
        
    } } else {
        if (SelectMode ==NO) {
            ViewWordAndMean *ToviewWord = [[ViewWordAndMean alloc] initWithNibName:@"ViewWordAndMean" bundle:nil];
            ToviewWord.Do = self;
            ToviewWord.word = [keyWorldSearch objectAtIndex:indexPath.row];
            ToviewWord.mean = [Dict objectForKey:[keyWorldSearch objectAtIndex:indexPath.row]];
            ToviewWord.dict = [NSMutableDictionary dictionaryWithDictionary:Dict];
            
            [self.navigationController pushViewController:ToviewWord animated:YES];
            
            
            
        } else {
            if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
                [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
                [MoveAndCopy removeObjectForKey:[KeyWords objectAtIndex:indexPath.row]];
                 [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
            }else{
                [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
                [MoveAndCopy setObject:[Dict objectForKey:[KeyWords objectAtIndex:indexPath.row]] forKey:[KeyWords objectAtIndex:indexPath.row]];
                  [tableView cellForRowAtIndexPath:indexPath].accessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];

    }
   
}
    }
}

-(void)addWord:(NSString *)word:(NSString *)Mean {
    if ( [Dict count]==0) {
        Dict = [NSMutableDictionary dictionaryWithObject:Mean forKey:word];
                }else {
    [Dict setObject:Mean forKey:word];
                }
  
    KeyWords = [[NSMutableArray alloc] initWithArray:[Dict allKeys]];
    [self LoadFirtthCharacter];
    [self.table reloadData];
  
    [Dict writeToFile:fileNameGlobal atomically:YES];
}

-(void)firthLoad {
    
}


- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    NSString *word = [[[sectionWithKeyWord allKeys] sortedArrayUsingSelector:@selector(compare:)]objectAtIndex:indexPath.section];
    NSString *keytime2 = [[sectionWithKeyWord objectForKey:word]objectAtIndex:indexPath.row];

    [Dict removeObjectForKey:keytime2];
   // [KeyWords removeObjectAtIndex:indexPath.row];
    [Dict writeToFile:fileNameGlobal atomically:YES];
   
    [self readDataFromFile:fileNameGlobal];
    [self LoadFirtthCharacter];
  
  //  [tableView deleteSections:[NSIndexSet indexSetWithIndex: indexPath.section]  withRowAnimation:UITableViewRowAnimationFade];
  // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.table reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];


}

- (IBAction)Edit:(id)sender {
    if (EditMode == NO) {
        
   
        EditMode =YES;
    [self.table setEditing:YES animated:YES];
    self.EditAndCancel.title = @"cancel";
    } else {
        EditMode =NO;
        [self.table setEditing:NO animated:YES];
        self.EditAndCancel.title = @"Edit";
    }
}


- (IBAction)SelectMode:(id)sender {
    if (SelectMode ==NO) {
        SelectMode=YES;
        [self.selectmodeSelectOn setImage:[UIImage imageNamed:@"select mode on"]];
    } else {
        SelectMode= NO;
         [self.selectmodeSelectOn setImage:[UIImage imageNamed:@"select"]];
    }
 //   NSLog(@"%hhd",SelectMode); test select mode
}
-(void)deleteDictionary {
    NSLog(@"delete");
    [self Hello];
    [self LoadFirtthCharacter];
    [self.table reloadData];
    
   
}
-(void)editWordWithMean:(NSMutableDictionary *)newdict {
    NSLog(@"work");
    NSLog(@"%@",fileNameGlobal);
    [newdict writeToFile:fileNameGlobal atomically:YES];
    [self readDataFromFile:fileNameGlobal];
 //   KeyWords = [Dict allKeys];
    [self LoadFirtthCharacter];
    [self.table reloadData];
     //     [ self.searchDisplayController setActive:NO];
    
}
- (IBAction)Copy:(id)sender {
    CopyMOv = [[CopyOrMove alloc]initWithNibName:@"CopyOrMove" bundle:nil];
   // loadDictionary.Do =self;
    CopyMOv.modeInteger = 1;
      CopyMOv.MoveAndCopy=[NSMutableDictionary dictionaryWithDictionary:MoveAndCopy];
    UINavigationController *navcontroler = [[UINavigationController alloc]initWithRootViewController:CopyMOv];
    [self presentViewController:navcontroler animated:YES completion:nil];
    
}

- (IBAction)Move:(id)sender {
    CopyMOv = [[CopyOrMove alloc]initWithNibName:@"CopyOrMove" bundle:nil];
    // loadDictionary.Do =self;
    CopyMOv.long2 = self;
    CopyMOv.modeInteger = 2;
    CopyMOv.MoveAndCopy=[NSMutableDictionary dictionaryWithDictionary:MoveAndCopy];
    UINavigationController *navcontroler = [[UINavigationController alloc]initWithRootViewController:CopyMOv];
    [self presentViewController:navcontroler animated:YES completion:nil];
    
}

-(void)deleleAfterMove{
    NSLog(@"delete after move");
    [Dict removeObjectsForKeys:[MoveAndCopy allKeys]];
   // KeyWords = [NSMutableArray arrayWithArray:[Dict allKeys]];
    [Dict writeToFile:fileNameGlobal atomically:YES];
    [self readDataFromFile:fileNameGlobal];
    [self LoadFirtthCharacter];
    MoveAndCopy = [[NSMutableDictionary alloc]init];
    [self.table reloadData];
    
}

- (void)clickedResetButton {
    for (int section = 0, sectionCount = self.table.numberOfSections; section < sectionCount; ++section) {
        for (int row = 0, rowCount = [self.table numberOfRowsInSection:section]; row < rowCount; ++row) {
            UITableViewCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            cell.accessoryType = UITableViewCellAccessoryNone;
           // cell.accessoryView = nill;
        }
    }
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length ==0) {
        searchBarIsTurning = NO;
    }
    else {
        
        searchBarIsTurning = YES;
        DictionaryWithSearch =[[NSMutableDictionary alloc]init];
        NSLog(@"ok");
        for (StringInfindBar in [Dict allKeys]) {    //find Words and Means
            alc =[StringInfindBar rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (alc.location != NSNotFound) {
                [  DictionaryWithSearch setObject:[Dict objectForKey:StringInfindBar] forKey:StringInfindBar];
                keyWorldSearch = [NSMutableArray arrayWithArray:[DictionaryWithSearch allKeys]];
            }
            
        }
        
    }
    
    [self.table reloadData];
    
    
}
-(void)changeDictionary:(NSString *)ISDictionaryWasChanging {
    fileNameGlobal = ISDictionaryWasChanging;
    NSLog(@"------%@",ISDictionaryWasChanging);
     self.title = [[fileNameGlobal lastPathComponent] stringByDeletingPathExtension];
    [self readDataFromFile:ISDictionaryWasChanging];
    [self LoadFirtthCharacter];
    [self.table reloadData];
}

-(void)closesearch{
 //   self.searchBar.hidden = YES;
    searchBarIsTurning =NO;
    [self readDataFromFile:fileNameGlobal];
    [self LoadFirtthCharacter];
    [self.table reloadData];
    NSLog(@"test");
}
@end
