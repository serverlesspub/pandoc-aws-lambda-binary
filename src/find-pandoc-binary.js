const path = require('path'),
	os = require('os'),
	fileExists = require('./file-exists'),
	unzipEmbeddedExecutable = require('./unzip-embedded-executable');

module.exports = function findPandocBinary() {
	'use strict';
	if (process.env.PANDOC_PATH) {
		return Promise.resolve(process.env.PANDOC_PATH);
	}
	return fileExists(path.join(os.tmpdir(), 'pandoc')).catch(unzipEmbeddedExecutable);
};

