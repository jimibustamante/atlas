angular.module('atlasApp')
  .directive('infoBox', ['filtersFact', function(filtersFact) {
    function link (scope, element, attrs) {
      filtersFact.getNationalStats().then(function successCallback(response) {
        scope.national_stats = response.data
        }, function errorCallback(response) {
          console.log("error")
        });
    }
    return {
      templateUrl: '/assets/templates/info-box.html',
      link: link,
      scope : {
        regionId: '=',
        communeId: '='
      }
    };
  }]);