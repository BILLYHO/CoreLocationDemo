//
//  ViewController.m
//  LocatonDemo
//
//  Created by billy.ho on 8/7/14.
//  Copyright (c) 2014 BILLYHO. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"CoreLocation Demo";
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 100)];
    _label.text = @"Locating...";
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 120, 50)];
    [button setTitle:@"Relocate" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // this creates the CCLocationManager that will find your current location
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// this delegate is called when the app successfully finds your current location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [_locationManager stopUpdatingLocation];
    NSLog(@"stop");
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSLog(@"%@", placemark.locality);
            _label.text = [NSString stringWithFormat:@"%@, %@",  [placemark locality], [placemark country]];
        }
    }];
}

- (void) refresh
{
    _label.text = @"Locating...";
    [_locationManager startUpdatingLocation];
    NSLog(@"start");
}

@end
