//
//  APIManager.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "APIManager.h"
#import "LocationManager.h"

@interface APIManager()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation APIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    return self;
}

- (void)fetchDealsWithRadius:(double)radius numberOfDeals:(int)number completion:(void(^)(NSArray<Deal *> *deals, NSError *error))completion {
    
    // get API key and location coordinate for request
    NSString *const baseURL = @"https://api.discountapi.com/v2/deals?api_key=%@&location=%f,%f&radius=%f&per_page=%d&order=distance";
    NSString *apiKey = [APIManager getAPIKey:@"DiscountAPIKey"];
    CLLocationCoordinate2D locationCoordinate = [LocationManager sharedLocationManager].currentLocationCoordinate;
    
    // put together URL and send request to API
    NSString *urlString = [NSString stringWithFormat:baseURL, apiKey, locationCoordinate.latitude, locationCoordinate.longitude, radius, number];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        }
        else {
            // create array of deals from response
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray<NSDictionary *> *dictionaries = dataDictionary[@"deals"];
            NSArray<Deal *> *deals = [Deal dealsWithDictionaries:dictionaries];
            
            completion(deals, nil);
        }
    }];
    [task resume];
}

- (void)fetchNearbyDeal:(void (^)(Deal *deal, UIBackgroundFetchResult result))completionHandler {
    [self fetchDealsWithRadius:0.2 numberOfDeals:1 completion:^(NSArray<Deal *> *deals, NSError *error) {
        if (error != nil) {
            completionHandler(nil, UIBackgroundFetchResultFailed);
        } else {
            if (deals.count != 0) {
                Deal *deal = deals.firstObject;
                completionHandler(deal, UIBackgroundFetchResultNewData);
            } else {
                completionHandler(nil, UIBackgroundFetchResultNoData);
            }
        }
    }];
}

+ (NSString *)getAPIKey:(NSString *)key {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                    @"APIKeys" ofType:@"plist"];
    NSDictionary *plist = [[NSDictionary alloc] initWithContentsOfFile:path];
    return [plist valueForKey:key];
}

@end
