// Copyright © 2020 Peogoo. All rights reserved.

#import <objc/runtime.h>
#import "ETGlobalFunctions.h"
#import <sys/utsname.h>

/*******************************************
 * GCD Helper Functions
 *******************************************/

// Get queue
//static void *__queueAddress             = &__queueAddress;
//dispatch_queue_t getNewQueue(NSString *label) {
//    dispatch_queue_t queue              = dispatch_queue_create([[NSString stringWithFormat:@"%@.%@", ObjC_Environment.BUNDLE_IDENTIFIER, label] UTF8String], NULL);
//    dispatch_queue_set_specific(queue, __queueAddress, (__bridge void *)queue, NULL);
//    return queue;
//}
//dispatch_queue_t getNewSerialQueue(NSString *label) {
//    dispatch_queue_t queue              = dispatch_queue_create([[NSString stringWithFormat:@"%@.%@", ObjC_Environment.BUNDLE_IDENTIFIER, label] UTF8String], DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_set_specific(queue, __queueAddress, (__bridge void *)queue, NULL);
//    return queue;
//}
//dispatch_queue_t getNewParallelQueue(NSString *label) {
//    dispatch_queue_t queue              = dispatch_queue_create([[NSString stringWithFormat:@"%@.%@", ObjC_Environment.BUNDLE_IDENTIFIER, label] UTF8String], DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_set_specific(queue, __queueAddress, (__bridge void *)queue, NULL);
//    return queue;
//}
//dispatch_queue_t getHighQueue() {
//    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//}
//dispatch_queue_t getDefaultQueue() {
//    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//}
//dispatch_queue_t getLowQueue() {
//    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//}
//dispatch_queue_t getBackgroundQueue() {
//    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//}
//
//
//// Test
//bool isOnQueue(dispatch_queue_t queue) {
//    return (dispatch_get_specific(__queueAddress) == (__bridge void *)queue);
//}
//
//
//// Run sync
//void runOnQueue(dispatch_queue_t queue, dispatch_block_t block) {
//    if (isOnQueue(queue)) {
//        //DLog(@"correct queue: running block directly");
//        block();
//    } else {
//        //DLog(@"wrong queue: running block sync");
//        dispatch_sync(queue, block);
//    }
//}
//void runOnMainQueue(dispatch_block_t block) {
//    if ([NSThread isMainThread]) {
//        block();
//    } else {
//        dispatch_sync(dispatch_get_main_queue(), block);
//    }
//}
//// Special cases
//// This function will test to see if we're already on the correct queue, in which case
////  it simply runs the block (ie. the block is not scheduled to run async).  However, if we
////  are not on the correct queue, then the block is scheduled to run on the queue async.
//void runOnQueueOrAsync(dispatch_queue_t queue, dispatch_block_t block) {
//    if (isOnQueue(queue)) {
//        //DLog(@"correct queue: running block directly");
//        block();
//    } else {
//        //DLog(@"wrong queue: running block async");
//        dispatch_async(queue, block);
//    }
//}
//// This function will test to see if we're already on the main thread, in which case
////  it simply runs the block (ie. the block is not scheduled to run async).  However, if we
////  are not on the main thread, then the block is scheduled to run on the main queue async.
//void runOnMainQueueOrAsync(dispatch_block_t block) {
//    if ([NSThread isMainThread]) {
//        block();
//    } else {
//        runOnMainQueueAsync(block);
//    }
//}
//// NOTE: this function will test to see if we're already on a non-main thread, in which case
////  it simply runs the the block (ie. the block is not scheduled to run async).  However, if we
////  are on the main thread, then the block is scheduled to run on a default queue async.
//dispatch_queue_t runOnNonMainQueue(dispatch_block_t block) {
//    if ([NSThread isMainThread]) {
//        dispatch_queue_t queue              = getDefaultQueue();
//        dispatch_async(queue, block);
//        return queue;
//    } else {
//        // This can simply call block because we're already on a non-main thread, no need to schedule it back onto same queue
//        block();
//        // No need to return a new queue, we didn't create one
//        return NULL;
//    }
//}
//
//
//// Run async
//void runOnQueueAsync(dispatch_queue_t queue, dispatch_block_t block) {
//    dispatch_async(queue, block);
//}
//void runOnMainQueueAsync(dispatch_block_t block) {
//    dispatch_async(dispatch_get_main_queue(), block);
//}
//dispatch_queue_t runOnNewQueueAsync(NSString *label, dispatch_block_t block) {
//    dispatch_queue_t queue              = getNewQueue(label);
//    dispatch_async(queue, block);
//    return queue;
//}
//dispatch_queue_t runOnHighQueueAsync(dispatch_block_t block) {
//    dispatch_queue_t queue              = getHighQueue();
//    dispatch_async(queue, block);
//    return queue;
//}
//dispatch_queue_t runOnDefaultQueueAsync(dispatch_block_t block) {
//    dispatch_queue_t queue              = getDefaultQueue();
//    dispatch_async(queue, block);
//    return queue;
//}
//dispatch_queue_t runOnLowQueueAsync(dispatch_block_t block) {
//    dispatch_queue_t queue              = getLowQueue();
//    dispatch_async(queue, block);
//    return queue;
//}
//dispatch_queue_t runOnBackgroundQueueAsync(dispatch_block_t block) {
//    dispatch_queue_t queue              = getBackgroundQueue();
//    dispatch_async(queue, block);
//    return queue;
//}
//
//
//// Run async delayed
//void runOnQueueAsyncDelayed(float seconds, dispatch_queue_t queue, dispatch_block_t block) {
//    dispatch_after(DISPATCH_SECS(seconds), queue, block);
//}
//void runOnMainQueueAsyncDelayed(float seconds, dispatch_block_t block) {
//    runOnQueueAsyncDelayed(seconds, dispatch_get_main_queue(), block);
//}
//dispatch_queue_t runOnNewQueueAsyncDelayed(NSString *label, float seconds, dispatch_block_t block) {
//    dispatch_queue_t queue              = getNewQueue(label);
//    runOnQueueAsyncDelayed(seconds, queue, block);
//    return queue;
//}
//dispatch_queue_t runOnHighQueueAsyncDelayed(float seconds, dispatch_block_t block) {
//    dispatch_queue_t queue              = getHighQueue();
//    runOnQueueAsyncDelayed(seconds, queue, block);
//    return queue;
//}
//dispatch_queue_t runOnDefaultQueueAsyncDelayed(float seconds, dispatch_block_t block) {
//    dispatch_queue_t queue              = getDefaultQueue();
//    runOnQueueAsyncDelayed(seconds, queue, block);
//    return queue;
//}
//dispatch_queue_t runOnLowQueueAsyncDelayed(float seconds, dispatch_block_t block) {
//    dispatch_queue_t queue              = getLowQueue();
//    runOnQueueAsyncDelayed(seconds, queue, block);
//    return queue;
//}
//dispatch_queue_t runOnBackgroundQueueAsyncDelayed(float seconds, dispatch_block_t block) {
//    dispatch_queue_t queue              = getBackgroundQueue();
//    runOnQueueAsyncDelayed(seconds, queue, block);
//    return queue;
//}


