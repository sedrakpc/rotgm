//
//  StopViewController.h
//  Citybus
//
//  Created by Sedrak Dalaloyan on 6/21/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtRoute.h"
#import "MBProgressHUD.h"

@interface StopViewController : UIViewController {
        MBProgressHUD *HUD;
        NSArray *contentList;
}
@property (weak, nonatomic) IBOutlet UITableView *stopTableView;
    @property (nonatomic, retain) RtRoute *route;
@end
