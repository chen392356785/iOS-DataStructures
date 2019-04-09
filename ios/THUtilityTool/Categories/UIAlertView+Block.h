//
//  UIAlertView+Block.h
//  Owner
//
//  Created by Neely on 2018/3/30.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)();

typedef void (^DismissBlocks)(NSInteger buttonIndex);
typedef void (^CancelBlock)();
typedef void (^PhotoPickedBlock)(UIImage *chosenImage);


@interface UIAlertView (Block)<UIAlertViewDelegate>

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message;

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(DismissBlocks) dismissed
                           onCancel:(CancelBlock) cancelled;

@property (nonatomic, copy) DismissBlocks dismissBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;


@end
