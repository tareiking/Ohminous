//
//  pickerResistorViewController.m
//  pickerResistor
//
//  Created by Tarei on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "pickerResistorViewController.h"

#pragma mark - 
#pragma mark TODO  mega ohms, removal of decimals for results, incorporate strings into tolerance, null the unapplicable colors, page for info, switch statement for choosing, 
#pragma mark -
#pragma mark Instance Variables

@implementation pickerResistorViewController
@synthesize tLabel, kLabel, mLabel;
@synthesize arrowPosition;
@synthesize picker, digits, colors, multiplier, tolerance, results, toleranceValues;
@synthesize resultLabel;

- (void)dealloc
{
    [arrowPosition release];
    [kLabel release];
    [kLabel release];
    [tLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark Init requirements for pickerView instance


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0 || component == 1){
        return [colors count];
    }
    
    if(component==2){
        return [ colors count ] - 2;
    }
    
    if(component==3){
        return [toleranceValues count];
    }
    else return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0 || component < 3){
        return [colors objectAtIndex:row];
    }
    if(component == 3){
        return [tolerance objectAtIndex:row];
    }
    else return @"none";
} 

- (void) initPickerValues {
    
  // an array is overkill, but is a proof of concept
  // results are still stored in variables
  self.results = [[NSMutableArray  alloc]  initWithObjects:
                    [NSNumber numberWithInt:0],
                    [NSNumber numberWithInt:0],
                    [NSNumber numberWithInt:0],
                    [NSString stringWithFormat:@"hello"], // store string values in this object field for tolerance
                    nil];

    // band colors.  values are dynamically deduced from the position in the array
    self.colors = [[NSArray alloc] initWithObjects:
                     @"Black", 
                     @"Brown", 
                     @"Red", 
                     @"Orange", 
                     @"Yellow", 
                     @"Green", 
                     @"Blue", 
                     @"Violet", 
                     @"Gray", 
                     @"White",
                     @"Gold",
                     @"Silver",
                     nil];

    // tolerance colors
    self.tolerance = [[NSArray alloc] initWithObjects:
                     @"Brown",     //1%
                     @"Red",       //2%
                     @"Green",     //0.5%
                     @"Blue",      //0.25%
                     @"Violet",    //0.1%
                     @"Gray",      //0.05%
                     @"Gold",      //5%
                     @"Silver",    //10%
                     @"none",      //20%
                     nil];

    // tolerance values
    self.toleranceValues = [[NSArray alloc] initWithObjects:
                     @"1%",
                     @"2%",
                     @"0.5%",    
                     @"0.1%",
                     @"0.05%",                            
                     @"5%",                            
                     @"10%",
                     @"20%",
                     nil];
}


# pragma mark - 
# pragma mark Calculate Values and update labels
# pragma mark TODO  NumberFormatter is leaking memory.  Talk to Rob to clear this up

- (void) calculateUpdate {
        
    float   bands       = round((first * 10) + (second));
    double  exponent    = (powf (10, third)); // wow - didn't even realise that pow(x, y) requires doubles and powf even existed
    double  resistance  = bands * exponent;
    
    
    NSNumberFormatter *nf   = [[NSNumberFormatter alloc] init]; // convert to a 'pretty' number format
    nf.numberStyle = NSNumberFormatterDecimalStyle;

    NSString *str           = [nf stringFromNumber:[NSNumber numberWithDouble:resistance]];    
    [nf release];
    
    // set visible toggles k M 
    if (resistance < 1) {
        self.resultLabel.text = [NSString stringWithFormat: @"0" ];
    } else {
        self.resultLabel.text = [NSString stringWithFormat: @"%@", str];
    }

    self.kLabel.hidden = YES;       // hiding labels preCalc
    self.mLabel.hidden = YES;       // hiding labels preCalc
    
    if (resistance > 999 && resistance < 99999){    // show K label
        self.kLabel.hidden = NO; 
    } 
    
    if (resistance > 99999){                        // show M label
        self.mLabel.hidden = NO; 
    }
    
    
    // this method of cleaning up isn't quite working
    nf = nil;
    str = nil;
    

    [str release];
}

#pragma mark -
#pragma mark Update Resistor Values based on user input
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{   
    // first band
    if(component == 0){
        [results insertObject:[NSNumber numberWithInt:row]atIndex:component];       // put value into results array
        first = [[results objectAtIndex:0] intValue];                               // put value into variable also, redundant
        self.arrowPosition.transform = CGAffineTransformMakeTranslation(10, 0);     // move the visual arrow to show which row has moved
        
    }
    
    // second band
    if(component == 1){
        [results insertObject:[NSNumber numberWithInt:row]atIndex:component];
        second = [[results objectAtIndex:1] intValue];
        self.arrowPosition.transform = CGAffineTransformMakeTranslation(80, 0);  
        
    }
    
    // third band
    if(component == 2){
        [results insertObject:[NSNumber numberWithInt:row]atIndex:component];
        third = [[results objectAtIndex:2] intValue];        
        self.arrowPosition.transform = CGAffineTransformMakeTranslation(160, 0);  
        
        
    }
    
    // fourth band (tolerance)
    if(component == 3){ // tolerance NSString
        [results insertObject:[NSNumber numberWithInt:row]atIndex:component];
        fourth = [[results objectAtIndex:3] intValue];        
        self.arrowPosition.transform = CGAffineTransformMakeTranslation(230, 0);    
        
        self.tLabel.text =  [NSString stringWithFormat:@"%@", [toleranceValues objectAtIndex:row]];         // set tLabel by position @ component 4
        
    }
    
    [self calculateUpdate]; // calculate resistance and update GUI
    
    
//    NSLog(@"First: %@.  Second: %@.  Third: %@.  Tolerance: %@.", [results objectAtIndex:0], [results objectAtIndex:1], [results objectAtIndex:2], [results objectAtIndex:4]);
}

#pragma mark -
#pragma mark Ordinary App Stuff

- (void)viewDidLoad
{   
    [self initPickerValues];  // method for populating picker values
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setArrowPosition:nil];
    [self setKLabel:nil];
    [self setTLabel:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
