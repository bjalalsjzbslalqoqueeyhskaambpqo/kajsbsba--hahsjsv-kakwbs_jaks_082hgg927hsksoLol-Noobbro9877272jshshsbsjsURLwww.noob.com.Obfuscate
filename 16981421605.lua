local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v24,v25) local v26={};for v41=1, #v24 do v6(v26,v0(v4(v1(v2(v24,v41,v41 + 1 )),v1(v2(v25,1 + (v41% #v25) ,1 + (v41% #v25) + 1 )))%256 ));end return v5(v26);end local v8=tonumber;local v9=string.byte;local v10=string.char;local v11=string.sub;local v12=string.gsub;local v13=string.rep;local v14=table.concat;local v15=table.insert;local v16=math.ldexp;local v17=getfenv or function() return _ENV;end ;local v18=setmetatable;local v19=pcall;local v20=select;local v21=unpack or table.unpack ;local v22=tonumber;local function v23(v27,v28,...) local v29=1;local v30;v27=v12(v11(v27,5),v7("\145\81","\90\191\127\148\124"),function(v42) if (v9(v42,2)==79) then local v93=0;while true do if (v93==0) then v30=v8(v11(v42,1,1));return "";end end else local v94=0;local v95;while true do if (v94==0) then v95=v10(v8(v42,16));if v30 then local v119=v13(v95,v30);v30=nil;return v119;else return v95;end break;end end end end);local function v31(v43,v44,v45) if v45 then local v96=(v43/((5 -3)^(v44-1)))%(2^(((v45-1) -(v44-1)) + 1)) ;return v96-(v96%1) ;else local v97=0;local v98;while true do if (v97==0) then v98=(5 -3)^(v44-1) ;return (((v43%(v98 + v98))>=v98) and 1) or 0 ;end end end end local function v32() local v46=0;local v47;while true do if (v46==0) then v47=v9(v27,v29,v29);v29=v29 + 1 ;v46=1;end if (v46==1) then return v47;end end end local function v33() local v48,v49=v9(v27,v29,v29 + (3 -1) );v29=v29 + 2 ;return (v49 * 256) + v48 ;end local function v34() local v50=0;local v51;local v52;local v53;local v54;while true do if (v50==0) then v51,v52,v53,v54=v9(v27,v29,v29 + 3 );v29=v29 + 4 ;v50=1;end if (v50==1) then return (v54 * (43216383 -26439167)) + (v53 * 65536) + (v52 * 256) + v51 ;end end end local function v35() local v55=0;local v56;local v57;local v58;local v59;local v60;local v61;while true do if (2==v55) then v60=v31(v57,21,31);v61=((v31(v57,32)==(932 -(857 + 74))) and  -1) or 1 ;v55=3;end if (v55==3) then if (v60==0) then if (v59==0) then return v61 * 0 ;else local v120=0;while true do if (v120==0) then v60=1;v58=0;break;end end end elseif (v60==2047) then return ((v59==(568 -(367 + 201))) and (v61 * (1/0))) or (v61 * NaN) ;end return v16(v61,v60-1023 ) * (v58 + (v59/((929 -(214 + 713))^52))) ;end if (v55==0) then v56=v34();v57=v34();v55=1;end if (v55==1) then v58=620 -(555 + 64) ;v59=(v31(v57,1,20) * (2^32)) + v56 ;v55=2;end end end local function v36(v62) local v63=0;local v64;local v65;while true do if (1==v63) then v64=v11(v27,v29,(v29 + v62) -1 );v29=v29 + v62 ;v63=2;end if (v63==0) then v64=nil;if  not v62 then local v118=0;while true do if (v118==0) then v62=v34();if (v62==0) then return "";end break;end end end v63=1;end if (v63==2) then v65={};for v103=1, #v64 do v65[v103]=v10(v9(v11(v64,v103,v103)));end v63=3;end if (v63==3) then return v14(v65);end end end local v37=v34;local function v38(...) return {...},v20("#",...);end local function v39() local v66=0;local v67;local v68;local v69;local v70;local v71;local v72;while true do if (v66==0) then v67={};v68={};v69={};v70={v67,v68,nil,v69};v66=1;end if (v66==1) then v71=v34();v72={};for v105=1,v71 do local v106=0;local v107;local v108;while true do if (0==v106) then v107=v32();v108=nil;v106=1;end if (v106==1) then if (v107==1) then v108=v32()~=0 ;elseif (v107==(1 + 1)) then v108=v35();elseif (v107==3) then v108=v36();end v72[v105]=v108;break;end end end v70[3]=v32();v66=2;end if (v66==2) then for v109=1,v34() do local v110=0;local v111;while true do if (v110==0) then v111=v32();if (v31(v111,1,1)==0) then local v122=v31(v111,2,3);local v123=v31(v111,4,6);local v124={v33(),v33(),nil,nil};if (v122==0) then v124[3]=v33();v124[4]=v33();elseif (v122==1) then v124[3]=v34();elseif (v122==(1 + 1)) then v124[3]=v34() -(2^16) ;elseif (v122==3) then local v281=0;while true do if (0==v281) then v124[3]=v34() -(2^16) ;v124[4]=v33();break;end end end if (v31(v123,1,1)==1) then v124[2]=v72[v124[2]];end if (v31(v123,2,2)==1) then v124[3]=v72[v124[880 -(282 + 595) ]];end if (v31(v123,1640 -(1523 + 114) ,3 + 0 )==1) then v124[4]=v72[v124[4]];end v67[v109]=v124;end break;end end end for v112=1,v34() do v68[v112-(1 -0) ]=v39();end return v70;end end end local function v40(v73,v74,v75) local v76=v73[1];local v77=v73[2];local v78=v73[3];return function(...) local v79=v76;local v80=v77;local v81=v78;local v82=v38;local v83=1;local v84= -1;local v85={};local v86={...};local v87=v20("#",...) -1 ;local v88={};local v89={};for v99=0,v87 do if (v99>=v81) then v85[v99-v81 ]=v86[v99 + 1 ];else v89[v99]=v86[v99 + 1 ];end end local v90=(v87-v81) + (1066 -(68 + 997)) ;local v91;local v92;while true do v91=v79[v83];v92=v91[1];if (v92<=31) then if (v92<=15) then if (v92<=7) then if (v92<=3) then if (v92<=(1271 -(226 + 1044))) then if (v92==(0 -0)) then v89[v91[2]]= #v89[v91[3]];else v89[v91[2]]=v75[v91[3]];end elseif (v92==2) then local v138=0;local v139;while true do if (0==v138) then v139=v91[2];v89[v139]=v89[v139](v21(v89,v139 + 1 ,v91[3]));break;end end else v89[v91[2]]=v89[v91[3]];end elseif (v92<=5) then if (v92>4) then v89[v91[119 -(32 + 85) ]]=v89[v91[3]][v91[4]];else local v144=v91[2];local v145=v89[v144];local v146=v89[v144 + 2 ];if (v146>0) then if (v145>v89[v144 + 1 ]) then v83=v91[3];else v89[v144 + 3 ]=v145;end elseif (v145<v89[v144 + 1 ]) then v83=v91[3 + 0 ];else v89[v144 + 3 ]=v145;end end elseif (v92>6) then local v147=v91[2];v89[v147](v21(v89,v147 + 1 + 0 ,v84));else v89[v91[2]]=v91[3];end elseif (v92<=11) then if (v92<=9) then if (v92>8) then local v150=v91[2];local v151=v89[v91[3]];v89[v150 + 1 ]=v151;v89[v150]=v151[v91[4]];else local v155=0;local v156;local v157;local v158;while true do if (v155==2) then if (v157>0) then if (v158<=v89[v156 + 1 ]) then local v350=0;while true do if (v350==0) then v83=v91[960 -(892 + 65) ];v89[v156 + 3 ]=v158;break;end end end elseif (v158>=v89[v156 + 1 ]) then local v351=0;while true do if (v351==0) then v83=v91[7 -4 ];v89[v156 + 3 ]=v158;break;end end end break;end if (v155==1) then v158=v89[v156] + v157 ;v89[v156]=v158;v155=2;end if (v155==0) then v156=v91[2];v157=v89[v156 + 2 ];v155=1;end end end elseif (v92>10) then local v159=0;local v160;local v161;while true do if (v159==1) then v89[v160 + 1 ]=v161;v89[v160]=v161[v91[4]];break;end if (v159==0) then v160=v91[3 -1 ];v161=v89[v91[4 -1 ]];v159=1;end end else local v162=v91[2];local v163,v164=v82(v89[v162](v89[v162 + (351 -(87 + 263)) ]));v84=(v164 + v162) -1 ;local v165=0;for v251=v162,v84 do v165=v165 + 1 ;v89[v251]=v163[v165];end end elseif (v92<=13) then if (v92==12) then local v166=0;local v167;local v168;local v169;local v170;while true do if (v166==1) then v84=(v169 + v167) -1 ;v170=0;v166=2;end if (v166==2) then for v316=v167,v84 do local v317=0;while true do if (v317==0) then v170=v170 + 1 ;v89[v316]=v168[v170];break;end end end break;end if (v166==0) then v167=v91[2];v168,v169=v82(v89[v167](v21(v89,v167 + (181 -(67 + 113)) ,v84)));v166=1;end end elseif v89[v91[2]] then v83=v83 + 1 ;else v83=v91[3];end elseif (v92>14) then local v171=0;local v172;while true do if (v171==0) then v172=v91[2];do return v89[v172](v21(v89,v172 + 1 ,v91[3]));end break;end end else v89[v91[2]]={};end elseif (v92<=23) then if (v92<=19) then if (v92<=17) then if (v92==16) then v89[v91[2]]();else local v174=v91[2];do return v21(v89,v174,v84);end end elseif (v92>18) then local v175=0;local v176;local v177;while true do if (v175==1) then for v318=v176 + 1 ,v84 do v15(v177,v89[v318]);end break;end if (v175==0) then v176=v91[2];v177=v89[v176];v175=1;end end else v89[v91[2]]=v89[v91[3]] + v91[3 + 1 ] ;end elseif (v92<=21) then if (v92==20) then if (v89[v91[2]]==v91[4]) then v83=v83 + 1 ;else v83=v91[3];end else v89[v91[4 -2 ]]();end elseif (v92==22) then if v89[v91[2]] then v83=v83 + 1 ;else v83=v91[3];end else local v179=0;local v180;local v181;local v182;while true do if (0==v179) then v180=v80[v91[3]];v181=nil;v179=1;end if (v179==1) then v182={};v181=v18({},{[v7("\71\184\39\25\124\130\54","\119\24\231\78")]=function(v319,v320) local v321=0;local v322;while true do if (v321==0) then v322=v182[v320];return v322[1][v322[2]];end end end,[v7("\189\18\171\79\203\73\31\134\40\189","\113\226\77\197\42\188\32")]=function(v323,v324,v325) local v326=0;local v327;while true do if (0==v326) then v327=v182[v324];v327[1][v327[2]]=v325;break;end end end});v179=2;end if (v179==2) then for v328=1,v91[4] do v83=v83 + 1 ;local v329=v79[v83];if (v329[1]==27) then v182[v328-1 ]={v89,v329[3 + 0 ]};else v182[v328-1 ]={v74,v329[3]};end v88[ #v88 + 1 ]=v182;end v89[v91[2]]=v40(v180,v181,v75);break;end end end elseif (v92<=27) then if (v92<=25) then if (v92>24) then v89[v91[2]]=v75[v91[3]];else local v185=0;local v186;local v187;local v188;local v189;while true do if (1==v185) then v84=(v188 + v186) -1 ;v189=0;v185=2;end if (0==v185) then v186=v91[2];v187,v188=v82(v89[v186](v21(v89,v186 + 1 ,v84)));v185=1;end if (v185==2) then for v331=v186,v84 do local v332=0;while true do if (v332==0) then v189=v189 + 1 ;v89[v331]=v187[v189];break;end end end break;end end end elseif (v92>26) then v89[v91[2]]=v89[v91[11 -8 ]];else do return;end end elseif (v92<=29) then if (v92==28) then v89[v91[2]]=v89[v91[3]]%v89[v91[4]] ;else for v254=v91[2],v91[955 -(802 + 150) ] do v89[v254]=nil;end end elseif (v92==30) then local v193=v91[5 -3 ];local v194,v195=v82(v89[v193](v21(v89,v193 + 1 ,v91[3])));v84=(v195 + v193) -1 ;local v196=0;for v256=v193,v84 do v196=v196 + 1 ;v89[v256]=v194[v196];end else v83=v91[3];end elseif (v92<=47) then if (v92<=39) then if (v92<=35) then if (v92<=33) then if (v92>32) then for v259=v91[2],v91[3] do v89[v259]=nil;end else local v198=0;local v199;local v200;local v201;local v202;while true do if (v198==2) then for v333=v199,v84 do local v334=0;while true do if (v334==0) then v202=v202 + (1 -0) ;v89[v333]=v200[v202];break;end end end break;end if (0==v198) then v199=v91[2];v200,v201=v82(v89[v199](v89[v199 + 1 ]));v198=1;end if (v198==1) then v84=(v201 + v199) -1 ;v202=0;v198=2;end end end elseif (v92==34) then if  not v89[v91[2]] then v83=v83 + 1 + 0 ;else v83=v91[3];end else local v203=v80[v91[1000 -(915 + 82) ]];local v204;local v205={};v204=v18({},{[v7("\5\41\253\187\62\19\236","\213\90\118\148")]=function(v261,v262) local v263=v205[v262];return v263[1][v263[2]];end,[v7("\100\17\186\83\90\82\32\176\83\85","\45\59\78\212\54")]=function(v264,v265,v266) local v267=0;local v268;while true do if (v267==0) then v268=v205[v265];v268[1][v268[2]]=v266;break;end end end});for v269=1,v91[11 -7 ] do local v270=0;local v271;while true do if (v270==0) then v83=v83 + 1 ;v271=v79[v83];v270=1;end if (v270==1) then if (v271[1]==27) then v205[v269-1 ]={v89,v271[3]};else v205[v269-1 ]={v74,v271[3]};end v88[ #v88 + 1 + 0 ]=v205;break;end end end v89[v91[2]]=v40(v203,v204,v75);end elseif (v92<=37) then if (v92==36) then local v207=0;local v208;while true do if (0==v207) then v208=v91[2];do return v21(v89,v208,v84);end break;end end else local v209=0;local v210;local v211;local v212;while true do if (0==v209) then v210=v91[2];v211=v89[v210];v209=1;end if (1==v209) then v212=v89[v210 + 2 ];if (v212>(0 -0)) then if (v211>v89[v210 + 1 ]) then v83=v91[3];else v89[v210 + (1190 -(1069 + 118)) ]=v211;end elseif (v211<v89[v210 + 1 ]) then v83=v91[6 -3 ];else v89[v210 + 3 ]=v211;end break;end end end elseif (v92>(82 -44)) then local v213=0;local v214;while true do if (v213==0) then v214=v91[2];do return v89[v214](v21(v89,v214 + 1 ,v91[3]));end break;end end else v89[v91[2]]=v91[3] + v89[v91[4]] ;end elseif (v92<=43) then if (v92<=41) then if (v92==40) then v89[v91[2]]=v91[3] + v89[v91[4]] ;else v89[v91[2]]=v74[v91[3]];end elseif (v92==(8 + 34)) then v89[v91[2]]=v89[v91[3]]%v89[v91[4]] ;else v89[v91[3 -1 ]]=v89[v91[3]] + v91[4 + 0 ] ;end elseif (v92<=45) then if (v92==44) then v89[v91[793 -(368 + 423) ]]=v89[v91[3]]%v91[4] ;else v89[v91[2]]={};end elseif (v92>46) then do return;end else v89[v91[6 -4 ]]=v74[v91[3]];end elseif (v92<=(73 -(10 + 8))) then if (v92<=51) then if (v92<=49) then if (v92>48) then local v225=v91[2];local v226=v89[v225];for v272=v225 + 1 ,v84 do v15(v226,v89[v272]);end else local v227=0;local v228;while true do if (v227==0) then v228=v91[2];v89[v228]=v89[v228](v21(v89,v228 + 1 ,v84));break;end end end elseif (v92>50) then local v229=0;local v230;while true do if (v229==0) then v230=v91[2];v89[v230]=v89[v230](v21(v89,v230 + 1 ,v91[11 -8 ]));break;end end else v83=v91[3];end elseif (v92<=53) then if (v92==52) then do return v89[v91[2]]();end else local v232=0;local v233;while true do if (v232==0) then v233=v91[2];v89[v233](v21(v89,v233 + 1 ,v84));break;end end end elseif (v92==(496 -(416 + 26))) then do return v89[v91[2]]();end elseif  not v89[v91[2]] then v83=v83 + 1 ;else v83=v91[3];end elseif (v92<=59) then if (v92<=57) then if (v92>56) then v89[v91[2]]=v91[3];else v89[v91[6 -4 ]]= #v89[v91[3]];end elseif (v92==58) then if (v89[v91[2]]==v91[4]) then v83=v83 + 1 ;else v83=v91[2 + 1 ];end else local v237=0;local v238;while true do if (v237==0) then v238=v91[2];v89[v238]=v89[v238](v21(v89,v238 + 1 ,v84));break;end end end elseif (v92<=(107 -46)) then if (v92==60) then v89[v91[2]]=v89[v91[3]][v91[442 -(145 + 293) ]];else local v241=v91[2];local v242,v243=v82(v89[v241](v21(v89,v241 + 1 ,v91[3])));v84=(v243 + v241) -1 ;local v244=0;for v273=v241,v84 do local v274=0;while true do if (v274==0) then v244=v244 + 1 ;v89[v273]=v242[v244];break;end end end end elseif (v92>62) then local v245=v91[2];local v246=v89[v245 + 2 ];local v247=v89[v245] + v246 ;v89[v245]=v247;if (v246>0) then if (v247<=v89[v245 + 1 ]) then local v341=0;while true do if (v341==0) then v83=v91[433 -(44 + 386) ];v89[v245 + (1489 -(998 + 488)) ]=v247;break;end end end elseif (v247>=v89[v245 + 1 ]) then v83=v91[1 + 2 ];v89[v245 + 3 ]=v247;end else v89[v91[2]]=v89[v91[3]]%v91[4] ;end v83=v83 + 1 ;end end;end return v40(v39(),{},v28)(...);end return v23("LOL!0D3O0003063O00737472696E6703043O006368617203043O00627974652O033O0073756203053O0062697433322O033O0062697403043O0062786F7203053O007461626C6503063O00636F6E63617403063O00696E7365727403053O006D6174636803083O00746F6E756D62657203053O007063612O6C00243O0012193O00013O0020055O0002001219000100013O002005000100010003001219000200013O002005000200020004001219000300053O0006220003000A000100010004323O000A0001001219000300063O002005000400030007001219000500083O002005000500050009001219000600083O00200500060006000A00062300073O000100062O001B3O00064O001B8O001B3O00044O001B3O00014O001B3O00024O001B3O00053O001219000800013O00200500080008000B0012190009000C3O001219000A000D3O000623000B0001000100052O001B3O00074O001B3O00094O001B3O00084O001B3O000A4O001B3O000B4O0003000C000B4O0036000C00014O0011000C6O002F3O00013O00023O00023O00026O00F03F026O00704002264O000E00025O001206000300014O003800045O001206000500013O0004250003002100012O002900076O0003000800024O0029000900014O0029000A00024O0029000B00034O0029000C00044O0003000D6O0003000E00063O00202B000F000600012O003D000C000F4O0030000B3O00022O0029000C00034O0029000D00044O0003000E00014O0038000F00014O002A000F0006000F001026000F0001000F2O0038001000014O002A00100006001000102600100001001000202B0010001000012O003D000D00104O000C000C6O0030000A3O000200203E000A000A00022O00200009000A4O003500073O00010004080003000500012O0029000300054O0003000400024O000F000300044O001100036O002F3O00017O00043O00027O004003053O003A25642B3A2O033O0025642B026O00F03F001C3O0006235O000100012O002E8O0029000100014O0029000200024O0029000300024O000E00046O0029000500034O000300066O0021000700074O003D000500074O001300043O0001002005000400040001001206000500024O0002000300050002001206000400034O003D000200044O003000013O000200263A00010018000100040004323O001800012O000300016O000E00026O000F000100024O001100015O0004323O001B00012O0029000100044O0036000100014O001100016O002F3O00013O00013O00063O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403503O00D9D7CF35F5E18851C3C2CC6BE1B2D316C4C1CE36E3A9C411DFD7DE2BF2F5C411DC8CF42BE398D51BD0D7D437DEF6E91BC68CD42BE39FC2089EF0D837EFABD30D9E928D7CBEEA934C80958B70A8B7D21F03083O007EB1A3BB4586DBA7026O00F03F010F3O00060D3O000D00013O0004323O000D0001001219000100013O001219000200023O0020090002000200032O002900045O001206000500043O001206000600054O003D000400064O000C00026O003000013O00022O00150001000100010004323O000E000100200500013O00062O002F3O00017O00",v17(),...);
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