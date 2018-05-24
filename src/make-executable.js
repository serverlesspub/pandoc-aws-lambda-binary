/*global require*/
const fs = require('fs');
module.exports = function makeExecutable(target) {
	'use strict';
	return new Promise((resolve, reject) => {
		fs.chmod(target, '0700', (err) => {
			if (err) {
				reject(target);
			} else {
				resolve(target);
			}
		});
	});
};

