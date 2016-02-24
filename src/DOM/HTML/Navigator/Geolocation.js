/* global exports */
"use strict";

// module DOM.HTML.Navigator.Geolocation

exports.geolocation = function (navigator) {
    return function () {
        return navigator.geolocation;
    };
};

exports.fGetCurrentPosition = function (geolocation) {
    return function (successCallback) {
        return function (errorCallback) {
            return function (options) {
                return function () {
                    geolocation.getCurrentPosition(function (position) {
                        successCallback(position)();
                    }, function (positionError) {
                        errorCallback(positionError)();
                    }, options);
                };
            };
        };
    };
};

exports.fWatchPosition = function (geolocation) {
    return function (successCallback) {
        return function (errorCallback) {
            return function (options) {
                return function () {
                    return geolocation.getCurrentPosition(function (position) {
                        successCallback(position)();
                    }, function (positionError) {
                        errorCallback(positionError)();
                    }, options);
                };
           };
        };
    };
};

exports.fClearWatch = function (geolocation) {
    return function (watchId) {
        return function () {
            geolocation.clearWatch(watchId);
        };
    };
};
