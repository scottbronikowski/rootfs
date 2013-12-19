from __future__ import print_function
import argparse
import os
import stat
import sys

try:
    from catkin.environment_cache import generate_environment_script, generate_static_environment_script
except ImportError:
    # find the import relatively to make it work before installing catkin
    sys.path.append(os.path.join('/root/ros_core_ws/install/share/catkin/cmake', '..', 'python'))
    from catkin.environment_cache import generate_environment_script, generate_static_environment_script


parser = argparse.ArgumentParser(description='Generate cached environment script.')
parser.add_argument('--static', action='store_true', help='The flag to skip sourcing the env script and generate a static environment')
args = parser.parse_args()

if not args.static:
    code = generate_environment_script('/root/ros/geometry/tf_conversions/build/devel/env.sh')
else:
    code = generate_static_environment_script('/root/ros/geometry/tf_conversions/build/devel', ['/root/ros/geometry/tf_conversions/build/devel', '/root/ros_core_ws/install'], 'lib/python2.7/dist-packages')

with open('/root/ros/geometry/tf_conversions/build/catkin_generated/env_cached.sh', 'w') as f:
    #print('Generate script for cached environment "%s"' % '/root/ros/geometry/tf_conversions/build/catkin_generated/env_cached.sh')
    f.write('\n'.join(code))

mode = os.stat('/root/ros/geometry/tf_conversions/build/catkin_generated/env_cached.sh').st_mode
os.chmod('/root/ros/geometry/tf_conversions/build/catkin_generated/env_cached.sh', mode | stat.S_IXUSR)
