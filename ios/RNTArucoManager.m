//
//  RNTArucoManager.m
//  VizpickRN
//
//  Created by Alex Chang on 2020/9/30.
//

#import "RNTArucoManager.h"
#import "ArucoDetectView.h"

@implementation RNTArucoManager

RCT_EXPORT_MODULE(RNTAruco)

RCT_EXPORT_VIEW_PROPERTY(onArucoDetect, RCTBubblingEventBlock)

-(UIView*)view {
  ArucoDetectView *cameraView = [[ArucoDetectView alloc] init];
  cameraView.delegate = self;
  return cameraView;
}

-(void)arucoDetectView:(ArucoDetectView *)view ids:(NSArray *)ids corners:(NSArray *)corners {
  view.onArucoDetect(@{
    @"corners": corners,
    @"ids": ids
   });
}

@end
