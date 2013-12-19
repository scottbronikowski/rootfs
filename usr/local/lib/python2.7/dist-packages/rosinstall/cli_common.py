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

import os
import re
from optparse import OptionParser
from rosinstall.common import samefile, MultiProjectException

# Support for any command line interface (CLI) for rosinstall


def get_workspace(argv, shell_path, config_filename=None, varname=None):
    """
    If target option -t is given return value of that one. Else, if varname
    is given and exists, considers that one, plus,
    if config_filename is given, searches for a file named in config_filename
    in 'shell_path' and ancestors.
    In that case, if two solutions are found, asks the user.

    :param shell_path: where to look for relevant config_filename
    :param config_filename: optional, filename for files defining workspaces
    :param varname: optional,
    :returns: abspath if a .rosinstall was found, error and exist else.
    """
    parser = OptionParser()
    parser.add_option("-t", "--target-workspace", dest="workspace", default=None,
                      help="which workspace to use",
                      action="store")
    # suppress errors based on any other options this parser is agnostic about
    argv2 = [x for x in argv if ((not x.startswith('-')) or
                              x.startswith('--target-workspace=') or
                              x.startswith('-t') or
                              x == '--target-workspace')]
    (options, args) = parser.parse_args(argv2)
    if options.workspace is not None:
        if (config_filename is not None and
            not os.path.isfile(os.path.join(options.workspace, config_filename))):

            raise MultiProjectException("%s has no workspace configuration file '%s'" % (os.path.abspath(options.workspace), config_filename))
        return os.path.abspath(options.workspace)

    varname_path = None
    if varname is not None and varname in os.environ:
        # workspace could be relative, maybe confusing, but that's the users fault
        varname_path = os.environ[varname]
        if varname_path.strip() == '' or not os.path.isdir(varname_path):
            varname_path = None

    # use current dir
    current_path = None
    if config_filename is not None:
        while shell_path is not None and not shell_path == os.path.dirname(shell_path):
            if os.path.exists(os.path.join(shell_path, config_filename)):
                current_path = shell_path
                break
            shell_path = os.path.dirname(shell_path)

    if current_path is not None and varname_path is not None and not samefile(current_path, varname_path):
        raise MultiProjectException("Ambiguous workspace: %s=%s, %s" % (varname, varname_path, os.path.abspath(config_filename)))

    if current_path is None and varname_path is None:
        raise MultiProjectException("Command requires a target workspace.")

    if current_path is not None:
        return current_path
    else:
        return varname_path


def _uris_match(basepath, uri1, uri2):
    """
    True if uri2 is None or not None and same folder or equal string
    as uri1. Relative folders resolved using basepath
    """
    if uri1 is None:
        uri1 = ''
    if uri2 is None:
        return True
    if ((uri1 == uri2) or
        (basepath is not None and
         os.path.isdir(os.path.join(basepath, uri1)) and
         os.path.realpath(os.path.join(basepath, uri2)) == os.path.realpath(os.path.join(basepath, uri1)))):
        return True
    return False


def _get_status_flags(basepath, line):
    if 'exists' in line and line['exists'] is False:
        return 'x'
    mflag = ''
    if 'modified' in line and line['modified'] is True:
        mflag = 'M'
    if (('curr_uri' in line and
         not _uris_match(basepath, line['uri'], line['curr_uri'])) or
        ('specversion' in line and
         line['specversion'] is not None and
         line['actualversion'] is not None and
         line['specversion'] != line['actualversion'])):
        mflag += 'V'
    return mflag


