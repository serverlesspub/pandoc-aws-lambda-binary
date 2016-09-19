/*global module, require, __dirname, Promise */
var os = require('os'),
	path = require('path'),
	fs = require('fs'),
	cp = require('./child-process-promise'),
	exists = function (target) {
		'use strict';
		return new Promise(function (resolve, reject) {
			fs.access(target, function (err) {
				if (err) {
					reject(target);
				} else {
					resolve(target);
				}
			});
		});
	},
	makeExecutable = function (target) {
		'use strict';
		return new Promise(function (resolve, reject) {
			fs.chmod(target, '0700', function (err) {
				if (err) {
					reject(target);
				} else {
					resolve(target);
				}
			});
		});
	},
	unzip = function (targetPath) {
		'use strict';
		return cp.exec('cat ' + path.join(__dirname, 'vendor', 'pandoc.gz') + ' | gzip -d  > ' + targetPath).then(function () {
			return makeExecutable(targetPath);
		});
	},
	findUnpackedBinary = function () {
		'use strict';
		return exists(path.join(os.tmpdir(), 'pandoc')).catch(unzip);
	};

module.exports = function pandoc(inPath, outPath, additionalOptions) {
	'use strict';
	return findUnpackedBinary().then(function (commandPath) {
		return cp.spawn(commandPath, [inPath, '-o', outPath].concat(additionalOptions || []));
	});
};
