#
# (c) Eduard Bloch <blade@debian.org>, 2003-...
#
# generic methods for module-assistant controled packages
# to be sourced or copied as example code

# autodetecting values. They may be overriden including parent.

guess_source=${MA_SOURCE_PKG:-`basename $0`}
export guess_source

guess_package=${guess_source%-src}
guess_package=${guess_package%-source}
guess_package=${guess_package%-modules}
guess_package=${guess_package%-driver}
guess_package=${guess_package%-kernel}
export guess_package

topdir=${MOD_TOPDIR:-/usr/src}
aptget=${MA_APTCMD:-apt-get}

if test -n "$MA_DEBUG" ; then
   set -x
fi

if [ "$TARBALL" ] ; then
   tarball="$TARBALL"
else
   for suf in .tar.bz2 .tar.gz .tgz ; do
      for presuf in "" -module -modules -driver -drivers -source -src -kernel-source -kernel-src ; do
         if [ -r "$MOD_SRCDIR" -a -e "$MOD_SRCDIR/$guess_package$presuf$suf" ] ; then
            tarball=$MOD_SRCDIR/$guess_package$presuf$suf
            break 2;
         fi
         if [ -e /usr/src/$guess_package$presuf$suf ] ; then
            tarball=/usr/src/$guess_package$presuf$suf
            break 2;
         fi
      done
   done
fi

MODULE_LOC=${MODULE_LOC:-/usr/src/modules}
builddir_base=${BUILDDIR:-$MODULE_LOC/$guess_package}
pkgprefix=${PKGPREFIX:-$guess_package} # target base name something like sl-modules
sourcepkg=${SOURCEPKG:-$guess_source} # installed package that provides the source

MA_VARDIR=${MA_VARDIR:-/var/cache/modass}

if [ `id -u` != 0 ] ; then
    if test -n "$ROOT_CMD" ; then
        :
    else
        if which fakeroot >/dev/null 2>&1 ; then
            ROOT_CMD=fakeroot
        else
            clear
            echo
            echo Warning, you are not root and fakeroot is not installed
            sleep 3
        fi
    fi
fi

# and better not export ROOT_CMD, the targets in debian/rules do not
# need to run fakeroot inside fakeroot

action () {
   if [ "$VERBOSE" ] ; then
      echo " $@" >&2
      "$@"
   elif [ "$DRYRUN" ] ; then
      echo " $@" >&2
   else
      "$@"
   fi
}

locate_dir () {
   for suf in "" -module -modules -driver -drivers -source -src -kernel-source -kernel-src -module-source -module-src -kernel; do
      if [ -d "$builddir_base$suf/" ] ; then
         builddir=$builddir_base$suf
         return 0;
      fi
   done
   return 1;
}

locate_dir

update () {
   export sourcepkg
   #   action $dpkg -s $sourcepkg  2>/dev/null | grep ^Version: | cut -f2 -d\  > \
   #   $MA_VARDIR/cache/$pkgprefix.cur_version|| rm $MA_VARDIR/cache/$pkgprefix.cur_version 

   if test -e $MA_VARDIR/$sourcepkg.apt_policy ; then
      newinfo=`cat $MA_VARDIR/$sourcepkg.apt_policy`
   else
      newinfo=`LANG=C apt-cache policy $sourcepkg 2>/dev/null`
   fi
   IFS=''
   if test "$newinfo" ; then
      export newinfo
      echo -n $newinfo |tr -s " " | grep Candidate: | cut -f3 -d\  | tr -d '\n' > \
      $MA_VARDIR/$sourcepkg.avail_version
      instvers=$(echo -n $newinfo |tr -s " " | grep Installed: | cut -f3  -d\  | tr -d '\n')
      if [ "$instvers" = "(none)" ] ; then
         rm -f $MA_VARDIR/$sourcepkg.cur_version
      else
         echo -n $instvers > $MA_VARDIR/$sourcepkg.cur_version
      fi
   else
      rm -f $MA_VARDIR/$sourcepkg.avail_version $MA_VARDIR/$sourcepkg.cur_version
   fi
}

cur_version() {
   cat $MA_VARDIR/$sourcepkg.cur_version 2>/dev/null
}

avail_version() {
   cat $MA_VARDIR/$sourcepkg.avail_version
}

