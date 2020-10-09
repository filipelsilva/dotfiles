# check https://medium.com/bugbountywriteup/pwndbg-gef-peda-one-for-all-and-all-for-one-714d71bf36b8 for info
define init-peda
source ~/.gdb-plugins/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-pwndbg
source ~/.gdbinit_pwndbg
end
document init-pwndbg
Initializes PwnDBG
end

define init-gef
source ~/.gdb-plugins/gdbinit-gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end
