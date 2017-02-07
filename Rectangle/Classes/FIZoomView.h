//
//  FIZoomView.h
//  Pods
//
//  Created by Developer on 1/30/17.
//
//

#import <UIKit/UIKit.h>

@interface FIZoomView : UIView{
    
    CGPoint _currentCenter;
    CGPoint _cornerCenter;
}

-(void)setZoomScale:(CGFloat)scale;

-(void)setZoomCenter:(CGPoint)point;
-(void)zoomViewHide:(BOOL)hide;

-(void)setDragingEnabled:(BOOL)enabled;

@end
