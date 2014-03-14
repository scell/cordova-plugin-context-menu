/**
 */

var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var ncmExport = {};

/**
 * 
 */
ncmExport.doMenu = function(opts, successCallback, failureCallback) {
	cordova.exec(successCallback, failureCallback, 'NativeContextMenuPlugin', 'doMenu', [opts]);
};

window.addEventListener('onContextMenuSelect', function(test){
  console.log(test);
})

module.exports = ncmExport;