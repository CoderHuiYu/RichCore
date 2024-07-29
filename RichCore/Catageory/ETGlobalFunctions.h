// Copyright © 2020 Peogoo. All rights reserved.
#import <Foundation/Foundation.h>
#import "NSString+Helper.h"

typedef void(^ActionBlock)(void);
typedef void(^InputBlock)(NSString *input);
typedef void(^InputsBlock)(NSString *input, NSString *msg);
// Helper functions because NSNull is confusing (JSON interprets null objects as NSNull)
static inline BOOL isEmpty(id thing) {
    return thing == nil
        || [thing isKindOfClass:NSNull.class]
        || ([thing respondsToSelector:@selector(length)] && [thing length] == 0) // NSData, NSString
        || ([thing isKindOfClass:NSString.class] && [(NSString *)thing trimmed].length == 0)
        || ([thing respondsToSelector:@selector(count)] && [thing count] == 0)
        || ([thing isKindOfClass:NSNumber.class] && [(NSNumber *)thing doubleValue] == 0)
        || ([thing isKindOfClass:NSDictionary.class] && [(NSDictionary *)thing allKeys].count == 0); // Identifies @{} literals
}

static inline BOOL isNotEmpty(id thing) {
    return (!isEmpty(thing));
}

static inline id nilIfEmpty(id thing) {
    return isNotEmpty(thing) ? thing : nil;
}

#define ZAssert(condition, ...) \
    do { \
        if (!(condition)) { \
            [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] \
                                                                    file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] \
                                                              lineNumber:__LINE__ \
                                                             description:__VA_ARGS__]; \
        } \
    } while (0)

/*******************************************
 * GCD Helper Functions
 *******************************************/

#define DISPATCH_SECS(SECS)                 dispatch_time(DISPATCH_TIME_NOW, SECS * NSEC_PER_SEC)
// Get queue
dispatch_queue_t getNewQueue(NSString *label);
dispatch_queue_t getNewSerialQueue(NSString *label);
dispatch_queue_t getNewParallelQueue(NSString *label);
dispatch_queue_t getHighQueue(void);
dispatch_queue_t getDefaultQueue(void);
dispatch_queue_t getLowQueue(void);
dispatch_queue_t getBackgroundQueue(void);

// Test
bool isOnQueue(dispatch_queue_t queue);

// Run sync
void runOnQueue(dispatch_queue_t queue, dispatch_block_t block);
void runOnMainQueue(dispatch_block_t block);
void runOnQueueOrAsync(dispatch_queue_t queue, dispatch_block_t block);
void runOnMainQueueOrAsync(dispatch_block_t block);
dispatch_queue_t runOnNonMainQueue(dispatch_block_t block);

// Run async
void runOnQueueAsync(dispatch_queue_t queue, dispatch_block_t block);
void runOnMainQueueAsync(dispatch_block_t block);
dispatch_queue_t runOnNewQueueAsync(NSString *label, dispatch_block_t block);
dispatch_queue_t runOnHighQueueAsync(dispatch_block_t block);
dispatch_queue_t runOnDefaultQueueAsync(dispatch_block_t block);
dispatch_queue_t runOnLowQueueAsync(dispatch_block_t block);
dispatch_queue_t runOnBackgroundQueueAsync(dispatch_block_t block);

// Run async delayed
void runOnQueueAsyncDelayed(float seconds, dispatch_queue_t queue, dispatch_block_t block);
void runOnMainQueueAsyncDelayed(float seconds, dispatch_block_t block);
dispatch_queue_t runOnNewQueueAsyncDelayed(NSString *label, float seconds, dispatch_block_t block);
dispatch_queue_t runOnHighQueueAsyncDelayed(float seconds, dispatch_block_t block);
dispatch_queue_t runOnDefaultQueueAsyncDelayed(float seconds, dispatch_block_t block);
dispatch_queue_t runOnLowQueueAsyncDelayed(float seconds, dispatch_block_t block);
dispatch_queue_t runOnBackgroundQueueAsyncDelayed(float seconds, dispatch_block_t block);

// From Mike Ash's recursive block fixed-point-combinator strategy (https://gist.github.com/1254684)
typedef void (^OneParameterBlock)(id parameter);
dispatch_block_t recursiveBlockVehicle(void (^block)(dispatch_block_t recurse));
OneParameterBlock recursiveOneParameterBlockVehicle(void (^block)(OneParameterBlock recurse, id parameter));




/*******************************************
 * Drawing Functions
 *******************************************/

// Highlight text in label with start location in label text to start search
void highlightText(NSString *text, UILabel *label, UIColor *color, NSInteger startLocation);

/*******************************************
 * Utility Functions
 *******************************************/

void roundCornersOnView(UIView *view, BOOL tl, BOOL tr, BOOL bl, BOOL br, float radius);
void circleOnView(UIView *view);
void circleOnViewWhiteBorder(UIView *view, CGFloat borderWidth);

/*******************************************
 * Common functions
 *******************************************/

void PGSwizzle(Class cls, SEL oldSelector, SEL newSelector);
void PGSwizzleClassMethod(Class cls, SEL oldSelector, SEL newSelector);

// MARK: Debugging
void PGWarn(NSString *format, ...);

// MARK: Typedefs
typedef void(^PGButtonActionBlock)(id sender);
