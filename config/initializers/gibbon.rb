require 'gibbon'
gibbon = Gibbon::Request.new(api_key: "7485132cf5e6eb8ed339838df2ceb78e-us16")
Gibbon::Request.open_timeout = 15
Gibbon::Request.symbolize_keys = true
Gibbon::Request.debug = false
Gibbon::Request.throws_exceptions = false
gibbon.timeout = 10