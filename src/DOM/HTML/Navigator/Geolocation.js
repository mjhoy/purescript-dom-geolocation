/* global exports */
"use strict";

// module DOM.HTML.Navigator.Geolocation

exports.geolocation = function (navigator) {
    return navigator.geolocation;
};

exports.getCurrentPosition = function (geolocation) {
    return function (successCallback) {
        return function (errorCallback) {
            return function (options) {
                return geolocation.getCurrentPosition(successCallback,
                                                      errorCallback,
                                                      options);
            };
        };
    };
};

exports.watchPosition = function (geolocation) {
    return function (successCallback) {
        return function (errorCallback) {
            return function (options) {
                return geolocation.watchPosition(successCallback,
                                                 errorCallback,
                                                 options);
            };
        };
    };
};

exports.clearWatch = function (geolocation) {
    return function (watchId) {
        return geolocation.clearWatch(watchId);
    };
};
