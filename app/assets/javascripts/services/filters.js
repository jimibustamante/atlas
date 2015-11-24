angular.module('atlasApp')
.factory('filtersFact', ['$http', 'FILTERS_VALUES', function ($http, FILTERS_VALUES) {
  var factory = {}
  factory.baseURL = "/api/v1"
  factory.regions = function() {
    return $http({method: 'GET', url: factory.baseURL + '/regions.json'})
  }

  factory.communes = function (region_id) {
    return $http({method: 'GET', url: factory.baseURL + '/regions/' + region_id + '/communes.json'})
  }

  factory.labors = function (owner_id) {
    return $http({method: 'GET', url: factory.baseURL + '/owners/' + owner_id + '/labors.json'})
  }

  factory.miningWastes = function(region_id, commune_id) {
    var data = {}
    if (region_id && region_id != "") {data.region_id = region_id}
    if (commune_id && commune_id != "") {data.commune_id = commune_id}
    return $http({method: 'GET', params : data, url: factory.baseURL + '/mining_wastes.json'})
  }

  factory.getOwners = function(name) {
    return $http({method: 'GET', url: factory.baseURL + '/owners.json', params: {name : name}})
  };

  factory.getOwnerMiningWastes = function(owner_id, labor_id) {
    return $http({method: 'GET', url: factory.baseURL + '/mining_wastes.json', params: {owner_id : owner_id, labor_id : labor_id}})
  };  

  factory.getNationalStats = function () {
    return $http({method: 'GET', url: factory.baseURL + '/national_stats.json', params: {name : name}})
  }

  factory.regionStats = function (region_id) {
    $http({method: 'GET', url: factory.baseURL + '/regional_stats.json', params: {region_id : region_id}}).then(function (response) {
      factory.regional_stats = response.data
    }, function () {
      console.log('error')
    })
  }

  factory.communeStats = function (commune_id) {
    if (commune_id) {
      $http({method: 'GET', url: factory.baseURL + '/communal_stats.json', params: {commune_id : commune_id}}).then(function (response) {
        factory.commune_stats = response.data
      }, function () {
        console.log('error')
      })
    }
  }

  return factory
}]);