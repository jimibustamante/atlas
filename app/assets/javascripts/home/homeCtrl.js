'use strict';

/**
 * @ngdoc function
 * @name atlasApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the atlasApp
 */
angular.module('atlasApp')
  .controller('HomeCtrl', ['$scope', 'filtersFact', 'uiGmapGoogleMapApi', 'uiGmapIsReady', function ($scope, filtersFact, uiGmapGoogleMapApi, uiGmapIsReady) {

      $scope.vm = filtersFact
      $scope.mining_wastes = []
      $scope.alerts = []

      uiGmapIsReady.promise().then(function (maps_instances) {
        $scope.map_instance = maps_instances[0].map
      })

      $scope.$on('mapInitialized', function(event, map) {
      });

      uiGmapGoogleMapApi.then(function (maps) {
        $scope.maps = maps
        $scope.map = { 
          center: { 
            latitude: -35.6090313, 
            longitude: -68.8358146 
          },
          zoom: 4,
          options: {
            mapTypeId: $scope.maps.MapTypeId.SATELLITE
          },
          markerOptions: {
            animation: $scope.maps.Animation.DROP
          }
        };
      })  


      filtersFact.regions().then(function successCallback(response) {
        $scope.regions =  response.data
        }, function errorCallback(response) {
          console.log("error")
          $scope.regions = []
        });
  
      $scope.getOwnersTypeahead = function (name) {
        return filtersFact.getOwners(name).then(function successCallback(response) {
          $scope.owners = response.data
          return response.data
          }, function errorCallback(response) {
            console.log("error")
          });
      }
  
      $scope.getLabors = function () {
        if ($scope.owner.id) {
          filtersFact.labors($scope.owner.id).then(function successCallback(response) {
              $scope.labors =  response.data
            }, function errorCallback(response) {
              console.log("error")
              $scope.labors = []
            });
        }
      }

      $scope.getCommunes = function () {
        $scope.commune_id = ""
        filtersFact.communes($scope.region_id).then(function successCallback(response) {
            $scope.communes =  response.data
          }, function errorCallback(response) {
            console.log("error")
            $scope.communes = []
          });
      }
  
      $scope.getMiningWastes = function () {
        filtersFact.miningWastes($scope.region_id, $scope.commune_id).then(function successCallback(response){
          $scope.mining_wastes = response.data
          if ($scope.mining_wastes.length > 0) {
            $scope.mapFitBounds()
          } else {
            var center = new $scope.maps.LatLng(-35.6090313, -68.8358146)
            $scope.map_instance.setCenter(center)
            $scope.map_instance.setZoom(4)
            $scope.showErrorAlert()
          }
        }, function errorCallback (response) {
          console.log("error")
          $scope.mining_wastes = []
        });
      }
  
      $scope.getMiningWastesByOwner = function () {
        filtersFact.getOwnerMiningWastes($scope.owner.id, $scope.labor_id).then(function successCallback(response){
          console.log("getMiningWastesByOwner")
          $scope.mining_wastes = response.data
          $scope.mapFitBounds()
        }, function errorCallback (response) {
          console.log("error")
          $scope.mining_wastes = []
        });
      }

      $scope.mapFitBounds = function () {
        setTimeout(function() {
          if ($scope.mining_wastes.length > 0 ) {
            var bounds = new $scope.maps.LatLngBounds();
            _.each($scope.mining_wastes, function (mw) {
              bounds.extend(new $scope.maps.LatLng(mw.coords.latitude, mw.coords.longitude))
            })
            $scope.map_instance.fitBounds(bounds)
          }
        }, 100);
      }      

      $scope.showErrorAlert = function () {
        if ($scope.alerts.length === 0) {
          $scope.alerts.push({msg: 'No existen resultados para esta búsqueda.', type: 'danger'})
        }
      }

      $scope.closeAlert = function () {
        $scope.alerts = []
      }

      $scope.updateStatsInfo = function (marker, event_name, relave) {
        $scope.vm.communeStats(relave.commune_id)
        $scope.vm.regionStats(relave.region_id)
      }
  
    }]);
