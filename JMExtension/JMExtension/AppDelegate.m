//
//  AppDelegate.m
//  JMExtension
//
//  Created by 山神 on 2019/2/21.
//  Copyright © 2019 山神. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSArray *test = @[@1, @2 , @3];
    NSLog(@"%@", test[1000]);
    NSLog(@"%@", [test objectAtIndexedSubscript:100]);

   NSMutableArray *tset2 = [NSMutableArray arrayWithObject:nil];
    [[NSArray alloc] initWithObjects:@"qq" count:1];

    return YES;
}



@end
