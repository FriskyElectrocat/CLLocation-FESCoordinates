//
//  FESCDViewController.m
//  CoordinatesDemo
//
//  Created by Dan Weeks on 2013-05-03.
//  Copyright (c) 2013 Frisky Electrocat Studios. All rights reserved.
//

#import "FESCDViewController.h"
#import "CLLocation+FESCoordinates.h"

@interface FESCDViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UITextField *degreesLat;
@property (weak, nonatomic) IBOutlet UITextField *minutesLat;
@property (weak, nonatomic) IBOutlet UITextField *secondsLat;
@property (weak, nonatomic) IBOutlet UITextField *degreesLong;
@property (weak, nonatomic) IBOutlet UITextField *minutesLong;
@property (weak, nonatomic) IBOutlet UITextField *secondsLong;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (nonatomic, readwrite) BOOL didZoom;

@end

@implementation FESCDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.coordinatesLabel.text = @"";
    self.coordinatesLabel.hidden = NO;
    self.didZoom = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButtonPressed:(id)sender {
    for (UITextField *tf in self.textFields) {
        if ([tf.text isEqualToString:@""]) {
            self.coordinatesLabel.text = @"ERROR: all fields must be filled";
            return;
        }
    }
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *latDegrees = [f numberFromString:self.degreesLat.text];
    NSNumber *latMinutes = [f numberFromString:self.minutesLat.text];
    NSNumber *latSeconds = [f numberFromString:self.secondsLat.text];
    NSNumber *longDegrees = [f numberFromString:self.degreesLong.text];
    NSNumber *longMinutes = [f numberFromString:self.minutesLong.text];
    NSNumber *longSeconds = [f numberFromString:self.secondsLong.text];

    FESCLLocationCoordinate2D latitude = FESCLLocationCoordinate2DMake((FESCLLocationDegrees)[latDegrees doubleValue],
                                                                       (FESCLLocationMinutes)[latMinutes doubleValue],
                                                                       (FESCLLocationSeconds)[latSeconds doubleValue]);
    FESCLLocationCoordinate2D longitude = FESCLLocationCoordinate2DMake((FESCLLocationDegrees)[longDegrees doubleValue],
                                                                        (FESCLLocationMinutes)[longMinutes doubleValue],
                                                                        (FESCLLocationSeconds)[longSeconds doubleValue]);
    CLLocation *location = [CLLocation fes_initWithLatitude:latitude andLongitude:longitude];

    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}

#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!self.didZoom) {
        MKCoordinateRegion region = self.mapView.region;
        region.span = MKCoordinateSpanMake(0.5, 0.5);
        [self.mapView setRegion:region animated:YES];
        self.didZoom = YES;
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    static NSCharacterSet *charSet = nil;
    if(!charSet) {
        charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"] invertedSet];
    }
    NSRange strLocation = [string rangeOfCharacterFromSet:charSet];
    return (strLocation.location == NSNotFound);
}

@end
