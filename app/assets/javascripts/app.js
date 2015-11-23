'use strict';

/**
 * @ngdoc overview
 * @name atlasApp
 * @description
 * # atlasApp
 *
 * Main module of the application.
 */
angular
  .module('atlasApp', ['ui.bootstrap', 'ui.router', 'templates', 'uiGmapgoogle-maps'])
  .constant(
    "FILTERS_VALUES", {
      "regions": ['I', 'II', 'III']
    }
  )
  .config([
  '$stateProvider',
  '$urlRouterProvider',
  'uiGmapGoogleMapApiProvider',
  function ($stateProvider, $urlRouterProvider, uiGmapGoogleMapApiProvider) {
    $stateProvider
      .state('home', {
        url: '/home',
        templateUrl: '/assets/templates/_home.html',
        controller: 'HomeCtrl'
      });
    $urlRouterProvider.otherwise('home');

    uiGmapGoogleMapApiProvider.configure({
        //    key: 'your api key',
        v: '3.20', //defaults to latest 3.X anyhow
        libraries: 'weather,geometry,visualization'
    });

  }])