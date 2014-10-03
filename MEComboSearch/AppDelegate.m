//
//  AppDelegate.m
//  MEComboSearch
//
//  Created by Andrey M on 04.10.14.
//  Copyright (c) 2014 Andrey M. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.foundItems = [[NSMutableArray alloc] init];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)searchItems:(id)sender {
    [self.progressIndicator startAnimation:sender];
    
    NSDictionary *params = @{@"units": @"metric", @"q": self.searchField.stringValue};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.openweathermap.org/data/2.5/find" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        [self.foundItems removeAllObjects];
        [[self.arrayController mutableArrayValueForKey:@"content"] removeAllObjects];
        
        for (NSDictionary *foundItem in [responseObject objectForKey:@"list"])
        {
            NSDictionary *item = @{
                @"name": [foundItem objectForKey:@"name"],
                @"temp": [NSString stringWithFormat:@"%@˚", [[foundItem objectForKey:@"main"] valueForKey:@"temp"]],
                @"description": [[[foundItem objectForKey:@"weather"] valueForKey:@"description"] objectAtIndex:0],
                @"country_image_url": [[NSString stringWithFormat:@"http://openweathermap.org/images/flags/%@.png",  [[foundItem objectForKey:@"sys"] valueForKey:@"country"]] lowercaseString]
            };
//            [self.foundItems addObject:item];
            [self.arrayController addObject:item];

//            NSLog(@"Found: %@", item);
        }
        
        NSLog(@"Found: %@", self.foundItems);
        
        
        
//        [self.arrayController addObjects:self.foundItems];
//        [self.foundItemsView reloadData];
        
        [self.progressIndicator stopAnimation:sender];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self.progressIndicator stopAnimation:sender];
    }];

}
@end
