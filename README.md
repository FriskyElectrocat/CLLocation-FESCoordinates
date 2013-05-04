CLLocation-FESCoordinates
=========================

## About

A `CLLocation` category to handle degrees, minutes, and seconds

Convert from degrees, minutes, and seconds values to decimal degrees and back again. Also initialize a `CLLocation` object from degrees, minutes, and seconds values.

## Types

* `FESCLLocationDegrees` – double used to store the degrees component of a coordinate.
* `FESCLLocationMinutes` – double used to store the minutes component of a coordinate.
* `FESCLLocationSeconds` – double used to store the seconds component of a coordinate.
* `FESCLLocationCoordinate2D` – struct used to store a triplet of degrees, minutes, and seconds representing a coordinate.

## Functions and Methods

`FESCLLocationCoordinate2D FESCLLocationCoordinate2DMake(FESCLLocationDegrees degrees, FESCLLocationMinutes minutes, FESCLLocationSeconds seconds);`

Creates an `FESCLLocationCoordinate2D` struct from separate degrees, minutes, and seconds components.

`+ (CLLocation *)fes_initWithLatitude:(FESCLLocationCoordinate2D)latitude
                        andLongitude:(FESCLLocationCoordinate2D)longitude;`

Create a `CLLocation` object from two `FESCLLocationCoordinate2D` structs each representing a coordinate in degrees, minutes, and seconds.

`+ (CLLocationDegrees)fes_decimalDegreesForCoordinate:(FESCLLocationCoordinate2D)coordinate;`

Convert an `FESCLLocationCoordinate2D` struct representing a coordinate in degrees, minutes, and seconds to decimal degrees.

`+ (FESCLLocationCoordinate2D)fes_coordinateForDecimalDegrees:(CLLocationDegrees)degrees;`

Convert a `CLLocationDegrees` value representing decimal degrees to a `FESCLLocationCoordinate2D` struct representing a coordinate in degrees, minutes, and seconds.

## License

Copyright © 2012 Daniel Weeks.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

