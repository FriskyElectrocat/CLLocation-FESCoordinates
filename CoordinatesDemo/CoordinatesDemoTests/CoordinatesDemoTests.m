//
//  CoordinatesDemoTests.m
//  CoordinatesDemoTests
//
//  Created by Dan Weeks on 2013-05-03.
//  Copyright (c) 2013 Frisky Electrocat Studios. All rights reserved.
//

#import "CoordinatesDemoTests.h"
#import "CLLocation+FESCoordinates.h"

@implementation CoordinatesDemoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCreateLocationWithCoordinatesDMS
{
    // known location
    // Oakland, California (37 46.3' N, 122 13.4' W) [37.771667 -122.223333]
    CLLocation *knownLocation = [[CLLocation alloc] initWithLatitude:37.771667 longitude:-122.223333];
    FESCLLocationDegreesMinutesSeconds latitude = FESCLLocationDegreesMinutesSecondsMake(37, 46.3, 0);
    FESCLLocationDegreesMinutesSeconds longitude = FESCLLocationDegreesMinutesSecondsMake(-122, 13.4, 0);
    FESCLLocationDegreesMinutesSeconds2D coordinate = FESCLLocationDegreesMinutesSeconds2DMake(latitude, longitude);
    CLLocation *newLocation = [CLLocation fes_initFromDegreesMinutesSeconds2D:coordinate];

    STAssertEqualsWithAccuracy(knownLocation.coordinate.latitude,
                               newLocation.coordinate.latitude,
                               0.000001,
                               @"Known CLLocation and generated CLLocation latitude do not match");
    STAssertEqualsWithAccuracy(knownLocation.coordinate.longitude,
                               newLocation.coordinate.longitude,
                               0.000001,
                               @"Known CLLocation and generated CLLocation longitude do not match");
}

- (void)testCreateLocationWithCoordinatesMinDec
{
    // known location
    // Oakland, California (37 46.3' N, 122 13.4' W) [37.771667 -122.223333]
    CLLocation *knownLocation = [[CLLocation alloc] initWithLatitude:37.771667 longitude:-122.223333];
    FESCLLocationDegreesMinDec latitude = FESCLLocationDegreesMinDecMake(37, 46.30002);
    FESCLLocationDegreesMinDec longitude = FESCLLocationDegreesMinDecMake(-122, 13.39998);
    FESCLLocationMinDec2D coordinate = FESCLLocationMinDec2DMake(latitude, longitude);
    CLLocation *newLocation = [CLLocation fes_initFromMinDec2D:coordinate];

    STAssertEqualsWithAccuracy(knownLocation.coordinate.latitude,
                               newLocation.coordinate.latitude,
                               0.000001,
                               @"Known CLLocation and generated CLLocation latitude do not match");
    STAssertEqualsWithAccuracy(knownLocation.coordinate.longitude,
                               newLocation.coordinate.longitude,
                               0.000001,
                               @"Known CLLocation and generated CLLocation longitude do not match");
}

- (void)testToDecimalDegreesFromCoordinateDMS
{
    // known location
    // Oakland, California (37 46.3' N, 122 13.4' W) [37.771667 -122.223333]
    FESCLLocationDegreesMinutesSeconds latitude = FESCLLocationDegreesMinutesSecondsMake(37, 46.3, 0);
    FESCLLocationDegreesMinutesSeconds longitude = FESCLLocationDegreesMinutesSecondsMake(-122, 13.4, 0);
    CLLocationDegrees latitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinutesSeconds:latitude];
    STAssertEqualsWithAccuracy(latitudeDeg, 37.771667, 0.000001, @"known latitude and calculated latitude do not match");
    CLLocationDegrees longitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinutesSeconds:longitude];
    STAssertEqualsWithAccuracy(longitudeDeg, -122.223333, 0.000001, @"known longitude and calculated longitude do not match");
}

- (void)testFromDecimalDegreesToCoordinateDMS
{
    // known location
    // Oakland, California (37º 46.3' 18" N, 122 13.4' 24" W) [37.77166667 -122.223333]
    CLLocationDegrees latitude = 37.77166667;
    CLLocationDegrees longitude = -122.223333;
    FESCLLocationDegreesMinutesSeconds latitudeFES = [CLLocation fes_degreesMinutesSecondsForDecimalDegrees:latitude];
    STAssertEquals(latitudeFES.degrees, 37.0, @"known degrees does not match calculated");
    STAssertEquals(latitudeFES.minutes, 46.3, @"known minutes does not match calculated");
    STAssertEquals(latitudeFES.seconds, 18.0, @"known seconds does not match calculated");
    FESCLLocationDegreesMinutesSeconds longitudeFES = [CLLocation fes_degreesMinutesSecondsForDecimalDegrees:longitude];
    STAssertEquals(longitudeFES.degrees, -122.0, @"known degrees does not match calculated");
    STAssertEquals(longitudeFES.minutes, 13.4, @"known minutes does not match calculated");
    STAssertEquals(longitudeFES.seconds, 24.0, @"known seconds does not match calculated");
}

