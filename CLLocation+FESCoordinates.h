//
//  CLLocation+FESCoordinates.h
//
//  Created by Dan Weeks on 2012-03-15.
//  Copyright © 2012 Daniel Weeks.
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
typedef double FESCLLocationDegrees; 
typedef double FESCLLocationMinutes;
typedef double FESCLLocationSeconds;

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
	FESCLLocationDegrees degrees;
    FESCLLocationMinutes minutes;
    FESCLLocationSeconds seconds;
} FESCLLocationDegreesMinutesSeconds;

typedef struct {
    FESCLLocationDegreesMinutesSeconds latitude;
    FESCLLocationDegreesMinutesSeconds longitude;
} FESCLLocationDegreesMinutesSeconds2D;

// MinDec Data Type
typedef struct {
    FESCLLocationDegrees degrees;
    FESCLLocationMinutes minutes;
} FESCLLocationDegreesMinDec;

typedef struct {
    FESCLLocationDegreesMinDec latitude;
    FESCLLocationDegreesMinDec longitude;
} FESCLLocationMinDec2D;

// a convenience function to make the FESCLLocationCoordinate2D struct
FESCLLocationDegreesMinutesSeconds FESCLLocationDegreesMinutesSecondsMake(FESCLLocationDegrees degrees, FESCLLocationMinutes minutes, FESCLLocationSeconds seconds);

// a convenience function to make the FESCLLocationDegreesMinDec struct
FESCLLocationDegreesMinDec FESCLLocationDegreesMinDecMake(FESCLLocationDegrees degrees,
                                                                FESCLLocationMinutes minutes);

FESCLLocationDegreesMinutesSeconds2D FESCLLocationDegreesMinutesSeconds2DMake(FESCLLocationDegreesMinutesSeconds latitude,
                                                                              FESCLLocationDegreesMinutesSeconds longitude);

FESCLLocationMinDec2D FESCLLocationMinDec2DMake(FESCLLocationDegreesMinDec latitude,
                                                FESCLLocationDegreesMinDec longitude);

@interface CLLocation (FESCoordinates)

+ (CLLocation *)fes_initFromDegreesMinutesSeconds2D:(FESCLLocationDegreesMinutesSeconds2D)coordinate;

+ (CLLocation *)fes_initFromMinDec2D:(FESCLLocationMinDec2D)coordinate;

+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinutesSeconds:(FESCLLocationDegreesMinutesSeconds)coordinate;

+ (FESCLLocationDegreesMinutesSeconds)fes_degreesMinutesSecondsForDecimalDegrees:(CLLocationDegrees)degrees;

+ (FESCLLocationDegreesMinutesSeconds2D)fes_degreesMinutesSeconds2DForCoordinate:(CLLocationCoordinate2D)coordinate;

+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinDec:(FESCLLocationDegreesMinDec)coordinate;

+ (FESCLLocationDegreesMinDec)fes_degreesMinDecForDecimalDegrees:(CLLocationDegrees)degrees;

+ (FESCLLocationMinDec2D)fes_degreesMinDec2DForCoordinate2D:(CLLocationCoordinate2D)coordinate;

// return a string representing the written notation for a DMS Coordinate.
+ (NSString *)fes_formattedStringForDegreesMinutesSeconds:(FESCLLocationDegreesMinutesSeconds)degrees_ withAxis:(FESAxis)axis;
// return a string representing the written notation for a MinDec Coordinate Degree.
+ (NSString *)fes_formattedStringForMinDecDegree:(FESCLLocationDegreesMinDec)degrees withAxis:(FESAxis)axis;


@end
