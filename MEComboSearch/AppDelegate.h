//
//  AppDelegate.h
//  MEComboSearch
//
//  Created by Andrey M on 04.10.14.
//  Copyright (c) 2014 Andrey M. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AFNetworking.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource> {
    NSMutableArray *_foundItems;
}

@property NSMutableArray *foundItems;
@property (weak) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSTableView *foundItemsView;

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
- (IBAction)searchItems:(id)sender;

@end

