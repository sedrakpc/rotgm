//
//  Constants.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 3/2/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#ifndef Rotgm_Constants_h
#define Rotgm_Constants_h

#define NSLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DEFAULT_TINT_COLOR [UIColor colorWithRed:37.0/255.0 green:150.0/255.0 blue:32.0/255.0 alpha:1.0]

#define LIGHT_GRAY_COLOR [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]

#endif
