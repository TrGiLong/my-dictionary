//
//  MyCell.h
//  Mydictionaries
//
//  Created by Tran Giang Long on 27.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Buttondetail;

@property (nonatomic, weak) IBOutlet UILabel *catelogLabel;
@property (weak, nonatomic) IBOutlet UILabel *Count;
@property (nonatomic, weak) IBOutlet UIImageView *ImageLabel;
@end
