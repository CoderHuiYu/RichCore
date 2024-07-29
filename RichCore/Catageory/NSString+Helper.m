// Copyright © 2020 Peogoo. All rights reserved.

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import "ETGlobalFunctions.h"

@implementation NSString (Helper)

- (NSString *)trimmed {
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (NSString *)numbersOnlyString {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet.decimalDigitCharacterSet invertedSet]] componentsJoinedByString:@""];
}

- (NSString *)phoneNumbersOnlyString {
    NSString *numbersOnlyString = [self numbersOnlyString];
    if ([self hasPrefix:@"+"]) { return [@"+" stringByAppendingString:numbersOnlyString]; }
    return numbersOnlyString;
}

- (NSString *)urlDecodedString {
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByRemovingPercentEncoding];
    return result;
}

- (NSString *)md5 {
    const char *string = [self UTF8String];
    unsigned char result[16];
    CC_MD5(string, (unsigned int)strlen(string), result);
    NSString *hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    return [hash lowercaseString];
}

/**
 Get height of the string for given width and font

 @param width (CGFloat) Maximum width of the string
 @param font (UIFont) Font of the string
 @return (CGFloat) Height of the given string
 */
- (CGFloat)heightOfStringForWidth:(CGFloat)width font:(UIFont *)font {
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName : font}
                                         context:nil];

    return textRect.size.height;
}

/**
 Get width of the string for given height and font

 @param height (CGFloat) Maximum height of the string
 @param font (UIFont) Font of the string
 @return (CGFloat) Width of the given string
 */
- (CGFloat)widthOfStringForHeight:(CGFloat)height font:(UIFont *)font {
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName : font}
                                         context:nil];

    return textRect.size.width;
}

- (NSString *)firstLetter {
    // It cut out any character that is not in the letterCharacterSet, and join them again into 1 string. Then it'll take the first letter of that result as a substring, and return it.
    if (isEmpty(self)) { return @""; }
    NSString *lettersOnlyString = [[self componentsSeparatedByCharactersInSet:NSCharacterSet.letterCharacterSet.invertedSet] componentsJoinedByString:@""];
    if (isEmpty(lettersOnlyString)) { return @""; }
    return [lettersOnlyString substringToIndex:1];
}

+ (NSString *)stringBySafelyAppendingString:(NSString *)firstString withString:(NSString *)secondString {
    if (isEmpty(firstString)) { return secondString.trimmed ?: @""; }
    if (isEmpty(secondString)) { return firstString.trimmed ?: @""; }
    return [@[ firstString.trimmed, secondString.trimmed ] componentsJoinedByString:@" "];
}

- (NSString *)truncatedStringByLength:(NSUInteger)length appendingEllipsis:(BOOL)shouldAppendEllipsis {
    if (length == 0) { return self; }

    NSRange stringRange = {0, MIN(self.length, length)}; // Defining the length we'll accept
    stringRange = [self rangeOfComposedCharacterSequencesForRange:stringRange]; // Adjust the range to include dependent chars
    NSString *truncatedString = [self substringWithRange:stringRange]; // Limited string

    if (![truncatedString isEqual:self] && shouldAppendEllipsis) { // If the string was truncated
        truncatedString = [truncatedString stringByAppendingString:@"…"];
    }
    return truncatedString;
}

@end

@implementation NSAttributedString (Helper)

+ (instancetype)attributedStringWithImage:(UIImage *)image centeredForFont:(UIFont *)font {
    return [NSAttributedString attributedStringWithImage:image centeredForFont:font withOffset:0];
}

+ (instancetype)attributedStringWithImage:(UIImage *)image centeredForFont:(UIFont *)font withOffset:(CGFloat)offset {
    NSTextAttachment *iconAttachment = [NSTextAttachment new];
    iconAttachment.image = image;
    iconAttachment.bounds = CGRectMake(0, font.capHeight / 2 - image.size.height / 2 + offset, image.size.width, image.size.height);
    return [self attributedStringWithAttachment:iconAttachment];
}

@end

@implementation NSMutableAttributedString (Helper)

- (void)appendString:(NSString *)string {
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
}

@end

