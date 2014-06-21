//
//  DirectionViewController.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 5/10/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtRoute.h"

@interface DirectionViewController : UIViewController
{
    NSArray *contentList;
}
@property (nonatomic, retain) RtRoute *route;
@property (weak, nonatomic) IBOutlet UITableView *directionTableView;
@end
