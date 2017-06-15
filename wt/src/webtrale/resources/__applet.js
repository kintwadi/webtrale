function gralejAppletStarted() {
    try {
        init();
    }
    catch (e) {
        setErrorMessage("Init failed: " + e);
    }
}

function init() {
    loadLexicon();
    $('parse-form').enable();
    $('q').focus();
}

var initGralejApplet_done = false;

function initGralejApplet() {
    if (initGralejApplet_done)
        return true;
    try {
        var conf = $('g').getConfig();
        conf.set('behavior.alwaysfitsize', true);
        conf.set('behavior.autoexpandtags', false);
        //conf.set('behavior.selectOnHover', true);
        conf.set('behavior.displayModelHiddenFeatures', false);
        conf.set('block.panel.margins.all', 10);
        return initGralejApplet_done = true;
    }
    catch (e) {
        setErrorMessage("The applet is not loaded yet [" + e + "]");
        return false;
    }
}

function loadLexicon() {
    setStatusMessage("pending", "Loading lexicon...");
    new Ajax.Request('words-raw', {
        method: 'get',
        onSuccess: function (t) {
            var s = t.responseText;
            if (s)
                setWords(s.split(/\r?\n/));
            else
                setErrorMessage("Request failed");
            },
        onFailure: function(t) {
            var s = t.responseText || "Request failed";
            setErrorMessage(s)
            }
    });
}

function setWords(ws) {
    var s = "";
    for (var i = 0; i < ws.length; ++i) {
        s += "<div class='lexitem' onclick='lex(this)'>"
            + ws[i].escapeHTML() + "</div>";
    }
    $('lex').innerHTML = s;
    clearStatusMessage();
}

function lex(w) {
    recOrLex('lex', 'q=' + escape(w.innerHTML.unescapeHTML()));
}

function rec() {
    var q = $('q');
    var s = q.value.strip();
    if (s.length == 0 || s.include("\\")) {
        setErrorMessage("Invalid input");
        q.activate();
        return;
    }
    recOrLex('rec', $('parse-form').serialize());
}

function recOrLex(rl, args) {
    setStatusMessage("pending", "Sending query...");
    if (!initGralejApplet())
        return;
    new Ajax.Request(rl + '-raw', {
        method: 'get',
        parameters: args,
        onSuccess: function (t) {
            var s = t.responseText;
            if (s)
                processTraleResponse(s);
            else
                setErrorMessage("Request failed");
            },
        onFailure: function(t) {
            var s = t.responseText || "Request failed";
            setErrorMessage(s)
            }
    });
}

function processTraleResponse(s) {
    //if (s.length > 100) s = s.substr(0, 100) + "...";
    //alert("will process: " + s);
    var n = $('g').parseTraleMessage(s);
    if (n == -1) {
        setErrorMessage("Exception while parsing TRALE response");
        return;
    }
    initSelectorBar(n);
    clearStatusMessage();
}

var __currentSelector = null;

function selectorClicked(btn, openInFrame) {
    if (btn == __currentSelector && !openInFrame)
        return;
    if (__currentSelector != null) {
        __currentSelector.style.backgroundColor = btn.style.backgroundColor;
    }
    __currentSelector = btn;
    btn.style.backgroundColor = "black";
    var viewId = parseInt(btn.innerHTML) - 1;
    try {
        if (openInFrame) {
            $('g').openViewInFrame(viewId);
            return;
        }
    }
    catch (ex) {}
    $('g').showView(viewId);
}


function initSelectorBar(n) {
    __currentSelector = null;
    var s = "";
    for (var i = 0; i < n; ++i) {
        s += "<span class='selector' onclick='selectorClicked(this, event.shiftKey)'>"
            + (i + 1) + "</span>";
    }
    $('selector-bar').innerHTML = s;
    if (s.length)
        selectorClicked($('selector-bar').firstChild, false);
}

function resizeGralejApplet(w, h) {
    $('g').width  = w;
    $('g').height = h;
}

function clearStatusMessage() {
    $('status').innerHTML = "&nbsp;";
}

function setErrorMessage(s) {
    var S="WebTrale: ";
    if (s.startsWith(S)) {
        s = s.substr(S.length);
        S = "Unknown word: ";
        if (s.startsWith(S))
            s = "Unknown word: <b>" + s.substr(S.length).escapeHTML() + "</b>";
        else if (s == "not recognized")
            s = "Not recognized";
        else
            s = s.escapeHTML();
    }
    else
        s = s.escapeHTML();
    setStatusMessage("error", s);
}

function setStatusMessage(statusClassName, s) {
    $('status').innerHTML = "<div class='status-" + statusClassName + "'>" +
        s + "</div>";
}

