//
//  pickerResistorViewController.h
//  pickerResistor
//
//  Created by Tarei on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pickerResistorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    
    int     first, second, third, fourth, fifth;
    
}
@property (nonatomic, retain) IBOutlet UILabel *tLabel;
@property (nonatomic, retain) IBOutlet UILabel *kLabel;
@property (nonatomic, retain) IBOutlet UILabel *mLabel;
@property (nonatomic, retain) IBOutlet UIImageView *arrowPosition;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;
@property (nonatomic, retain) NSArray *digits;
@property (nonatomic, retain) NSArray *multiplier;
@property (nonatomic, retain) NSArray *colors;
@property (nonatomic, retain) NSArray *tolerance;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) NSArray *toleranceValues;




@end
