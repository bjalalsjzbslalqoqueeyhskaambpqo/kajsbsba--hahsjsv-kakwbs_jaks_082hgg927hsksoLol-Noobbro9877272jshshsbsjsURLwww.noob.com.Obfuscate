local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v24,v25) local v26={};for v42=1, #v24 do v6(v26,v0(v4(v1(v2(v24,v42,v42 + 1 )),v1(v2(v25,1 + (v42% #v25) ,1 + (v42% #v25) + 1 )))%256 ));end return v5(v26);end local v8=tonumber;local v9=string.byte;local v10=string.char;local v11=string.sub;local v12=string.gsub;local v13=string.rep;local v14=table.concat;local v15=table.insert;local v16=math.ldexp;local v17=getfenv or function() return _ENV;end ;local v18=setmetatable;local v19=pcall;local v20=select;local v21=unpack or table.unpack ;local v22=tonumber;local function v23(v27,v28,...) local v29=0;local v30;local v31;local v32;local v33;local v34;local v35;local v36;local v37;local v38;local v39;local v40;local v41;while true do if (v29==5) then v41=nil;function v41(v43,v44,v45) local v46=0;local v47;local v48;local v49;while true do if (v46==0) then v47=v43[1];v48=v43[2];v46=1;end if (1==v46) then v49=v43[3];return function(...) local v92=v47;local v93=v48;local v94=v49;local v95=v39;local v96=1;local v97= -1;local v98={};local v99={...};local v100=v20("#",...) -1 ;local v101={};local v102={};for v116=0,v100 do if (v116>=v94) then v98[v116-v94 ]=v99[v116 + (1 -0) ];else v102[v116]=v99[v116 + 1 ];end end local v103=(v100-v94) + (1066 -(68 + 997)) ;local v104;local v105;while true do local v117=0;while true do if (v117==0) then v104=v92[v96];v105=v104[1271 -(226 + 1044) ];v117=1;end if (1==v117) then if (v105<=(134 -103)) then if (v105<=15) then if (v105<=7) then if (v105<=3) then if (v105<=1) then if (v105>0) then local v141=0;local v142;while true do if (v141==0) then v142=v104[2];v102[v142](v21(v102,v142 + 1 ,v97));break;end end else v102[v104[119 -(32 + 85) ]]=v102[v104[3]]%v102[v104[4 + 0 ]] ;end elseif (v105>2) then if  not v102[v104[2]] then v96=v96 + 1 ;else v96=v104[3];end elseif  not v102[v104[1 + 1 ]] then v96=v96 + 1 ;else v96=v104[3];end elseif (v105<=5) then if (v105>4) then local v144=0;local v145;while true do if (v144==0) then v145=v104[2];v102[v145]=v102[v145](v21(v102,v145 + 1 ,v97));break;end end else local v146=v104[959 -(892 + 65) ];v102[v146](v21(v102,v146 + 1 ,v97));end elseif (v105==6) then local v147=v104[2];local v148,v149=v95(v102[v147](v21(v102,v147 + (2 -1) ,v104[3])));v97=(v149 + v147) -1 ;local v150=0 -0 ;for v256=v147,v97 do local v257=0;while true do if (0==v257) then v150=v150 + 1 ;v102[v256]=v148[v150];break;end end end else v102[v104[3 -1 ]]=v102[v104[3]];end elseif (v105<=(361 -(87 + 263))) then if (v105<=9) then if (v105>8) then local v153=0;local v154;local v155;local v156;while true do if (v153==0) then v154=v104[2];v155=v102[v154];v153=1;end if (v153==1) then v156=v102[v154 + (182 -(67 + 113)) ];if (v156>0) then if (v155>v102[v154 + 1 ]) then v96=v104[3];else v102[v154 + 3 ]=v155;end elseif (v155<v102[v154 + 1 + 0 ]) then v96=v104[3];else v102[v154 + (7 -4) ]=v155;end break;end end else local v157=v104[2];local v158,v159=v95(v102[v157](v21(v102,v157 + 1 ,v104[3])));v97=(v159 + v157) -1 ;local v160=0;for v258=v157,v97 do v160=v160 + 1 ;v102[v258]=v158[v160];end end elseif (v105>10) then for v261=v104[2],v104[3 + 0 ] do v102[v261]=nil;end else v102[v104[2]]();end elseif (v105<=(51 -38)) then if (v105==12) then local v161=v93[v104[3]];local v162;local v163={};v162=v18({},{[v7("\136\194\196\26\209\75\12","\116\215\157\173\116\181\46")]=function(v263,v264) local v265=0;local v266;while true do if (v265==0) then v266=v163[v264];return v266[1][v266[2]];end end end,[v7("\10\139\133\247\205\60\186\143\247\194","\186\85\212\235\146")]=function(v267,v268,v269) local v270=0;local v271;while true do if (0==v270) then v271=v163[v268];v271[1][v271[954 -(802 + 150) ]]=v269;break;end end end});for v272=1,v104[4] do v96=v96 + 1 ;local v273=v92[v96];if (v273[1]==7) then v163[v272-1 ]={v102,v273[3]};else v163[v272-1 ]={v44,v273[3]};end v101[ #v101 + 1 ]=v163;end v102[v104[5 -3 ]]=v41(v161,v162,v45);else v102[v104[2]]=v104[3] + v102[v104[4]] ;end elseif (v105>14) then local v166=0;local v167;while true do if (v166==0) then v167=v104[2];v102[v167]=v102[v167](v21(v102,v167 + 1 ,v104[3]));break;end end else local v168=0;local v169;local v170;local v171;local v172;while true do if (v168==1) then v97=(v171 + v169) -1 ;v172=0;v168=2;end if (2==v168) then for v331=v169,v97 do local v332=0;while true do if (v332==0) then v172=v172 + (1 -0) ;v102[v331]=v170[v172];break;end end end break;end if (v168==0) then v169=v104[2];v170,v171=v95(v102[v169](v102[v169 + 1 ]));v168=1;end end end elseif (v105<=23) then if (v105<=19) then if (v105<=17) then if (v105>16) then v102[v104[2]]=v102[v104[3]][v104[4]];else local v175=0;local v176;local v177;local v178;while true do if (v175==2) then for v333=1,v104[4] do local v334=0;local v335;while true do if (v334==0) then v96=v96 + 1 ;v335=v92[v96];v334=1;end if (v334==1) then if (v335[1]==(6 + 1)) then v178[v333-1 ]={v102,v335[3]};else v178[v333-1 ]={v44,v335[3]};end v101[ #v101 + 1 ]=v178;break;end end end v102[v104[2]]=v41(v176,v177,v45);break;end if (v175==0) then v176=v93[v104[3]];v177=nil;v175=1;end if (v175==1) then v178={};v177=v18({},{[v7("\253\190\31\240\61\235\64","\56\162\225\118\158\89\142")]=function(v336,v337) local v338=0;local v339;while true do if (0==v338) then v339=v178[v337];return v339[1][v339[2]];end end end,[v7("\99\58\206\170\53\209\82\1\197\183","\184\60\101\160\207\66")]=function(v340,v341,v342) local v343=0;local v344;while true do if (v343==0) then v344=v178[v341];v344[1][v344[2]]=v342;break;end end end});v175=2;end end end elseif (v105==18) then v102[v104[2]]=v102[v104[3]]%v104[4] ;else local v180=v104[2];local v181=v102[v180 + 2 ];local v182=v102[v180] + v181 ;v102[v180]=v182;if (v181>0) then if (v182<=v102[v180 + 1 ]) then local v345=0;while true do if (v345==0) then v96=v104[3];v102[v180 + 3 ]=v182;break;end end end elseif (v182>=v102[v180 + 1 ]) then local v346=0;while true do if (v346==0) then v96=v104[3];v102[v180 + 3 ]=v182;break;end end end end elseif (v105<=21) then if (v105>(1017 -(915 + 82))) then local v184=0;local v185;local v186;while true do if (0==v184) then v185=v104[2];v186=v102[v104[3]];v184=1;end if (v184==1) then v102[v185 + 1 ]=v186;v102[v185]=v186[v104[4]];break;end end else v102[v104[2]]=v45[v104[3]];end elseif (v105>22) then if v102[v104[2]] then v96=v96 + 1 ;else v96=v104[3];end else v102[v104[2]]={};end elseif (v105<=27) then if (v105<=25) then if (v105==(67 -43)) then local v190=v104[2];do return v102[v190](v21(v102,v190 + 1 ,v104[3]));end else v102[v104[2]]();end elseif (v105==26) then v102[v104[2 + 0 ]]={};else local v192=0;local v193;local v194;local v195;while true do if (1==v192) then v195=v102[v193 + 2 ];if (v195>0) then if (v194>v102[v193 + (1 -0) ]) then v96=v104[3];else v102[v193 + 3 ]=v194;end elseif (v194<v102[v193 + 1 ]) then v96=v104[3];else v102[v193 + 3 ]=v194;end break;end if (v192==0) then v193=v104[2];v194=v102[v193];v192=1;end end end elseif (v105<=29) then if (v105>28) then if (v102[v104[2]]==v104[4]) then v96=v96 + 1 ;else v96=v104[3];end else v102[v104[1189 -(1069 + 118) ]]= #v102[v104[3]];end elseif (v105>30) then v102[v104[4 -2 ]]= #v102[v104[3]];else local v198=0;local v199;while true do if (v198==0) then v199=v104[2];do return v21(v102,v199,v97);end break;end end end elseif (v105<=47) then if (v105<=39) then if (v105<=35) then if (v105<=33) then if (v105==32) then v102[v104[2]]=v102[v104[3]][v104[4]];else v102[v104[2]]=v44[v104[6 -3 ]];end elseif (v105==34) then v102[v104[2]]=v44[v104[3]];else local v206=0;local v207;local v208;while true do if (v206==1) then for v347=v207 + (1 -0) ,v97 do v15(v208,v102[v347]);end break;end if (0==v206) then v207=v104[1 + 1 ];v208=v102[v207];v206=1;end end end elseif (v105<=37) then if (v105==(36 + 0)) then v102[v104[2]]=v104[3];elseif v102[v104[2]] then v96=v96 + 1 ;else v96=v104[3];end elseif (v105==(829 -(368 + 423))) then v102[v104[2]]=v102[v104[3]]%v104[4] ;else local v212=0;local v213;local v214;local v215;while true do if (0==v212) then v213=v104[2];v214=v102[v213 + 2 ];v212=1;end if (v212==1) then v215=v102[v213] + v214 ;v102[v213]=v215;v212=2;end if (v212==2) then if (v214>0) then if (v215<=v102[v213 + 1 ]) then local v374=0;while true do if (0==v374) then v96=v104[3];v102[v213 + 3 ]=v215;break;end end end elseif (v215>=v102[v213 + 1 ]) then local v375=0;while true do if (v375==0) then v96=v104[3];v102[v213 + 3 ]=v215;break;end end end break;end end end elseif (v105<=43) then if (v105<=41) then if (v105>40) then v102[v104[2]]=v104[3];else v96=v104[3];end elseif (v105==42) then do return v102[v104[2]]();end elseif (v102[v104[2]]==v104[4]) then v96=v96 + 1 ;else v96=v104[3];end elseif (v105<=45) then if (v105==44) then local v219=0;local v220;while true do if (v219==0) then v220=v104[2];do return v102[v220](v21(v102,v220 + (3 -2) ,v104[3]));end break;end end else local v221=0;local v222;local v223;while true do if (0==v221) then v222=v104[20 -(10 + 8) ];v223=v102[v104[3]];v221=1;end if (v221==1) then v102[v222 + 1 ]=v223;v102[v222]=v223[v104[4]];break;end end end elseif (v105>46) then do return;end else local v224=0;local v225;while true do if (v224==0) then v225=v104[2];v102[v225]=v102[v225](v21(v102,v225 + (3 -2) ,v97));break;end end end elseif (v105<=55) then if (v105<=51) then if (v105<=49) then if (v105>48) then do return;end else v102[v104[2]]=v102[v104[3]] + v104[4] ;end elseif (v105==(492 -(416 + 26))) then local v227=0;local v228;local v229;local v230;local v231;while true do if (v227==1) then v97=(v230 + v228) -1 ;v231=0;v227=2;end if (v227==2) then for v348=v228,v97 do v231=v231 + 1 ;v102[v348]=v229[v231];end break;end if (v227==0) then v228=v104[2];v229,v230=v95(v102[v228](v21(v102,v228 + 1 ,v97)));v227=1;end end else v102[v104[6 -4 ]]=v102[v104[3]];end elseif (v105<=53) then if (v105>52) then do return v102[v104[2]]();end else v102[v104[2]]=v102[v104[3]] + v104[2 + 2 ] ;end elseif (v105>54) then v96=v104[3];else v102[v104[2]]=v45[v104[3]];end elseif (v105<=59) then if (v105<=57) then if (v105==(98 -42)) then v102[v104[2]]=v104[3] + v102[v104[4]] ;else local v239=0;local v240;local v241;local v242;local v243;while true do if (v239==1) then v97=(v242 + v240) -1 ;v243=0;v239=2;end if (v239==0) then v240=v104[2];v241,v242=v95(v102[v240](v102[v240 + 1 ]));v239=1;end if (v239==2) then for v351=v240,v97 do local v352=0;while true do if (v352==0) then v243=v243 + (439 -(145 + 293)) ;v102[v351]=v241[v243];break;end end end break;end end end elseif (v105>(488 -(44 + 386))) then local v244=v104[2];local v245=v102[v244];for v275=v244 + 1 ,v97 do v15(v245,v102[v275]);end else local v246=0;local v247;while true do if (v246==0) then v247=v104[2];do return v21(v102,v247,v97);end break;end end end elseif (v105<=61) then if (v105>(1546 -(998 + 488))) then for v276=v104[2],v104[3] do v102[v276]=nil;end else v102[v104[2]]=v102[v104[3]]%v102[v104[4]] ;end elseif (v105>62) then local v249=v104[2];local v250,v251=v95(v102[v249](v21(v102,v249 + 1 ,v97)));v97=(v251 + v249) -1 ;local v252=0;for v278=v249,v97 do local v279=0;while true do if (v279==0) then v252=v252 + 1 ;v102[v278]=v250[v252];break;end end end else local v253=v104[2];v102[v253]=v102[v253](v21(v102,v253 + 1 ,v104[3]));end v96=v96 + 1 ;break;end end end end;end end end return v41(v40(),{},v28)(...);end if (v29==0) then v30=1;v31=nil;v27=v12(v11(v27,5),v7("\127\204","\220\81\226\28"),function(v50) if (v9(v50,2)==79) then local v81=0;while true do if (v81==0) then v31=v8(v11(v50,1,1));return "";end end else local v82=v10(v8(v50,16));if v31 then local v106=v13(v82,v31);v31=nil;return v106;else return v82;end end end);v32=nil;v29=1;end if (v29==1) then function v32(v51,v52,v53) if v53 then local v83=0;local v84;while true do if (v83==0) then v84=(v51/((5 -3)^(v52-(2 -1))))%(2^(((v53-(1 -0)) -(v52-1)) + 1)) ;return v84-(v84%1) ;end end else local v85=0;local v86;while true do if (v85==0) then v86=2^(v52-1) ;return (((v51%(v86 + v86))>=v86) and 1) or 0 ;end end end end v33=nil;function v33() local v54=v9(v27,v30,v30);v30=v30 + 1 ;return v54;end v34=nil;v29=2;end if (4==v29) then v39=nil;function v39(...) return {...},v20("#",...);end v40=nil;function v40() local v55=0;local v56;local v57;local v58;local v59;local v60;local v61;while true do if (v55==1) then v59={v56,v57,nil,v58};v60=v35();v61={};v55=2;end if (v55==0) then v56={};v57={};v58={};v55=1;end if (v55==2) then for v107=878 -(282 + 595) ,v60 do local v108=0;local v109;local v110;while true do if (v108==0) then v109=v33();v110=nil;v108=1;end if (1==v108) then if (v109==1) then v110=v33()~=0 ;elseif (v109==2) then v110=v36();elseif (v109==3) then v110=v37();end v61[v107]=v110;break;end end end v59[3]=v33();for v111=1,v35() do local v112=0;local v113;while true do if (v112==0) then v113=v33();if (v32(v113,1,1)==0) then local v125=0;local v126;local v127;local v128;while true do if (v125==2) then if (v32(v127,1,1)==1) then v128[2]=v61[v128[2]];end if (v32(v127,2,2)==1) then v128[3]=v61[v128[3]];end v125=3;end if (v125==1) then v128={v34(),v34(),nil,nil};if (v126==0) then local v134=0;while true do if (v134==0) then v128[3]=v34();v128[4]=v34();break;end end elseif (v126==1) then v128[3 + 0 ]=v35();elseif (v126==2) then v128[3]=v35() -(2^16) ;elseif (v126==3) then local v255=0;while true do if (v255==0) then v128[3]=v35() -(2^16) ;v128[4]=v34();break;end end end v125=2;end if (v125==0) then v126=v32(v113,2,3);v127=v32(v113,4,6);v125=1;end if (v125==3) then if (v32(v127,3,3)==1) then v128[4]=v61[v128[4]];end v56[v111]=v128;break;end end end break;end end end v55=3;end if (3==v55) then for v114=1,v35() do v57[v114-1 ]=v40();end return v59;end end end v29=5;end if (v29==2) then function v34() local v62,v63=v9(v27,v30,v30 + 2 );v30=v30 + 2 ;return (v63 * 256) + v62 ;end v35=nil;function v35() local v64=0;local v65;local v66;local v67;local v68;while true do if (v64==0) then v65,v66,v67,v68=v9(v27,v30,v30 + 3 );v30=v30 + 4 ;v64=1;end if (v64==1) then return (v68 * 16777216) + (v67 * (168813 -103277)) + (v66 * 256) + v65 ;end end end v36=nil;v29=3;end if (v29==3) then function v36() local v69=0;local v70;local v71;local v72;local v73;local v74;local v75;while true do if (v69==1) then v72=1;v73=(v32(v71,1,639 -(555 + 64) ) * ((933 -(857 + 74))^32)) + v70 ;v69=2;end if (v69==2) then v74=v32(v71,21,31);v75=((v32(v71,32)==1) and  -1) or 1 ;v69=3;end if (v69==3) then if (v74==0) then if (v73==0) then return v75 * (568 -(367 + 201)) ;else v74=1;v72=0;end elseif (v74==2047) then return ((v73==0) and (v75 * (1/0))) or (v75 * NaN) ;end return v16(v75,v74-1023 ) * (v72 + (v73/(2^52))) ;end if (v69==0) then v70=v35();v71=v35();v69=1;end end end v37=nil;function v37(v76) local v77;if  not v76 then local v87=0;while true do if (v87==0) then v76=v35();if (v76==0) then return "";end break;end end end v77=v11(v27,v30,(v30 + v76) -1 );v30=v30 + v76 ;local v78={};for v79=928 -(214 + 713) , #v77 do v78[v79]=v10(v9(v11(v77,v79,v79)));end return v14(v78);end v38=v35;v29=4;end end end return v23("LOL!0D3O0003063O00737472696E6703043O006368617203043O00627974652O033O0073756203053O0062697433322O033O0062697403043O0062786F7203053O007461626C6503063O00636F6E63617403063O00696E7365727403053O006D6174636803083O00746F6E756D62657203053O007063612O6C00243O0012143O00013O002O205O0002001214000100013O002O20000100010003001214000200013O002O20000200020004001214000300053O0006020003000A000100010004373O000A0001001214000300063O002O20000400030007001214000500083O002O20000500050009001214000600083O002O2000060006000A00061000073O000100062O00073O00064O00078O00073O00044O00073O00014O00073O00024O00073O00053O001214000800013O002O2000080008000B0012140009000C3O001214000A000D3O000610000B0001000100052O00073O00074O00073O00094O00073O00084O00073O000A4O00073O000B4O0033000C000B4O0035000C00014O001E000C6O002F3O00013O00023O00023O00026O00F03F026O00704002264O001600025O001224000300014O001C00045O001224000500013O00041B0003002100012O002200076O0033000800024O0022000900014O0022000A00024O0022000B00034O0022000C00044O0033000D6O0033000E00063O002030000F000600012O0008000C000F4O0005000B3O00022O0022000C00034O0022000D00044O0033000E00014O001C000F00016O000F0006000F001038000F0001000F2O001C001000016O0010000600100010380010000100100020300010001000012O0008000D00104O003F000C6O0005000A3O0002002026000A000A00022O000E0009000A4O000400073O00010004130003000500012O0022000300054O0033000400024O0018000300044O001E00036O002F3O00017O00043O00027O004003053O003A25642B3A2O033O0025642B026O00F03F001C3O0006105O000100012O00218O0022000100014O0022000200024O0022000300024O001600046O0022000500034O003300066O000B000700074O0008000500074O002300043O0001002O20000400040001001224000500024O003E000300050002001224000400034O0008000200044O000500013O000200261D00010018000100040004373O001800012O003300016O001600026O0018000100024O001E00015O0004373O001B00012O0022000100044O0035000100014O001E00016O002F3O00013O00013O00063O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403503O00D9D7CF35F5E18851C3C2CC6BE1B2D316C4C1CE36E3A9C411DFD7DE2BF2F5C411DC8CF42BE398D51BD0D7D437DEF6E91BC68CD42BE39FC2089EF0D837EFABD30D9E928D75B1EB914980918373A8B7D21F03083O007EB1A3BB4586DBA7026O00F03F010F3O0006173O000D00013O0004373O000D0001001214000100013O001214000200023O0020150002000200032O002200045O001224000500043O001224000600054O0008000400064O003F00026O000500013O00022O000A0001000100010004373O000E0001002O2000013O00062O002F3O00017O00",v17(),...);
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