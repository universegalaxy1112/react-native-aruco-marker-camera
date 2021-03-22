//
//  ArucoDetectView.m
//  cvAruco
//
//  Created by Alex Chang on 2020/10/5.
//  Copyright © 2020 Dan Park. All rights reserved.
//

#import "ArucoDetectView.h"
#import "SKWorldTransform.h"
#import "ArucoNode.h"
#import "ArucoCV.h"

@implementation ArucoDetectView
{
  ARSCNView *scenenView;
  BOOL mutexLock;
}

-(instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
//  [self initSceneView];
  return self;
}

-(instancetype)init
{
  self = [super init];
  return self;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  [self initSceneView];
}

//-(void)didMoveToSuperview {
//  [super didMoveToSuperview];
//  [self initSceneView];
//}

-(void)initSceneView {
  if (scenenView != NULL) {
    return;
  }
  
  scenenView = [[ARSCNView alloc] initWithFrame:self.bounds];
  [self addSubview:scenenView];
  
  scenenView.delegate = self;
  scenenView.session.delegate = self;
  
  ARWorldTrackingConfiguration *config = [[ARWorldTrackingConfiguration alloc] init];
  [config setPlaneDetection:ARPlaneDetectionHorizontal];
  [config setLightEstimationEnabled:YES];
  [config setWorldAlignment:ARWorldAlignmentGravity];
  
  [scenenView setAutoenablesDefaultLighting:YES];
  [scenenView.session runWithConfiguration:config];
}

-(void)pause {
  [scenenView.session pause];
}

-(void)updateContentNodeCache:(NSArray<SKWorldTransform*>*)targTransforms :(SCNMatrix4)cameraTransform {
//  for (int i = 0; i < targTransforms.count; i++) {
//    SKWorldTransform *transform = targTransforms[i];
//    SCNMatrix4 targTransform = SCNMatrix4Mult(transform.transform, cameraTransform);
//
//    ArucoNode *node = [self findCube:(NSInteger)transform.arucoId];
//    if (node != NULL) {
//      [node setWorldTransform:targTransform];
//    } else {
//      ArucoNode *arucoCube = [[ArucoNode alloc] initWithSize:0.04 :23];
//      [scenenView.scene.rootNode addChildNode:arucoCube];
//      [arucoCube setWorldTransform:targTransform];
//    }
//  }
}

-(ArucoNode*)findCube:(NSInteger)arucoId {
  for(int i = 0; i < scenenView.scene.rootNode.childNodes.count; i++) {
    ArucoNode *node = (ArucoNode*)(scenenView.scene.rootNode.childNodes[i]);
    if (node != NULL) {
      if (arucoId == node.identifier) {
        return node;
      }
    }
  }
  
  return nil;
}

-(void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
  if (mutexLock) {
    return;
  }
  
  mutexLock = YES;
  
  CVPixelBufferRef pixelBuffer = frame.capturedImage;
  
  NSMutableArray *idArray = nil;
  NSMutableArray *cornerArray = nil;
  
  NSMutableArray<SKWorldTransform*> *transMatrixArray = [ArucoCV estimatePose:pixelBuffer withIntrinsics:frame.camera.intrinsics andMarkerSize:0.133 corners:&cornerArray ids:&idArray];
  
  if (transMatrixArray.count == 0) {
    mutexLock = NO;
    return;
  }
  
  SCNMatrix4 cameraMatrix = SCNMatrix4FromMat4(frame.camera.transform);
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.delegate arucoDetectView:self ids:idArray corners:cornerArray];
    [self updateContentNodeCache:transMatrixArray :cameraMatrix];
    mutexLock = NO;
  });
}

@end
