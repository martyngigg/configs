#
# gdb initialization file.
#
# Sets better gdb defaults and loads pretty printers
#

# gdb commands
set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off

# python pretty printers
python
import os
import sys
sys.path.insert(0, os.path.join(os.path.expanduser("~"), ".gdb/python"))
from libstdcxx.v6.printers import register_libstdcxx_printers
from qt4 import register_qt4_printers
from boost import register_printers as register_boost_printers

register_libstdcxx_printers(None)
register_qt4_printers(None)
register_boost_printers(None)

end
