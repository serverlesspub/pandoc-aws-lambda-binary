/*global module, require, console, Promise */
var childProcess = require('child_process'),
	execPromise = function (command) {
		'use strict';
		return new Promise(function (resolve, reject) {
			childProcess.exec(command, function (err, result) {
				console.log('exec complete', err, result);
				if (err) {
					reject(err);
				} else {
					resolve();
				}
			});
		});
	},
	spawnPromise = function (command, options) {
		'use strict';
		return new Promise(function (resolve, reject) {
			var process = childProcess.spawn(command, options);
			process.stdout.on('data', console.log);
			process.stderr.on('data', console.error);
			process.on('close', function (code) {
				console.log('spawn ended', code);
				if (code !== 0) {
					reject(code);
				} else {
					resolve();
				}
			});
		});
	};
module.exports = {
	exec: execPromise,
	spawn: spawnPromise
};
