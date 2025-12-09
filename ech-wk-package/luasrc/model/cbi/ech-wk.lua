m = Map("ech-wk", translate("ECH Workers Proxy"), translate("Configuration for ECH Workers Proxy Client"))

s = m:section(NamedSection, "general", "ech-wk", translate("General Settings"))
s.anonymous = true
s.addremove = false

o = s:option(Flag, "enabled", translate("Enable"))
o.rmempty = false

o = s:option(Value, "server_addr", translate("Server Address"), translate("Format: x.x.workers.dev:443"))
o.rmempty = false

o = s:option(Value, "listen_addr", translate("Listen Address"), translate("Local address to listen on (e.g., 127.0.0.1:30000)"))
o.default = "127.0.0.1:30000"

o = s:option(Value, "token", translate("Token"), translate("Authentication token"))
o.password = true
o.rmempty = true

o = s:option(Value, "server_ip", translate("Server IP"), translate("Optional: Specific IP for the server to bypass DNS"))
o.rmempty = true

o = s:option(Value, "dns_server", translate("DoH Server"), translate("DoH server for ECH query"))
o.default = "dns.alidns.com/dns-query"

o = s:option(Value, "ech_domain", translate("ECH Domain"), translate("Domain for ECH query"))
o.default = "cloudflare-ech.com"

return m
