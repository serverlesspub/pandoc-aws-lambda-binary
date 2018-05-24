/*global module, require, __dirname, Promise */
const path = require('path'),
	cp = require('./child-process-promise'),
	findPandocBinary = require('./find-pandoc-binary');

module.exports = function pandoc(inPath, outPath, additionalOptions) {
	'use strict';
	const commandOptions = [inPath, '-o', outPath].concat(additionalOptions || []),
		envOptions = {
			cwd: path.dirname(inPath),
			env: process.env
		};
	return findPandocBinary().then((commandPath) => {
		console.log('executing', commandPath, 'in', envOptions.cwd);
		return cp.spawn(commandPath, commandOptions, envOptions);
	});
};
