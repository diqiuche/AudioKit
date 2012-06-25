//
//  OCSGrain.h
//  ExampleProject
//
//  Created by Adam Boulanger on 6/21/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "OCSOpcode.h"

@interface OCSGrain : OCSOpcode
{
    OCSParam *amplitude;
    OCSParam *pitch;
    OCSParam *grainDensity;
    OCSParamControl *amplitudeOffset;
    OCSParamControl *pitchOffset;
    OCSParamControl *grainDuration;
    OCSParamConstant *maxGrainDuration;
    OCSFunctionTable *grainFunction;
    OCSFunctionTable *windowFunction;
    BOOL isRandomGrainFunctionIndex;
    OCSParam *output;
}
@property (nonatomic, retain) OCSParam *output;

/// Initialization Statement
- (id)initWithAmplitude:(OCSParam *)amp
                  Pitch:(OCSParam *)pch
           GrainDensity:(OCSParam *)dens
        AmplitudeOffset:(OCSParamControl *)ampOffset
            PitchOffset:(OCSParamControl *)pchOffset
          GrainDuration:(OCSParamControl *)gdur
       MaxGrainDuration:(OCSParamConstant *)maxgdur
          GrainFunction:(OCSFunctionTable *)gFunction
         WindowFunction:(OCSFunctionTable *)wFunction;

/// Initialization Statement
- (id)initWithAmplitude:(OCSParam *)amp
                 Pitch:(OCSParam *)pch
          GrainDensity:(OCSParam *)dens
       AmplitudeOffset:(OCSParamControl *)ampOffset
           PitchOffset:(OCSParamControl *)pchOffset
         GrainDuration:(OCSParamControl *)gdur
      MaxGrainDuration:(OCSParamConstant *)maxgdur
         GrainFunction:(OCSFunctionTable *)gFunction
        WindowFunction:(OCSFunctionTable *)wFunction
IsRandomGrainFunctionIndex:(BOOL)isRandGrainIndex;

@end
