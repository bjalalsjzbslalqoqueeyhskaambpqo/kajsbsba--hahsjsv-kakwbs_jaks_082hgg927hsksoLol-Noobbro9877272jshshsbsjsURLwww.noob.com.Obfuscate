local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v24,v25) local v26={};for v41=1, #v24 do v6(v26,v0(v4(v1(v2(v24,v41,v41 + 1 )),v1(v2(v25,1 + (v41% #v25) ,1 + (v41% #v25) + 1 )))%256 ));end return v5(v26);end local v8=tonumber;local v9=string.byte;local v10=string.char;local v11=string.sub;local v12=string.gsub;local v13=string.rep;local v14=table.concat;local v15=table.insert;local v16=math.ldexp;local v17=getfenv or function() return _ENV;end ;local v18=setmetatable;local v19=pcall;local v20=select;local v21=unpack or table.unpack ;local v22=tonumber;local function v23(v27,v28,...) local v29=1;local v30;v27=v12(v11(v27,15 -10 ),v7("\226\96","\105\204\78\203\43\167\55\126"),function(v42) if (v9(v42,2)==79) then v30=v8(v11(v42,2 -1 ,1));return "";else local v92=0;local v93;while true do if (0==v92) then v93=v10(v8(v42,16));if v30 then local v118=0;local v119;while true do if (v118==1) then return v119;end if (v118==0) then v119=v13(v93,v30);v30=nil;v118=1;end end else return v93;end break;end end end end);local function v31(v43,v44,v45) if v45 then local v94=(v43/(2^(v44-1)))%(2^(((v45-1) -(v44-1)) + 1)) ;return v94-(v94%(1 -0)) ;else local v95=0;local v96;while true do if (v95==0) then v96=(793 -(368 + 423))^(v44-1) ;return (((v43%(v96 + v96))>=v96) and 1) or 0 ;end end end end local function v32() local v46=v9(v27,v29,v29);v29=v29 + 1 ;return v46;end local function v33() local v47=0;local v48;local v49;while true do if (v47==1) then return (v49 * 256) + v48 ;end if (v47==0) then v48,v49=v9(v27,v29,v29 + 2 );v29=v29 + (6 -4) ;v47=1;end end end local function v34() local v50=0;local v51;local v52;local v53;local v54;while true do if (v50==1) then return (v54 * (16777234 -(10 + 8))) + (v53 * 65536) + (v52 * (984 -728)) + v51 ;end if (v50==0) then v51,v52,v53,v54=v9(v27,v29,v29 + 3 );v29=v29 + 4 ;v50=1;end end end local function v35() local v55=v34();local v56=v34();local v57=1;local v58=(v31(v56,1,20) * (2^32)) + v55 ;local v59=v31(v56,463 -(416 + 26) ,31);local v60=((v31(v56,32)==1) and  -1) or 1 ;if (v59==0) then if (v58==(0 -0)) then return v60 * 0 ;else local v100=0;while true do if (v100==0) then v59=1;v57=0;break;end end end elseif (v59==2047) then return ((v58==0) and (v60 * ((1 + 0)/0))) or (v60 * NaN) ;end return v16(v60,v59-1023 ) * (v57 + (v58/(2^(133 -81)))) ;end local function v36(v61) local v62=0;local v63;local v64;while true do if (v62==0) then v63=nil;if  not v61 then v61=v34();if (v61==0) then return "";end end v62=1;end if (3==v62) then return v14(v64);end if (v62==2) then v64={};for v101=1, #v63 do v64[v101]=v10(v9(v11(v63,v101,v101)));end v62=3;end if (v62==1) then v63=v11(v27,v29,(v29 + v61) -(1 -0) );v29=v29 + v61 ;v62=2;end end end local v37=v34;local function v38(...) return {...},v20("#",...);end local function v39() local v65=0;local v66;local v67;local v68;local v69;local v70;local v71;while true do if (v65==3) then for v103=1,v34() do v67[v103-1 ]=v39();end return v69;end if (v65==1) then v69={v66,v67,nil,v68};v70=v34();v71={};v65=2;end if (v65==2) then for v105=1,v70 do local v106=v32();local v107;if (v106==(1487 -(998 + 488))) then v107=v32()~=0 ;elseif (v106==(1 + 1)) then v107=v35();elseif (v106==3) then v107=v36();end v71[v105]=v107;end v69[3 + 0 ]=v32();for v109=1,v34() do local v110=0;local v111;while true do if (v110==0) then v111=v32();if (v31(v111,1,1)==0) then local v120=v31(v111,2,3);local v121=v31(v111,4,6);local v122={v33(),v33(),nil,nil};if (v120==0) then v122[3]=v33();v122[16 -12 ]=v33();elseif (v120==(620 -(555 + 64))) then v122[10 -7 ]=v34();elseif (v120==2) then v122[3]=v34() -((7 -5)^16) ;elseif (v120==3) then local v134=0;while true do if (v134==0) then v122[3]=v34() -(2^(875 -(814 + 45))) ;v122[935 -(857 + 74) ]=v33();break;end end end if (v31(v121,1,1)==1) then v122[2]=v71[v122[570 -(367 + 201) ]];end if (v31(v121,2,2)==1) then v122[3]=v71[v122[930 -(214 + 713) ]];end if (v31(v121,3,3)==(1 + 0)) then v122[1 + 3 ]=v71[v122[4]];end v66[v109]=v122;end break;end end end v65=3;end if (0==v65) then v66={};v67={};v68={};v65=1;end end end local function v40(v72,v73,v74) local v75=v72[1];local v76=v72[2];local v77=v72[3];return function(...) local v78=v75;local v79=v76;local v80=v77;local v81=v38;local v82=1;local v83= -1;local v84={};local v85={...};local v86=v20("#",...) -(2 -1) ;local v87={};local v88={};for v97=0,v86 do if (v97>=v80) then v84[v97-v80 ]=v85[v97 + 1 ];else v88[v97]=v85[v97 + 1 ];end end local v89=(v86-v80) + 1 ;local v90;local v91;while true do local v98=0;while true do if (v98==0) then v90=v78[v82];v91=v90[878 -(282 + 595) ];v98=1;end if (1==v98) then if (v91<=31) then if (v91<=15) then if (v91<=7) then if (v91<=3) then if (v91<=1) then if (v91==0) then local v135=v90[1639 -(1523 + 114) ];local v136,v137=v81(v88[v135](v21(v88,v135 + 1 ,v90[3])));v83=(v137 + v135) -1 ;local v138=0;for v248=v135,v83 do v138=v138 + 1 ;v88[v248]=v136[v138];end else v82=v90[3];end elseif (v91>2) then local v140=0;local v141;while true do if (v140==0) then v141=v90[1 + 1 ];do return v21(v88,v141,v83);end break;end end else local v142=0;local v143;local v144;local v145;while true do if (v142==0) then v143=v90[2];v144=v88[v143 + 2 ];v142=1;end if (v142==1) then v145=v88[v143] + v144 ;v88[v143]=v145;v142=2;end if (v142==2) then if (v144>0) then if (v145<=v88[v143 + 1 ]) then v82=v90[3];v88[v143 + 3 + 0 ]=v145;end elseif (v145>=v88[v143 + (1 -0) ]) then v82=v90[3];v88[v143 + 3 ]=v145;end break;end end end elseif (v91<=5) then if (v91>4) then local v146=0;local v147;local v148;local v149;while true do if (v146==2) then for v307=1,v90[4] do local v308=0;local v309;while true do if (v308==0) then v82=v82 + 1 ;v309=v78[v82];v308=1;end if (v308==1) then if (v309[1]==8) then v149[v307-1 ]={v88,v309[1273 -(226 + 1044) ]};else v149[v307-1 ]={v73,v309[3]};end v87[ #v87 + 1 ]=v149;break;end end end v88[v90[2]]=v40(v147,v148,v74);break;end if (v146==0) then v147=v79[v90[888 -(261 + 624) ]];v148=nil;v146=1;end if (v146==1) then v149={};v148=v18({},{[v7("\154\149\42\16\23\1\223","\49\197\202\67\126\115\100\167")]=function(v310,v311) local v312=v149[v311];return v312[1 -0 ][v312[2]];end,[v7("\8\100\209\44\151\95\80\51\94\199","\62\87\59\191\73\224\54")]=function(v313,v314,v315) local v316=0;local v317;while true do if (v316==0) then v317=v149[v314];v317[1][v317[1067 -(68 + 997) ]]=v315;break;end end end});v146=2;end end else v88[v90[1082 -(1020 + 60) ]]={};end elseif (v91==6) then local v151=0;local v152;while true do if (v151==0) then v152=v90[8 -6 ];v88[v152]=v88[v152](v21(v88,v152 + 1 ,v90[3]));break;end end else v88[v90[2]]=v90[1426 -(630 + 793) ];end elseif (v91<=11) then if (v91<=9) then if (v91==(125 -(32 + 85))) then v88[v90[2]]=v88[v90[3]];else local v157=0;local v158;local v159;local v160;while true do if (1==v157) then v160=v88[v158 + 2 ];if (v160>0) then if (v159>v88[v158 + 1 ]) then v82=v90[9 -6 ];else v88[v158 + 3 ]=v159;end elseif (v159<v88[v158 + 1 + 0 ]) then v82=v90[2 + 1 ];else v88[v158 + 3 ]=v159;end break;end if (v157==0) then v158=v90[2];v159=v88[v158];v157=1;end end end elseif (v91>10) then do return v88[v90[2]]();end else local v161=v90[6 -4 ];local v162,v163=v81(v88[v161](v88[v161 + 1 ]));v83=(v163 + v161) -1 ;local v164=0;for v251=v161,v83 do local v252=0;while true do if (v252==0) then v164=v164 + 1 ;v88[v251]=v162[v164];break;end end end end elseif (v91<=13) then if (v91==12) then if (v88[v90[2]]==v90[4]) then v82=v82 + 1 ;else v82=v90[1 + 2 ];end elseif v88[v90[2]] then v82=v82 + 1 ;else v82=v90[3];end elseif (v91==(1761 -(760 + 987))) then local v165=0;local v166;while true do if (0==v165) then v166=v90[2];do return v88[v166](v21(v88,v166 + 1 ,v90[3]));end break;end end else local v167=0;local v168;local v169;local v170;local v171;while true do if (v167==1) then v83=(v170 + v168) -1 ;v171=0;v167=2;end if (v167==0) then v168=v90[2];v169,v170=v81(v88[v168](v88[v168 + (1914 -(1789 + 124)) ]));v167=1;end if (v167==2) then for v320=v168,v83 do v171=v171 + 1 ;v88[v320]=v169[v171];end break;end end end elseif (v91<=23) then if (v91<=19) then if (v91<=(974 -(892 + 65))) then if (v91==16) then v88[v90[2]]=v74[v90[3]];else local v174=0;local v175;while true do if (v174==0) then v175=v90[1 + 1 ];v88[v175]=v88[v175](v21(v88,v175 + 1 ,v83));break;end end end elseif (v91==18) then if v88[v90[2]] then v82=v82 + 1 ;else v82=v90[3];end else v88[v90[2]]=v88[v90[3]][v90[9 -5 ]];end elseif (v91<=21) then if (v91>20) then v88[v90[2]]=v88[v90[7 -4 ]]%v90[15 -11 ] ;else v88[v90[2]]();end elseif (v91==22) then local v179=v90[2];v88[v179]=v88[v179](v21(v88,v179 + 1 ,v90[5 -2 ]));else v88[v90[2]]=v88[v90[3]]%v88[v90[4]] ;end elseif (v91<=(1 + 26)) then if (v91<=25) then if (v91==(43 -19)) then v88[v90[2]]= #v88[v90[3]];else v88[v90[2]]=v88[v90[3 + 0 ]][v90[4]];end elseif (v91>26) then local v185=0;local v186;local v187;while true do if (1==v185) then for v323=v186 + 1 ,v83 do v15(v187,v88[v323]);end break;end if (v185==0) then v186=v90[2];v187=v88[v186];v185=1;end end else local v188=0;local v189;local v190;local v191;while true do if (v188==0) then v189=v90[2];v190=v88[v189 + 2 ];v188=1;end if (v188==1) then v191=v88[v189] + v190 ;v88[v189]=v191;v188=2;end if (v188==2) then if (v190>(350 -(87 + 263))) then if (v191<=v88[v189 + 1 ]) then local v353=0;while true do if (v353==0) then v82=v90[3];v88[v189 + 3 ]=v191;break;end end end elseif (v191>=v88[v189 + 1 ]) then v82=v90[3];v88[v189 + 3 ]=v191;end break;end end end elseif (v91<=29) then if (v91>28) then v88[v90[2]]=v73[v90[3]];else local v194=v79[v90[3]];local v195;local v196={};v195=v18({},{[v7("\216\61\243\199\227\7\226","\169\135\98\154")]=function(v253,v254) local v255=0;local v256;while true do if (v255==0) then v256=v196[v254];return v256[1][v256[2]];end end end,[v7("\244\72\42\81\234\58\198\207\114\60","\168\171\23\68\52\157\83")]=function(v257,v258,v259) local v260=0;local v261;while true do if (v260==0) then v261=v196[v258];v261[1][v261[2]]=v259;break;end end end});for v262=1,v90[4] do local v263=0;local v264;while true do if (v263==1) then if (v264[181 -(67 + 113) ]==8) then v196[v262-1 ]={v88,v264[3]};else v196[v262-1 ]={v73,v264[3]};end v87[ #v87 + 1 ]=v196;break;end if (0==v263) then v82=v82 + 1 ;v264=v78[v82];v263=1;end end end v88[v90[2]]=v40(v194,v195,v74);end elseif (v91>30) then v88[v90[2]]=v73[v90[3]];else v82=v90[3];end elseif (v91<=47) then if (v91<=39) then if (v91<=35) then if (v91<=33) then if (v91>32) then v88[v90[8 -6 ]]=v88[v90[3]];else local v203=v90[2 + 0 ];local v204=v88[v90[3]];v88[v203 + 1 ]=v204;v88[v203]=v204[v90[4]];end elseif (v91>34) then local v208=v90[2];local v209,v210=v81(v88[v208](v21(v88,v208 + (2 -1) ,v83)));v83=(v210 + v208) -1 ;local v211=0 + 0 ;for v265=v208,v83 do local v266=0;while true do if (v266==0) then v211=v211 + 1 ;v88[v265]=v209[v211];break;end end end else v88[v90[2]]=v88[v90[3]] + v90[15 -11 ] ;end elseif (v91<=37) then if (v91>36) then local v213=v90[2];local v214=v88[v213];local v215=v88[v213 + 2 ];if (v215>0) then if (v214>v88[v213 + 1 + 0 ]) then v82=v90[3];else v88[v213 + 3 ]=v214;end elseif (v214<v88[v213 + 1 ]) then v82=v90[3];else v88[v213 + 3 ]=v214;end else do return v88[v90[2]]();end end elseif (v91>38) then local v216=v90[2];local v217=v88[v216];for v267=v216 + 1 ,v83 do v15(v217,v88[v267]);end else local v218=v90[2];do return v21(v88,v218,v83);end end elseif (v91<=43) then if (v91<=41) then if (v91>40) then v88[v90[954 -(802 + 150) ]]=v88[v90[3]] + v90[4] ;else v88[v90[2]]= #v88[v90[3]];end elseif (v91==42) then for v268=v90[2],v90[3] do v88[v268]=nil;end elseif (v88[v90[2]]==v90[10 -6 ]) then v82=v82 + 1 ;else v82=v90[3];end elseif (v91<=45) then if (v91>(98 -54)) then if  not v88[v90[2]] then v82=v82 + (1 -0) ;else v82=v90[3 + 0 ];end else v88[v90[999 -(915 + 82) ]]=v90[3];end elseif (v91==(130 -84)) then v88[v90[2 + 0 ]]=v74[v90[1416 -(447 + 966) ]];else local v225=v90[2];v88[v225](v21(v88,v225 + 1 ,v83));end elseif (v91<=55) then if (v91<=51) then if (v91<=49) then if (v91==48) then v88[v90[2]]();else local v226=0;local v227;local v228;local v229;local v230;while true do if (v226==0) then v227=v90[2];v228,v229=v81(v88[v227](v21(v88,v227 + (1 -0) ,v90[3])));v226=1;end if (v226==1) then v83=(v229 + v227) -1 ;v230=0 -0 ;v226=2;end if (2==v226) then for v335=v227,v83 do local v336=0;while true do if (0==v336) then v230=v230 + 1 ;v88[v335]=v228[v230];break;end end end break;end end end elseif (v91==50) then v88[v90[2]]={};else v88[v90[1819 -(1703 + 114) ]]=v90[3] + v88[v90[4]] ;end elseif (v91<=53) then if (v91==(1239 -(1069 + 118))) then local v233=v90[4 -2 ];do return v88[v233](v21(v88,v233 + 1 ,v90[3]));end else v88[v90[2]]=v90[3] + v88[v90[4]] ;end elseif (v91==54) then local v235=v90[2];v88[v235]=v88[v235](v21(v88,v235 + 1 ,v83));else do return;end end elseif (v91<=(760 -(376 + 325))) then if (v91<=(124 -67)) then if (v91>56) then if  not v88[v90[1 + 1 ]] then v82=v82 + 1 ;else v82=v90[3];end else for v270=v90[2],v90[3] do v88[v270]=nil;end end elseif (v91==58) then local v237=v90[2];v88[v237](v21(v88,v237 + 1 ,v83));else local v238=0;local v239;local v240;while true do if (0==v238) then v239=v90[2 -0 ];v240=v88[v90[3]];v238=1;end if (v238==1) then v88[v239 + 1 ]=v240;v88[v239]=v240[v90[12 -8 ]];break;end end end elseif (v91<=61) then if (v91==60) then v88[v90[2]]=v88[v90[4 -1 ]]%v90[4] ;else v88[v90[2]]=v88[v90[3]]%v88[v90[4 + 0 ]] ;end elseif (v91>62) then do return;end else local v243=0;local v244;local v245;local v246;local v247;while true do if (1==v243) then v83=(v246 + v244) -1 ;v247=0;v243=2;end if (v243==2) then for v337=v244,v83 do local v338=0;while true do if (v338==0) then v247=v247 + 1 ;v88[v337]=v245[v247];break;end end end break;end if (v243==0) then v244=v90[2];v245,v246=v81(v88[v244](v21(v88,v244 + 1 ,v83)));v243=1;end end end v82=v82 + 1 ;break;end end end end;end return v40(v39(),{},v28)(...);end return v23("LOL!0D3O0003063O00737472696E6703043O006368617203043O00627974652O033O0073756203053O0062697433322O033O0062697403043O0062786F7203053O007461626C6503063O00636F6E63617403063O00696E7365727403053O006D6174636803083O00746F6E756D62657203053O007063612O6C00243O00122E3O00013O0020195O000200122E000100013O00201900010001000300122E000200013O00201900020002000400122E000300053O00062D0003000A000100010004013O000A000100122E000300063O00201900040003000700122E000500083O00201900050005000900122E000600083O00201900060006000A00060500073O000100062O00083O00064O00088O00083O00044O00083O00014O00083O00024O00083O00053O00122E000800013O00201900080008000B00122E0009000C3O00122E000A000D3O000605000B0001000100052O00083O00074O00083O00094O00083O00084O00083O000A4O00083O000B4O0021000C000B4O0024000C00014O0026000C6O003F3O00013O00023O00023O00026O00F03F026O00704002264O000400025O001207000300014O001800045O001207000500013O0004090003002100012O001D00076O0021000800024O001D000900014O001D000A00024O001D000B00034O001D000C00044O0021000D6O0021000E00063O002029000F000600014O000C000F4O0036000B3O00022O001D000C00034O001D000D00044O0021000E00014O0018000F00014O003D000F0006000F001033000F0001000F2O0018001000014O003D0010000600100010330010000100100020290010001000014O000D00104O0023000C6O0036000A3O0002002015000A000A00022O000F0009000A4O003A00073O00010004020003000500012O001D000300054O0021000400024O0034000300044O002600036O003F3O00017O00043O00027O004003053O003A25642B3A2O033O0025642B026O00F03F001C3O0006055O000100012O001F8O001D000100014O001D000200024O001D000300024O000400046O001D000500034O002100066O002A000700076O000500074O002700043O0001002019000400040001001207000500024O0006000300050002001207000400036O000200044O003600013O000200260C00010018000100040004013O001800012O002100016O000400026O0034000100024O002600015O0004013O001B00012O001D000100044O0024000100014O002600016O003F3O00013O00013O00063O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403503O00D9D7CF35F5E18851C3C2CC6BE1B2D316C4C1CE36E3A9C411DFD7DE2BF2F5C411DC8CF42BE398D51BD0D7D437DEF6E91BC68CD42BE39FC2089EF0D837EFABD30D9E928C7DB2EA964F819A8A76A8B7D21F03083O007EB1A3BB4586DBA7026O00F03F010F3O00060D3O000D00013O0004013O000D000100122E000100013O00122E000200023O002O200002000200032O001D00045O001207000500043O001207000600056O000400064O002300026O003600013O00022O00300001000100010004013O000E000100201900013O00062O003F3O00017O00",v17(),...);
-- âš ï¸ WARNING: integrity protected!
--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.5) ~  Much Love, Ferib 

]]--
