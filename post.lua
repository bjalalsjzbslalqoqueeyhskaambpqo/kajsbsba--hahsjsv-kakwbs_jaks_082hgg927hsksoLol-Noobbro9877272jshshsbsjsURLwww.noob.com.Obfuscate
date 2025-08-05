local function e(d,k)
    local r={}
    for i=1,#d do 
        r[i]=string.char(string.byte(d:sub(i,i))~string.byte(k:sub((i-1)%#k+1,(i-1)%#k+1))~(i-1)%256)
    end
    for j=1,3 do 
        for i=1,#r do 
            local b=string.byte(r[i])
            r[i]=string.char(((b<<3)|(b>>5))~string.byte(k:sub((i+j-1)%#k+1,(i+j-1)%#k+1))~((i*j)%256))
        end 
    end
    return table.concat(r)
end

return function(t,s)
    if not t or not s then return end
    local h=gethwid and gethwid()or"unknown"
    if #h<8 then return end
    h=#h>16 and h:sub(1,16)or h..string.rep("x",16-#h)
    local p=game:GetService("HttpService"):JSONEncode({t=t,s=s,h=h})
    local en=e(p,"SK2024_ENHANCED")
    local r=request({Url="https://onx-dev.uk/api/v2/script/"..s,Method="POST",Body=en,Headers={["Content-Type"]="application/octet-stream"}})
    if r and r.StatusCode==200 then loadstring(r.Body)()end
end
