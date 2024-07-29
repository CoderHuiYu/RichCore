// Copyright © 2017 Tellus, Inc. All rights reserved.

#import "CGGeometry.h"

double constrain(double value, double min, double max) {
    if (value < min) { return min; }
    if (value > max) { return max; }
    return value;
}

double constrainMin(double value, double min) {
    if (value < min) { return min; }
    return value;
}

double constrainMax(double value, double max) {
    if (value > max) { return max; }
    return value;
}

//// MARK: Point
//CGPoint CGPointAdd(CGPoint lhs, CGPoint rhs) { return CGPointMake(lhs.x + rhs.x, lhs.y + rhs.y); }

// MARK: Size
CGSize CGSizeMakeUniform(CGFloat size) { return CGSizeMake(size, size); }
CGSize CGSizeMultiply(CGSize lhs, CGSize rhs) { return CGSizeMake(lhs.width * rhs.width, lhs.height * rhs.height); }
CGSize CGSizeDivide(CGSize lhs, CGSize rhs) { return CGSizeMake(lhs.width / rhs.width, lhs.height / rhs.height); }

// MARK: Rect
CGRect CGRectMake2(CGPoint origin, CGSize size) { return CGRectMake(origin.x, origin.y, size.width, size.height); }

// MARK: Other
CGFloat CGPointDistanceToPoint(CGPoint p1, CGPoint p2) { return hypot(p2.x - p1.x, p2.y - p1.y); }

CGPoint CGPointClampToRect(CGPoint p, CGRect rect) {
    p.x = constrain(p.x, CGRectGetMinX(rect), CGRectGetMaxX(rect));
    p.y = constrain(p.y, CGRectGetMinY(rect), CGRectGetMaxY(rect));
    return p;
}

CGFloat CGPointDistanceToRect(CGPoint p, CGRect rect) {
    CGPoint pInRect = CGPointClampToRect(p, rect);
    return CGPointDistanceToPoint(p, pInRect);
}

// MARK: Scale
CGSize CGSizeScaleToSize(CGSize size, CGSize targetSize, ZLScaleMode scaleMode) {
    CGSize scaling = CGSizeDivide(targetSize, size);
    // Adjust scale for aspect fit/fill
    switch (scaleMode) {
    case ZLScaleModeAspectFit: scaling = CGSizeMakeUniform(MIN(scaling.width, scaling.height)); break;
    case ZLScaleModeAspectFill: scaling = CGSizeMakeUniform(MAX(scaling.width, scaling.height)); break;
    case ZLScaleModeFill: break;
    }
    return CGSizeMultiply(size, scaling);
}
