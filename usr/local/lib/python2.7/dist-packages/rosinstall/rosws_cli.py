# Software License Agreement (BSD License)
#
# Copyright (c) 2010, Willow Garage, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of Willow Garage, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

"""%(prog)s is a command to manipulate ROS workspaces. %(prog)s replaces its predecessor rosinstall.

Official usage:
  %(prog)s CMD [ARGS] [OPTIONS]

%(prog)s will try to infer install path from context

Type '%(prog)s help' for usage.
"""

from __future__ import print_function
import os
import sys
import yaml

from optparse import OptionParser

from rosinstall.cli_common import get_info_list, get_info_table, get_workspace
import rosinstall.rosinstall_cmd as rosinstall_cmd
from rosinstall.multiproject_cmd import get_config, cmd_install_or_update, \
    cmd_snapshot, cmd_version, cmd_info
import rosinstall.__version__

from rosinstall.common import MultiProjectException, select_elements
from rosinstall.helpers import ROSINSTALL_FILENAME, \
    get_ros_package_path, get_ros_stack_path
from rosinstall.multiproject_cli import MultiprojectCLI, __MULTIPRO_CMD_DICT__, \
    __MULTIPRO_CMD_HELP_LIST__, __MULTIPRO_CMD_ALIASES__, \
    IndentedHelpFormatterWithNL, list_usage

## This file adds or extends commands from multiproject_cli where ROS
## specific output has to be generated.

# extend the commands of multiproject
__ROSWS_CMD_DICT__ = {}
__ROSWS_CMD_DICT__.update(__MULTIPRO_CMD_DICT__)
__ROSWS_CMD_DICT__["regenerate"] = "create ROS workspace specific setup files"

__ROSWS_CMD_HELP_LIST__ = __MULTIPRO_CMD_HELP_LIST__[:]
__ROSWS_CMD_HELP_LIST__.extend([None, 'regenerate'])

_PROGNAME = 'rosws'
_VARNAME = 'ROS_WORKSPACE'


