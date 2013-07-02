//
//  CLLocation+FESCoordinates.m
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

#import "CLLocation+FESCoordinates.h"

double FESMinutesInDegreeConstant = 60.0;
double FESSecondsInMinuteConstant = 60.0;
double FESSecondsInDegreeConstant = 3600.0;

FESCLLocationDegreesMinutesSeconds FESCLLocationDegreesMinutesSecondsMake(FESCLLocationDegrees degrees,
                                                                 FESCLLocationMinutes minutes,
                                                                 FESCLLocationSeconds seconds)
{
    FESCLLocationDegreesMinutesSeconds retValue;
    retValue.degrees = degrees;
    retValue.minutes = minutes;
    retValue.seconds = seconds;
    return retValue;
}

FESCLLocationDegreesMinutesSeconds2D FESCLLocationDegreesMinutesSeconds2DMake(FESCLLocationDegreesMinutesSeconds latitude,
                                                                              FESCLLocationDegreesMinutesSeconds longitude)
{
    FESCLLocationDegreesMinutesSeconds2D retValue;
    retValue.latitude = latitude;
    retValue.longitude = longitude;
    return retValue;
}

FESCLLocationDegreesMinDec FESCLLocationDegreesMinDecMake(FESCLLocationDegrees degrees,
                                                                FESCLLocationMinutes minutes)
{
    FESCLLocationDegreesMinDec retValue;
    retValue.degrees = degrees;
    retValue.minutes = minutes;
    return retValue;
}

FESCLLocationMinDec2D FESCLLocationMinDec2DMake(FESCLLocationDegreesMinDec latitude,
                                                FESCLLocationDegreesMinDec longitude)
{
    FESCLLocationMinDec2D retValue;
    retValue.latitude = latitude;
    retValue.longitude = longitude;
    return retValue;
}

@implementation CLLocation (FESCoordinates)

+ (CLLocation *)fes_initFromDegreesMinutesSeconds2D:(FESCLLocationDegreesMinutesSeconds2D)coordinate;
{
    CLLocationDegrees latitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinutesSeconds:coordinate.latitude];
    CLLocationDegrees longitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinutesSeconds:coordinate.longitude];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitudeDeg longitude:longitudeDeg];
    return location;
}

+ (CLLocation *)fes_initFromMinDec2D:(FESCLLocationMinDec2D)coordinate
{
    CLLocationDegrees latitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinDec:coordinate.latitude];
    CLLocationDegrees longitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinDec:coordinate.longitude];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitudeDeg longitude:longitudeDeg];
    return location;
}

+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinutesSeconds:(FESCLLocationDegreesMinutesSeconds)coordinate
{
    NSInteger degreesSign = 1;
    if (coordinate.degrees < 0.0){
        degreesSign = -1;
    }
    CLLocationDegrees retDegrees = coordinate.degrees;
    retDegrees += degreesSign * (coordinate.minutes / FESMinutesInDegreeConstant);
    retDegrees += degreesSign * (coordinate.seconds / FESSecondsInDegreeConstant);
    return retDegrees;
}

+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinDec:(FESCLLocationDegreesMinDec)coordinate
{
    NSInteger degreesSign = 1;
    if (coordinate.degrees < 0.0){
        degreesSign = -1;
    }
    CLLocationDegrees retDegrees = coordinate.degrees;
    retDegrees += degreesSign * (coordinate.minutes / FESMinutesInDegreeConstant);
    return retDegrees;
}

+ (FESCLLocationDegreesMinutesSeconds)fes_degreesMinutesSecondsForDecimalDegrees:(CLLocationDegrees)degrees_
{

    double seconds = round(fabs(degrees_ * FESSecondsInDegreeConstant));
    double degrees = floor(seconds / FESSecondsInDegreeConstant);
    if (degrees_ < 0.0) {
        degrees *= -1.0;
    }
    seconds = fmod(seconds, FESSecondsInDegreeConstant);
    double minutes = seconds / FESSecondsInMinuteConstant;
    seconds = fmod(seconds, FESMinutesInDegreeConstant);

    return FESCLLocationDegreesMinutesSecondsMake((FESCLLocationDegrees)degrees,
                                         (FESCLLocationMinutes)minutes,
                                         (FESCLLocationSeconds)seconds);
}

