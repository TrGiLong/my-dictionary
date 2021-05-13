//
//  ManagerDictionaries.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 26.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "ManagerDictionaries.h"
#import "MyCell.h"
@interface ManagerDictionaries ()
@property(nonatomic,strong) createDic *createDictionary2;
@end

@implementation ManagerDictionaries

@synthesize ListDictionaries,createDictionary2,patchTimeOpen;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationWithLogo" ]  forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor =[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroup"]];
    

    [self showfileWithMydictionary];
    [super viewDidLoad];
    [[self tableOfDictionaries]setDelegate:self];
    [[self tableOfDictionaries]setDataSource:self ];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}
-(void)Add{
    createDictionary2 = [[createDic alloc]initWithNibName:@"createDic" bundle:nil];
    createDictionary2.Do =self;
    createDictionary2.Test = [NSArray arrayWithArray:ListDictionaries];
    createDictionary2.mode = 1;
    createDictionary2.listDict = [NSArray arrayWithArray:ListDictionaries];
    UINavigationController *navcontroler = [[UINavigationController alloc]initWithRootViewController:createDictionary2];
    
    [self presentViewController:navcontroler animated:YES completion:nil];
}

-(void)cancel {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [ListDictionaries count];
}

-(void)createDic:(NSString *)Name{
    NSLog(@"!!!!");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@.Mydictionary" ,documentsDirectory,Name];
    NSMutableDictionary *test = [[NSMutableDictionary alloc]init];
    [test writeToFile:Filename atomically:YES];
    [self showfileWithMydictionary];
    [self.tableOfDictionaries reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];  //set bacgrooup color
    cell.textLabel.text = [ListDictionaries objectAtIndex:indexPath.row];
    return cell;
     */
    
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

  //cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow icon view detail"]];
  //  cell.accessoryType =   UITableViewCellAccessoryDetailButton;
 //   cell.accessoryView = cell.accessoryType;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0,40, 40);
   button.frame = frame;   // match the button's size with the image size
    [button setBackgroundImage:[UIImage imageNamed:@"arrow icon view detail"] forState:UIControlStateNormal];
    // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
    
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell"]];
    cell.backgroundView = myBackgroundView;
    
    return cell;
    
    
    
}


- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableOfDictionaries];
    NSIndexPath *indexPath = [self.tableOfDictionaries indexPathForRowAtPoint: currentTouchPosition];
    NSLog(@"%@",indexPath);
    
    
    createDictionary2 = [[createDic alloc]initWithNibName:@"createDic" bundle:nil];
    createDictionary2.Do =self;
    createDictionary2.Test = [NSArray arrayWithArray:ListDictionaries];
    createDictionary2.mode = 2;
    createDictionary2.nameDictCurrent = [ListDictionaries objectAtIndex:indexPath.row];
    createDictionary2.listDict = [NSArray arrayWithArray:ListDictionaries];
    UINavigationController *navcontroler = [[UINavigationController alloc]initWithRootViewController:createDictionary2];
    
    [self presentViewController:navcontroler animated:YES completion:nil];

}


-(NSInteger)countWord:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    NSDictionary *timeDict = [NSDictionary dictionaryWithContentsOfFile:Filename];
    
    return [timeDict count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.Do loadDictionaryfile:[ListDictionaries objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[ListDictionaries objectAtIndex:indexPath.row]];
    
    [[NSFileManager defaultManager] removeItemAtPath: Filename error: nil];
    [self showfileWithMydictionary];
    if ([Filename isEqualToString:patchTimeOpen]) {
        [self.Do deleteDictionary];
    }
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeDic:(NSString *)OldName:(NSString *)NewName{
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,OldName];

   
    
    
    NSDictionary *timeDict =[NSDictionary dictionaryWithContentsOfFile:Filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:Filename error:NULL];

   Filename = [NSString stringWithFormat:@"%@/%@", documentsDirectory,NewName];
 
    [timeDict writeToFile:Filename atomically:YES];
    
    [self.Do changeDictionary:Filename];
    
    [self showfileWithMydictionary];
    [self.tableOfDictionaries reloadData];
}

@end
