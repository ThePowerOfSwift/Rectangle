//
//  CropViewController.m
//  Pods
//
//  Created by Developer on 2/7/17.
//
//

#import "CropViewController.h"
#import "FIImageRectangleDetector.h"
#import "FIConstantValues.h"

@interface CropViewController ()
    
    @end

@implementation CropViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    croppedImage = [[CIImage alloc] initWithImage:self.originalImage];
    
    _sharedDetector = [FIImageRectangleDetector sharedDetector];
    _detectedRectangleFeature = [_sharedDetector biggestRectangleInRectangles:[[_sharedDetector highAccuracyRectangleDetector] featuresInImage:croppedImage]];
    
    croppedImage = [_sharedDetector drawHighlightOverlayForPoints:croppedImage topLeft:_detectedRectangleFeature.topLeft
                                                         topRight:_detectedRectangleFeature.topRight
                                                       bottomLeft:_detectedRectangleFeature.bottomLeft
                                                      bottomRight:_detectedRectangleFeature.bottomRight];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    static float margin = 0.0;
    
    _detectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin, [FIConstantValues pictureSelectorHeaderViewHeight] + margin, self.view.frame.size.width - margin * 2, self.view.frame.size.height -[FIConstantValues pictureSelectorFooterViewHeight] -[FIConstantValues pictureSelectorHeaderViewHeight] - margin * 2)];
    _detectedImage.translatesAutoresizingMaskIntoConstraints = NO;
    _detectedImage.userInteractionEnabled = YES;
    [_detectedImage setImage:self.originalImage];
    [self.view addSubview:_detectedImage];
    
    
    
    
    if (_detectedRectangleFeature) {
        
        [self magnetActivated];
        
    }else{
        
        [self magnetDeactivated];
    }
    
    [self initializeHeaderView];
    [self initializeFooterView];
    [self setupUI];
    
    NSLayoutConstraint* imgTop = [NSLayoutConstraint constraintWithItem:_detectedImage
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_headerView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0 constant:0.0];
    NSLayoutConstraint* imgLeft = [NSLayoutConstraint constraintWithItem:_detectedImage
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0 constant:margin];
    NSLayoutConstraint* imgRight = [NSLayoutConstraint constraintWithItem:_detectedImage
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0 constant:-margin];
    NSLayoutConstraint* imgBtm = [NSLayoutConstraint constraintWithItem:_detectedImage
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_footerView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0 constant:0.0];
    
    NSArray* imgConstraints = [NSArray arrayWithObjects:imgTop, imgBtm, imgLeft, imgRight, nil];
    
    [self.view addConstraints:imgConstraints];
    
    
}


-(void) findRectangleInImage {
    if (_detectedRectangleFeature) {
        
        [self magnetActivated];
        
    }else{
        
        [self magnetDeactivated];
    }
}

-(void) setupUI {}

-(void) findRectangle {
    if (_detectedRectangleFeature) {
        
        [self magnetActivated];
        
    }else{
        
        [self magnetDeactivated];
    }
}

-(void) selectAllArea {
    static float margin = 10.0f;
    float absoluteHeight = self.originalImage.size.height / _detectedImage.frame.size.height;
    float absoluteWidth = self.originalImage.size.width / _detectedImage.frame.size.width;
    
    if (!_overlayView) {
        
        _overlayView = [[FIOverlayView alloc] initWithFrame:CGRectZero];
        _overlayView.translatesAutoresizingMaskIntoConstraints = NO;
        [_detectedImage addSubview:_overlayView];
        
        NSLayoutConstraint* imgTop = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_detectedImage
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgLeft = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_detectedImage
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgRight = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_detectedImage
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgBtm = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_detectedImage
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0 constant:0.0];
        
        NSArray* imgConstraints = [NSArray arrayWithObjects:imgTop, imgBtm, imgLeft, imgRight, nil];
        
        [_detectedImage addConstraints:imgConstraints];
        
    }
    
    _overlayView.absoluteHeight = absoluteHeight;
    _overlayView.absoluteWidth = absoluteWidth;
    
    _overlayView.topLeftPath = CGPointMake(margin, margin);
    _overlayView.topRightPath = CGPointMake(_detectedImage.frame.size.width - margin,margin);
    _overlayView.bottomLeftPath = CGPointMake(margin, _detectedImage.frame.size.height - margin);
    _overlayView.bottomRightPath = CGPointMake(_detectedImage.frame.size.width - margin, _detectedImage.frame.size.height - margin);
    
    [_overlayView initializeSubView];
}

-(void)magnetActivated{
    
    float absoluteHeight = self.originalImage.size.height / _detectedImage.frame.size.height;
    float absoluteWidth = self.originalImage.size.width / _detectedImage.frame.size.width;
    
    if (!_overlayView) {
        
        _overlayView = [[FIOverlayView alloc] initWithFrame:CGRectZero];
        _overlayView.translatesAutoresizingMaskIntoConstraints = NO;
        [_detectedImage addSubview:_overlayView];
        
        NSLayoutConstraint* imgTop = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_detectedImage
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgLeft = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_detectedImage
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgRight = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_detectedImage
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgBtm = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_detectedImage
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0 constant:0.0];
        
        NSArray* imgConstraints = [NSArray arrayWithObjects:imgTop, imgBtm, imgLeft, imgRight, nil];
        
        [_detectedImage addConstraints:imgConstraints];
        
    }
    
    _overlayView.absoluteHeight = absoluteHeight;
    _overlayView.absoluteWidth = absoluteWidth;
    
    _overlayView.topLeftPath = CGPointMake(_detectedRectangleFeature.topLeft.x/absoluteWidth, (_detectedImage.frame.size.height - _detectedRectangleFeature.topLeft.y/ absoluteHeight));
    _overlayView.topRightPath = CGPointMake(_detectedRectangleFeature.topRight.x/absoluteWidth,(_detectedImage.frame.size.height -  _detectedRectangleFeature.topRight.y/ absoluteHeight));
    _overlayView.bottomLeftPath = CGPointMake(_detectedRectangleFeature.bottomLeft.x/absoluteWidth,(_detectedImage.frame.size.height -  _detectedRectangleFeature.bottomLeft.y/ absoluteHeight));
    _overlayView.bottomRightPath = CGPointMake(_detectedRectangleFeature.bottomRight.x/absoluteWidth,(_detectedImage.frame.size.height -  _detectedRectangleFeature.bottomRight.y/ absoluteHeight));
    
    [_overlayView initializeSubView];
    
}
    
