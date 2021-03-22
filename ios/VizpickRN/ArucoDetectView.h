//
//  ArucoDetectView.h
//  cvAruco
//
//  Created by Alex Chang on 2020/10/5.
//  Copyright © 2020 Dan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
#import <React/RCTComponent.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ArucoDetectViewDelegate;

@interface ArucoDetectView : UIView<ARSCNViewDelegate, ARSessionDelegate, ARSessionObserver>

@property (nonatomic, weak, nullable) id<ArucoDetectViewDelegate> delegate;
@property (nonatomic, copy) RCTBubblingEventBlock onArucoDetect;
-(void)initSceneView;
-(void)pause;

@end

@protocol ArucoDetectViewDelegate <NSObject>

-(void)arucoDetectView:(ArucoDetectView*)view ids:(NSArray*)ids corners:(NSArray*)corners;

@end


NS_ASSUME_NONNULL_END