def get_info_table_elements(basepath, entries, headers):
    """returns a list of dict with refined information from entries"""

    outputs = []
    for line in entries:
        if not 'curr_uri' in line:
            line['curr_uri'] = None
        if not 'specversion' in line:
            line['specversion'] = None
        if not 'actualversion' in line:
            line['actualversion'] = None
        if not 'curr_version' in line:
            line['curr_version'] = None
        if not 'version' in line:
            line['version'] = None
        output_dict = {'scm': line['scm'],
                       'uri': line['uri'],
                       'curr_uri': None,
                       'version': line['version'],
                       'localname': line['localname']}

        if line is None:
            print("Bug Warning, an element is missing")
            continue

        if line['scm'] == 'git':
            if (line['specversion'] is not None and len(line['specversion']) > 12):
                line['specversion'] = line['specversion'][0:12]
            if (line['actualversion'] is not None and len(line['actualversion']) > 12):
                line['actualversion'] = line['actualversion'][0:12]

        if line['scm'] is not None:

            if line['scm'] == 'svn':
                # in case of SVN, we can use the final part of standard uri as version
                uri = line['uri']
                version = line['version']
                match = re.match('(.*/)((tags|branches|trunk)(/.*)*)', uri)
                if match is not None and len(match.groups()) > 1 and uri == ''.join(match.groups()[0:2]):
                    uri = match.groups()[0]
                    if (match.groups()[1] is not None and version is None or version.strip() == ''):
                        version = match.groups()[1]
                    else:
                        version = match.groups()[1]
                    line['uri'] = uri
                    line['version'] = version
                if line['curr_uri'] is not None:
                    uri = line['curr_uri']
                    match = re.match('(.*/)((tags|branches|trunk)(/.*)*)', uri)
                    if match is not None and len(match.groups()) > 1 and uri == ''.join(match.groups()[0:2]):
                        uri = match.groups()[0]
                        if (match.groups()[1] is not None and version is None or version.strip() == ''):
                            version = match.groups()[1]
                        else:
                            version = match.groups()[1]
                        line['curr_uri'] = uri
                        line['curr_version'] = version

            if (line['curr_version'] is not None and
                line['version'] != line['curr_version']):

                output_dict['version'] = "%s  (%s)" % (line['curr_version'], line['version'])
            else:
                output_dict['version'] = line['version']

            if (line['specversion'] is not None and
                line['specversion'] != '' and
                line['actualversion'] != line['specversion']):

                output_dict['matching'] = "%s (%s)" % (line['actualversion'], line['specversion'])
            else:
                output_dict['matching'] = line['actualversion']

            common_prefixes = ["https://", "http://"]
            if line['uri'] is not None:
                for pre in common_prefixes:
                    if line['uri'].startswith(pre):
                        line['uri'] = line['uri'][len(pre):]
                        break
                output_dict['uri'] = line['uri']

            if line['curr_uri'] is not None:
                for pre in common_prefixes:
                    if line['curr_uri'].startswith(pre):
                        line['curr_uri'] = line['curr_uri'][len(pre):]
                        break

            if (not _uris_match(basepath, line['uri'], line['curr_uri'])):
                output_dict['uri'] = "%s    (%s)" % (line['curr_uri'], line['uri'])

        else:
            output_dict['matching'] = " "
        output_dict['status'] = _get_status_flags(basepath, line)

        outputs.append(output_dict)

    return outputs


def get_info_table(basepath, entries, data_only=False, reverse=False):
    """return a refined textual representation of the entries"""
    headers = {
      'uri': "URI  (Spec) [http(s)://...]",
      'scm': "SCM ",
      'localname': "Localname",
      'version': "Version-Spec",
      'matching': "UID  (Spec)",
      'status': "S"}

    # table design
    selected_headers = ['localname', 'status', 'scm', 'version', 'matching', 'uri']

    outputs = get_info_table_elements(
        basepath=basepath,
        entries=entries,
        headers=headers)

    # adjust column width
    column_length = {}
    for header in list(headers.keys()):
        column_length[header] = len(headers[header])
        for entry in outputs:
            if entry[header] is not None:
                column_length[header] = max(column_length[header],
                                            len(entry[header]))

    resultlines = []
    if not data_only and len(outputs) > 0:
        header_line = ' '
        for i, header in enumerate(selected_headers):
            output = headers[header]
            if i < len(selected_headers) - 1:
                output = output.ljust(column_length[header]) + " "
            header_line += output
        resultlines.append(header_line)
        header_line = ' '
        for i, header in enumerate(selected_headers):
            output = '-' * len(headers[header])
            if i < len(selected_headers) - 1:
                output = output.ljust(column_length[header]) + " "
            header_line += output
        resultlines.append(header_line)

    if reverse:
        outputs = reversed(outputs)
    for entry in outputs:
        if entry is None:
            print("Bug Warning, an element is missing")
            continue
        data_line = ' '
        for i, header in enumerate(selected_headers):
            output = entry[header]
            if output is None:
                output = ''
            if i < len(selected_headers) - 1:
                output = output.ljust(column_length[header]) + " "
            data_line += output
        resultlines.append(data_line)
    return "\n".join(resultlines)


def get_info_list(basepath, line, data_only=False):
    """
    Info for a single config entry
    """

    assert line is not None, "Bug Warning, an element is missing"

    headers = {
      'uri': "URI:",
      'curr_uri': "Current URI:",
      'scm': "SCM:",
      'localname': "Localname:",
      'path': "Path",
      'version': "Version-Spec:",
      'status': "Status:",
      'specversion': "Spec-Revision:",
      'actualversion': "Current-Revision:",
      'properties': "Other Properties:"}

    # table design
    selected_headers = ['localname', 'path', 'status',
                        'scm', 'uri', 'curr_uri',
                        'version', 'specversion', 'actualversion',
                        'properties']

    line['status'] = _get_status_flags(basepath, line)

    header_length = 0
    for header in list(headers.keys()):
        header_length = max(header_length, len(headers[header]))
    result = ''
    for header in selected_headers:
        if not data_only:
            title = "%s  " % (headers[header].ljust(header_length))
        else:
            title = ''
        if header in line:
            output = line[header]
        if output is None:
            output = ''
        result += "%s%s\n" % (title, output)
    return result
