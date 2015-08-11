//
//  TableViewController.m
//  omg
//
//  Created by yasin aktimur on 11.08.2015.
//  Copyright (c) 2015 yasin aktimur. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()


@property NSMutableArray *arr;

@end

@implementation TableViewController

@synthesize arr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arr = [[NSMutableArray alloc] initWithArray:@[@"google",@"facebook",@"twitter",@"soundweet",@"pinterest"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [arr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"programmaticCell";
    MGSwipeTableCell * cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = @"Detail text";
    cell.delegate = self; //optional
    
    
 

    
    
    
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor]],
                          
                          [MGSwipeButton buttonWithTitle:@"More" backgroundColor:[UIColor lightGrayColor]]];
    
    
    cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    //cell.leftSwipeSettings.keepButtonsSwiped = NO;
    
    

    return cell;
}






-(void) swipeTableCell:(MGSwipeTableCell*) cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive
{
    NSString * str;
    switch (state) {
        case MGSwipeStateNone: str = @"None"; break;
        case MGSwipeStateSwippingLeftToRight: str = @"SwippingLeftToRight"; break;
        case MGSwipeStateSwippingRightToLeft: str = @"SwippingRightToLeft"; break;
        case MGSwipeStateExpandingLeftToRight: str = @"ExpandingLeftToRight"; break;
        case MGSwipeStateExpandingRightToLeft: str = @"ExpandingRightToLeft"; break;
    }
    
    //NSLog(@"Swipe state: %@ ::: Gesture: %@", str, gestureIsActive ? @"Active" : @"Ended");
}


-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}



-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
  
    
    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [self.tableView indexPathForCell:cell];
        [arr removeObjectAtIndex:path.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    }else if(direction == MGSwipeDirectionRightToLeft && index == 1) {
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
        NSLog(@"%li", (long)path.row);
    
    
    
    }
    
    return YES;
}



-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    swipeSettings.transition = MGSwipeTransitionClipCenter;
    swipeSettings.keepButtonsSwiped = NO;
    expansionSettings.buttonIndex = 0;
    expansionSettings.threshold = 1.0;
    expansionSettings.expansionLayout = MGSwipeExpansionLayoutCenter;
    expansionSettings.expansionColor = [UIColor colorWithRed:33/255.0 green:175/255.0 blue:67/255.0 alpha:1.0];
    expansionSettings.triggerAnimation.easingFunction = MGSwipeEasingFunctionCubicOut;
    expansionSettings.fillOnTrigger = NO;
    
 
    //__weak TableViewController * me = self;
    
    UIColor * color = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:49/255.0 alpha:1.0];
    UIFont * font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    if (direction == MGSwipeDirectionLeftToRight) {
        
        
        MGSwipeButton * queueButton = [MGSwipeButton buttonWithTitle:@"Resweet" backgroundColor:color padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            
            NSLog(@"%@", [self.tableView indexPathForCell:sender]);
            
            return YES;
        }];
        
        
        queueButton.titleLabel.font = font;
        
        return @[queueButton];
    }



    return nil;

}









@end
