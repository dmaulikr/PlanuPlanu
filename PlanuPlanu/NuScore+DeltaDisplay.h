//
//  NuScore+DeltaDisplay.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 2/29/12.
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

#import "NuScore.h"
#import <PlanuKit/PlanuKit.h>

@interface NuScore (DeltaDisplay)

- (NSString*)playerAndRaceName;
- (NSString*)planetsDelta;
- (NSString*)shipsDelta;
- (NSString*)starbasesDelta;
- (NSInteger)allShips;
- (NSString*)capitalShipsDelta;
- (NSString*)freightersDelta;

@end
