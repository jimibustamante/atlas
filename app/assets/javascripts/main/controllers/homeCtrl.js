'use strict';

/**
 * @ngdoc function
 * @name atlasApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the atlasApp
 */
angular.module('atlasApp')
  .controller('HomeCtrl', function ($scope, filtersFact) {
    $scope.map = { center: { latitude: -35.6090313, longitude: -68.8358146 }, zoom: 4 };
    $scope.regions = filtersFact.regions
  });
