# Software License Agreement (BSD License)
#
# Copyright (c) 2009, Willow Garage, Inc.
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
import yaml
try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen

from rosinstall.common import MultiProjectException

__REPOTYPES__ = ['svn', 'bzr', 'hg', 'git', 'tar']
__ALLTYPES__ = __REPOTYPES__ + ['other', 'setup-file']

## The Path spec is a leightweigt object to transport the
## specification of a config element between functions,
## independently of yaml structure.
## Specifications are persisted in yaml, this file deals
## with manipulations of any such structures representing configs as
## yaml.
## get_path_spec_from_yaml turns yaml into path_spec, and pathspec
## get_legacy_yaml returns yaml.


def get_yaml_from_uri(uri):
    """reads and parses yaml from a local file or remote uri"""
    stream = None
    try:
        try:
            if os.path.isfile(uri):
                stream = open(uri, 'r')
            else:
                stream = urlopen(uri)
        except IOError as ioe:
            raise MultiProjectException(
                "Is not a local file, nor able to download as a URL [%s]: %s\n" % (uri, ioe))
        except ValueError as vae:
            raise MultiProjectException(
                "Is not a local file, nor a valid URL [%s] : %s\n" % (uri, vae))

        if not stream:
            raise MultiProjectException("couldn't load config uri %s\n" % uri)
        try:
            yamldata = yaml.load(stream)
        except yaml.YAMLError as yame:
            raise MultiProjectException(
                "Invalid multiproject yaml format in [%s]: %s\n" % (uri, yame))

        # we want a list or a dict, but pyyaml parses xml as string
        if type(yamldata) == 'str':
            raise MultiProjectException(
                "Invalid multiproject yaml format in [%s]: %s\n" % (uri, yamldata))
    finally:
        if stream is not None:
            stream.close()
    return yamldata


def get_path_specs_from_uri(uri, config_filename=None, as_is=False):
    """
    Builds a list of PathSpec elements from several types of input locations, "uris".
    The function treats other workspace folders/files as special uris to prevent mutual conflicts.

    :param uri: a folder, a file, or a web url
    :param config_filename: name for files to be treated special as other workspaces
    :param as_is: do not rewrite, used for loading the current workspace config without rewriting
    """
    if os.path.isdir(uri):
        if (config_filename is not None and
            os.path.isfile(os.path.join(uri, config_filename))):

            uri = os.path.join(uri, config_filename)
        else:
            # plain folders returned as themselves
            return [PathSpec(local_name=uri)]
    yaml_spec = get_yaml_from_uri(uri)
    if yaml_spec is None:
        return []
    specs = [get_path_spec_from_yaml(x) for x in yaml_spec]

    if (config_filename is not None and
        not as_is and
        os.path.isfile(uri) and
        os.path.basename(uri) == config_filename):

        # treat config files and folders with such files special
        # to prevent 2 workspaces from interacting
        return rewrite_included_source(specs, os.path.dirname(uri))
    return specs


def rewrite_included_source(source_path_specs, source_dir):
    """
    assumes source_path_specs is the contents of a config file in
    another directory source dir. It rewrites all elements, by changing
    any relative path relative to source dir and changing vcs
    types to non-vcs types types, to prevent two environments from
    conflicting
    """
    for index, pathspec in enumerate(source_path_specs):
        local_name = os.path.normpath(os.path.join(source_dir,
                                                   pathspec.get_local_name()))
        pathspec.set_local_name(local_name)
        if pathspec.get_path() is not None:
            path = os.path.normpath(os.path.join(source_dir, pathspec.get_path()))
            pathspec.set_path(path)
        pathspec.detach_vcs_info()
        source_path_specs[index] = pathspec
    return source_path_specs


def aggregate_from_uris(config_uris, config_filename=None):
    """
    Builds a List of PathSpec from a list of location strings (uri,
    paths). If locations is a folder, attempts to find config_filename in it,
    and use "folder/config_filename" instead(rewriting element path and
    stripping scm nature), else add folder as PathSpec.    Anything else,
    parse yaml at location, and add a PathSpec for each element.

    :param config_uris: source of yaml
    :param config_filename: file to use when given a folder
    """
    aggregate_source_yaml = []
    # build up a merged list of config elements from all given config_uris
    if config_uris is not None:
        for loop_uri in config_uris:
            source_path_specs = get_path_specs_from_uri(loop_uri, config_filename)
            # deal with duplicates in Config class
            if source_path_specs is not None:
                assert type(source_path_specs) == list, 'Probable bug: expected list, was %s' % type(source_path_specs)
                aggregate_source_yaml.extend(source_path_specs)
    return aggregate_source_yaml


