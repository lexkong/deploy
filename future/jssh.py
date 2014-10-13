#!/usr/bin/python
#-*- coding:utf-8 -*-
#author sunbx@funshion.com
#date	2013-10-10

import sys, time, os

try:
    import pexpect
except ImportError:
    print """
         You must install pexpect module
    """
    sys.exit(1)

addr_map = {
	'server_1' : ('sunbx@192.168.8.91', 'sunbx'),
}

cmd_map = {
    'huitui':"/home/sunbx/path/server/workspace/project/.script/huitui.sh",
    'fabu' : "/home/sunbx/path/server/workspace/project/.script/fabu.sh",
} 

if len(sys.argv) != 2:
    sys.stderr.write("Usage: python %s cmd \n" % sys.argv[0])
    raise SystemExit(1)

cmd_output_map = {}

for key in addr_map:
    try:
        cmd_key = sys.argv[1]
	cmd     = cmd_map[cmd_key]
    except:
        sys.stderr.write("Usage: python %s cmd \n" % sys.argv[0])
        print """ 
    		cmd: huitui or fabu 
	"""
        raise SystemExit(1)
    server = pexpect.spawn('ssh %s' % addr_map[key][0])
   # server.expect('.*yes/no.*')
   # server.sendline("yes")
    server.expect('.*ssword:')
    server.sendline(addr_map[key][1])
    command_output = pexpect.run ('bash %s' % cmd)
    server.sendline("quit")
    cmd_output_map[key] = command_output

for key in cmd_output_map:
    print cmd_output_map[key] + key