- (void)testFromCoordinateToDMS2D
{
    CLLocation *knownLocation = [[CLLocation alloc] initWithLatitude:37.77166667 longitude:-122.223333];
    FESCLLocationDegreesMinutesSeconds2D location = [CLLocation fes_degreesMinutesSeconds2DForCoordinate:[knownLocation coordinate]];
    STAssertEquals(location.latitude.degrees, 37.0, @"known degrees does not match calculated");
    STAssertEquals(location.latitude.minutes, 46.3, @"known minutes does not match calculated");
    STAssertEquals(location.latitude.seconds, 18.0, @"known seconds does not match calculated");
    STAssertEquals(location.longitude.degrees, -122.0, @"known degrees does not match calculated");
    STAssertEquals(location.longitude.minutes, 13.4, @"known minutes does not match calculated");
    STAssertEquals(location.longitude.seconds, 24.0, @"known seconds does not match calculated");
}

- (void)testFormattedStringForDMS
{
    CLLocationDegrees latitude = 37.77166667;
    CLLocationDegrees longitude = -122.223333;
    FESCLLocationDegreesMinutesSeconds latCoords = [CLLocation fes_degreesMinutesSecondsForDecimalDegrees:latitude];
    FESCLLocationDegreesMinutesSeconds longCoords = [CLLocation fes_degreesMinutesSecondsForDecimalDegrees:longitude];
    NSString *latString = [CLLocation fes_formattedStringForDegreesMinutesSeconds:latCoords withAxis:FESAxisLatitude];
    NSString *longString = [CLLocation fes_formattedStringForDegreesMinutesSeconds:longCoords withAxis:FESAxisLongitude];
    STAssertEqualObjects(latString, @"37° 46.3′ 18″ N", @"known formatted string for latitude does not match output.");
    STAssertEqualObjects(longString, @"122° 13.4′ 24″ W", @"known formatted string for longitude does not match output.");

}
- (void)testToDecimalDegreesFromMinDec
{
    FESCLLocationDegreesMinDec latitude = FESCLLocationDegreesMinDecMake(37.0, 46.30002);
    FESCLLocationDegreesMinDec longitude = FESCLLocationDegreesMinDecMake(-122, 13.39998);
    CLLocationDegrees latitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinDec:latitude];
    STAssertEqualsWithAccuracy(latitudeDeg, 37.771667, 0.000001, @"known latitude and calculated latitude do not match");
    CLLocationDegrees longitudeDeg = [CLLocation fes_decimalDegreesForDegreesMinDec:longitude];
    STAssertEqualsWithAccuracy(longitudeDeg, -122.223333, 0.000001, @"known longitude and calculated longitude do not match");
}

- (void)testFromDecimalDegreesToMinDec
{
    // known location
    // Oakland, California (37 46.3' N, 122 13.4' W) [37.771667 -122.223333]
    CLLocationDegrees latitude = 37.771667;
    CLLocationDegrees longitude = -122.223333;
    FESCLLocationDegreesMinDec latCoords = [CLLocation fes_degreesMinDecForDecimalDegrees:latitude];
    FESCLLocationDegreesMinDec longCoords = [CLLocation fes_degreesMinDecForDecimalDegrees:longitude];
    STAssertEquals(latCoords.degrees, 37.0, @"known degrees does not match calculated");
    STAssertEqualsWithAccuracy(latCoords.minutes, 46.30002, 0.000001, @"known minutes does not match calculated");
    STAssertEquals(longCoords.degrees, -122.0, @"known degrees does not match calculated");
    STAssertEqualsWithAccuracy(longCoords.minutes, 13.39998, 0.000001, @"known minutes does not match calculated");
}

- (void)testFromCoordinateToMinDec2D
{
    // known location
    // The Abbey, Santa Cruz, California (36 58.6' N, 122 2.0' W) [36.976835 -122.032614]
    CLLocation *knownLocation = [[CLLocation alloc] initWithLatitude:36.976835 longitude:-122.032614];
    FESCLLocationMinDec2D location = [CLLocation fes_degreesMinDec2DForCoordinate2D:[knownLocation coordinate]];
    STAssertEquals(location.latitude.degrees, 36.0, @"known latitude degrees does not match calculated");
    STAssertEqualsWithAccuracy(location.latitude.minutes, 58.6101, 0.000001, @"known minutes does not match calculated");
    STAssertEquals(location.longitude.degrees, -122.0, @"known degrees does not match calculated");
    STAssertEqualsWithAccuracy(location.longitude.minutes, 1.95684, 0.000001, @"known minutes does not match calculated");
}

- (void)testFormattedStringForMinDecDegree
{
    CLLocationDegrees latitude = 36.976835;
    CLLocationDegrees longitude = -122.032614;
    FESCLLocationDegreesMinDec latCoords = [CLLocation fes_degreesMinDecForDecimalDegrees:latitude];
    FESCLLocationDegreesMinDec longCoords = [CLLocation fes_degreesMinDecForDecimalDegrees:longitude];
    NSString *latString = [CLLocation fes_formattedStringForMinDecDegree:latCoords withAxis:FESAxisLatitude];
    NSString *longString = [CLLocation fes_formattedStringForMinDecDegree:longCoords withAxis:FESAxisLongitude];
    STAssertEqualObjects(latString, @"36°58.6101 N", @"known formatted string for latitude does not match output.");
    STAssertEqualObjects(longString, @"122°1.9568 W", @"known formatted string for longitude does not match output.");
}

@end
