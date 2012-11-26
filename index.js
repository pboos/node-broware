module.exports = process.env.BROWARE_COV
  ? require('./lib-cov/broware')
  : require('./lib/broware');