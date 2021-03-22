//
//  ArucoNode.m
//  cvAruco
//
//  Created by Alex Chang on 2020/10/5.
//  Copyright © 2020 Dan Park. All rights reserved.
//

#import "ArucoNode.h"

@implementation ArucoNode

- (instancetype)initWithSize:(CGFloat)sz :(NSInteger)arucoId
{
    self = [super init];
    if (self) {
        self.size = sz;
        self.identifier = arucoId;
        
        self.geometry = [SCNBox boxWithWidth:self.size height:self.size length:self.size chamferRadius:0];
        SCNMaterial *mat = [SCNMaterial material];
        self.geometry.materials = @[mat];
        
        CGFloat hue = (CGFloat)((arucoId * 3) % 250);
        UIColor *color = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1.0];
        mat.diffuse.contents = color;
    }
    return self;
}

@end