class PathSpec:
    def __init__(self,
                 # localname is used as ID, currently also is used as path
                 local_name,
                 scmtype=None,
                 uri=None,
                 version=None,
                 tags=None,
                 revision=None,
                 currevision=None,
                 path=None,
                 curr_uri=None):
        """Fills in local properties based on dict, unifies different syntaxes"""
        self._local_name = local_name
        self._path = path
        self._uri = uri
        self._curr_uri = curr_uri
        self._version = version
        self._scmtype = scmtype
        self._tags = tags or []
        self._revision = revision
        self._currevision = currevision

    def __str__(self):
        return str(self.get_legacy_yaml())

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.__dict__ == other.__dict__
        else:
            return False

    def __ne__(self, other):
        return not self.__eq__(other)

    def detach_vcs_info(self):
        """if wrapper has VCS information, remove it to make it a plain folder"""
        if self._scmtype is not None:
            self._scmtype = None
            self._uri = None
            self._version = None
            self._revision = None
            self._currevision = None

    def get_legacy_type(self):
        """return one of __ALLTYPES__"""
        if self._scmtype is not None:
            return self._scmtype
        elif self._tags is not None and 'setup-file' in self._tags:
            return 'setup-file'
        return 'other'

    def get_legacy_yaml(self):
        """
        return something like
        {hg: {local-name: common,
              version: common-1.0.2,
              uri: https://kforge.org/common/}}
        """
        # TODO switch to new syntax
        properties = {'local-name': self._local_name}
        if self._uri is not None:
            properties['uri'] = self._uri
        if self._version is not None:
            properties['version'] = self._version
        if self._tags is not None:
            for tag in self._tags:
                if tag != 'setup-file' and tag != []:
                    if type(tag) == dict:
                        properties.update(tag)
                    else:
                        properties[tag] = None
        yaml_dict = {self.get_legacy_type(): properties}
        return yaml_dict

    def get_local_name(self):
        return self._local_name

    def set_local_name(self, local_name):
        self._local_name = local_name

    def get_path(self):
        return self._path

    def set_path(self, path):
        self._path = path

    def get_tags(self):
        return self._tags

    def get_scmtype(self):
        return self._scmtype

    def get_version(self):
        return self._version

    def get_revision(self):
        return self._revision

    def get_current_revision(self):
        return self._currevision

    def get_uri(self):
        return self._uri

    def get_curr_uri(self):
        return self._curr_uri


def get_path_spec_from_yaml(yaml_dict):
    """
    Fills in local properties based on dict, unifies different syntaxes
    """
    local_name = None
    uri = None
    version = None
    scmtype = None
    tags = []
    if type(yaml_dict) != dict:
        raise MultiProjectException(
            "Yaml for each element must be in YAML dict form")
    # old syntax:
# - hg: {local-name: common_rosdeps,
#        version: common_rosdeps-1.0.2,
#        uri: https://kforge.ros.org/common/rosdepcore}
# - setup-file: {local-name: /opt/ros/fuerte/setup.sh}
# - other: {local-name: /opt/ros/fuerte/share/ros}
# - other: {local-name: /opt/ros/fuerte/share}
# - other: {local-name: /opt/ros/fuerte/stacks}
    if yaml_dict is None or len(yaml_dict) == 0:
        raise MultiProjectException("no element in yaml dict.")
    if len(yaml_dict) > 1:
        raise MultiProjectException(
            "too many keys in element dict %s" % (list(yaml_dict.keys())))
    if not list(yaml_dict.keys())[0] in __ALLTYPES__:
        raise MultiProjectException(
            "Unknown element type '%s'" % (list(yaml_dict.keys())[0]))
    firstkey = list(yaml_dict.keys())[0]
    if firstkey in __REPOTYPES__:
        scmtype = list(yaml_dict.keys())[0]
    if firstkey == 'setup-file':
        tags.append('setup-file')
    values = yaml_dict[firstkey]
    if values is not None:
        for key, value in list(values.items()):
            if key == "local-name":
                local_name = value
            elif key == "meta":
                tags.append({key: value})
            elif key == "uri":
                uri = value
            elif key == "version":
                version = value
            else:
                raise MultiProjectException(
                    "Unknown key %s in %s" % (key, yaml_dict))
    # global validation
    if local_name is None:
        raise MultiProjectException(
            "Config element without a local-name: %s" % (yaml_dict))
    if scmtype != None:
        if uri is None:
            raise MultiProjectException(
                "scm type without declared uri in %s" % (values))
    # local_name is fixed, path may be normalized, made absolute, etc.
    path = local_name
    return PathSpec(local_name=local_name,
                    path=path,
                    scmtype=scmtype,
                    uri=uri,
                    version=version,
                    tags=tags)


def generate_config_yaml(config, filename, header):
    """
    Writes file filename with header first and then the config as yaml
    """
    if not os.path.exists(config.get_base_path()):
        os.makedirs(config.get_base_path())
    with open(os.path.join(config.get_base_path(), filename), 'w+b') as f:
        if header is not None:
            f.write(header.encode('UTF-8'))
        content = yaml.safe_dump([x.get_legacy_yaml() for x in config.get_source()])
        f.write(content.encode('UTF-8'))
