const os = require('os');
const fs = require('fs');

const os_info = [ 
  "tmpDir",
  "hostname",
  "type",
  "platform",
  "arch",
  "release",
  "uptime",
  "loadavg",
  "totalmem",
  "freemem",
  "cpus",
];

module.exports = function() {
  var info = { lsb: {} };

  os_info.forEach(function(func) {
    info[func] = os[func]();
  });

  var lsbRelease = '/etc/lsb-release';
  if (fs.existsSync(lsbRelease)) {
    fs.readFileSync(lsbRelease, 'utf8')
      .trim().split('\n')
      .map(function(line) { 
        var pair = line.replace(/"/g, '').split('=');
        info.lsb[pair[0]] = pair[1];
      });
  }

  var cpuinfo = fs.readFileSync('/proc/cpuinfo', 'utf8');
  console.log(cpuinfo);

  return info;
};

