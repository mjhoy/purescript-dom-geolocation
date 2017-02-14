/* global exports */
"use strict";

exports.geolocation = function (navigator) {
    return function () {
        return navigator.geolocation;
    };
};

exports.fGetCurrentPosition = function (options) {
    return function (successCallback) {
        return function (errorCallback) {
            return function (geolocation) {
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

exports.fGetCurrentPosition2 = function(geolocation) {
    return function(options) {
        return function(onSuccess, onError) {
            geolocation.getCurrentPosition(function (position) {
                onSuccess(position)();
            }, function (positionError) {
                onError(positionError)();
            }, options);
        }
    }
}

exports.fWatchPosition = function (Tuple) {
    return function (options) {
        return function (successCallback) {
            return function (errorCallback) {
                return function (geolocation) {
                    return function () {
                        var watchId = geolocation.watchPosition(function (position) {
                            successCallback(new Tuple(position, watchId))();
                        }, function (positionError) {
                            errorCallback(positionError)();
                        }, options);
                        return;
                    };
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
