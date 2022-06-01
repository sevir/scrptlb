local hello_message = table.concat({ 'Hello', 'from', 'Lua!' }, ' ')
print(hello_message)

local request = http.get("https://www.digio.es")
print(request["status"])
print(request["body"])