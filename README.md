It's library for system scripting. Tested and developed under linux and for linux.
Install:

1. Install subprocess for lua.
2. Move file systemscripting.lua to correct way (read about package.path and package.cpath).
3. Use with require.

Easter egg (!): it provides two exterenal functions: table.copy(tab) and table.contact(tab1, tab2).

Using:
systemscripting.cmd(program, args..., input)

Use this function for full completed extrenal programs support!
Output:
If start is passed:
table with fileds exitcode (number), out (output from stdin), err (output from stderr)
If problems while starting process:
three results: nil, errormsg, errno (as you can see, this function is full compactible with assert)

Example:
for k,v in pairs(sys.cmd('grep','-o', 'world','Hello, world!')) do print(k,v) end
Result:
out	world

err
exit	0
