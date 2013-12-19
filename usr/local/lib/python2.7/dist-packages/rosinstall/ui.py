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

import sys


class Ui(object):
    """
    wrap user interaction, such that client libraries may provide own
    implementation
    """

    # For now, primarily define this for replacement in unittests
    GLOBAL_UI = None

    @staticmethod
    def get_ui():
        if Ui.GLOBAL_UI is None:
            return Ui()
        return Ui.GLOBAL_UI

    @staticmethod
    def set_ui(uiarg):
        Ui.GLOBAL_UI = uiarg

    def __init__(self):
        pass

    def get_backup_path(self):
        """Interactive function asking the user to choose a path for backup"""
        backup_path = self.get_input("Please enter backup pathname: ")
        print(("backing up to %s" % backup_path))
        return backup_path

    def get_input(self, prompt):
        if sys.hexversion > 0x03000000:
            return input(prompt)
        else:
            return raw_input(prompt)

    def prompt_del_abort_retry(self, prompt, allow_skip=False):
        """
        Interactive function asking the user to choose a conflict resolution
        """
        if allow_skip:
            valid_modes = ['(d)elete and replace',
                           '(a)bort',
                           '(b)ackup and replace',
                           '(s)kip']
        else:
            valid_modes = ['(d)elete and replace',
                           '(a)bort',
                           '(b)ackup and replace']

        mode = ""

        full_prompt = "%s %s: " % (prompt, ", ".join(valid_modes))

        while mode == "":
            mode_input = self.get_input(full_prompt)
            if mode_input == 'b' or mode_input == 'backup':
                mode = 'backup'
            elif mode_input == 'd' or mode_input == 'delete':
                mode = 'delete'
            elif mode_input == 'a' or mode_input == 'abort':
                mode = 'abort'
            elif allow_skip and mode_input == 's' or mode_input == 'skip':
                mode = 'skip'
        return mode
