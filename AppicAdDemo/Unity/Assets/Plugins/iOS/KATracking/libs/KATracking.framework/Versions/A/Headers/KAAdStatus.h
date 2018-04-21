//
//  KAAdStatusCode.h
//  Copyright (c) 2016 KA. All rights reserved.
//
/**
 * Enumeration for error codes
 */
typedef NS_ENUM(NSInteger, KAAdStatusCode) {
    KAAdStatusCodeMissingResourceBundle        = 51001,    // Resource bundle is not present
    KAAdStatusCodeNoFill                       = 51002,    // Ad is not filled at this time
    KAAdStatusCodeDuplicateRequest             = 51003,    // Instance of ad is already served, usually caused duplicated request on same instance of ad
    KAAdStatusCodeMediationRequestFailed       = 51101,     // General mediation platform failed to receive ad in time or returned mediation error
    KAAdStatusCodeMediationInvalidRequest      = 51102,     // Mediation platform return invalid request error
    KAAdStatusCodeMediationInvalidConfig       = 51103,
    KAAdStatusCodeInvalidRequestPath           = 59994,        // Incorrect server address
    KAAdStatusCodeNetworkUnavailable           = 59995,        // Network is currently not available
    KAAdStatusCodeNetworkTimeout               = 59996,         // Network request timeout
    KAAdStatusCodeInternalError                = 59997,         // SDK internal process error
    KAAdStatusCodeServerError                  = 59998,        // Server has return an error
    KAAdStatusCodeUnknown                      = 59999
};
