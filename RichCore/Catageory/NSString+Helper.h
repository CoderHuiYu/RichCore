// Copyright © 2020 Peogoo. All rights reserved.

#import <UIKit/UIKit.h>

@interface NSString (Helper)

- (NSString *)trimmed;
- (NSString *)numbersOnlyString;
- (NSString *)phoneNumbersOnlyString;
- (NSString *)urlDecodedString;
- (NSString *)md5;

/**
 Get height of the string for given width and font

 @param width (CGFloat) Maximum width of the string
 @param font (UIFont) Font of the string
 @return (CGFloat) Height of the given string
 */
- (CGFloat)heightOfStringForWidth:(CGFloat)width font:(UIFont *)font;
/**
 Get width of the string for given height and font

 @param height (CGFloat) Maximum height of the string
 @param font (UIFont) Font of the string
 @return (CGFloat) Width of the given string
 */
- (CGFloat)widthOfStringForHeight:(CGFloat)height font:(UIFont *)font;

/**
 This method will return the first alphabet letter of the string (thus excluding symbols, numbers, spaces, etc).

 @return returns the first letter of a given string
 */
- (NSString *)firstLetter;

/**
 Safely appends two strings, checking for nullability on both of them.

 @param firstString the left side of the resulting string
 @param secondString the right side of the resulting string
 @return a safely appended string
 */
+ (NSString *)stringBySafelyAppendingString:(NSString *)firstString withString:(NSString *)secondString;

/// Truncates a string to a max length. Appends … if string was truncated. @see https://stackoverflow.com/questions/2952298/how-can-i-truncate-an-nsstring-to-a-set-length
- (NSString *)truncatedStringByLength:(NSUInteger)length appendingEllipsis:(BOOL)shouldAppendEllipsis;

@end

@interface NSAttributedString (Helper)

+ (instancetype)attributedStringWithImage:(UIImage *)image centeredForFont:(UIFont *)font;
// Zinder
+ (instancetype)attributedStringWithImage:(UIImage *)image centeredForFont:(UIFont *)font withOffset:(CGFloat)offset;

@end

@interface NSMutableAttributedString (Helper)

- (void)appendString:(NSString *)string;

@end
