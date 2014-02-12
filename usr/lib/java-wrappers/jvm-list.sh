# jvm-list.sh: a list of available JVM and some shortcuts
# Copyright 2008, 2009 by Vincent Fourmond <fourmond@debian.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.

# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

# All variables defined here can be used as arguments for the
# find_java_runtime function if you strip the __jvm_ at the beginning
# of the variable...
#
# They can also be used for the JAVA_FLAVOR environment variable, see
# java-wrappers(7).

__arch=$(dpkg --print-architecture)

# default runtime
__jvm_default="/usr/lib/jvm/default-java"

# Sun runtimes
__jvm_sun6="/usr/lib/jvm/java-6-sun /usr/lib/j2*1.6-sun"

# all sun runtimes
__jvm_sun="$__jvm_sun6"
# Sun version at least 5:
__jvm_sunmin5="$__jvm_sun6"

# Now, free runtimes:
__jvm_gcj2="/usr/lib/jvm/java-*-gcj-4.* "
__jvm_gcj5="/usr/lib/jvm/java-1.5*-gcj-4.* "
__jvm_openjdk6="/usr/lib/jvm/java-6-openjdk-$__arch /usr/lib/jvm/java-6-openjdk"
__jvm_openjdk7="/usr/lib/jvm/java-7-openjdk-$__arch /usr/lib/jvm/java-7-openjdk"


# And a few aliases
__jvm_gcj="$__jvm_gcj2"
__jvm_openjdk="$__jvm_openjdk7 $__jvm_openjdk6"

# The java* runtimes:
__jvm_java7="$__jvm_openjdk7"
# -> corresponds to Provides: java6-runtime 
__jvm_java6="$__jvm_openjdk6 $__jvm_sun6 $__jvm_java7"
# -> corresponds to Provides: java5-runtime 
__jvm_java5="$__jvm_gcj5 $__jvm_java6"
# -> corresponds to Provides: java2-runtime 
__jvm_java2="$__jvm_java5 $__jvm_gcj2"

# current java alternatives
__jvm_alt=$(readlink /etc/alternatives/java|sed -n 's/\(\/usr\/lib\/jvm\/[^\/]*\)\/.*/\1/p')

# All JVMs
__jvm_all="$__jvm_default /usr/lib/jvm/*"

# Probably here should come a few meaningful global aliases.