+ (FESCLLocationDegreesMinDec)fes_degreesMinDecForDecimalDegrees:(CLLocationDegrees)degrees_
{
    // Let's get the whole number value for the degrees
    double degrees = floor(fabs(degrees_));

    // if it's south or west, the degrees will be negative.  Let's check and make
    // sure we've got the degrees signed correctly.
    if (degrees_ < 0.0) {
        degrees *= -1.0;
    }

    // now for minutes
    double minutes = (fabs(degrees_) - fabs(degrees)) * FESMinutesInDegreeConstant;

    // and let's return our MinDec representation.
    return FESCLLocationDegreesMinDecMake((FESCLLocationDegrees)degrees,
                                             (FESCLLocationMinutes)minutes);
}

+ (FESCLLocationDegreesMinutesSeconds2D)fes_degreesMinutesSeconds2DForCoordinate:(CLLocationCoordinate2D)coordinate
{
    FESCLLocationDegreesMinutesSeconds latitude = [CLLocation fes_degreesMinutesSecondsForDecimalDegrees:coordinate.latitude];
    FESCLLocationDegreesMinutesSeconds longitude = [CLLocation fes_degreesMinutesSecondsForDecimalDegrees:coordinate.longitude];

    // and let's return our MinDec representation.
    return FESCLLocationDegreesMinutesSeconds2DMake(latitude, longitude);
}

+ (FESCLLocationMinDec2D)fes_degreesMinDec2DForCoordinate2D:(CLLocationCoordinate2D)coordinate
{
    FESCLLocationDegreesMinDec latitude = [CLLocation fes_degreesMinDecForDecimalDegrees:coordinate.latitude];
    FESCLLocationDegreesMinDec longitude = [CLLocation fes_degreesMinDecForDecimalDegrees:coordinate.longitude];
        
    // and let's return our MinDec representation.
    return FESCLLocationMinDec2DMake(latitude, longitude);
}

+ (NSString *)fes_formattedStringForDegreesMinutesSeconds:(FESCLLocationDegreesMinutesSeconds)degrees_ withAxis:(FESAxis)axis
{

    NSString *direction = nil;

    // convert the components of an FESCLLocationDegreesMinutesSeconds to NSNumbers
    // so that they can be used by the NSNumber Formatter.
    NSNumber *nDegrees = @(fabs(degrees_.degrees));
    NSNumber *nMinutes = @(degrees_.minutes);
    NSNumber *nSeconds = @(degrees_.seconds);

    // Set up the formatter with the appropriate output format and convert
    // our NSNumbers. format would look something like this: 123.4567
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"##0.####"];
    NSString *degrees = [numberFormatter stringFromNumber:nDegrees];
    NSString *minutes = [numberFormatter stringFromNumber:nMinutes];
    NSString *seconds = [numberFormatter stringFromNumber:nSeconds];

    // Based upon the access, we need to set the direction string based upon
    // whether it's a postive or negative value.
    if (axis == FESAxisLatitude) {
        if (degrees_.degrees < 0.0) {
            direction = @"S";
        } else {
            direction = @"N";
        }
    } else {  // FESAxisLongitude
        if (degrees_.degrees < 0.0) {
            direction = @"W";
        } else {
            direction = @"E";
        }
    }

    // now return a formatted string using our converted degrees data.
    return [NSString stringWithFormat:@"%@° %@′ %@″ %@", degrees, minutes, seconds, direction];
}

+ (NSString *)fes_formattedStringForMinDecDegree:(FESCLLocationDegreesMinDec)degrees_ withAxis:(FESAxis)axis
{

    NSString *direction = nil;
 
    // convert the components of an FESCLLocationDegreesMinDec to NSNumbers
    // so that they can be used by the NSNumber Formatter.
    NSNumber *nDegrees = @(fabs(degrees_.degrees));
    NSNumber *nMinutes = @(degrees_.minutes);
    
    // Set up the formatter with the appropriate output format and convert
    // our NSNumbers. format would look something like this: 123.4567
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"##0.####"];
    NSString *degrees = [numberFormatter stringFromNumber:nDegrees];
    NSString *minutes = [numberFormatter stringFromNumber:nMinutes];
    
    // Based upon the access, we need to set the direction string based upon
    // whether it's a postive or negative value.
    if (axis == FESAxisLatitude) {
        if (degrees_.degrees < 0.0) {
            direction = @"S";
        } else {
            direction = @"N";
        }
    } else {  // FESAxisLongitude
        if (degrees_.degrees < 0.0) {
            direction = @"W";
        } else {
            direction = @"E";
        }
    }
    
    // now return a formatted string using our converted degrees data.
    return [NSString stringWithFormat:@"%@°%@ %@", degrees, minutes, direction];
}

@end
