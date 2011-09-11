# GC REFRESH v0.1

GC Refresh by Strzelewicz Alexandre (http://apps.hemca.com)
: This plugin **auto-reload Chromium tabs** when you save a file

# PLEASE

Contribute to : http://emacs.vote-system.com/ !

# INSTALLATION

1. You must be on a UNIX system
2. The command line **chromium-browser** must be accessible from the command line !

If all of this is OK so you can install it :

    $ cd ~/.emacs.d/
    $ git clone https://Alexandre-Strzelewicz@github.com/Alexandre-Strzelewicz/gc-refresh.git
    $ emacs ~/.emacs.el

Then add to your .emacs.el :

     (add-to-list 'load-path (expand-file-name "~/.emacs.d/gc-refresh"))
     (require 'gc-refresh-mode)

# USAGE

* M-x : gc-refresh-mode
* Type the url 
* Then you're OK !

# TODO

- File parsing to get URL to refresh & open directly the right page

MIT licensed

