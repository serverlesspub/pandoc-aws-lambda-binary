/*global require */
const path = require('path'),
	cp = require('./child-process-promise'),
	makeExecutable = require('./make-executable');
module.exports = function unzipEmbeddedExecutable(targetPath) {
	'use strict';
	return cp.exec('cat ' + path.join(__dirname, '..', 'vendor', 'pandoc.gz') + ' | gzip -d  > ' + targetPath)
	.then(() => makeExecutable(targetPath));
};
