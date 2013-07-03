CLLocation-FESCoordinates
=========================

## About

A `CLLocation` category to handle various representations of map coordinates.

With this category, you can:

* Convert from degrees, minutes, and seconds values to decimal degrees and back again.
* Convert from decimal degrees to MinDec values of degrees and minutes and back again.
* Initialize a `CLLocation` object from degrees, minutes, and seconds  or MinDec values.

## Types

* `FESLocationDegrees` – double used to store the degrees component of a coordinate.
* `FESLocationMinutes` – double used to store the minutes component of a coordinate.
* `FESLocationSeconds` – double used to store the seconds component of a coordinate.
* `FESLocationDegreesMinutesSeconds` – struct used to store a triplet of degrees, minutes, and seconds representing a coordinate.
* `FESLocationDegreesMinutesSeconds2D` – struct used to store a pair of FESLocationDegreesMinutesSeconds that represent a coordinate.
* `FESLocationDegreesMinDec` - struct used to store of degrees and seconds representing a MinDec coordinate.
* `FESLocationMinDec2D` - struct used to store a pair of FESLocationMinDec2D that represent a location.

## Functions and Methods

`FESLocationDegreesMinutesSeconds FESLocationDegreesMinutesSecondsMake(FESLocationDegrees degrees, FESLocationMinutes minutes, FESLocationSeconds seconds);`

Creates an `FESLocationDegreesMinutesSeconds` struct from separate degrees, minutes, and seconds components.

`FESLocationDegreesMinDec FESLocationDegreesMinDecMake(FESLocationDegrees degrees, FESLocationMinutes minutes);`

Creates an `FESLocationDegreesMinDec` struct from two components: degrees and minutes.

`FESLocationMinDec2D FESLocationMinDec2DMake(FESLocationDegreesMinDec latitude, FESLocationDegreesMinDec longitude);`

Creates a FESLocationMinDec2D struct from a pair of  FESLocationMinDecCoordinate to represent a location.

`+ (CLLocation *)fes_initFromDegreesMinutesSeconds2D:(FESLocationDegreesMinutesSeconds2D)location;`

Create a `CLLocation` object from an `FESLocationDegreesMinutesSeconds2D` struct representing a location in degrees, minutes, and seconds.

`+ (CLLocation *)fes_initFromMinDec2D:(FESLocationMinDec2D)location;`

Create a `CLLocation` object from an `FESLocationMinDec2D` struct representing a MinDec location in degrees and minutes.

`+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinutesSeconds:(FESLocationDegreesMinutesSeconds)coordinate;`

Convert an `FESLocationDegreesMinutesSeconds` struct representing a coordinate in degrees, minutes, and seconds to decimal degrees.

`+ (CLLocationDegrees)fes_decimalDegreesForDegreesMinDec:(FESLocationDegreesMinDec)coordinate;`

Convert an `FESLocationDegreesMinDec` struct representing a MinDec coordinate in degrees and minutes to decimal degrees.

`+ (FESLocationDegreesMinutesSeconds)fes_degreesMinutesSecondsForDecimalDegrees:(CLLocationDegrees)degrees;`

Convert a `CLLocationDegrees` value representing decimal degrees to an `FESLocationCoordinate2D` struct representing a coordinate in degrees, minutes, and seconds.

`+ (FESLocationDegreesMinDec)fes_degreesMinDecForDecimalDegrees:(CLLocationDegrees)degrees;`

Convert a `CLLocationDegrees` value representing decimal degrees to an `FESLocationDegreesMinDec` struct representing one axis of a MinDec coordinate  in degrees and minutes.

`+ (FESLocationDegreesMinutesSeconds2D)fes_degreesMinutesSeconds2DForCoordinate:(CLLocationCoordinate2D)location;`

Convert a `CLLocationCoordinate2D` value representing a location to `FESLocationDegreesMinutesSeconds2D` struct representing a location in degrees, minutes, and seconds format.

`+ (FESLocationMinDec2D)fes_degreesMinDec2DForCoordinate:(CLLocationCoordinate2D)location;`

Convert a `CLLocationCoordinate2D` value representing a location to `FESLocationMinDec2D` struct representing a location in MinDec format.

`+ (NSString *)fes_formattedStringForDegreesMinutesSeconds:(FESLocationDegreesMinutesSeconds)degrees withAxis:(FESAxis)axis;`

Format and return an `NSString` with the values represented by an `FESLocationDegreesMinutesSeconds` and it's axis (latitude or longitude).

`+ (NSString *)fes_formattedStringForMinDecDegree:(FESLocationDegreesMinDec)degrees withAxis:(FESAxis)axis;`

Format and return an `NSString` with the values represented by an `FESLocationDegreesMinDec` and it's axis (latitude or longitude).

## License

See `LICENSE` file.
