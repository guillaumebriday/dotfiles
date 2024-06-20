$LOAD_PATH << '~/.rbenv/versions/3.2.2/lib/ruby/gems/3.2.0/gems/amazing_print-1.6.0/lib/'

require "amazing_print"
AmazingPrint.irb!

IRB.conf[:USE_AUTOCOMPLETE] = false
