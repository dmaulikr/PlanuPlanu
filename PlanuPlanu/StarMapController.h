//
//  StarMapController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>
#import "StarMapView.h"
#import "NuColorScheme.h"
#import "MapMuxPopoverController.h"

@interface StarMapController : NSWindowController <NSTabViewDelegate, NSTableViewDataSource, StarMapViewDelegate>
{
    NuTurn* turn;
    NSScrollView* mapScroll;
    StarMapView* starMap;
    
    NSButton* planetToolBarButton;
    NSButton* shipToolBarButton;
    NSButton* stormToolBarButton;
    NSButton* connectionToolBarButton;
    NSButton* visibilityToolBarButton;
    
    // Color Scheme Selection
    NSWindow* colorSchemeWindow;
    NSTableView* colorSchemeTableView;
    NSPopUpButton* loadScheme;
    NSArray* colorSchemes;
    NuColorScheme* activeScheme;
    
    NSPopover* muxPopover;
    MapMuxPopoverController* mmpc;
    
    
}

@property (nonatomic, retain) NuTurn* turn;

@property (assign) IBOutlet NSScrollView* mapScroll;
@property (assign) IBOutlet NSButton* planetToolBarButton;
@property (assign) IBOutlet NSButton* shipToolBarButton;
@property (assign) IBOutlet NSButton* stormToolBarButton;
@property (assign) IBOutlet NSButton* connectionToolBarButton;
@property (assign) IBOutlet NSButton* visibilityToolBarButton;

@property (assign) IBOutlet NSWindow* colorSchemeWindow;
@property (assign) IBOutlet NSTableView* colorSchemeTableView;
@property (assign) IBOutlet NSPopUpButton* loadScheme;
@property (nonatomic, retain) NSArray* colorSchemes;
@property (nonatomic, retain) NuColorScheme* activeScheme;

@property (nonatomic, assign) IBOutlet NSPopover* muxPopover;
@property (nonatomic, assign) IBOutlet MapMuxPopoverController* mmpc;

- (void)initStarMapView;
- (void)initToolBar;

- (IBAction)colorToolBarClicked:(id)sender;
- (IBAction)planetToolBarClicked:(id)sender;
- (IBAction)shipToolBarClicked:(id)sender;
- (IBAction)stormToolBarClicked:(id)sender;
- (IBAction)connectionToolBarClicked:(id)sender;
- (IBAction)visibilityToolBarClicked:(id)sender;

- (IBAction)loadColorScheme:(id)sender;
- (void)initColorScheme;

- (IBAction)ppvr:(id)sender;
@end
