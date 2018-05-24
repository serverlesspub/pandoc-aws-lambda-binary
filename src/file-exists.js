const fs = require('fs');
module.exports = function fileExists(target) {
	'use strict';
	return new Promise((resolve, reject) => {
		fs.access(target, (err) => {
			if (err) {
				reject(target);
			} else {
				resolve(target);
			}
		});
	});
};

