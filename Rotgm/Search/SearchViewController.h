//
//  SearchViewController.h
//  Citybus
//
//  Created by Sedrak Dalaloyan on 2/21/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *contentList;
    NSMutableArray *filteredContentList;
    BOOL isSearching;
}
@property (strong, nonatomic) IBOutlet UITableView *serachTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end
