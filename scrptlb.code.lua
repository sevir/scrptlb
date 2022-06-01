local hello_message = table.concat({ 'Hello', 'from', 'Lua!' }, ' ')
print(hello_message)

local request = http.get("https://www.digio.es")
print(request["status"])
print(request["body"])

http.add_header("Authorization", "Bearer mt0dgHmLJMVQhvjpNXDyA83vA_PxH23Y")
http.add_header("Content-Type", "application/json")

http.set_body("Hello World")
local request = http.post("https://reqbin.com/echo/post/json")
print(request["status"])
print(request["body"])