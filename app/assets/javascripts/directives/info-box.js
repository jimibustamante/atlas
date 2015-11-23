angular.module('atlasApp')
  .directive('infoBox', ['filtersFact', function(filtersFact) {
    function link (scope, element, attrs) {
      
    }
    return {
      templateUrl: '/assets/templates/info-box.html',
      link: link
    };
    }]);