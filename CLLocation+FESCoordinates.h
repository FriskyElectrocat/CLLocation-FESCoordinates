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

typedef struct {
	FESCLLocationDegrees degrees;
    FESCLLocationMinutes minutes;
    FESCLLocationSeconds seconds;
} FESCLLocationCoordinate2D;

// MinDec Handling
typedef struct {
    FESCLLocationDegrees degrees;
    FESCLLocationMinutes minutes;
} FESCLLocationMinDecCoordinate;

// a convenience funciton to make the FESCLLocationCoordinate2D struct
FESCLLocationCoordinate2D FESCLLocationCoordinate2DMake(FESCLLocationDegrees degrees, FESCLLocationMinutes minutes, FESCLLocationSeconds seconds);

FESCLLocationMinDecCoordinate FESCLLocationMinDecCoordinateMake(FESCLLocationDegrees degrees,
                                                                FESCLLocationMinutes minutes);

@interface CLLocation (FESCoordinates)

+ (CLLocation *)fes_initWithLatitude:(FESCLLocationCoordinate2D)latitude
                        andLongitude:(FESCLLocationCoordinate2D)longitude;

+ (CLLocationDegrees)fes_decimalDegreesForCoordinate:(FESCLLocationCoordinate2D)coordinate;

+ (FESCLLocationCoordinate2D)fes_coordinateForDecimalDegrees:(CLLocationDegrees)degrees;

+ (FESCLLocationMinDecCoordinate)fes_minDecForDecimalDegrees:(CLLocationDegrees)degrees;

@end
