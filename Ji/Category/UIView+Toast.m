//
//  UIView+Toast.m
//  Wai
//
//  Created by lwq on 16/5/10.
//  Copyright © 2016年 evol. All rights reserved.
//

#import "UIView+Toast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat NIMKitToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat NIMKitToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat NIMKitToastHorizontalPadding   = 10.0;
static const CGFloat NIMKitToastVerticalPadding     = 10.0;
static const CGFloat NIMKitToastCornerRadius        = 10.0;
static const CGFloat NIMKitToastOpacity             = 0.8;
static const CGFloat NIMKitToastFontSize            = 16.0;
static const CGFloat NIMKitToastMaxTitleLines       = 0;
static const CGFloat NIMKitToastMaxMessageLines     = 0;
static const NSTimeInterval NIMKitToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat NIMKitToastShadowOpacity       = 0.8;
static const CGFloat NIMKitToastShadowRadius        = 6.0;
static const CGSize  NIMKitToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    NIMKitToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval NIMKitToastDefaultDuration  = 3.0;

// image view size
static const CGFloat NIMKitToastImageViewWidth      = 80.0;
static const CGFloat NIMKitToastImageViewHeight     = 80.0;

// activity
static const CGFloat NIMKitToastActivityWidth       = 100.0;
static const CGFloat NIMKitToastActivityHeight      = 100.0;
static const NSString * NIMKitToastActivityDefaultPosition = @"center";

// interaction
static const BOOL NIMKitToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * NIMKitToastTimerKey         = @"CSToastTimerKey";
static const NSString * NIMKitToastActivityViewKey  = @"CSToastActivityViewKey";
static const NSString * NIMKitToastTapCallbackKey   = @"CSToastTapCallbackKey";

// positions
NSString * const NIMKitToastPositionTop             = @"top";
NSString * const NIMKitToastPositionCenter          = @"center";
NSString * const NIMKitToastPositionBottom          = @"bottom";

@interface UIView (ToastPrivate)

- (void)el_hideToast:(UIView *)toast;
- (void)el_toastTimerDidFinish:(NSTimer *)timer;
- (void)el_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)el_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)el_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)el_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@implementation UIView (Toast)
#pragma mark - Toast Methods

- (void)el_makeToast:(NSString *)message {
    [self el_makeToast:message duration:NIMKitToastDefaultDuration position:NIMKitToastPositionCenter];
}

- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self el_viewForMessage:message title:nil image:nil];
    [self el_showToast:toast duration:duration position:position];
}

- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self el_viewForMessage:message title:title image:nil];
    [self el_showToast:toast duration:duration position:position];
}

- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self el_viewForMessage:message title:nil image:image];
    [self el_showToast:toast duration:duration position:position];
}

- (void)el_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self el_viewForMessage:message title:title image:image];
    [self el_showToast:toast duration:duration position:position];
}

- (void)el_showToast:(UIView *)toast {
    [self el_showToast:toast duration:NIMKitToastDefaultDuration position:nil];
}


- (void)el_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self el_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)el_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
             tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self el_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (NIMKitToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(el_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:NIMKitToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(el_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &NIMKitToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &NIMKitToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)el_hideToast:(UIView *)toast {
    [UIView animateWithDuration:NIMKitToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)el_toastTimerDidFinish:(NSTimer *)timer {
    [self el_hideToast:(UIView *)timer.userInfo];
}

- (void)el_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &NIMKitToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &NIMKitToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self el_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)el_makeToastActivity {
    [self el_makeToastActivity:NIMKitToastActivityDefaultPosition];
}

- (void)el_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &NIMKitToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NIMKitToastActivityWidth, NIMKitToastActivityHeight)];
    activityView.center = [self el_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:NIMKitToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = NIMKitToastCornerRadius;
    
    if (NIMKitToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = NIMKitToastShadowOpacity;
        activityView.layer.shadowRadius = NIMKitToastShadowRadius;
        activityView.layer.shadowOffset = NIMKitToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &NIMKitToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:NIMKitToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)el_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &NIMKitToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:NIMKitToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &NIMKitToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)el_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:NIMKitToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + NIMKitToastVerticalPadding);
        } else if([point caseInsensitiveCompare:NIMKitToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - NIMKitToastVerticalPadding);
}

- (CGSize)el_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)el_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = NIMKitToastCornerRadius;
    
    if (NIMKitToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = NIMKitToastShadowOpacity;
        wrapperView.layer.shadowRadius = NIMKitToastShadowRadius;
        wrapperView.layer.shadowOffset = NIMKitToastShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:NIMKitToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(NIMKitToastHorizontalPadding, NIMKitToastVerticalPadding, NIMKitToastImageViewWidth, NIMKitToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = NIMKitToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = NIMKitToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:NIMKitToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * NIMKitToastMaxWidth) - imageWidth, self.bounds.size.height * NIMKitToastMaxHeight);
        CGSize expectedSizeTitle = [self el_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = NIMKitToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:NIMKitToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * NIMKitToastMaxWidth) - imageWidth, self.bounds.size.height * NIMKitToastMaxHeight);
        CGSize expectedSizeMessage = [self el_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = NIMKitToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + NIMKitToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + NIMKitToastHorizontalPadding;
        messageTop = titleTop + titleHeight + NIMKitToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (NIMKitToastHorizontalPadding * 2)), (longerLeft + longerWidth + NIMKitToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + NIMKitToastVerticalPadding), (imageHeight + (NIMKitToastVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}

@end
