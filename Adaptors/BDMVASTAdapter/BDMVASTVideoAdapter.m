//
//  BDMVASTVideoAdapter.m
//  BDMVASTVideoAdapter
//
//  Created by Pavel Dunyashev on 24/09/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "BDMVASTVideoAdapter.h"
#import "BDMVASTNetwork.h"

@import BidMachine.Adapters;
@import StackVASTKit;
@import StackUIKit;


@interface BDMVASTVideoAdapter () <STKVASTControllerDelegate>

@property (nonatomic, strong) STKVASTController *videoController;
@property (nonatomic, copy) NSNumber *maxDuration;
@property (nonatomic, copy) NSNumber *skipAfter;

@end

@implementation BDMVASTVideoAdapter

- (instancetype)init {
    if (self = [super init]) {
        _maxDuration = @(180);
        _skipAfter = @(2);
        
    }
    return self;
}

- (UIView *)adView {
    return self.videoController.view;
}

- (void)prepareContent:(NSDictionary<NSString *,NSString *> *)contentInfo {
    NSString * rawXML = contentInfo[@"creative"];
    self.maxDuration = contentInfo[@"max_duration"] ? @(contentInfo[@"max_duration"].floatValue) : self.maxDuration;
    self.skipAfter = contentInfo[@"skip_after"] ? @(contentInfo[@"skip_after"].floatValue) : self.skipAfter;
    NSData * xmlData = [rawXML dataUsingEncoding:NSUTF8StringEncoding];
    
    self.videoController = [STKVASTController new];
    self.videoController.delegate = self;
    [self.videoController loadForVastXML:xmlData];
}

- (void)present {
    [self.videoController presentFromViewController:self.rootViewController];
}

#pragma mark - Private

- (NSNumber *)closeTime {
    return self.skipAfter > 0 ? self.skipAfter : @(2);
}

- (BOOL)forceCloseTime {
    return NO;
}

- (NSNumber *)videoCloseTime {
    return @(5);
}

- (BOOL)isAutoclose {
    return NO;
}

- (BOOL)isRewarded {
    return self.rewarded;
}

- (UIViewController *)rootViewController {
    return [self.displayDelegate rootViewControllerForAdapter:self] ?: UIViewController.stk_topPresentedViewController;
}

#pragma mark - AVKControllerDelegate

- (void)vastControllerReady:(STKVASTController *)controller {
    [self.loadingDelegate adapterPreparedContent:self];
}

- (void)vastController:(STKVASTController *)controller didFailToLoad:(NSError *)error {
    [self.loadingDelegate adapter:self failedToPrepareContentWithError: [error bdm_wrappedWithCode:BDMErrorCodeNoContent]];
}

- (void)vastController:(STKVASTController *)controller didFailWhileShow:(NSError *)error {
    [self.displayDelegate adapter:self failedToPresentAdWithError: [error bdm_wrappedWithCode:BDMErrorCodeBadContent]];
}

- (void)vastControllerDidClick:(STKVASTController *)controller clickURL:(NSString *)clickURL {
    [self.displayDelegate adapterRegisterUserInteraction:self];
    NSURL *productLink = clickURL ? [NSURL URLWithString:clickURL] : nil;
    if (productLink) {
        [controller pause];
        [STKSpinnerScreen show];
        __weak typeof(controller) weakController = controller;
        [STKProductPresentation openURLs:@[productLink] success:^(NSURL *link) {
            [STKSpinnerScreen hide];
        } failure:^(NSError *error) {
            [STKSpinnerScreen hide];
        } completion:^{
            [weakController resume];
        }];
    }
}

- (void)vastControllerDidDismiss:(STKVASTController *)controller {
    [self.displayDelegate adapterDidDismiss:self];
}

- (void)vastControllerDidFinish:(STKVASTController *)controller {
    [self.displayDelegate adapterFinishRewardAction:self];
}

- (void)vastControllerDidPresent:(STKVASTController *)controller {
    [self.displayDelegate adapterWillPresent:self];
}

/// Noop
- (void)vastControllerDidSkip:(STKVASTController *)controller {}

@end
