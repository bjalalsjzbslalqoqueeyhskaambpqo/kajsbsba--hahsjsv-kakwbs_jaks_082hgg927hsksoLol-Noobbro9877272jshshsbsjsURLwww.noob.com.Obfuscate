--[[
	Obfuscated with wfuscator <https://>
	Obfuscation level: 
	Still a work in progress! Do not deobfuscate!

	<https:///>; ;
]]
return(function()local a;do local b=bit32;local c;local d;local e;local f=50;local g={[22]=18,[31]=8,[33]=28,[0]=3,[1]=13,[2]=23,[26]=33,[12]=1,[13]=6,[14]=10,[15]=16,[16]=20,[17]=26,[18]=30,[19]=36,[3]=0,[4]=2,[5]=4,[6]=7,[7]=9,[8]=12,[9]=14,[10]=17,[20]=19,[21]=22,[23]=24,[24]=27,[25]=29,[27]=32,[32]=34,[34]=37,[11]=5,[28]=11,[29]=15,[30]=21,[35]=25,[36]=31,[37]=35}local h={[0]='ABC','ABx','ABC','ABC','ABC','ABx','ABC','ABx','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','AsBx','ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','AsBx','AsBx','ABC','ABC','ABC','ABx','ABC'}local i={[0]={b='OpArgR',c='OpArgN'},{b='OpArgK',c='OpArgN'},{b='OpArgU',c='OpArgU'},{b='OpArgR',c='OpArgN'},{b='OpArgU',c='OpArgN'},{b='OpArgK',c='OpArgN'},{b='OpArgR',c='OpArgK'},{b='OpArgK',c='OpArgN'},{b='OpArgU',c='OpArgN'},{b='OpArgK',c='OpArgK'},{b='OpArgU',c='OpArgU'},{b='OpArgR',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgR',c='OpArgN'},{b='OpArgR',c='OpArgN'},{b='OpArgR',c='OpArgN'},{b='OpArgR',c='OpArgR'},{b='OpArgR',c='OpArgN'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgK',c='OpArgK'},{b='OpArgR',c='OpArgU'},{b='OpArgR',c='OpArgU'},{b='OpArgU',c='OpArgU'},{b='OpArgU',c='OpArgU'},{b='OpArgU',c='OpArgN'},{b='OpArgR',c='OpArgN'},{b='OpArgR',c='OpArgN'},{b='OpArgN',c='OpArgU'},{b='OpArgU',c='OpArgU'},{b='OpArgN',c='OpArgN'},{b='OpArgU',c='OpArgN'},{b='OpArgU',c='OpArgN'}}local function j(k,l,m,n)local o=0;for p=l,m,n do local q=256^math.abs(p-l)o=o+q*string.byte(k,p,p)end;return o end;local function r(s,t,u,v)local w=(-1)^b.rshift(v,7)local x=b.rshift(u,7)+b.lshift(b.band(v,0x7F),1)local y=s+b.lshift(t,8)+b.lshift(b.band(u,0x7F),16)local z=1;if x==0 then if y==0 then return w*0 else z=0;x=1 end elseif x==0x7F then if y==0 then return w*1/0 else return w*0/0 end end;return w*2^(x-127)*(1+z/2^23)end;local function A(s,t,u,v,B,C,D,E)local w=(-1)^b.rshift(E,7)local x=b.lshift(b.band(E,0x7F),4)+b.rshift(D,4)local y=b.band(D,0x0F)*2^48;local z=1;y=y+C*2^40+B*2^32+v*2^24+u*2^16+t*2^8+s;if x==0 then if y==0 then return w*0 else z=0;x=1 end elseif x==0x7FF then if y==0 then return w*1/0 else return w*0/0 end end;return w*2^(x-1023)*(z+y/2^52)end;local function F(k,l,m)return j(k,l,m-1,1)end;local function G(k,l,m)return j(k,m-1,l,-1)end;local function H(k,l)return r(string.byte(k,l,l+3))end;local function I(k,l)local s,t,u,v=string.byte(k,l,l+3)return r(v,u,t,s)end;local function J(k,l)return A(string.byte(k,l,l+7))end;local function K(k,l)local s,t,u,v,B,C,D,E=string.byte(k,l,l+7)return A(E,D,C,B,v,u,t,s)end;local L={[4]={little=H,big=I},[8]={little=J,big=K}}local function M(N)local O=N.index;local P=string.byte(N.source,O,O)N.index=O+1;return P end;local function Q(N,R)local S=N.index+R;local T=string.sub(N.source,N.index,S-1)N.index=S;return T end;local function U(N)local R=N:s_szt()local T;if R~=0 then T=string.sub(Q(N,R),1,-2)end;return T end;local function V(R,W)return function(N)local S=N.index+R;local X=W(N.source,N.index,S)N.index=S;return X end end;local function Y(R,W)return function(N)local Z=W(N.source,N.index)N.index=N.index+R;return Z end end;local function _(N)local R=N:s_int()local a0=table.create(R)for p=1,R do local a1=N:s_ins()local a2=b.band(a1,0x3F)local a3=h[a2]local a4=i[a2]local a5={value=a1,op=g[a2],A=b.band(b.rshift(a1,6),0xFF)}if a3=='ABC'then a5.B=b.band(b.rshift(a1,23),0x1FF)a5.C=b.band(b.rshift(a1,14),0x1FF)a5.is_KB=a4.b=='OpArgK'and a5.B>0xFF;a5.is_KC=a4.c=='OpArgK'and a5.C>0xFF;if a2==10 then local m=b.band(b.rshift(a5.B,3),31)if m==0 then a5.const=a5.B else a5.const=b.lshift(b.band(a5.B,7)+8,m-1)end end elseif a3=='ABx'then a5.Bx=b.band(b.rshift(a1,14),0x3FFFF)a5.is_K=a4.b=='OpArgK'elseif a3=='AsBx'then a5.sBx=b.band(b.rshift(a1,14),0x3FFFF)-131071 end;a0[p]=a5 end;return a0 end;local function a6(N)local R=N:s_int()local a0=table.create(R)for p=1,R do local a7=M(N)local a8;if a7==1 then a8=M(N)~=0 elseif a7==3 then a8=N:s_num()elseif a7==4 then a8=U(N)end;a0[p]=a8 end;return a0 end;local function a9(N,k)local R=N:s_int()local a0=table.create(R)for p=1,R do a0[p]=e(N,k)end;return a0 end;local function aa(N)local R=N:s_int()local a0=table.create(R)for p=1,R do a0[p]=N:s_int()end;return a0 end;local function ab(N)local R=N:s_int()local a0=table.create(R)for p=1,R do a0[p]={varname=U(N),startpc=N:s_int(),endpc=N:s_int()}end;return a0 end;local function ac(N)local R=N:s_int()local a0=table.create(R)for p=1,R do a0[p]=U(N)end;return a0 end;function e(N,ad)local ae={}local k=U(N)or ad;ae.source=k;N:s_int()N:s_int()ae.num_upval=M(N)ae.num_param=M(N)M(N)ae.max_stack=M(N)ae.code=_(N)ae.const=a6(N)ae.subs=a9(N,k)aa(N)ab(N)ac(N)for af,ag in ae.code do if ag.is_K then ag.const=ae.const[ag.Bx+1]else if ag.is_KB then ag.const_B=ae.const[ag.B-0xFF]end;if ag.is_KC then ag.const_C=ae.const[ag.C-0xFF]end end end;return ae end;function c(k)local ah;local ai;local aj;local ak;local al;local am;local an;local ao={index=1,source=k}assert(Q(ao,4)=='\27Lua','invalid Lua signature')assert(M(ao)==0x51,'invalid Lua version')assert(M(ao)==0,'invalid Lua format')ai=M(ao)~=0;aj=M(ao)ak=M(ao)al=M(ao)am=M(ao)an=M(ao)~=0;ah=ai and F or G;ao.s_int=V(aj,ah)ao.s_szt=V(ak,ah)ao.s_ins=V(al,ah)if an then ao.s_num=V(am,ah)elseif L[am]then ao.s_num=Y(am,L[am][ai and'little'or'big'])else error('unsupported float size')end;return e(ao,'@wfuscator-vm')end;local function ap(a0,aq)for p,ar in pairs(a0)do if ar.index>=aq then ar.value=ar.store[ar.index]ar.store=ar;ar.index='value'a0[p]=nil end end end;local function as(a0,aq,at)local au=a0[aq]if not au then au={index=aq,store=at}a0[aq]=au end;return au end;local function av(aw,ax)local k=aw.source;error(string.format('%s: %s',k,ax),0)end;local function ay(az,aA,aB)local aC=az.code;local aD=az.subs;local aE=az.vararg;local aF=-1;local aG={}local at=az.memory;local aH=az.pc;while true do local aI=aC[aH]local a2=aI.op;aH=aH+1;if a2<18 then if a2<8 then if a2<3 then if a2<1 then for p=aI.A,aI.B do at[p]=nil end elseif a2>1 then local ar=aB[aI.B]at[aI.A]=ar.store[ar.index]else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;at[aI.A]=aJ+aK end elseif a2>3 then if a2<6 then if a2>4 then local aL=aI.A;local aM=aI.B;local aq;if aI.is_KC then aq=aI.const_C else aq=at[aI.C]end;at[aL+1]=at[aM]at[aL]=at[aM][aq]else at[aI.A]=aA[aI.const]end elseif a2>6 then local aq;if aI.is_KC then aq=aI.const_C else aq=at[aI.C]end;at[aI.A]=at[aI.B][aq]else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;at[aI.A]=aJ-aK end else at[aI.A]=at[aI.B]end elseif a2>8 then if a2<13 then if a2<10 then aA[aI.const]=at[aI.A]elseif a2>10 then if a2<12 then local aL=aI.A;local aM=aI.B;local aN=aI.C;local aO;if aM==0 then aO=aF-aL else aO=aM-1 end;local aP=table.pack(at[aL](table.unpack(at,aL+1,aL+aO)))local aQ=aP.n;if aN==0 then aF=aL+aQ-1 else aQ=aN-1 end;table.move(aP,1,aQ,aL,at)else local ar=aB[aI.B]ar.store[ar.index]=at[aI.A]end else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;at[aI.A]=aJ*aK end elseif a2>13 then if a2<16 then if a2>14 then local aL=aI.A;local aM=aI.B;local aO;if aM==0 then aO=aF-aL else aO=aM-1 end;ap(aG,0)return at[aL](table.unpack(at,aL+1,aL+aO))else local aq,aR;if aI.is_KB then aq=aI.const_B else aq=at[aI.B]end;if aI.is_KC then aR=aI.const_C else aR=at[aI.C]end;at[aI.A][aq]=aR end elseif a2>16 then at[aI.A]=table.create(aI.const)else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;at[aI.A]=aJ/aK end else at[aI.A]=aI.const end else local aL=aI.A;local aS=at[aL+2]local aq=at[aL]+aS;local aT=at[aL+1]local aU;if aS==math.abs(aS)then aU=aq<=aT else aU=aq>=aT end;if aU then at[aL]=aq;at[aL+3]=aq;aH=aH+aI.sBx end end elseif a2>18 then if a2<28 then if a2<23 then if a2<20 then at[aI.A]=#at[aI.B]elseif a2>20 then if a2<22 then local aL=aI.A;local aM=aI.B;local R;if aM==0 then R=aF-aL+1 else R=aM-1 end;ap(aG,0)return table.unpack(at,aL,aL+R-1)else local aM=aI.B;local T=at[aM]for p=aM+1,aI.C do T=T..at[p]end;at[aI.A]=T end else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;at[aI.A]=aJ%aK end elseif a2>23 then if a2<26 then if a2>24 then ap(aG,aI.A)else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;if(aJ==aK)==(aI.A~=0)then aH=aH+aC[aH].sBx end;aH=aH+1 end elseif a2>26 then local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;if(aJ<aK)==(aI.A~=0)then aH=aH+aC[aH].sBx end;aH=aH+1 else local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;at[aI.A]=aJ^aK end else at[aI.A]=aI.B~=0;if aI.C~=0 then aH=aH+1 end end elseif a2>28 then if a2<33 then if a2<30 then local aJ,aK;if aI.is_KB then aJ=aI.const_B else aJ=at[aI.B]end;if aI.is_KC then aK=aI.const_C else aK=at[aI.C]end;if(aJ<=aK)==(aI.A~=0)then aH=aH+aC[aH].sBx end;aH=aH+1 elseif a2>30 then if a2<32 then local aV=aD[aI.Bx+1]local aW=aV.num_upval;local aX;if aW~=0 then aX={}for p=1,aW do local aY=aC[aH+p-1]if aY.op==g[0]then aX[p-1]=as(aG,aY.B,at)elseif aY.op==g[4]then aX[p-1]=aB[aY.B]end end;aH=aH+aW end;at[aI.A]=d(aV,aA,aX)else local aL=aI.A;local aM=aI.B;if not at[aM]~=(aI.C~=0)then at[aL]=at[aM]aH=aH+aC[aH].sBx end;aH=aH+1 end else at[aI.A]=-at[aI.B]end elseif a2>33 then if a2<36 then if a2>34 then local aL=aI.A;local R=aI.B;if R==0 then R=aE.len;aF=aL+R-1 end;table.move(aE.list,1,R,aL,at)else local aL=aI.A;local aZ,aT,aS;aZ=assert(tonumber(at[aL]),'`for` initial value must be a number')aT=assert(tonumber(at[aL+1]),'`for` limit must be a number')aS=assert(tonumber(at[aL+2]),'`for` step must be a number')at[aL]=aZ-aS;at[aL+1]=aT;at[aL+2]=aS;aH=aH+aI.sBx end elseif a2>36 then local aL=aI.A;local aN=aI.C;local R=aI.B;local a_=at[aL]local b0;if R==0 then R=aF-aL end;if aN==0 then aN=aI[aH].value;aH=aH+1 end;b0=(aN-1)*f;table.move(at,aL+1,aL+R,b0+1,a_)else at[aI.A]=not at[aI.B]end else if not at[aI.A]~=(aI.C~=0)then aH=aH+aC[aH].sBx end;aH=aH+1 end else local aL=aI.A;local b1=aL+3;if type(at[aL])=="table"then at[aL+1]=at[aL]at[aL]=pairs(at[aL])end;local b2={at[aL](at[aL+1],at[aL+2])}table.move(b2,1,aI.C,b1,at)if at[b1]~=nil then at[aL+2]=at[b1]aH=aH+aC[aH].sBx end;aH=aH+1 end else aH=aH+aI.sBx end;az.pc=aH end end;function d(ae,aA,b3)local function b4(...)local b5=table.pack(...)local at=table.create(ae.max_stack)local aE={len=0,list={}}table.move(b5,1,ae.num_param,0,at)if ae.num_param<b5.n then local b6=ae.num_param+1;local R=b5.n-ae.num_param;aE.len=R;table.move(b5,b6,b6+R-1,1,aE.list)end;local az={vararg=aE,memory=at,code=ae.code,subs=ae.subs,pc=1}local b7=table.pack(pcall(ay,az,aA,b3))if b7[1]then return table.unpack(b7,2,b7.n)else local aw={pc=az.pc,source=ae.source}return av(aw,b7[2])end end;return b4 end;a=function(b8,aA)return d(c(b8),aA)()end end local n=string.char;local o=string.sub;local z=20;local h=table.pack;local bd=math;local aa=160;local p=string.gsub;local g=table.create;local q=string.find;local e=table.insert;local r=ipairs;local i=table.unpack;local t='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'local v=function(ad,an)local am,ah=1,0;local ae=z+an;while ad>0 and ae>0 do local af,ag=ad%2,ae%2;if af~=ag then ah=ah+am;end;ad=(ad-af)/2;ae=(ae-ag)/2;am=am*2;end;if ad<ae then ad=ae;end;while ad>0 do local af=ad%2;if af>0 then ah=ah+am;end;ad=(ad-af)/2;am=am*2;end;return ah;end;local u=function(ai,an)ai=p(ai,'[^'..t..'=]','')ai=p(ai,'.',function(aj)if(aj=='=')then return''end;local ak,af='',(q(t,aj)-1)for al=6,1,-1 do ak=ak..(af%2^al-af%2^(al-1)>0 and'1'or'0')end;return ak;end)ai=p(ai,'%d%d%d?%d?%d?%d?%d?%d?',function(aj)if(#aj~=8)then return''end;local am=0;for al=1,8 do am=am+(o(aj,al,al)=='1'and 2^(8-al)or 0)end;return n(v(am,an))end)return ai;end;local s=function(ad,an)local am,ah=1,0;local ae=aa+an;while ad>0 and ae>0 do local af,ag=ad%2,ae%2;if af~=ag then ah=ah+am;end;ad=(ad-af)/2;ae=(ae-ag)/2;am=am*2;end;if ad<ae then ad=ae;end;while ad>0 do local af=ad%2;if af>0 then ah=ah+am;end;ad=(ad-af)/2;am=am*2;end;return ah;end;local ao,f,bc,l,x,bj,d,j,bg,bh,bi,w,y,as,bf,k,bb,be,bk,m,c=assert,table.remove,task,math.random,function(ad,am)local ah=g(0)for ae=1,#ad,am do e(ah,o(ad,ae,ae+am-1))end;return ah;end,typeof,8,task.spawn,loadstring,pairs,_G,function(ag)local ah=""repeat local bl=ag/2;local al,bm=bd['modf'](bl)ag=al;ah=bd['ceil'](bm)..ah;until ag==0;return ah;end,(function()ao=function(ap,aq,ar)if not ap then as(aq,2+(ar or 0))end;end;local y=g(0)y['partial']=function(at,...)local au=h(...)local av=h(i(au))return function(...)local au=h(...)local aw=g(0)for ax,ay in r(av)do e(aw,ay)end;for ax,ay in r(h(i(au)))do e(aw,ay)end;return at(i(aw))end;end;return y;end)(),error,getmetatable,task.wait,table,string,game,string.len,115;local ab=g(0)ab[25]=u("LQ==",9)ab[41]=u("bH1/dw==",8)ab[94]=s(275,113)ab[29]=u("",9)ab[118]=s(175,82)ab[54]=s(128,72,233)ab[57]=s(147,68)ab[101]=s(260,100)ab[51]=s(143,74)ab[108]=s(242,82)ab[112]=s(251,89)ab[93]=s(236,68,282)ab[32]=u("ag==",10)ab[34]=u("cWVjdA==",2)ab[72]=s(220,62)ab[106]=s(212,54,939)ab[5]=u("cWh5cWpr",4)ab[117]=s(220,66)ab[116]=s(217,59)ab[89]=s(198,83)ab[113]=s(238,78)ab[3]=u("dnpvcw==",7)ab[114]=s(205,81)ab[87]=s(228,66)ab[121]=s(253,94)ab[59]=s(256,97)ab[10]=u("VFlQRU9G",12)ab[60]=s(275,115,124)ab[28]=u("PH08fTx9Jjx9Jjx9Jjx9Jjx9Jjx9Jg==",5)ab[83]=s(224,66,299)ab[88]=s(304,103)ab[45]=u("bn99dQ==",10)ab[70]=s(255,95)ab[86]=s(250,91,926)ab[81]=s(254,94)ab[74]=s(216,75)ab[107]=s(274,114,506)ab[9]=u("SFA=",3)ab[21]=u("",1)ab[23]=u("",6)ab[95]=s(229,77)ab[109]=s(241,83)ab[19]=u("f2tteg==",4)ab[100]=s(241,80)ab[18]=u("",10)ab[6]=u("fX9ud39ue257eHZ/",6)ab[73]=s(225,65)ab[92]=s(217,57)ab[11]=u("fHp2fg==",7)ab[103]=s(264,106,127)ab[48]=u("Mm90e3h2fzpudTp8c3R+Omx7aHN7eHZ/OnN0Omx3Mw==",6)ab[40]=u("bnVrenhw",7)ab[111]=s(239,77)ab[119]=s(148,88,55)ab[98]=s(180,57,108)ab[68]=s(230,70)ab[71]=s(212,54,746,719)ab[61]=s(212,71)ab[37]=u("aA==",5)ab[12]=u("WA==",12)ab[49]=u("BFNqfk4fHhsXGxcfHx8fHx8fHx8fHx8fHx8fHx8fHTlxHh8fHl8fHxgfHx8anx8fGd9fH1ofHh+eXx4f2p8fH9mf3h4e3h4fWh4dH1le3R2anh0f2h4dH9ne3RwanR8fGR1cG1odHR9ZXdwbmh0dH5mdXBranR8f2d3cGhqcHx8ZHFsZWlwbH5qcHx/aHB4f2ZzbGBrbGx9aGxofuxsfHx8fnxwfHx8b2lsaH9mb2hYa2hofWhoZH5paGh+ZWlkU2hodH9ma2RQ7WR8fHx+fH1rZGR+VGR8f2lkYHx6YGB9e2Bgfw5mfHpbZGZHaWRgfHlgXH16YFx+e2Bcfw5kfHZbZGY/aWRYfHpgWH17YFh/DmZ8eltkZjdpZGB8eWBUfXpgVH8OZnx6W2RmL2lkWHx4YFB9eWBQfw5mfHpbZmYraWRgfHtgUH14YEx/DmZ8eltkZiNpZFh8emBMfXtgTH8OZnx6W2ZmH2lkYHx5YEh9emBIfw5mfHpbZGYXaWRYfHhgRH15YER/DmZ8eltmZhNpZFh8e2BEfXlgTH8OZnx6W2RmC2lkWHx5YEB9e2BMfw5mfHpbZGYHaWRYfHtgQH17YFh/DmZ8eltkZgNpZGB8eWA8fXpgPH57YDx/eGA4fw5mfHZbZGb/aWRYfHlgOH14YFh/DmZ8eltkZvdpZFh8emA4fXpgRH8OZnx6W2ZmD2lkYHx4YDR9eWA0fw5mfHpbZmbzaWRgfHtgNH16YDx+eGAwfw5kfHZbZGbraWRYfHpgMH16YER/DmZ8eltmZudpZFh8eWBAfXtgTH8OZnx6W2Zm42lkWHx5YCx9emAsfw5mfHpbZGbfaWRgfHhgKH15YCh+emAofw5kfHZbZmbbaWRYfHtgKH14YCx/DmZ8eltkZttpZFh8eWAkfXlgeH8OZnx6W2Rmz2lkWHx7YCR9e2BMfw5mfHpbZGbLaWRgfHlgIH16YCB/DmZ8eltkZsdpZFh8eGAcfXtgTH8OZnx6W2Zmw2lkWHx6YBx9e2BIfw5mfHpbZma/aWRgfHhgGH15YBh+emAYfw5kfHZbZma7aWRgfHhgFH17YGB/DmZ8eltmZrNpZGB8emAUfXtgFH8OZnx6W2Zmr2lkYHx5YBB9emAQfntgEH8OZHx2W2Rmp2lkYHx5YAx9emAMfw5mfHpbZGafaWRYfHtgDH17YEh/DmZ8e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XxwfHx8fH+eRXxwfHx8fH79qXxwfHx8fHw+SXxscHx8fHx8fH35zHxscHx8fHx8fH35+HxwfHx8fH792XxwfHx8fH99FXxwfHx8fH79zXxwfHx8fH9eSXxwfHx8fH197XxwfHx8fH/97XxwfHx8fH59QXxwfHx8fH/9kXxwfHx8fH99sXxwfHx8fH793XxwfHx8fH99IXxwfHx8fH/9gXxwfHx8fH990XxwfHx8fH2edXxwfHx8fH7ebXxscHx8fHx8fH35uHxgfHx8fHx8fHx8fHx4fHx8eHx8fHR0fEg4fHx+VHx8f3h8fHwseHx9fHp8f/x8dn9seHx8fHR8eWx2fH58dHx/fHR8cE1wfHBIcXxlDHR8dw14fH8Bf4mCBHx8eAR+fHx4fHx8cHx8fHx8f7yAfHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8eHx8fHh8fHx4eHxgOHx8fXh8fH5BfXx/bHx8f2Z/fHh8eHx7D3x8eHx+fHlseHx9Z3t8dnx4fHUOeHx6fHp8fSp+eHQgfXh8JX+NgQR8fHgEfnx8aHx8fGx4fHx8fHx8fHxwfHx8fHx8fXxsaHx8fHx8fH3Jwe3kfGxofHx8fHx8ffHp2cx8cHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8eHx8fHh8fHx0eHxcmHx8fWh8fH58fHx9Dnx8emx8fH9pfHx8enh8fWx4fH1ne3x2eHh4f3l4eH8Ofnx2Z3x8eCJ+fHwkfFZ+bH58f3x8fH4OfHx6FHx8fCd8Xn9sfHx8aXh8fXp4fH5seHx+Znl4cA56fHtkfnh7Z3x8exR8fHwnfHp/bHx8fGl4fH17eHh+bHh8fmR5dHN5eHR8Dnh8dWR+eHtsfHx8aXh8fXp4dH5seHx+Z3l0cA56fHtkfnh7Z3x8exR8fHwnfHp/bHx8fGl4fH14eHB+bHh8fmV5cHN6eHB8Dnh8dWR+eHkEfHx4BH58fEB8fHxscHx8fHx8fH35+HxsdHx8fHx8fH24fHB8fHx8f33dfHB8fHx8fH19fHB8fHx8fT5RfHB8fHx8fp5pfHB8fHx8fHyJfHB8fHx8f33lfHB8fHx8fHyNfHB8fHx8fH1FfHB8fHx8fn3hfHB8fHx8fHyBfHB8fHx8fX3RfHB8fHx8fHyFfHB8fHx8f335fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHh8fHx4fHx8cHh8ZBx8fH1sfHx+fHx8fQ58fHpsfnx/aHx8fHl4fH16eHx/Dn58emd8fHgifnx8J3x2fWx8fHp8fHx9Dnx8emx+fH9ofHx8e3h8fWx6fH1ke3h3Dn58emd8fHlmfnx9BHx8eAR+fHxofHx8bHR8fHx8fHx9uHxwfHx8fH/97XxwfHx8fHx9RXxwfHx8fHx96XxwfHx8fH59fXx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx4fHx8eHx8fHR4fGQ8fHx9bHx8fnx8fH0OfHx6bH58f2h8fHx5eHx9bHp8fWZ7fHcOfnx6Z3x8eWZ+fH5sfnx+Z318eWZ+fH0EfHx4BH58fGx8fHxsdHx8fHx8fH24fHB8fHx8fH3hfHB8fHx8fH15fHB8fHx8fn15fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHh8fHx4fHx8bHx8OXB8fHxsfHx97Hx8fGx+fHxsfHx5DH58fAx8eHwkfE59bHp8fmh4fH0ifnh0JHx+fXV4fH10enx+bHp8e2x4fHhpdHx9enR8fnt0fH94dHh8eXB4fXpweH57cHh/eHB0fHlsdHwOdnxvZHp0cmd4eHPteHx8fHx8dGx8fHsOenx8bHR8eWl0fH56dHR/e3R0fQ52fHhldHRuDnp8ehR4fHwmfHp+bHh8e2l4fHx4dHB9eXRwfw56fHpneHhyBHh8emh4fH9oeHx8I3x4cCV/pYEUeHx8JXx+fPB8fHwmfH5/8Hx8fPp8fHwkf7GAbHx8eWl8fH56fHB/bHx8e2d/cHkOfnx4ZXx8fAR8fHgEfnx8PHx8fGxwfHx8fHx8ffnMfGx0fHx8fHx8fbh8cHx8fHx9fe18cHx8fHx8fT18cHx8fHx9/l18cHx8fHx+PZV8cHx8fHx8vaV8cHx8fHx9XnV8cHx8fHx8/mF8cHx8fHx/fSl8cHx8fHx9/dl8cHx8fHx8fRV8cHx8fHx//dV8cHx8fHx/fRl8cHx8fHx//cV8cHx8fHx8fW18dHx8fHx8fHx8fHx8eHx8fHh8fHx0fHxoPHx8fOx8fHxsfHx8bH58fA5+fH1sfnx+aHx8f3l8fHxsenx8Znl8dg5+fHlmfnx9ZXx8fnx8fH0IfHx5BHx8fAR+fHxwfHx8bHR8fHx8fHx9uHxwfHx8fHz91XxwfHx8fH59dXx4fHx8fHx8fHx8fHx4fHx8eHx8fHR8fFwofHx8bHx8fWx+fH5ofHx/eXx8fHp4fH17eHx+Dnx8dWZ+fH1lfHx+fHx8f2x+fHxoeHx9eHh4fmx6fH5leXhzenh4fA54fHdkfnh5CH58eQR8fHwEfnx8YHx8fGx0fHx8fHx8fbh8cHx8fHx/fel8cHx8fHx8fVl8cHx8fHx/fm18cHx8fHx8fdF8cHx8fHx8fXV8cHx8fHx+PYl8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8eHx8fHh8fHx0fHxoKHx8fGx8fH1sfnx+aHx8f3l8fHxsenx8Znl8dg5+fHlmfnx8ZXx8fWx+fH5ofHx/e3x8fGx6fHxkeXh2Dn58eWZ+fH1lfHx+fHx8fQh8fHkEfHx8BH58fGh8fHxsdHx8fHx8fH24fHB8fHx8f/3ZfHB8fHx8fH1xfHB8fHx8fn3JfHB8fHx8fn1xfHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHh8fHx4fHx8cHx8YDx8fHxsfHx9bH58fmh8fH95fHx8bHp8fGZ5fHV7eHx+eHh4fg5+fHVmfnx9ZXx8fnx8fH9sfHx5CH58eQR8fHwEfnx8aHx8fGx0fHx8fHx8fbh8cHx8fHx+fel8cHx8fHx+fWV8cHx8fHx93ll8cHx8fHx/fSl8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8f",11)ab[66]=s(216,58,696)ab[96]=s(274,115,882)ab[31]=u("ZGJ1",3)ab[4]=u("bmlvdHN6",9)ab[43]=u("cXZrfWps",4)ab[7]=u("TE9BRFNUUklORw==",12)ab[22]=u("IA==",9)ab[27]=u("cmZgdw==",1)ab[65]=s(261,103,542)ab[2]=u("Y3ZkfA==",3)ab[15]=u("bg==",6)ab[85]=s(262,103,688)ab[80]=s(184,76)ab[97]=s(153,90)ab[33]=u("eHN6aQ==",7)ab[24]=u("c3x7cQ==",1)ab[20]=u("OQ==",3)ab[62]=s(212,54,605,226)ab[75]=s(177,60,583)ab[115]=s(247,87)ab[99]=s(133,54)ab[46]=u("cHdqfGtt",5)ab[63]=s(262,100)ab[8]=u("Znd/ZGU=",2)ab[105]=s(255,93,532,403)ab[79]=s(237,76)ab[102]=s(217,59)ab[78]=s(172,88,236)ab[50]=s(164,95)ab[104]=s(263,101)ab[39]=u("bXx+dg==",9)ab[47]=u("a3Buf311",10)ab[35]=u("aw==",4)ab[67]=s(230,70)ab[84]=s(209,51)ab[90]=s(243,91)ab[14]=u("bA==",7)ab[110]=s(219,59)ab[82]=s(269,108,828,336)ab[69]=s(219,57)ab[64]=s(221,63)ab[53]=s(203,82,756)ab[55]=s(187,59,925)ab[58]=s(360,106)ab[77]=s(238,52)ab[56]=s(139,58)ab[30]=u("EQ==",12)ab[44]=u("bXZoeXtz",4)ab[52]=s(150,70,380)ab[13]=u("aA==",11)ab[120]=s(298,114)ab[26]=u("JA==",1)ab[1]=u("a359c3o=",11)ab[42]=u("Znd1fQ==",2)ab[91]=s(214,54)ab[36]=u("bg==",2)ab[17]=u("TEk=",3)ab[76]=s(187,94)ab[38]=u("ZndkYn93eg==",2)ab[16]=u("I0M=",10)local ba=function(ar)local ac={[ab[s(250,ab[50],178,967,18)]]=bb,[ab[s(263,ab[51])]]=bc,[ab[s(275,ab[52])]]=bd,[ab[s(221,ab[53])]]=be,[ab[s(273,116)]]=r,[ab[s(263,97)]]=bf,[ab[s(271,ab[54])]]=bg,[ab[s(264,ab[55])]]=bh,[ab[s(248,ab[56],602)]]=bi,[ab[s(248,82)]]=bj,[ab[s(284,ab[57])]]=bk,}ac[ab[s(270,ab[58])]]=c;ac[ab[s(218,55)]]=d;ac[ab[s(233,70)]]=function(ad,an)local am,ah=ab[59],ab[60];local ae=ac[ab[s(221,ab[61])]]+an;while ad>ab[68]and ae>ab[67]do local af,ag=ad%ab[62],ae%ab[63];if af~=ag then ah=ah+am;end;ad=(ad-af)/ab[64];ae=(ae-ag)/ab[65];am=am*ab[66]end;if ad<ae then ad=ae;end;while ad>ab[73]do local af=ad%ab[69];if af>ab[70]then ah=ah+am;end;ad=(ad-af)/ab[71];am=am*ab[72]end;return ah;end;ac[ab[s(208,ab[99])]]=function(ai,an)ai=p(ai,ab[s(284,ab[75])]..t..ab[s(195,ab[74])],ab[s(247,ab[76])])ai=p(ai,ab[s(195,55)],function(aj)if(aj==ab[s(204,ab[77],232)])then return ab[s(274,103)]end;local ak,af=ab[s(227,ab[78])],(q(t,aj)-ab[79])for al=ab[87],ab[86],-ab[85]do ak=ak..(af%ab[84]^al-af%ab[83]^(al-ab[82])>ab[81]and ab[s(194,56)]or ab[s(237,ab[80])])end;return ak;end)ai=p(ai,ab[s(203,ab[88])],function(aj)if(#aj~=ab[90])then return ab[s(200,ab[89],765)]end;local am=ab[91]for al=ab[96],ab[95]do am=am+(o(aj,al,al)==ab[s(225,95,613)]and ab[94]^(ab[93]-al)or ab[92])end;return n(ac[ab[s(291,ab[97])]](am,an))end)return ai;end;ac[ab[s(249,ab[114])]]=function(ad,an)local am,ah=ab[100],ab[101];local ae=ac[ab[s(202,78)]]+an;while ad>ab[108]and ae>ab[107]do local af,ag=ad%ab[102],ae%ab[103];if af~=ag then ah=ah+am;end;ad=(ad-af)/ab[104];ae=(ae-ag)/ab[105];am=am*ab[106]end;if ad<ae then ad=ae;end;while ad>ab[113]do local af=ad%ab[109];if af>ab[110]then ah=ah+am;end;ad=(ad-af)/ab[111];am=am*ab[112]end;return ah;end;ac[ab[s(237,61,24)]]=(function()ao=function(ap,aq,ar)if not ap then as(aq,ab[116]+(ar or ab[115]))end;end;local y=g(0)y[ab[s(255,57,193,824)]]=function(at,...)local au=h(...)local av=h(i(au))return function(...)local au=h(...)local aw=g(0)for ax,ay in r(av)do e(aw,ay)end;for ax,ay in r(h(i(au)))do e(aw,ay)end;return at(i(aw))end;end;return y;end)();(function(az)end)(ac)return ac;end;return a(ab[s(313,104)],ba(ab[121]))end)()