build() {
   shift
   eval `echo "$@" | tr ' ' '\n' | grep "KVERS\|KSRC\|KDREV"` 2>&1
   logfile=$MA_VARDIR/$sourcepkg.buildlog.$KVERS.`date +%s`
   flag=$MA_VARDIR/$sourcepkg.flag.$KVERS.`date +%s`
   export KVERS KDREV KSRC MA_VARDIR logfile flag

   ( echo Build log starting, file: $logfile ;
     echo Date: `date -R` ;
     echo ;
   ) > $logfile

   if test -z "$builddir" || ! test -d $builddir ; then
      if ! unpack || ! locate_dir ; then
         echo "Source not found. Run: module-assistant auto-install" | tee $logfile
         exit 1;
      fi
   fi
   cd $builddir || exit 1

   action $ROOT_CMD debian/rules kdist_clean | tee $logfile || true

   # bash cannot evaluate the return codes of the command in pipe, so
   # make this groovy workaround. I have tried flag process and tail
   # constructs, they all suck

   ( touch $flag && action $ROOT_CMD debian/rules "$@" 2>&1 || rm $flag
   )  | tee -a $logfile

   # if flag has survived, okay, otherwise sth. failed
   if test -f $flag ; then
       file=`action $ROOT_CMD debian/rules echo-debfile 2>/dev/null`
       if test -n "$file" && test -r "$file" ; then
           echo "$file" >> $MA_VARDIR/$sourcepkg.buildstate.$KVERS
       else
           perl -mCwd -pe 'if (/^dpkg-deb/) { s,\.deb.*\n,.deb,; s,.*\p{Zs}[^\w./]+,,; s,//,/,g; $_=Cwd::abs_path($_)."\n";} else {undef $_}' $logfile >> $MA_VARDIR/$sourcepkg.buildstate.$KVERS
       fi
      # extra stuff
      begin=`ls -l --time-style=+%s $flag | tr -s ' ' | cut -f6 -d\ `
      echo Build time: $(expr $(date +%s) - $begin) seconds >> $logfile
      rm -f $flag
   else
      tput smso ; echo BUILD FAILED! ; 
      tput rmso ; echo See $logfile for details.
      exit 1;
   fi
}

lastpkg() {
# assume that KVERS is in the environment
   action tail -n1 $MA_VARDIR/$sourcepkg.buildstate.$KVERS 2>/dev/null
}

unpack() {

   if test -n "$MA_NOTUNP" ; then return 0 ; fi

   cd $topdir || exit 1
#   test -r $target || return 1
   if test -e "$tarball" ; then
      if ! test -r "$tarball" ; then
         echo "Could not read $tarball!"
         exit 1
      fi
   else
      echo "The source tarball could not be found!"
      echo "Package $sourcepkg not installed?"
      echo "Running \"m-a -f get $sourcepkg\" may help."
      exit 1
  fi
  echo Extracting the package tarball, $tarball, please wait...
  if [ ${tarball%gz} != $tarball ] ; then
      action tar --gzip -x -f $tarball
  elif [ ${tarball%bz2} != $tarball ] ; then
      action action tar --bzip2 -x -f $tarball
  else
      echo Unknown compression method, $tarball
      exit 1
  fi
}

download() {
   action $ROOT_CMD $aptget $REINSTALL install $sourcepkg
}

# wipes the builddir
clean() {
   rm -rf $builddir
}
   
purge() {
   action rm -f `cat $MA_VARDIR/$sourcepkg.buildstate.*`
   action rm -rf $builddir $MA_VARDIR/$sourcepkg.*
}

installed() {
#   action test "`cat $MA_VARDIR/$pkgprefix.cur_version` 2>/dev/null"
#   exit $?
  test -s $MA_VARDIR/$sourcepkg.cur_version && test -e $tarball
  exit $?
}

prefix() {
   echo $pkgprefix
}

echodebfile() {
   eval `echo "$@" | tr ' ' '\n' | grep "KVERS\|KDREV\|KSRC"`
   logfile=$MA_VARDIR/$sourcepkg.buildlog.$KVERS.`date +%s`
   export KVERS KDREV KSRC MA_VARDIR
   cd $builddir 2>/dev/null || exit 1
   $ROOT_CMD debian/rules echo-debfile 2>/dev/null
}

