//
//  UITableView+SeparatorColor.m
//  UITableView+SeparatorColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UITableView+SeparatorColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UITableView ()

@property (nonatomic, strong) UIColor *normalSeparatorColor;

@end

static char *nightSeparatorColorKey;
static char *normalSeparatorColorKey;

@implementation UITableView (SeparatorColor)

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setSeparatorColor:);                                  
        SEL swizzledSelector = @selector(hook_setSeparatorColor:);                                 
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

- (void)hook_setSeparatorColor:(UIColor*)separatorColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        [self setNormalSeparatorColor:separatorColor];
    }
    [self hook_setSeparatorColor:separatorColor];
}

- (UIColor *)nightSeparatorColor {
    return objc_getAssociatedObject(self, &nightSeparatorColorKey) ? : ([DKNightVersionManager useDefaultNightColor] ? self.defaultNightSeparatorColor :self.separatorColor);
}

- (void)setNightSeparatorColor:(UIColor *)nightSeparatorColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [self setSeparatorColor:nightSeparatorColor];
    }
    objc_setAssociatedObject(self, &nightSeparatorColorKey, nightSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalSeparatorColor {
    return objc_getAssociatedObject(self, &normalSeparatorColorKey);
}

- (void)setNormalSeparatorColor:(UIColor *)normalSeparatorColor {
    objc_setAssociatedObject(self, &normalSeparatorColorKey, normalSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)defaultNightSeparatorColor {
    BOOL notUIKitSubclass = [self isKindOfClass:[UITableView class]] && ![NSStringFromClass(self.class) containsString:@"UI"];
    if ([self isMemberOfClass:[UITableView class]] || notUIKitSubclass) {
        return UIColorFromRGB(0x313131);
    } else {
        UIColor *resultColor = self.normalSeparatorColor ?: [UIColor clearColor];
        return resultColor;
    }
}

@end
