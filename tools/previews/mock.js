// Mock LuCI pages (made-up data only) shared by make-previews.js and qa.js.
const fs = require('fs'), path = require('path');
const ROOT = path.resolve(__dirname, '../..');
const bar = (t, pct) => `<div class="cbi-progressbar" title="${t}"><div style="width:${pct}%"></div></div>`;
const row = (k, v) => `<div class="cbi-value"><label class="cbi-value-title">${k}</label><div class="cbi-value-field">${v}</div></div>`;
const sect = (title, body) => `<div class="cbi-section"><h3>${title}</h3><div class="cbi-section-node">${body}</div></div>`;
const hide = '<span class="label" style="float:right">Hide</span>';
const port = (n, s) => `<div class="ifacebox" style="display:inline-block;margin:4px 14px 8px 0;width:96px;text-align:center"><div class="ifacebox-head"><strong>${n}</strong></div><div class="ifacebox-body"><div style="padding:6px 0">${s}</div><small>&#9650; 1.2 GiB<br>&#9660; 340 MiB</small></div></div>`;
const lease = (h, ip, mac, t) => `<div class="tr"><div class="td">${h}</div><div class="td">${ip}</div><div class="td">${mac}</div><div class="td">${t}</div><div class="td"><button class="cbi-button cbi-button-action">Reserve IP</button></div></div>`;

const overview = `
<div class="cbi-map"><h2>Status</h2>
${sect('System' + hide,
  row('Hostname', 'router') + row('Model', 'Example Router AX6000') + row('Architecture', 'ARMv8 Processor rev 4') +
  row('Firmware Version', 'OpenWrt 25.12.6 / LuCI') + row('Uptime', '12d 4h 31m 8s') + row('Load Average', '0.11, 0.08, 0.03'))}
${sect('Memory' + hide,
  row('Total Available', bar('330 MiB / 484 MiB (68%)', 68)) + row('Used', bar('163 MiB / 484 MiB (33%)', 33)) + row('Cached', bar('52 MiB / 484 MiB (10%)', 10)))}
${sect('Port status' + hide, port('lan1', '1 GbE') + port('lan2', 'no link') + port('lan3', 'no link') + port('lan4', '1 GbE') + port('wan', '1 GbE'))}
${sect('Network' + hide, `<div class="ifacebox" style="width:100%"><div class="ifacebox-head"><strong>IPv4 Upstream</strong></div><div class="ifacebox-body" style="text-align:left;padding:6px 10px"><strong>Protocol:</strong> DHCP client<br><strong>Address:</strong> 203.0.113.24/24<br><strong>Gateway:</strong> 203.0.113.1<br><strong>Connected:</strong> 3h 41m 5s</div></div>` + row('Active Connections', bar('212 / 31232 (1%)', 1)))}
<div class="cbi-section"><h3>DHCP Leases${hide}</h3><div class="table">
<div class="tr table-titles"><div class="th">Hostname</div><div class="th">IPv4 address</div><div class="th">MAC address</div><div class="th">Remaining time</div><div class="th">Static Lease</div></div>
${lease('laptop', '192.168.1.103', '02:00:5e:10:00:01', '8h 6m 19s')}
${lease('phone', '192.168.1.173', '02:00:5e:10:00:02', '10h 33m 34s')}
${lease('smart-tv', '192.168.1.161', '02:00:5e:10:00:03', '10h 15m 19s')}
${lease('nas', '192.168.1.192', '02:00:5e:10:00:04', '11h 52m 52s')}
</div></div></div>`;

