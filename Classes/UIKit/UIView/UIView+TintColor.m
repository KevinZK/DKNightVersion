//
//  UIView+TintColor.m
//  UIView+TintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UIView+TintColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UIView ()

@property (nonatomic, strong) UIColor *normalTintColor;

@end

static char *nightTintColorKey;
static char *normalTintColorKey;

@implementation UIView (TintColor)

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setTintColor:);                                  
        SEL swizzledSelector = @selector(hook_setTintColor:);                                 
        Method originalMethod = class_getInstanceMethod(class, originalSelector);  
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);  
        BOOL didAddMethod =                                                        
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));                   
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));           
        } else {                                                                   
            method_exchangeImplementations(originalMethod, swizzledMethod);        
        }
    });
}

- (void)hook_setTintColor:(UIColor*)tintColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        [self setNormalTintColor:tintColor];
    }
    [self hook_setTintColor:tintColor];
}

- (UIColor *)nightTintColor {
    return objc_getAssociatedObject(self, &nightTintColorKey) ? : ([DKNightVersionManager useDefaultNightColor] ? self.defaultNightTintColor :self.tintColor);
}

- (void)setNightTintColor:(UIColor *)nightTintColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [self setTintColor:nightTintColor];
    }
    objc_setAssociatedObject(self, &nightTintColorKey, nightTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalTintColor {
    return objc_getAssociatedObject(self, &normalTintColorKey);
}

- (void)setNormalTintColor:(UIColor *)normalTintColor {
    objc_setAssociatedObject(self, &normalTintColorKey, normalTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)defaultNightTintColor {
    BOOL notUIKitSubclass = [self isKindOfClass:[UIView class]] && ![NSStringFromClass(self.class) containsString:@"UI"];
    if ([self isMemberOfClass:[UIView class]] || notUIKitSubclass) {
        return UIColorFromRGB(0xffffff);
    } else {
        UIColor *resultColor = self.normalTintColor ?: [UIColor whiteColor];
        return resultColor;
    }
}

@end
