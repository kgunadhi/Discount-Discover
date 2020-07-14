//
//  DealCell.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"

NS_ASSUME_NONNULL_BEGIN

@interface DealCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Deal *deal;

@end

NS_ASSUME_NONNULL_END
