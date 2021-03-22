//
//  ArucoNode.h
//  cvAruco
//
//  Created by Alex Chang on 2020/10/5.
//  Copyright © 2020 Dan Park. All rights reserved.
//

#import <ARKit/ARKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArucoNode : SCNNode

@property CGFloat size;
@property NSInteger identifier;

-(instancetype)initWithSize:(CGFloat)sz :(NSInteger)arucoId;

@end

NS_ASSUME_NONNULL_END
