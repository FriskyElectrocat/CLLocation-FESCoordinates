//
//  CLLocation+FESCoordinates.h
//
//  Created by Dan Weeks on 2012-03-15.
//  Copyright © 2012-2013 Daniel Weeks & Johnnie Pittman.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <CoreLocation/CoreLocation.h>

// extend from CLLocationDegrees typedef for minutes and seconds
typedef double FESLocationDegrees;
typedef double FESLocationMinutes;
typedef double FESLocationSeconds;

// constants for formulas
extern double FESMinutesInDegreeConstant;
extern double FESSecondsInMinuteConstant;
extern double FESSecondsInDegreeConstant;

// for specifying the axis that a degree is found on.
typedef enum {
    FESAxisLatitude,
    FESAxisLongitude
} FESAxis;

// Degrees Minutes Seconds Data Type
typedef struct {
	FESLocationDegrees degrees;
    FESLocationMinutes minutes;
    FESLocationSeconds seconds;
} FESLocationDegreesMinutesSeconds;

typedef struct {
    FESLocationDegreesMinutesSeconds latitude;
    FESLocationDegreesMinutesSeconds longitude;
} FESLocationDegreesMinutesSeconds2D;

// MinDec Data Type
typedef struct {
    FESLocationDegrees degrees;
    FESLocationMinutes minutes;
} FESLocationDegreesMinDec;

typedef struct {
    FESLocationDegreesMinDec latitude;
    FESLocationDegreesMinDec longitude;
} FESLocationMinDec2D;

// a convenience function to make the FESLocationCoordinate2D struct
FESLocationDegreesMinutesSeconds FESLocationDegreesMinutesSecondsMake(FESLocationDegrees degrees,
                                                                          FESLocationMinutes minutes,
                                                                          FESLocationSeconds seconds);

// a convenience function to make the FESLocationDegreesMinDec struct
FESLocationDegreesMinDec FESLocationDegreesMinDecMake(FESLocationDegrees degrees,
                                                          FESLocationMinutes minutes);

FESLocationDegreesMinutesSeconds2D FESLocationDegreesMinutesSeconds2DMake(FESLocationDegreesMinutesSeconds latitude,
                                                                              FESLocationDegreesMinutesSeconds longitude);

FESLocationMinDec2D FESLocationMinDec2DMake(FESLocationDegreesMinDec latitude,
                                                FESLocationDegreesMinDec longitude);

@interface CLLocation (FESCoordinates)

+ (CLLocation *)fes_initFromDegreesMinutesSeconds2D:(FESLocationDegreesMinutesSeconds2D)coordinate;

+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinutesSeconds:(FESLocationDegreesMinutesSeconds)coordinate;

+ (FESLocationDegreesMinutesSeconds)fes_degreesMinutesSecondsForDecimalDegrees:(CLLocationDegrees)degrees;

+ (FESLocationDegreesMinutesSeconds2D)fes_degreesMinutesSeconds2DForCoordinate:(CLLocationCoordinate2D)coordinate;

+ (CLLocation *)fes_initFromMinDec2D:(FESLocationMinDec2D)coordinate;

+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinDec:(FESLocationDegreesMinDec)coordinate;

+ (FESLocationDegreesMinDec)fes_degreesMinDecForDecimalDegrees:(CLLocationDegrees)degrees;

+ (FESLocationMinDec2D)fes_degreesMinDec2DForCoordinate2D:(CLLocationCoordinate2D)coordinate;

// return a string representing the written notation for a DMS Coordinate.
+ (NSString *)fes_formattedStringForDegreesMinutesSeconds:(FESLocationDegreesMinutesSeconds)degrees_
                                                 withAxis:(FESAxis)axis;
// return a string representing the written notation for a MinDec Coordinate Degree.
+ (NSString *)fes_formattedStringForMinDecDegree:(FESLocationDegreesMinDec)degrees
                                        withAxis:(FESAxis)axis;

@end
