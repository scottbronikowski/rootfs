
 /* ==================================================================
    FILE: "/home/joze/src/tclreadline/tclreadline.h.in"
    LAST MODIFICATION: "Mit, 20 Sep 2000 17:18:12 +0200 (joze)"
    (C) 1998 - 2000 by Johannes Zellner, <johannes@zellner.org>
    $Id: tclreadline.h.in,v 2.5 2000/09/20 17:44:34 joze Exp $
    vim:set ft=c:
    ---
    tclreadline -- gnu readline for tcl
    http://www.zellner.org/tclreadline/
    Copyright (c) 1998 - 2000, Johannes Zellner <johannes@zellner.org>
    This software is copyright under the BSD license.
    ================================================================== */  

#ifndef TCLREADLINE_H_
#define TCLREADLINE_H_

#include <tcl.h>

#define TCLRL_LIBRARY        "/usr/share/tcltk/tclreadline2.1.0"

/* VERSION STRINGS */
#define TCLRL_VERSION_STR    "2.1.0"
#define TCLRL_PATCHLEVEL_STR "2.1.0"

/* VERSION NUMBERS */
#define TCLRL_MAJOR      2
#define TCLRL_MINOR      1
#define TCLRL_PATCHLEVEL 0

#ifdef __cplusplus
extern "C" {
#endif
int Tclreadline_Init(Tcl_Interp *interp);
int Tclreadline_SafeInit(Tcl_Interp *interp);
#ifdef __cplusplus
}
#endif

#endif /* TCLREADLINE_H_ */
