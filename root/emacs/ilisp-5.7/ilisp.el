;;; -*- Mode: Emacs-Lisp -*-

;;; ilisp.el --

;;; This file is part of ILISP.
;;; Version: 5.7
;;;
;;; Copyright (C) 1990, 1991, 1992, 1993 Chris McConnell
;;;               1993, 1994 Ivan Vasquez
;;;               1994, 1995 Marco Antoniotti and Rick Busdiecker
;;;
;;; Other authors' names for which this Copyright notice also holds
;;; may appear later in this file.
;;;
;;; Send mail to 'ilisp-request@lehman.com' to be included in the
;;; ILISP mailing list. 'ilisp@lehman.com' is the general ILISP
;;; mailing list were bugs and improvements are discussed.
;;;
;;; ILISP is freely redistributable under the terms found in the file
;;; COPYING.

     

;;; Author: Chris McConnell <ccm@cs.cmu.edu>
;;; Maintainer: The Net <ilisp@lehman.com>
;;; Created: 14 Jun 1994
;;; Version: 5.7
;;; Keywords: lisp common-lisp scheme comint

;;; This file may become part of GNU Emacs in the near future.

;;; GNU Emacs is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY.  No author or distributor
;;; accepts responsibility to anyone for the consequences of using it
;;; or for whether it serves any particular purpose or works at all,
;;; unless he says so in writing.  Refer to the GNU Emacs General Public
;;; License for full details.

;;; Everyone is granted permission to copy, modify and redistribute
;;; GNU Emacs, but only under the conditions described in the
;;; GNU Emacs General Public License.   A copy of this license is
;;; supposed to have been given to you along with GNU Emacs so you
;;; can know your rights and responsibilities.  It should be in a
;;; file named COPYING.  Among other things, the copyright notice
;;; and this notice must be preserved on all copies.

;;; *****************************************************************
;;; Please read the texinfo file (via m-x info in emacs or tex it and
;;; print it out) for installation instructions.
;;; *****************************************************************

;;; This file defines a generic LISP interface that can be customized
;;; to match a specific LISP dialect.  Support is already provided for
;;; a number of common LISP dialects.  Lucid, Allegro and CMU are
;;; fully supported.  Other LISP dialects are missing features like
;;; arglist and find-source.

;;; Since this is built on top of the general command-interpreter-in-
;;; a-buffer mode (comint mode), it shares a common base
;;; functionality, and a common set of bindings, with all modes
;;; derived from comint mode.  This makes it easier to use.

;;; For documentation on the functionality provided by comint mode,
;;; and the hooks available for customizing it, see the file
;;; comint.el.

;;; Throughout this file you will find comment lines with %'s on them.
;;; These lines define sections for outline mode which I use while
;;; programming to temporarily hide code.

;;; See the documentation for ILISP mode, or read texinfo document for
;;; information.  All of the EMACS function names begin or end with
;;; lisp or ilisp to separate ilisp functions from functions in other
;;; packages.  Functions that work only in lisp buffers or that work
;;; in both lisp buffers and inferior lisp buffers use lisp, all other
;;; functions use ilisp.  If a function is intended to be used
;;; interactively, then the lisp or ilisp comes at the end of the
;;; function name, otherwise at the start.

;;;%%KNOWN BUGS
;;; 
;;; If you type multiple things to the top level before you get a
;;; prompt, the LISP may be running with the status light indicating
;;; ready.  This is because I have no way to distinguish between input
;;; to a program and that to the top level.
;;;
;;; When running a lisp on Ultrix, you need to set ilisp-program to
;;; "/bin/sh -c your/path/your-lisp-image".
;;; 
;;; If you get lisp output breaking up in weird places it almost
;;; certainly means that comint-prompt-regexp is not precise enough.
;;;
;;; I would like to eat Lucid's return from break in the process
;;; filter, but I can't tell how many newlines to eat after.


;;;%%CONTRIBUTORS

;; Recent contributors include (in alphabetical order):

;; Marco Antoniotti, Robert P. Goldman, Larry Hunter, Eyvind Ness, 
;; Ivan Vazquez, Fred White


;;;%Requirements
(if (string-match "\\`18" emacs-version)
    (load "comint-v18") ; Included older version of comint.
  (require 'comint))


;;; This is the old call. The new one is just below. It now dispatches
;;; on the correct type of Emacs.
;;;(load "ilisp-cpat")
(load "ilcompat")

(load "comint-ipc")

;; This is optional -- used only by io-bridge-ilisp
(load "bridge")

(if (load "ilisp-all.elc" t)
    t
  (progn				; I know it is useless in Elisp.
    (load "ilisp-def")
    (load "ilisp-el")
    (load "ilisp-sym")
    (load "ilisp-inp")
    (load "ilisp-ind")

    (load "ilisp-prc")
    (load "ilisp-val")
    (load "ilisp-out")
    (load "ilisp-mov")
    (load "ilisp-key")
    (load "ilisp-prn")
    (load "ilisp-low")
    (load "ilisp-doc")
    (load "ilisp-ext")			; Some emacs-lisp
					; bindings. Lisp char syntax.
    (load "ilisp-mod")
    (load "ilisp-dia")
    (load "ilisp-cmt")
    (load "ilisp-rng")
    (load "ilisp-hnd")
    (load "ilisp-utl")
    (load "ilisp-cmp")
    (load "ilisp-kil")
    (load "ilisp-snd")
    (load "ilisp-xfr")
    (load "ilisp-hi")
    (load "ilisp-aut")

    ;; Dialects.
    ;; The user will define their autoloads to load "ilisp" when trying
    ;; to run their dialect.  This will load all of the dialects in.
    (load "ilisp-cl")
    (load "ilisp-cmu")
    (load "ilisp-acl")
    (load "ilisp-hlw")
    (load "ilisp-kcl")
    (load "ilisp-luc")
    (load "ilisp-sch")
    ))

;;; Create the keymaps before running the hooks.
;;; This is necessary if you want the lispm bindings in the load
;;; hook. Otherwise you need to put it AFTER the running of the hooks

;;; (if (not ilisp-mode-map) (ilisp-bindings))


;;; Now run the hooks.

(run-hooks 'ilisp-site-hook)
;;; (run-hooks 'load-hook)
(run-hooks 'ilisp-load-hook)		; It seem s more reasonable.

(if (not ilisp-mode-map) (ilisp-bindings))

;;; Optional:
; (load "ilisp-menu")
(if (not (member +ilisp-emacs-version-id+ '(xemacs lucid-19 lucid-19-new)))
    (load "ilisp-mnb"))

(provide 'ilisp)
