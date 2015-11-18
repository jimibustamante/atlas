angular.module('atlasApp')
.factory('filtersFact', ['$http', 'FILTERS_VALUES', function($http, FILTERS_VALUES) {
  var factory = {}

  factory.regions = function() {
    return $http({method: 'GET', url: '/regions.json'})
  }

  factory.get_comuna = function () {
    console.log("GET COMUNA!")
  }
  return factory
}]);