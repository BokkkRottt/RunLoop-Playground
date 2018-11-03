//
//  NSObject+NewMethod.h
//  RunLoop
//
//  Created by Huxley on 2018/10/31.
//  Copyright © 2018 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NewMethod)

/**
 取消对此对象的所以对aSelector的延迟执行，无视其参数。
 @note 此方法不是线程安全的
 @param aSelector 目标方法
 */
- (void)cancelPreviousPerformRequestsWithSelector:(SEL)aSelector;

@end
