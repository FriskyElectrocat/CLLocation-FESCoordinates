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
    FESCLLocationCoordinate2D latitude = FESCLLocationCoordinate2DMake(37, 46.3, 0);
    FESCLLocationCoordinate2D longitude = FESCLLocationCoordinate2DMake(-122, 13.4, 0);
    CLLocation *newLocation = [CLLocation fes_initFromDMSWithLatitude:latitude andLongitude:longitude];

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
    FESCLLocationDegreeMinDec latitude = FESCLLocationDegreeMinDecMake(37, 46.30002);
    FESCLLocationDegreeMinDec longitude = FESCLLocationDegreeMinDecMake(-122, 13.39998);
    CLLocation *newLocation = [CLLocation fes_initFromMinDecWithLatitude:latitude andLongitude:longitude];

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
    FESCLLocationCoordinate2D latitude = FESCLLocationCoordinate2DMake(37, 46.3, 0);
    FESCLLocationCoordinate2D longitude = FESCLLocationCoordinate2DMake(-122, 13.4, 0);
    CLLocationDegrees latitudeDeg = [CLLocation fes_decimalDegreesForCoordinate:latitude];
    STAssertEqualsWithAccuracy(latitudeDeg, 37.771667, 0.000001, @"known latitude and calculated latitude do not match");
    CLLocationDegrees longitudeDeg = [CLLocation fes_decimalDegreesForCoordinate:longitude];
    STAssertEqualsWithAccuracy(longitudeDeg, -122.223333, 0.000001, @"known longitude and calculated longitude do not match");
}

- (void)testFromDecimalDegreesToCoordinateDMS
{
    // known location
    // Oakland, California (37º 46.3' 18" N, 122 13.4' 24" W) [37.77166667 -122.223333]
    CLLocationDegrees latitude = 37.77166667;
    CLLocationDegrees longitude = -122.223333;
    FESCLLocationCoordinate2D latitudeFES = [CLLocation fes_coordinateForDecimalDegrees:latitude];
    STAssertEquals(latitudeFES.degrees, 37.0, @"known degrees does not match calculated");
    STAssertEquals(latitudeFES.minutes, 46.3, @"known minutes does not match calculated");
    STAssertEquals(latitudeFES.seconds, 18.0, @"known seconds does not match calculated");
    FESCLLocationCoordinate2D longitudeFES = [CLLocation fes_coordinateForDecimalDegrees:longitude];
    STAssertEquals(longitudeFES.degrees, -122.0, @"known degrees does not match calculated");
    STAssertEquals(longitudeFES.minutes, 13.4, @"known minutes does not match calculated");
    STAssertEquals(longitudeFES.seconds, 24.0, @"known seconds does not match calculated");
}

- (void)testToDecimalDegreesFromMinDec
{
    FESCLLocationDegreeMinDec latitude = FESCLLocationDegreeMinDecMake(37.0, 46.30002);
    FESCLLocationDegreeMinDec longitude = FESCLLocationDegreeMinDecMake(-122, 13.39998);
    CLLocationDegrees latitudeDeg = [CLLocation fes_decimalDegreesForCoordinateMinDec:latitude];
    STAssertEqualsWithAccuracy(latitudeDeg, 37.771667, 0.000001, @"known latitude and calculated latitude do not match");
    CLLocationDegrees longitudeDeg = [CLLocation fes_decimalDegreesForCoordinateMinDec:longitude];
    STAssertEqualsWithAccuracy(longitudeDeg, -122.223333, 0.000001, @"known longitude and calculated longitude do not match");
}

- (void)testFromDecimalDegreesToMinDec
{
    // known location
    // Oakland, California (37 46.3' N, 122 13.4' W) [37.771667 -122.223333]
    CLLocationDegrees latitude = 37.771667;
    CLLocationDegrees longitude = -122.223333;
    FESCLLocationDegreeMinDec latCoords = [CLLocation fes_minDecForDecimalDegrees:latitude];
    FESCLLocationDegreeMinDec longCoords = [CLLocation fes_minDecForDecimalDegrees:longitude];
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
    FESCLLocationMinDec2D location = [CLLocation fes_minDec2DForCoordinate:[knownLocation coordinate]];
    STAssertEquals(location.latitude.degrees, 36.0, @"known latitude degrees does not match calculated");
    STAssertEqualsWithAccuracy(location.latitude.minutes, 58.6101, 0.000001, @"known minutes does not match calculated");
    STAssertEquals(location.longitude.degrees, -122.0, @"known degrees does not match calculated");
    STAssertEqualsWithAccuracy(location.longitude.minutes, 1.95684, 0.000001, @"known minutes does not match calculated");
}

@end