class RoswsCLI(MultiprojectCLI):

    def __init__(self, config_filename=ROSINSTALL_FILENAME, progname=_PROGNAME):
        MultiprojectCLI.__init__(self,
                                 progname=progname,
                                 config_filename=config_filename,
                                 config_generator=rosinstall_cmd.cmd_persist_config)

    def cmd_init(self, argv):
        if self.config_filename is None:
            print('Error: Bug: config filename required for init')
            return 1
        parser = OptionParser(usage="""usage: %s init [TARGET_PATH [SOURCE_PATH]]?""" % _PROGNAME,
                              formatter=IndentedHelpFormatterWithNL(),
                              description=__MULTIPRO_CMD_DICT__["init"] + """

%(prog)s init does the following:
  1. Reads folder/file/web-uri SOURCE_PATH looking for a rosinstall yaml
  2. Creates new %(cfg_file)s file at TARGET-PATH
  3. Generates ROS setup files

SOURCE_PATH can e.g. be a folder like /opt/ros/electric
If PATH is not given, uses current dir.

Examples:
$ %(prog)s init ~/fuerte /opt/ros/fuerte
""" % {'cfg_file': self.config_filename, 'prog': _PROGNAME},
                              epilog="See: http://www.ros.org/wiki/rosinstall for details\n")
        parser.add_option("-c", "--catkin", dest="catkin", default=False,
                          help="Declare this is a catkin build.",
                          action="store_true")
        parser.add_option("--cmake-prefix-path", dest="catkinpp", default=None,
                          help="Where to set the CMAKE_PREFIX_PATH",
                          action="store")
        parser.add_option("--continue-on-error", dest="robust", default=False,
                          help="Continue despite checkout errors",
                          action="store_true")
        parser.add_option("-j", "--parallel", dest="jobs", default=1,
                          help="How many parallel threads to use for installing",
                          action="store")
        (options, args) = parser.parse_args(argv)
        if len(args) < 1:
            target_path = '.'
        else:
            target_path = args[0]

        if not os.path.isdir(target_path):
            if not os.path.exists(target_path):
                os.mkdir(target_path)
            else:
                print('Error: Cannot create in target path %s ' % target_path)

        if os.path.exists(os.path.join(target_path, self.config_filename)):
            print('Error: There already is a workspace config file %s at "%s". Use %s install/modify.' % (self.config_filename, target_path, _PROGNAME))
            return 1
        if len(args) > 2:
            parser.error('Too many arguments')
        config_uris = []
        if len(args) == 2:
            config_uris.append(args[1])
        if len(config_uris) > 0:
            print('Using ROS_ROOT: %s' % config_uris[0])

        config = get_config(basepath=target_path,
                            additional_uris=config_uris,
                            config_filename=self.config_filename)

        # includes ROS specific files

        print("Writing %s" % os.path.join(config.get_base_path(), self.config_filename))
        rosinstall_cmd.cmd_persist_config(config)

        ## install or update each element
        install_success = cmd_install_or_update(
            config,
            robust=False,
            num_threads=int(options.jobs))

        rosinstall_cmd.cmd_generate_ros_files(config,
                                              target_path,
                                              nobuild=True,
                                              rosdep_yes=False,
                                              catkin=options.catkin,
                                              catkinpp=options.catkinpp,
                                              no_ros_allowed=True)

        if not install_success:
            print("Warning: installation encountered errors, but --continue-on-error was requested.  Look above for warnings.")
        print("\nrosinstall update complete.")
        if (options.catkin is False
            and options.catkinpp is None):
            print("\nType 'source %s/setup.bash' to change into this environment. Add that source command to the bottom of your ~/.bashrc to set it up every time you log in.\n\nIf you are not using bash please see http://www.ros.org/wiki/rosinstall/NonBashShells " % os.path.abspath(target_path))
        return 0


    def cmd_regenerate(self, target_path, argv, config=None):
        parser = OptionParser(usage="usage: %s regenerate" % _PROGNAME,
                              formatter=IndentedHelpFormatterWithNL(),
                              description=__MULTIPRO_CMD_DICT__["remove"] + """

this command without options generates files setup.sh, setup.bash and
setup.zsh. Note that doing this is unnecessary in general, as these
files do not change anymore, unless you change from one ROS distro to
another (which you should never do like this, create a separate new
workspace instead), or you deleted or modified any of those files
accidentally.
""",
                              epilog="See: http://www.ros.org/wiki/rosinstall for details\n")
        parser.add_option("-c", "--catkin", dest="catkin", default=False,
                          help="Declare this is a catkin build.",
                          action="store_true")
        parser.add_option("--cmake-prefix-path", dest="catkinpp", default=None,
                          help="Where to set the CMAKE_PREFIX_PATH",
                          action="store")
        (options, args) = parser.parse_args(argv)
        if len(args) > 0:
            print("Error: Too many arguments.")
            print(parser.usage)
            return -1

        if config is None:
            config = get_config(
                target_path,
                additional_uris=[],
                config_filename=self.config_filename)
        elif config.get_base_path() != target_path:
            raise MultiProjectException(
                "Config path does not match %s %s " % (config.get_base_path(),
                                                     target_path))
        rosinstall_cmd.cmd_generate_ros_files(config,
                                              target_path,
                                              nobuild=True,
                                              rosdep_yes=False,
                                              catkin=options.catkin,
                                              catkinpp=options.catkinpp,
                                              no_ros_allowed=True)
        return 0

    def cmd_info(self, target_path, argv, reverse=True, config=None):
        only_option_valid_attrs = ['path', 'localname', 'version', 'revision', 'cur_revision', 'uri', 'cur_uri', 'scmtype']
        parser = OptionParser(usage="usage: %s info [localname]* [OPTIONS]" % _PROGNAME,
                              formatter=IndentedHelpFormatterWithNL(),
                              description=__MULTIPRO_CMD_DICT__["info"] + """

The Status (S) column shows
 x  for missing
 L  for uncommited (local) changes
 V  for difference in version and/or remote URI

The 'Version-Spec' column shows what tag, branch or revision was given
in the .rosinstall file. The 'UID' column shows the unique ID of the
current (and specified) version. The 'URI' column shows the configured
URL of the repo.

If status is V, the difference between what was specified and what is
real is shown in the respective column. For SVN entries, the url is
split up according to standard layout (trunk/tags/branches).  The
ROS_PACKAGE_PATH follows the order of the table, earlier entries
overlay later entries.

When given one localname, just show the data of one element in list form.
This also has the generic properties element which is usually empty.

The --only option accepts keywords: %(opts)s

Examples:
$ %(prog)s info -t ~/ros/fuerte
$ %(prog)s info robot_model
$ %(prog)s info --yaml
$ %(prog)s info --only=path,cur_uri,cur_revision robot_model geometry
""" % {'prog': _PROGNAME, 'opts': only_option_valid_attrs},
                              epilog="See: http://www.ros.org/wiki/rosinstall for details\n")
        parser.add_option("--data-only", dest="data_only", default=False,
                          help="Does not provide explanations",
                          action="store_true")
        parser.add_option("--no-pkg-path", dest="no_pkg_path", default=False,
                          help="Suppress ROS_PACKAGE_PATH.",
                          action="store_true")
        parser.add_option("--pkg-path-only", dest="pkg_path_only", default=False,
                          help="Shows only ROS_PACKAGE_PATH separated by ':'. Supercedes all other options.",
                          action="store_true")
        parser.add_option("--only", dest="only", default=False,
                          help="Shows comma-separated lists of only given comma-separated attribute(s).",
                          action="store")
        parser.add_option("--yaml", dest="yaml", default=False,
                          help="Shows only version of single entry. Intended for scripting.",
                          action="store_true")

        # -t option required here for help but used one layer above, see cli_common
        parser.add_option("-t", "--target-workspace", dest="workspace", default=None,
                          help="which workspace to use",
                          action="store")
        (options, args) = parser.parse_args(argv)

        if config is None:
            config = get_config(
                target_path,
                additional_uris=[],
                config_filename=self.config_filename)
        elif config.get_base_path() != target_path:
            raise MultiProjectException("Config path does not match %s %s " % (config.get_base_path(), target_path))
        if args == []:
            args = None
        # relevant for code completion, so these should yield quick response:
        if options.pkg_path_only:
            print(":".join(get_ros_package_path(config)))
            return 0
        elif options.only:
            only_options = options.only.split(",")
            if only_options == '':
                parser.error('No valid options given')

            lookup_required = False
            for attr in only_options:
                if not attr in only_option_valid_attrs:
                    parser.error("Invalid --only option '%s', valids are %s" % (attr, only_option_valid_attrs))
                if attr in ['cur_revision', 'cur_uri', 'revision']:
                    lookup_required = True
            elements = select_elements(config, args)
            for element in elements:
                if lookup_required and element.is_vcs_element():
                    spec = element.get_versioned_path_spec()
                else:
                    spec = element.get_path_spec()
                output = []
                for attr in only_options:
                    if 'localname' == attr:
                        output.append(spec.get_local_name() or '')
                    if 'path' == attr:
                        output.append(spec.get_path() or '')
                    if 'scmtype' == attr:
                        output.append(spec.get_scmtype() or '')
                    if 'uri' == attr:
                        output.append(spec.get_uri() or '')
                    if 'version' == attr:
                        output.append(spec.get_version() or '')
                    if 'revision' == attr:
                        output.append(spec.get_revision() or '')
                    if 'cur_uri' == attr:
                        output.append(spec.get_curr_uri() or '')
                    if 'cur_revision' == attr:
                        output.append(spec.get_current_revision() or '')
                print(','.join(output))
            return 0
        if options.yaml:
            source_aggregate = cmd_snapshot(config, localnames=args)
            print(yaml.safe_dump(source_aggregate))
            return 0

        # this call takes long, as it invokes scms.
        outputs = cmd_info(config, localnames=args)
        if args is not None and len(outputs) == 1:
            print(get_info_list(config.get_base_path(),
                                outputs[0],
                                options.data_only))
            return 0

        header = 'workspace: %s\nROS_ROOT: %s' % (target_path,
                                                get_ros_stack_path(config))
        print(header)
        if not options.no_pkg_path:
            table = get_info_table(config.get_base_path(),
                                   outputs,
                                   options.data_only,
                                   reverse=reverse)
            if table is not None and table != '':
                print("\n%s" % table)

        return 0
