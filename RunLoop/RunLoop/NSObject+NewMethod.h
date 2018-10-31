//
//  NSObject+NewMethod.h
//  RunLoop
//
//  Created by Huxley on 2018/10/31.
//  Copyright © 2018 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NewMethod)

- (void)cancelPreviousPerformRequestsWithSelector:(SEL)aSelector;

@end
