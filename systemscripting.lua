#!/usr/bin/lua
local subprocess = require 'subprocess'

local modtab = {};

table.copy = function(tab)
	local tab2 = {}
	for k,v in pairs(tab) do
		tab2[k] = v
	end
	return tab2
end;
table.contact = function(tab1, tab2)
	local tmptab = table.copy(tab1)
	for k,v in pairs(tab2) do
		tmptab[k] = v
	end
	return tmptab
end;

modtab.cmd_nonblock = function(...)
	return subprocess.popen(table.contact({...}, {stdin = subprocess.PIPE; stdout = subprocess.PIPE; stderr = subprocess.PIPE; close_fds = true}))
end;

-- cmd(binary, arg1, arg2, argN, string_to_stdin)

modtab.cmd = function(...)
	local args = {...};
	local istr = args[#args]
	args[#args] = nil
	local proc,errormsg,errno = modtab.cmd_nonblock(table.unpack(args));
	if not proc then return nil,errormsg,errno end
	proc.stdin:write(istr);
	proc.stdin:close();
	proc:wait();
	return {out = proc.stdout:read('*a'); err = proc.stderr:read('*a'); exit = proc.exitcode}
end;
return modtab