def rosws_main(argv=None, usage=None):
    """
    Calls the function corresponding to the first argument.

    :param argv: sys.argv by default
    :param usage: function printing usage string, multiproject_cli.list_usage by default
    """
    if argv is None:
        argv = sys.argv
    if (sys.argv[0] == '-c'):
        sys.argv = [_PROGNAME] + sys.argv[1:]
    if '--version' in argv:
        print("%s: \t%s\n%s" % (_PROGNAME, rosinstall.__version__.version, cmd_version()))
        sys.exit(0)

    if not usage:
        usage = lambda: print(list_usage(progname=_PROGNAME,
                                         description=__doc__,
                                         command_keys=__ROSWS_CMD_HELP_LIST__,
                                         command_helps=__ROSWS_CMD_DICT__,
                                         command_aliases=__MULTIPRO_CMD_ALIASES__))
    workspace = None
    if len(argv) < 2:
        try:
            workspace = get_workspace(argv,
                                      os.getcwd(),
                                      config_filename=ROSINSTALL_FILENAME,
                                      varname=_VARNAME)
            argv.append('info')
        except MultiProjectException as e:
            print(str(e))
            usage()
            return 0

    if '--help' == argv[1]:
        usage()
        return 0

    try:
        command = argv[1]
        args = argv[2:]

        if command == 'help':
            if len(argv) < 3:
                usage()
                return 0

            else:
                command = argv[2]
                args = argv[3:]
                args.insert(0, "--help")
                # help help
                if command == 'help':
                    usage()
                    return 0
        cli = RoswsCLI()

        # commands for which we do not infer target workspace
        commands = {'init': cli.cmd_init}
        # commands which work on a workspace
        ws_commands = {
            'info': cli.cmd_info,
            'remove': cli.cmd_remove,
            'regenerate': cli.cmd_regenerate,
            'set': cli.cmd_set,
            'merge': cli.cmd_merge,
            'diff': cli.cmd_diff,
            'status': cli.cmd_status,
            'update': cli.cmd_update}
        for label in list(ws_commands.keys()):
            if label in __MULTIPRO_CMD_ALIASES__:
                ws_commands[__MULTIPRO_CMD_ALIASES__[label]] = ws_commands[label]

        if command not in commands and command not in ws_commands:
            if os.path.exists(command):
                args = ['-t', command] + args
                command = 'info'
            else:
                if command.startswith('-'):
                    print("First argument must be name of a command: %s" % command)
                else:
                    print("Error: unknown command: %s" % command)
                usage()
                return 1

        if command in commands:
            return commands[command](args)
        else:
            if workspace is None and not '--help' in args and not '-h' in args:
                workspace = get_workspace(args,
                                          os.getcwd(),
                                          config_filename=ROSINSTALL_FILENAME,
                                          varname=_VARNAME)
            return ws_commands[command](workspace, args)

    except KeyboardInterrupt:
        return 1