const settings = `
<div class="cbi-map"><h2>Router Password</h2><div class="cbi-map-descr">Changes the administrator password for accessing the device.</div>
<ul class="cbi-tabmenu"><li class="cbi-tab"><a href="#">Router Password</a></li><li class="cbi-tab-disabled"><a href="#">SSH Access</a></li><li class="cbi-tab-disabled"><a href="#">SSH-Keys</a></li><li class="cbi-tab-disabled"><a href="#">HTTP(S) Access</a></li></ul>
<div class="alert-message warning"><h4>Heads up</h4><p>Changes only apply once you press Save &amp; Apply.</p></div>
${sect('General settings',
  row('Hostname', '<input type="text" value="router">') +
  row('Timezone', '<select><option>Europe/London</option><option>UTC</option></select>') +
  row('Password', '<input type="password" value="hunter2hunter2">') +
  row('Enable logging', '<input type="checkbox" checked>') +
  row('Log level', '<select><option>Warning</option><option>Debug</option></select>'))}
${sect('Interfaces', `<table class="table"><tr class="tr table-titles"><th class="th">Name</th><th class="th">Status</th><th class="th">Actions</th></tr>
<tr class="tr"><td class="td">lan</td><td class="td"><span class="label">UP</span></td><td class="td"><button class="cbi-button cbi-button-edit">Edit</button> <button class="cbi-button cbi-button-negative">Delete</button></td></tr></table>`)}
<div class="cbi-page-actions"><button class="cbi-button cbi-button-apply">Save &amp; Apply</button> <button class="cbi-button cbi-button-save">Save</button> <button class="cbi-button cbi-button-reset">Reset</button></div>
</div>`;

const nav = (active) => ['Status', 'System', 'Services', 'Network'].map(n =>
  `<li class="dropdown${n === active ? ' active' : ''}"><a class="menu" href="#">${n}</a><ul class="dropdown-menu">` +
  { Status: ['Overview', 'Routing', 'Firewall', 'System Log'], System: ['System', 'Administration', 'Software', 'Startup', 'Backup / Flash'],
    Services: ['Dynamic DNS', 'SQM QoS', 'Scheduled Tasks'], Network: ['Interfaces', 'Wireless', 'Routing', 'DHCP and DNS', 'Diagnostics', 'Firewall'] }[n]
    .map(i => `<li><a href="#">${i}</a></li>`).join('') + '</ul></li>').join('') + '<li><a href="#">Log out</a></li>';


// Collect what a theme's own header/footer templates contribute (dark flag, clock element, clock script).
function themeInfo(t) {
  const dir = path.join(ROOT, 'themes', 'luci-theme-' + t);
  const hdr = fs.readFileSync(`${dir}/ucode/template/themes/${t}/header.ut`, 'utf8');
  const ftr = fs.readFileSync(`${dir}/ucode/template/themes/${t}/footer.ut`, 'utf8');
  return {
    dir,
    dm: (hdr.match(/const darkpref = '(true|false)'/) || [, 'true'])[1],
    clock: (hdr.match(/<div class="(?:hdr-clock|mc-clock|bp-stamp)" id="[^"]+"><\/div>/) || [''])[0],
    script: ((ftr.match(/<script>(\(function\(\)\{var e=document\.getElementById\('(?:hdr-clock|mc-clock|bp-stamp)'\).*?)<\/script>/s)) || [, ''])[1],
  };
}

function pageHtml(t, page, tod) {
  const { dir, dm, clock, script } = themeInfo(t);
  return `<!doctype html><html lang="en" data-darkmode="${dm}"${tod ? ` data-tod="${tod}"` : ''}><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="file://${dir}/htdocs/luci-static/${t}/cascade.css">
<link rel="stylesheet" media="only screen and (max-width: 854px)" href="file://${dir}/htdocs/luci-static/${t}/mobile.css"></head>
<body class="lang_en"><header><a class="brand" href="#">router</a><ul class="nav" id="topmenu">${nav(page === 'overview' ? 'Status' : 'System')}</ul>${clock}
<div id="indicators" class="pull-right"><span class="label notice">Refreshing</span></div></header>
<div id="maincontent" class="container">${page === 'overview' ? overview : settings}</div>
<footer><span>Powered by LuCI / OpenWrt 25.12.6</span></footer>
${tod ? '' : `<script>${script}</script>`}</body></html>`;
}

module.exports = { ROOT, pageHtml, themeInfo };
