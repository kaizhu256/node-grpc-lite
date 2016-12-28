module.exports = require('../../../../external/grpc_node-v' +
    require('../../../package.json').version +
    '-abi' +
    process.versions.modules +
    '-' +
    process.platform +
    '-' +
    process.arch);
