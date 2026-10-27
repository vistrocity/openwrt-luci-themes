/* ==========================================================================
 * __NAME__ overrides
 * @@DESC@@
 * ========================================================================== */

:root,
:root[data-darkmode="false"],
:root[data-darkmode="true"] {
	--font-sans: @@font@@;

	--background-color-delta-l-sign: @@bsign@@;
	--background-color-h: @@bh@@;
	--background-color-s: @@bs@@;
	--background-color-l: @@bl@@;

	--text-color-delta-l-sign: @@tsign@@;
	--text-color-h: @@th@@;
	--text-color-s: @@ts@@;
	--text-color-l: @@tl@@;

	--border-color-delta-l-sign: @@bsign@@;

	--primary-color-high: @@accent@@;
	--primary-color-medium: @@accent@@;
	--primary-color-low: @@accent2@@;
	--on-primary-color: @@on@@;

	--error-color-high-rgb: @@err_rgb@@;
	--error-color-medium: @@err@@;
	--error-color-low: @@err@@;

	--success-color-high-rgb: @@ok_rgb@@;
	--success-color-medium: @@ok@@;
	--success-color-low: @@ok@@;

	--warn-color-high: @@warn@@;
	--warn-color-medium: @@warn@@;
	--warn-color-low: @@warn@@;
	--on-warn-color: @@on@@;

	--t-bg: @@bg@@;
	--t-card: @@card@@;
	--t-head: @@head@@;
	--t-ink: @@ink@@;
	--t-dim: @@dim@@;
	--t-rule: @@rule@@;
	--t-hover: @@hover@@;
	--t-accent: @@accent@@;
	--t-accent2: @@accent2@@;
	--t-on: @@on@@;
	--t-err: @@err@@;
	--t-ok: @@ok@@;
	--t-warn: @@warn@@;

	color-scheme: @@scheme@@;
}

html { background: var(--t-bg); }

body {
	font-size: @@fs@@;
	line-height: 1.5;
	color: var(--t-ink);
	background: var(--t-bg);
}

input, select, textarea, button, .btn, .cbi-button { font-family: var(--font-sans); }

::selection { background: var(--t-accent); color: var(--t-on); }

a { color: var(--t-accent); }
a:hover { color: var(--t-accent2); }

/* --- Header ---------------------------------------------------------------- */

header {
	background: var(--t-head);
	border-bottom: @@hborder@@;
	box-shadow: none;
}

header a { color: var(--t-dim); text-shadow: none; }

header .brand {
	color: var(--t-ink);
	font-weight: 700;
	letter-spacing: .04em;
}

header .brand:hover, header ul .active > a { background: transparent; color: var(--t-accent); }

.nav a { letter-spacing: .03em; }
.nav a:hover { color: var(--t-ink); background: var(--t-hover); }
.nav .active > a { color: var(--t-accent); background: transparent; box-shadow: inset 0 -2px 0 var(--t-accent); }
.nav a.menu:hover { background: var(--t-hover); }

/* Submenu: attached to the bar with an invisible hover bridge so it cannot be lost. */
.nav .dropdown-menu {
	top: 100%;
	margin-top: -2px;
	background: var(--t-card);
	border: 1px solid var(--t-rule);
	border-radius: @@rad@@;
	box-shadow: @@pop@@;
}

.nav .dropdown-menu::before { content: ""; position: absolute; left: -2px; right: -2px; top: -12px; height: 12px; }

.nav .dropdown-menu a.menu { color: var(--t-ink); }
.nav .dropdown-menu li a { color: var(--t-ink); background: transparent; text-shadow: none; }
.nav .dropdown-menu li a:hover { background: var(--t-hover); color: var(--t-accent); }
.nav .dropdown-menu .active a { color: var(--t-accent); }

.hdr-clock {
	margin-left: auto;
	align-self: center;
	padding: 0 14px;
	color: var(--t-dim);
	font-family: var(--font-mono, ui-monospace, Menlo, Consolas, monospace);
	font-size: 13px;
	white-space: nowrap;
}

header .pull-right { margin-left: 0; align-self: center; }

@media (max-width: 854px) { .hdr-clock { display: none; } }

/* --- Sections ---------------------------------------------------------------- */

.cbi-section {
	background: var(--t-card);
	border: 1px solid var(--t-rule);
	border-radius: @@rad@@;
	box-shadow: @@shadow@@;
	padding: 14px 18px 8px;
	margin-bottom: 22px;
}

.cbi-section .cbi-section,
.cbi-value > .cbi-section {
	background: transparent;
	border: 0;
	box-shadow: none;
	padding: 0;
	margin-bottom: 0;
}

