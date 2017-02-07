//
//  CropViewController.h
//  Pods
//
//  Created by Developer on 2/7/17.
//
//

#import <UIKit/UIKit.h>
#import "FIImageRectangleDetector.h"
#import "FIZoomView.h"
#import "FIOverlayView.h"

@class CropViewController;

@protocol CropDelegate <NSObject>
    
-(void)cropperViewdidCropped:(UIImage *)croppedImage cropVC:(CropViewController *)cropVC;
    
@end

@interface CropViewController : UIViewController{
    
    CIImage* croppedImage;
    UIImageView* _detectedImage;
    
    UIButton* _magnetButton;
    BOOL _magnetEnabled;
    
    FIOverlayView* _overlayView;
    CIRectangleFeature *_detectedRectangleFeature;
    FIImageRectangleDetector* _sharedDetector;
    
    CGFloat _rotatedDegree;
}
    
@property(nonatomic, strong) UIImage* originalImage;
@property(nonatomic, weak) id<CropDelegate> delegate;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;

-(void) findRectangle;
-(void) findRectangleInImage;

-(void) selectAllArea;
-(UIImage *) getCroppedImage;
-(void)autoRectangleDetect;
-(void) setupUI;
@end

