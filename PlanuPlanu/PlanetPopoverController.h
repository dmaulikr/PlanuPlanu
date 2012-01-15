//
//  PlanetPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface PlanetPopoverController : NSViewController <NSPopoverDelegate>
{
    NSTextField* planetName;
    NuPlanet* planet;
    NSPopover *child;
    NSTextField* temperature;
}

@property (nonatomic, assign) IBOutlet NSTextField* planetName;
@property (nonatomic, assign) IBOutlet NSTextField* temperature;

@property (nonatomic, retain) NuPlanet* planet;
@property (nonatomic, assign) NSPopover* child;

@property (nonatomic, readonly) NSString* displayNeutronium;
@property (nonatomic, readonly) NSString* displayDuranium;
@property (nonatomic, readonly) NSString* displayTritanium;
@property (nonatomic, readonly) NSString* displayMolybdenum;

@property (nonatomic, readonly) NSString* displayMines;
@property (nonatomic, readonly) NSString* displayFactories;
@property (nonatomic, readonly) NSString* displayDefense;

@property (nonatomic, readonly) NSString* displayClans;
@property (nonatomic, readonly) NSString* displayTemp;

@end