-(void)magnetDeactivated{
    
    static float margin = 60.0f;
    float absoluteHeight = self.originalImage.size.height / _detectedImage.frame.size.height;
    float absoluteWidth = self.originalImage.size.width / _detectedImage.frame.size.width;
    
    if (!_overlayView) {
        
        _overlayView = [[FIOverlayView alloc] initWithFrame:CGRectZero];
        _overlayView.translatesAutoresizingMaskIntoConstraints = NO;
        [_detectedImage addSubview:_overlayView];
        
        NSLayoutConstraint* imgTop = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_detectedImage
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgLeft = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_detectedImage
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgRight = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_detectedImage
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0 constant:0.0];
        NSLayoutConstraint* imgBtm = [NSLayoutConstraint constraintWithItem:_overlayView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_detectedImage
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0 constant:0.0];
        
        NSArray* imgConstraints = [NSArray arrayWithObjects:imgTop, imgBtm, imgLeft, imgRight, nil];
        
        [_detectedImage addConstraints:imgConstraints];
        
    }
    
    _overlayView.absoluteHeight = absoluteHeight;
    _overlayView.absoluteWidth = absoluteWidth;
    
    _overlayView.topLeftPath = CGPointMake(margin, margin);
    _overlayView.topRightPath = CGPointMake(_detectedImage.frame.size.width - margin,margin);
    _overlayView.bottomLeftPath = CGPointMake(margin, _detectedImage.frame.size.height - margin);
    _overlayView.bottomRightPath = CGPointMake(_detectedImage.frame.size.width - margin, _detectedImage.frame.size.height - margin);
    
    [_overlayView initializeSubView];
}
    
    
-(void)initializeHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    [_headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_headerView setBackgroundColor:[FIConstantValues standartBackgroundColor]];
    [self.view addSubview:_headerView];
    
    NSLayoutConstraint* headerTop = [NSLayoutConstraint constraintWithItem:_headerView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0 constant:0.0];
    NSLayoutConstraint* headerHeight = [NSLayoutConstraint constraintWithItem:_headerView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0 constant:[FIConstantValues pictureSelectorHeaderViewHeight]];
    NSLayoutConstraint* headerLeft = [NSLayoutConstraint constraintWithItem:_headerView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0 constant:0.0];
    NSLayoutConstraint* headerRight = [NSLayoutConstraint constraintWithItem:_headerView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:0.0];
    
    NSArray* headerViewConstraints = [NSArray arrayWithObjects:headerTop, headerHeight, headerLeft, headerRight, nil];
    
    [self.view addConstraints:headerViewConstraints];
}
    
-(void)initializeFooterView{
    
    _footerView = [[UIView alloc] initWithFrame:CGRectZero];
    [_footerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_footerView setBackgroundColor:[FIConstantValues standartBackgroundColor]];
    [self.view addSubview:_footerView];
    
    NSLayoutConstraint* footerBottom = [NSLayoutConstraint constraintWithItem:_footerView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0 constant:0.0];
    NSLayoutConstraint* footerHeight = [NSLayoutConstraint constraintWithItem:_footerView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0 constant:[FIConstantValues pictureSelectorFooterViewHeight]];
    NSLayoutConstraint* footerLeft = [NSLayoutConstraint constraintWithItem:_footerView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0 constant:0.0];
    NSLayoutConstraint* footerRight = [NSLayoutConstraint constraintWithItem:_footerView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:0.0];
    
    NSArray* footerViewConstraints = [NSArray arrayWithObjects:footerBottom, footerHeight, footerLeft, footerRight, nil];
    [self.view addConstraints:footerViewConstraints];
}
    
-(void)autoRectangleDetect{
    
    if (_magnetEnabled) {
        
        [self magnetDeactivated];
        _magnetEnabled = NO;
    }else{
        
        if (_detectedRectangleFeature)
        {
            
            [self magnetActivated];
            _magnetEnabled = YES;
            
        }else{
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"We can't detect document please retake." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            _magnetButton.enabled = NO;
            _magnetEnabled = NO;
        }
        
    }
}
    
-(void)confirmButtonClicked {
    
    [self.delegate cropperViewdidCropped:[_overlayView cropImage:self.originalImage] cropVC:self];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}

-(UIImage *) getCroppedImage {
    return [_overlayView cropImage:self.originalImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
- (BOOL) shouldAutorotate {
    
    if (_detectedRectangleFeature) {
        
        [self magnetActivated];
        
    }else{
        
        [self magnetDeactivated];
    }
    
    return YES;
}
    
    
@end
