// Copyright © 2017 Tellus, Inc. All rights reserved.

#import <UIKit/UIKit.h>

double constrainMin(double value, double min);
double constrainMax(double value, double max);

//// MARK: Point
//CGPoint CGPointAdd(CGPoint lhs, CGPoint rhs);

// MARK: Rect
CGRect CGRectMake2(CGPoint origin, CGSize size);

// MARK: Other
CGFloat CGPointDistanceToRect(CGPoint p, CGRect rect);

// MARK: Scale
typedef NS_ENUM(NSInteger, ZLScaleMode) { ZLScaleModeFill, ZLScaleModeAspectFit, ZLScaleModeAspectFill };
CGSize CGSizeScaleToSize(CGSize size, CGSize targetSize, ZLScaleMode scaleMode);
