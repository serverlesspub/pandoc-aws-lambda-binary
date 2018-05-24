/*global module, require, console, Promise */
const childProcess = require('child_process'),
	execPromise = function (command) {
		'use strict';
		return new Promise((resolve, reject) => {
			childProcess.exec(command, (err) => {
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
		return new Promise((resolve, reject) => {
			const process = childProcess.spawn(command, options);
			process.stdout.on('data', buffer => console.log(buffer.toString()));
			process.stderr.on('data', buffer => console.error(buffer.toString()));
			process.on('close', (code) => {
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