h2 { color: var(--t-ink); font-size: 24px; font-weight: 700; }
h3, .cbi-section > h3 { color: var(--t-accent); font-size: 16px; font-weight: 700; letter-spacing: .03em; }

.cbi-map-descr, .cbi-section-descr { color: var(--t-dim); }

.cbi-value { border-bottom: 1px solid var(--t-rule); }
.cbi-section-node > .cbi-value:last-child { border-bottom: 0; }
.cbi-value-title { color: var(--t-dim); }

/* --- Tables ------------------------------------------------------------------ */

.table .th {
	background: transparent;
	color: var(--t-dim);
	font-size: 12.5px;
	letter-spacing: .06em;
	border-color: var(--t-rule);
}

.table .td { border-color: var(--t-rule); background: transparent; }
.table .tr:hover .td { background: var(--t-hover); }

/* --- Form controls ----------------------------------------------------------- */

input[type="text"], input[type="password"], input[type="number"],
input[type="email"], input[type="url"], input[type="search"],
textarea, select,
.cbi-dropdown:not(.btn):not(.cbi-button) {
	background-color: var(--t-bg);
	color: var(--t-ink);
	border: 1px solid var(--t-rule);
	border-radius: @@rad@@;
	box-shadow: none;
}

::placeholder { color: var(--t-dim); opacity: .6; }

input:focus, textarea:focus, select:focus,
.cbi-dropdown:focus, .cbi-dropdown[open] {
	border-color: var(--t-accent) !important;
	box-shadow: 0 0 0 2px rgba(@@focus@@, .35) !important;
}

/* only the opened list; the visible label of a split button lives in a plain <ul> */
.cbi-dropdown[open] > ul.dropdown {
	background: var(--t-card);
	border: 1px solid var(--t-rule);
	border-radius: @@rad@@;
	box-shadow: @@pop@@;
}

/* --- Buttons ----------------------------------------------------------------- */

@@BUTTONS@@
/* --- Tabs, alerts, modals ---------------------------------------------------- */

.cbi-tabmenu { border-bottom: 1px solid var(--t-rule); }

.cbi-tabmenu li a {
	background: transparent;
	border: 0;
	border-radius: 0;
	color: var(--t-dim);
}

.cbi-tabmenu li.cbi-tab a {
	color: var(--t-accent);
	background: transparent;
	box-shadow: inset 0 -2px 0 var(--t-accent);
}

.alert-message,
.alert-message.warning {
	background: var(--t-card);
	color: var(--t-ink);
	border: 0;
	border-left: 4px solid var(--t-warn);
	border-radius: @@rad@@;
	text-shadow: none;
}

.alert-message.danger, .alert-message.error { border-left-color: var(--t-err); }
.alert-message.success, .alert-message.info { border-left-color: var(--t-accent); }

.modal {
	background: var(--t-card);
	color: var(--t-ink);
	border: 1px solid var(--t-rule);
	border-radius: @@rad@@;
	box-shadow: @@pop@@;
}

#modal_overlay { background: @@overlay@@; }

/* --- Meters: label is drawn above the bar via ::before, so no overflow:hidden --- */

.cbi-progressbar {
	height: 8px;
	border: 1px solid var(--t-rule);
	border-radius: @@brad@@;
	background: var(--t-bg);
}

.cbi-progressbar::before { color: var(--t-dim); font-size: 12.5px; }

.cbi-progressbar > div {
	background: var(--t-accent);
	border-radius: @@brad@@;
	box-shadow: none;
}

.ifacebox, .ifacebadge {
	background: var(--t-card);
	border: 1px solid var(--t-rule);
	border-radius: @@rad@@;
	box-shadow: none;
	text-shadow: none;
}

.ifacebox-head { border-radius: @@rad@@ @@rad@@ 0 0; }

.label {
	background: transparent;
	color: var(--t-accent);
	border: 1px solid var(--t-accent);
	border-radius: @@rad@@;
}

footer {
	margin-top: 10px;
	padding-top: 10px;
	color: var(--t-dim);
	font-size: 12.5px;
	border-top: 1px solid var(--t-rule);
}

footer a { color: var(--t-dim); }
footer a:hover { color: var(--t-accent); }

* { scrollbar-color: var(--t-dim) var(--t-bg); scrollbar-width: thin; }


/* --- Accessibility and small-screen baseline (keep these when restyling) ---- */

:focus-visible { outline: 2px solid var(--t-accent); outline-offset: 2px; }

@media (max-width: 600px) {
	.cbi-section { padding-left: 12px; padding-right: 12px; }
	.cbi-value-title { width: auto; }
	.hdr-clock { display: none; }
}

@media (prefers-reduced-motion: reduce) {
	* { transition: none !important; animation: none !important; }
}
