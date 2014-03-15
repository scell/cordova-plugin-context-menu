/**
 */

var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var ncmExport = {};

/**
 * @TODO: work on a way to have a passed callback to be called when button is tapped
 */
ncmExport.doMenu = function(opts, successCallback, failureCallback) {
	cordova.exec(successCallback, failureCallback, 'NativeContextMenuPlugin', 'doMenu', [opts]);
};

document.addEventListener('onNativeContextMenuClose', function(evt){
  if (ncmExport.onClose && typeof ncmExport.onClose === "function"){
    ncmExport.onClose.call(this, evt);
  }
})

module.exports = ncmExport;