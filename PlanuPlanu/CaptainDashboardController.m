//
//  CaptainDashboardController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "CaptainDashboardController.h"
#import "Preferences.h"
#import "StarMapController.h"
#import "JSONKit.h"

@implementation CaptainDashboardController

@synthesize loginMessage, gameList, games, progress;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:kPrefAutoLogin] == YES)
    {
        NSString* apiKey =  [defaults stringForKey:kPrefApiKey];
        loginMessage.stringValue = apiKey;
    }
    
    NuGameListRequest* glr = [[NuGameListRequest alloc] init];
    
    NSString* username = [defaults stringForKey:kPrefUsername];
    
    if (username != nil)
    {
        [glr requestGamesFor:username withDelegate:self];
    }
}
 
- (void)requestsSucceededWith:(NSArray*) Games
{
    self.games = Games;
    [gameList reloadData];
}

- (void)requestFailedWith:(NSString*) Reason
{
    loginMessage.stringValue = [NSString stringWithFormat:@"%@", Reason];
    self.games = [NuGame allGames];
    [gameList reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (games == nil)
    {
        return 0;
    }
    
    return [games count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    NuGame* ng = [games objectAtIndex:rowIndex];
    
    if ([aTableColumn.identifier isEqualToString:@"gameid"])
    {
        return [NSString stringWithFormat:@"%d", ng.gameId];
    }
    else
    {
        return ng.name;
    }
}


- (void)loadGame:(id)sender
{
    NSInteger sRow = gameList.selectedRow;
    
    if (sRow < 0)
    {
        return;
    }
    
    NuGame* game = [games objectAtIndex:sRow];
    
    NuTurnRequest* tr = [[NuTurnRequest alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *apiKey = [defaults stringForKey:kPrefApiKey];
    
    [progress startAnimation:self];
    [progress setHidden:NO];
    
//    [tr requestTurnFor:game.gameId With:apiKey andDelegate:self];
    [tr updateAllTurnsForGame:game
                      withKey:apiKey
                  andDelegate:self];
}

- (void)loadFile:(id)sender
{
    NSOpenPanel* importJson = [NSOpenPanel openPanel];
    
    importJson.canChooseFiles = YES;
    importJson.canChooseDirectories = NO;
    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    if ( [importJson runModal] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSArray* files = [importJson filenames];
        
        // Loop through all the files and process them.
        for(int i = 0; i < [files count]; i++ )
        {
            NSString* fileName = [files objectAtIndex:i];
            
            NSString* response = [NSString stringWithContentsOfFile:fileName encoding:NSASCIIStringEncoding error:nil];
            
            // Do something with the filename.
            NuTurn* trn = nil;
            
            id decodedJson = [response objectFromJSONString];
            
            // TODO: load this from somewhere
            NSManagedObjectContext* context = nil;
            
            if ([decodedJson isKindOfClass:[NSDictionary class]] == YES)
            {
                trn = [NuTurn turnFromJson:decodedJson
                               withContext:context];
                  
                [self turnRequestSucceededWith:trn];
            }
        }
    }

}

- (void)turnRequestSucceededWith:(NuTurn*) turn
{
    StarMapController* smc = [[StarMapController alloc] initWithWindowNibName:@"StarMap"];
    smc.turn = turn;
    
    [progress stopAnimation:self];
    [progress setHidden:YES];
  
    [smc showWindow:self];
}

- (void)turnRequestFailedWith:(NSString*) Reason
{
    [progress stopAnimation:self];
    [progress setHidden:YES];
    
    NSAlert* alert = [[NSAlert alloc] init];
    alert.messageText = [NSString stringWithFormat:@"%@\nUsing cached data", Reason];
    [alert runModal];
    [alert release];
    
    StarMapController* smc = [[StarMapController alloc] initWithWindowNibName:@"StarMap"];
    NSInteger sRow = gameList.selectedRow;
    
    if (sRow < 0)
    {
        return;
    }
    
    NuGame* game = [games objectAtIndex:sRow];
    
    NuTurn* turn = nil;
    for (NuTurn* t in game.turns)
    {
        if (turn == nil)
        {
            turn = t;
        }
        else
        {
            if (turn.settings.turnNumber < t.settings.turnNumber)
            {
                turn = t;
            }
        }
    }
    
    smc.turn = turn;
    [smc showWindow:self];

}

@end
