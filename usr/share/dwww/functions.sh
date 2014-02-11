# Common functions used by dwww shell scripts
#
# $Id: functions.sh.in 548 2011-01-16 20:41:44Z robert $
#

readonly dwww_config="/etc/dwww/dwww.conf"
readonly dwww_libdir="/usr/share/dwww"
readonly dwww_version="1.11.7"
readonly dwww_cache_dir="/var/cache/dwww"

#
# Initialize dwww: set default variables, read config file, set umask & PATH
#
dwww_initialize() {

	
	DWWW_ALLOWEDLINKPATH="/usr/share:/usr/lib:/usr/local/share:/var/www"
	DWWW_BROWSER=""
	DWWW_CGIDIR="/usr/lib/cgi-bin"
	DWWW_CGIUSER="www-data"
	DWWW_DOCBASE2PKG_DB="/var/cache/dwww/docbase2pkg.dat"
	DWWW_DOCPATH="/usr/share/doc:/usr/share/info:/usr/share/man:/usr/local/share/doc:/usr/local/share/info:/usr/local/share/man:/usr/share/common-licenses"
	DWWW_DOCROOTDIR="/var/www"
	DWWW_INDEX_DOCUMENTATION="yes"
	DWWW_INDEX_FULL_TIME_INTERVAL="28"
	DWWW_INDEX_INCREMENTAL_TIME_INTERVAL="7"
	DWWW_KEEPDAYS="10"
	DWWW_MERGE_MAN2HTML_INDEX="no"
	DWWW_QUICKFIND_DB="/var/cache/dwww/quickfind.dat"
	DWWW_REGDOCS_DB="/var/cache/dwww/regdocs.dat"
	DWWW_SERVERNAME="localhost"
	DWWW_SERVERPORT="80"
	DWWW_TMPDIR="/var/lib/dwww"
	DWWW_USEFILEURL="no"
	DWWW_USEHTTPS="no"
	DWWW_USE_CACHE="yes"
	DWWW_X11_BROWSER=""


	
	if [ -r "$dwww_config" ]  ; then
		. "$dwww_config"
	fi

	umask 022
	PATH="/usr/sbin:/usr/bin:/bin:$PATH"
}

#
# Recreate /var/cache/dwww if it's removed
#
dwww_setup_cache_dir() {
	if [ ! -d "$dwww_cache_dir" ]; then
		mkdir "$dwww_cache_dir"
		chmod 755 "$dwww_cache_dir"
		chown root "$dwww_cache_dir"
	fi		
	if [ ! -d "$dwww_cache_dir/db" ]; then
		mkdir "$dwww_cache_dir/db"
		chmod 755 "$dwww_cache_dir/db"
		chown "$DWWW_CGIUSER" "$dwww_cache_dir/db"
	fi
}	
	
#
# Encode URLs
#
urlencode() {
	echo "$@" | perl -pe 'chomp(); s/([^A-Za-z0-9\ \_\-\.\/])/"%" . unpack("H*", $1)/eg; tr/ /+/;'
}


#
# Format as table
#
table_it()
{
	state=A
	w1=' WIDTH="33%"'
	w2=''
	
	echo '<TABLE BORDER="0" WIDTH="95%" ALIGN="center">'
	
	while read line ; do
		
		case "$state" in
			A)
				state=B
				echo "<TR>"
				echo "<TD$w1 ALIGN=\"LEFT\">$line</TD>"
			;;
			B)
				state=C
				echo "<TD$w1 ALIGN=\"LEFT\">$line</TD>"
				w1=""
			;;
			C)
				state=A
				echo "<TD$w2 ALIGN=\"LEFT\">$line</TD>"
				echo "</TR>"
				w2=""
			;;
		esac
		
	done

	case "$state" in
		A)
		;;
		B)
			echo "<TD$w1></TD><TD$w2></TD></TR>"
		;;
		C)
			echo "<TD$w2></TD></TR>"
		;;
	esac
	
	if [ "$first_line" != A ]; then
		echo '</TABLE>'
	fi		
}


