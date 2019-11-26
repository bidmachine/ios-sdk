//
//  BDMInterstitial.h
//  BidMachine
//
//  Created by Stas Kochkin on 07/11/2017.
//  Copyright © 2017 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BidMachine/BDMRequest.h>
#import <BidMachine/BDMAuctionInfo.h>
#import <BidMachine/BDMAdEventProducerProtocol.h>
#import <BidMachine/BDMAdRequests.h>


@class BDMInterstitial;

/**
 Interstitial callback handler protocol
 */
@protocol BDMInterstitialDelegate <NSObject>
/**
 Called when interstitial is ready to be presented on screen
 
 @param interstitial Ready to present rewarded
 */
- (void)interstitialReadyToPresent:(nonnull BDMInterstitial *)interstitial;
/**
 Triggers when interstitial failed to load

 @param interstitial Failed instance of interstitial ad
 @param error Error object that contains information about reason of failure
 */
- (void)interstitial:(nonnull BDMInterstitial *)interstitial failedWithError:(nonnull NSError *)error;
/**
 Triggers when interstitial failed to present
 
 @param interstitial Failed instance of interstitial ad
 @param error Error object that contains information about reason of failure
 */
- (void)interstitial:(nonnull BDMInterstitial *)interstitial failedToPresentWithError:(nonnull NSError *)error;
/**
 Triggers when interstitial presents creative

 @param interstitial Presenting instance of interstitial ad
 */
- (void)interstitialWillPresent:(nonnull BDMInterstitial *)interstitial;
/**
 Triggers when interstitial was closed

 @param interstitial Presented instance of interstitial ad
 */
- (void)interstitialDidDismiss:(nonnull BDMInterstitial *)interstitial;
/**
 Triggers when interstitial registered user interaction with creative

 @param interstitial Presenting instance of interstitial ad
 */
- (void)interstitialRecieveUserInteraction:(nonnull BDMInterstitial *)interstitial;
@optional
/**
 Triggers ready event
 
 @param interstitial Ready instance of interstitial ad
 @param auctionInfo Auction info
 */
- (void)interstitial:(nonnull BDMInterstitial *)interstitial
    readyToPresentAd:(nonnull BDMAuctionInfo *)auctionInfo __attribute__((deprecated("Use -interstitialReadyToPresent: instead")));
/**
 Triggers when interstitial expired
 
 @param interstitial Expired instance of interstitial
 */
- (void)interstitialDidExpire:(nonnull BDMInterstitial *)interstitial;
@end


/**
 Object to present regular interstitial ad
 */
@interface BDMInterstitial : NSObject <BDMAdEventProducer>
/**
 Delegate of producer
 */
@property (nonatomic, weak, nullable) id<BDMAdEventProducerDelegate> producerDelegate;
/**
 Specifies ad type of interstitial
 */
@property (nonatomic, assign, readwrite) BDMFullscreenAdType type __attribute__((deprecated("Use BDMInterstitialRequest.adSize instead")));
/**
 Info of latest sucessful auction
 */
@property (nonatomic, copy, readonly, nullable) BDMAuctionInfo * auctionInfo;
/**
 Callback handler
 */
@property (nonatomic, weak, nullable) id<BDMInterstitialDelegate> delegate;
/**
 Boolean flag that indicates if ad is available
 */
@property (nonatomic, assign, readonly, getter=isLoaded) BOOL loaded;
/**
 Boolean flag that indicates if SDK can show ad or not
 */
@property (nonatomic, assign, readonly) BOOL canShow;
/**
 Presented ad view. If ad is not on screen this property is nil
 */
@property (nonatomic, readonly, nullable) UIView * adView;
/**
 Begins loading of interstitial ad

 @param request Request with mediation specific parameters
 */
- (void)makeRequest:(nonnull BDMRequest *)request __attribute__((deprecated("Use -populateWithRequest: instead")));
/**
 Adds request to ad object instance. If request was not
 performed, ad object will perform request by itslef
 
 @param request Request
 */
- (void)populateWithRequest:(nonnull BDMInterstitialRequest *)request;
/**
 Begins presentation of ad if it's available

 @param rootViewController view controller for presentation
 */
- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController;
/**
 Removes all loaded ad data
 */
- (void)invalidate;
@end