// From Mike Ash's recursive block fixed-point-combinator strategy (https://gist.github.com/1254684)
dispatch_block_t recursiveBlockVehicle(void (^block)(dispatch_block_t recurse)) {
    // assuming ARC, so no explicit copy
    return ^{ block(recursiveBlockVehicle(block)); };
}
OneParameterBlock recursiveOneParameterBlockVehicle(void (^block)(OneParameterBlock recurse, id parameter)) {
    return ^(id parameter){ block(recursiveOneParameterBlockVehicle(block), parameter); };
}




/*******************************************
 * Drawing Functions
 *******************************************/

void highlightText(NSString *textHighlight, UILabel *label, UIColor *color, NSInteger startLocation) {
    NSError *error;
    if (textHighlight.length) {
        // NSRegularExpression with input text, this treat \\%@ use to ignore dollar sign char
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"\\%@", textHighlight] options:NSRegularExpressionCaseInsensitive error:&error];
        if (!error){
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
            NSArray *allMatches = [regex matchesInString:label.text options:0 range:NSMakeRange(startLocation, [label.text length]-startLocation)];
            for (NSTextCheckingResult *aMatch in allMatches) {
                NSRange matchRange = [aMatch range];
                [attributedString setAttributes:@{ NSForegroundColorAttributeName:color } range:matchRange];
                // Only highlight first matching text
                break;
            }
            [label setAttributedText:attributedString];
        }
    }
}

/*******************************************
 * Utility Functions
 *******************************************/
void circleOnView(UIView *view) {
    circleOnViewWhiteBorder(view, 0);
}

void circleOnViewWhiteBorder(UIView *view, CGFloat borderWidth) {
    CGRect rect = view.bounds;

    CGFloat radius = CGRectGetWidth(rect) / 2;

    //Make round
    // Create the path for to make circle
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(radius, radius)];

    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];

    maskLayer.frame = rect;
    maskLayer.path  = maskPath.CGPath;

    // Set the newly created shape layer as the mask for the view's layer
    view.layer.mask = maskLayer;

    //Give Border
    //Create path for border
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(radius, radius)];

    // Create the shape layer and set its path
    CAShapeLayer *borderLayer = [CAShapeLayer layer];

    borderLayer.frame       = rect;
    borderLayer.path        = borderPath.CGPath;
    borderLayer.strokeColor = UIColor.whiteColor.CGColor;
    borderLayer.fillColor   = UIColor.clearColor.CGColor;
    borderLayer.lineWidth   = borderWidth;

    //Add this layer to give border.
    [view.layer addSublayer:borderLayer];
    view.contentMode = UIViewContentModeScaleAspectFill;
}

void roundCornersOnView(UIView *view, BOOL tl, BOOL tr, BOOL bl, BOOL br, float radius) {
    if (tl || tr || bl || br) {

        UIRectCorner corner = 0; //holds the corner
        //Determine which corner(s) should be changed
        if (tl) {
            corner = corner | UIRectCornerTopLeft;
        }
        if (tr) {
            corner = corner | UIRectCornerTopRight;
        }
        if (bl) {
            corner = corner | UIRectCornerBottomLeft;
        }
        if (br) {
            corner = corner | UIRectCornerBottomRight;
        }

        CGRect bounds = view.bounds;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                       byRoundingCorners:corner
                                                             cornerRadii:CGSizeMake(radius, radius)];

        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }
}

void PGSwizzle(Class cls, SEL oldSelector, SEL newSelector) {
    Method oldMethod = class_getInstanceMethod(cls, oldSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls, oldSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(cls, newSelector, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

void PGSwizzleClassMethod(Class cls, SEL oldSelector, SEL newSelector) {
    Method oldMethod = class_getClassMethod(cls, oldSelector);
    Method newMethod = class_getClassMethod(cls, newSelector);
    if (class_addMethod(cls, oldSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(cls, newSelector, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

void PGWarn(NSString *format, ...) {
    #if IS_DEBUG
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    PGLog(@"WARNING: %@", message);
    #endif
}
