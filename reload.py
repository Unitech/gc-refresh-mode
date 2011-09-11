#!/usr/bin/env python
#
#
# Reload Chrome on port 9222
# Code forked and modified by Strzelewicz Alexandre
#
# Thanks to :
# http://pypi.python.org/pypi/chrome_remote_shell/
# http://www.emacswiki.org/emacs/SaveAndReloadBrowser
#

try:
    import json
except ImportError:
    import simplejson as json
import socket

import sys

HANDSHAKE = 'ChromeDevToolsHandshake\r\n'
RESPONSELESS_COMMANDS = ['evaluate_javascript']

class Shell(object):
    """A remote debugging connection to Google Chrome."""

    def __init__(self, host='localhost', port=9222):
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.connect((host, port))
        self.socket.send(HANDSHAKE)
        assert self.socket.recv(len(HANDSHAKE)) == HANDSHAKE

    def request(self, tool, destination=None, **kw):
        """Send a command to a tool supported by Google Chrome.

        `tool` - 'DevToolsService' or 'V8Debugger'
        other arguments - Combined to form the JSON request object

        """
        j = json.dumps(kw)
        request = 'Content-Length:%d\r\nTool:%s\r\n' % (len(j), tool)
        if destination:
            request += 'Destination:%s\r\n' % (destination,)
        request += '\r\n%s\r\n' % (j,)
        self.socket.send(request)
        if kw.get('command', '') not in RESPONSELESS_COMMANDS:
            response = self.socket.recv(30000) # ugh
            j = response.split('\r\n\r\n', 1)[1]
            return json.loads(j)

    def open_url(self, url):
        """Open a URL in a new tab."""
        response = self.request('DevToolsService', command='list_tabs')
        tabs = response['data']
        first_tab = tabs[0]
        tab_id = first_tab[0]
        javascript = "window.open(%r, '_blank');" % (url,)
        self.request('V8Debugger', destination=tab_id,
                     command='evaluate_javascript', data=javascript)


if len(sys.argv) < 2:
    url = 'localhost'
else:
    url = sys.argv[1]

shell = Shell('localhost', 9222)
response = shell.request('DevToolsService', command='list_tabs')
tabs_with_url = []

for el in response['data']:
    if el[1].find(url) > -1:
        tabs_with_url.append(el[0])

for tab in tabs_with_url:
    shell.request('V8Debugger',
                  destination=tab,
                  command='evaluate_javascript',
                  data="window.location = window.location;")

print "Succesfully refreshed ==> " + str(len(tabs_with_url)) + " <== Chrome tabs containing the url = " + url
