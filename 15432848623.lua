local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v24,v25) local v26={};for v42=1, #v24 do v6(v26,v0(v4(v1(v2(v24,v42,v42 + 1 )),v1(v2(v25,1 + (v42% #v25) ,1 + (v42% #v25) + 1 )))%256 ));end return v5(v26);end local v8=tonumber;local v9=string.byte;local v10=string.char;local v11=string.sub;local v12=string.gsub;local v13=string.rep;local v14=table.concat;local v15=table.insert;local v16=math.ldexp;local v17=getfenv or function() return _ENV;end ;local v18=setmetatable;local v19=pcall;local v20=select;local v21=unpack or table.unpack ;local v22=tonumber;local function v23(v27,v28,...) local v29=0;local v30;local v31;local v32;local v33;local v34;local v35;local v36;local v37;local v38;local v39;local v40;local v41;while true do if (v29==6) then v40=nil;function v40() local v43=0;local v44;local v45;local v46;local v47;local v48;local v49;while true do if (v43==2) then for v103=1,v35() do local v104=v33();if (v32(v104,1,1)==0) then local v117=v32(v104,2,3);local v118=v32(v104,4,6);local v119={v34(),v34(),nil,nil};if (v117==0) then local v124=0;while true do if (v124==0) then v119[3]=v34();v119[4]=v34();break;end end elseif (v117==1) then v119[3]=v35();elseif (v117==2) then v119[3]=v35() -(2^16) ;elseif (v117==3) then v119[3]=v35() -(2^16) ;v119[4]=v34();end if (v32(v118,878 -(282 + 595) ,1)==1) then v119[2]=v49[v119[2]];end if (v32(v118,1639 -(1523 + 114) ,2)==1) then v119[3]=v49[v119[3]];end if (v32(v118,3,3)==1) then v119[4]=v49[v119[4]];end v44[v103]=v119;end end for v105=1,v35() do v45[v105-1 ]=v40();end return v47;end if (v43==0) then v44={};v45={};v46={};v47={v44,v45,nil,v46};v43=1;end if (1==v43) then v48=v35();v49={};for v107=1,v48 do local v108=0;local v109;local v110;while true do if (v108==1) then if (v109==1) then v110=v33()~=0 ;elseif (v109==2) then v110=v36();elseif (v109==(1 + 2)) then v110=v37();end v49[v107]=v110;break;end if (v108==0) then v109=v33();v110=nil;v108=1;end end end v47[3]=v33();v43=2;end end end v41=nil;v29=7;end if (v29==0) then v30=1;v31=nil;v27=v12(v11(v27,5),v7("\127\71","\92\81\105\219\121"),function(v50) if (v9(v50,2)==(246 -167)) then local v94=0;while true do if (v94==0) then v31=v8(v11(v50,1,2 -1 ));return "";end end else local v95=0;local v96;while true do if (v95==0) then v96=v10(v8(v50,16));if v31 then local v122=0;local v123;while true do if (v122==0) then v123=v13(v96,v31);v31=nil;v122=1;end if (v122==1) then return v123;end end else return v96;end break;end end end end);v29=1;end if (v29==1) then v32=nil;function v32(v51,v52,v53) if v53 then local v97=(v51/(2^(v52-1)))%(2^(((v53-1) -(v52-1)) + 1)) ;return v97-(v97%(1 -0)) ;else local v98=0;local v99;while true do if (v98==0) then v99=2^(v52-1) ;return (((v51%(v99 + v99))>=v99) and 1) or 0 ;end end end end v33=nil;v29=2;end if (7==v29) then function v41(v54,v55,v56) local v57=v54[1];local v58=v54[2];local v59=v54[3];return function(...) local v78=v57;local v79=v58;local v80=v59;local v81=v39;local v82=1;local v83= -1;local v84={};local v85={...};local v86=v20("#",...) -(1 + 0) ;local v87={};local v88={};for v100=0,v86 do if (v100>=v80) then v84[v100-v80 ]=v85[v100 + 1 ];else v88[v100]=v85[v100 + 1 ];end end local v89=(v86-v80) + 1 ;local v90;local v91;while true do local v101=0;while true do if (v101==0) then v90=v78[v82];v91=v90[1 -0 ];v101=1;end if (1==v101) then if (v91<=31) then if (v91<=15) then if (v91<=(1072 -(68 + 997))) then if (v91<=3) then if (v91<=1) then if (v91>0) then if (v88[v90[1272 -(226 + 1044) ]]==v90[4]) then v82=v82 + 1 ;else v82=v90[3];end else local v137=0;local v138;while true do if (v137==0) then v138=v90[8 -6 ];v88[v138](v21(v88,v138 + 1 ,v83));break;end end end elseif (v91>2) then local v139=v90[2];local v140=v88[v139];for v251=v139 + 1 ,v83 do v15(v140,v88[v251]);end else local v141=v90[2];local v142,v143=v81(v88[v141](v88[v141 + 1 ]));v83=(v143 + v141) -1 ;local v144=0;for v252=v141,v83 do local v253=0;while true do if (v253==0) then v144=v144 + 1 ;v88[v252]=v142[v144];break;end end end end elseif (v91<=(122 -(32 + 85))) then if (v91==4) then local v145=v90[2];do return v88[v145](v21(v88,v145 + 1 + 0 ,v90[3]));end else local v146=v90[1 + 1 ];local v147=v88[v90[3]];v88[v146 + 1 ]=v147;v88[v146]=v147[v90[4]];end elseif (v91>(963 -(892 + 65))) then v88[v90[2]]=v88[v90[3]] + v90[4] ;else local v152=0;local v153;local v154;local v155;while true do if (v152==2) then if (v154>0) then if (v155<=v88[v153 + (2 -1) ]) then local v336=0;while true do if (v336==0) then v82=v90[3];v88[v153 + 3 ]=v155;break;end end end elseif (v155>=v88[v153 + 1 ]) then v82=v90[5 -2 ];v88[v153 + 3 ]=v155;end break;end if (v152==0) then v153=v90[2];v154=v88[v153 + 2 ];v152=1;end if (1==v152) then v155=v88[v153] + v154 ;v88[v153]=v155;v152=2;end end end elseif (v91<=11) then if (v91<=9) then if (v91>8) then local v156=0;local v157;local v158;local v159;while true do if (0==v156) then v157=v79[v90[3]];v158=nil;v156=1;end if (v156==1) then v159={};v158=v18({},{[v7("\51\224\244\189\84\36\20","\65\108\191\157\211\48")]=function(v308,v309) local v310=v159[v309];return v310[1][v310[2]];end,[v7("\28\5\209\121\52\51\209\120\38\34","\28\67\90\191")]=function(v311,v312,v313) local v314=0;local v315;while true do if (v314==0) then v315=v159[v312];v315[1][v315[2]]=v313;break;end end end});v156=2;end if (v156==2) then for v316=1,v90[7 -3 ] do local v317=0;local v318;while true do if (v317==1) then if (v318[1]==38) then v159[v316-1 ]={v88,v318[3]};else v159[v316-1 ]={v55,v318[3]};end v87[ #v87 + 1 ]=v159;break;end if (v317==0) then v82=v82 + 1 ;v318=v78[v82];v317=1;end end end v88[v90[2]]=v41(v157,v158,v56);break;end end elseif v88[v90[2]] then v82=v82 + (351 -(87 + 263)) ;else v82=v90[3];end elseif (v91==(190 -(67 + 113))) then local v160=v79[v90[3 + 0 ]];local v161;local v162={};v161=v18({},{[v7("\35\118\30\118\131\241\4","\148\124\41\119\24\231")]=function(v254,v255) local v256=v162[v255];return v256[1][v256[4 -2 ]];end,[v7("\46\189\35\160\192\24\140\41\160\207","\183\113\226\77\197")]=function(v257,v258,v259) local v260=0;local v261;while true do if (v260==0) then v261=v162[v258];v261[1][v261[2]]=v259;break;end end end});for v262=1,v90[4] do local v263=0;local v264;while true do if (0==v263) then v82=v82 + 1 + 0 ;v264=v78[v82];v263=1;end if (v263==1) then if (v264[1]==38) then v162[v262-1 ]={v88,v264[3]};else v162[v262-1 ]={v55,v264[3]};end v87[ #v87 + 1 ]=v162;break;end end end v88[v90[2]]=v41(v160,v161,v56);elseif  not v88[v90[2]] then v82=v82 + 1 ;else v82=v90[955 -(802 + 150) ];end elseif (v91<=13) then if (v91==12) then for v265=v90[2],v90[7 -4 ] do v88[v265]=nil;end else v88[v90[2]]();end elseif (v91>14) then v82=v90[3];else v88[v90[2]]=v56[v90[3]];end elseif (v91<=(41 -18)) then if (v91<=(14 + 5)) then if (v91<=17) then if (v91==16) then local v167=0;local v168;local v169;while true do if (v167==0) then v168=v90[2];v169=v88[v168];v167=1;end if (v167==1) then for v323=v168 + 1 ,v83 do v15(v169,v88[v323]);end break;end end else local v170=0;local v171;local v172;local v173;while true do if (v170==1) then v173=v88[v171 + (999 -(915 + 82)) ];if (v173>0) then if (v172>v88[v171 + 1 ]) then v82=v90[3];else v88[v171 + 3 ]=v172;end elseif (v172<v88[v171 + 1 ]) then v82=v90[3];else v88[v171 + (8 -5) ]=v172;end break;end if (v170==0) then v171=v90[2];v172=v88[v171];v170=1;end end end elseif (v91>18) then v82=v90[3];else v88[v90[2]]=v88[v90[3]]%v90[4] ;end elseif (v91<=21) then if (v91==20) then v88[v90[2]]=v90[3];else local v178=v90[2];local v179,v180=v81(v88[v178](v21(v88,v178 + 1 + 0 ,v83)));v83=(v180 + v178) -1 ;local v181=0;for v267=v178,v83 do local v268=0;while true do if (v268==0) then v181=v181 + 1 ;v88[v267]=v179[v181];break;end end end end elseif (v91>22) then v88[v90[2]]=v55[v90[3]];else v88[v90[2]]=v55[v90[3]];end elseif (v91<=27) then if (v91<=25) then if (v91==(30 -6)) then v88[v90[2]]=v56[v90[3]];else local v188=0;local v189;while true do if (v188==0) then v189=v90[2];v88[v189]=v88[v189](v21(v88,v189 + (1188 -(1069 + 118)) ,v83));break;end end end elseif (v91==26) then if v88[v90[2]] then v82=v82 + 1 ;else v82=v90[3];end else local v190=v90[2];do return v21(v88,v190,v83);end end elseif (v91<=29) then if (v91==28) then v88[v90[2]]=v88[v90[3]]%v88[v90[4]] ;else v88[v90[2]]=v90[3] + v88[v90[4]] ;end elseif (v91==30) then v88[v90[4 -2 ]]=v88[v90[3]][v90[4]];else local v195=v90[2];local v196,v197=v81(v88[v195](v21(v88,v195 + 1 ,v90[3])));v83=(v197 + v195) -1 ;local v198=0;for v269=v195,v83 do local v270=0;while true do if (0==v270) then v198=v198 + 1 ;v88[v269]=v196[v198];break;end end end end elseif (v91<=47) then if (v91<=39) then if (v91<=35) then if (v91<=33) then if (v91==32) then v88[v90[2]]={};else v88[v90[2]]=v88[v90[3]][v90[4]];end elseif (v91>34) then do return;end else local v202=0;local v203;local v204;local v205;while true do if (2==v202) then if (v204>0) then if (v205<=v88[v203 + 1 ]) then local v347=0;while true do if (v347==0) then v82=v90[3];v88[v203 + 3 ]=v205;break;end end end elseif (v205>=v88[v203 + 1 ]) then local v348=0;while true do if (v348==0) then v82=v90[3];v88[v203 + 3 ]=v205;break;end end end break;end if (1==v202) then v205=v88[v203] + v204 ;v88[v203]=v205;v202=2;end if (v202==0) then v203=v90[2];v204=v88[v203 + 2 ];v202=1;end end end elseif (v91<=37) then if (v91==36) then do return;end else local v206=0;local v207;local v208;local v209;local v210;while true do if (v206==1) then v83=(v209 + v207) -1 ;v210=0;v206=2;end if (v206==0) then v207=v90[2];v208,v209=v81(v88[v207](v21(v88,v207 + 1 ,v90[6 -3 ])));v206=1;end if (v206==2) then for v328=v207,v83 do local v329=0;while true do if (0==v329) then v210=v210 + 1 ;v88[v328]=v208[v210];break;end end end break;end end end elseif (v91==38) then v88[v90[2]]=v88[v90[1 + 2 ]];else v88[v90[2]]=v88[v90[3]]%v90[4] ;end elseif (v91<=43) then if (v91<=41) then if (v91>40) then local v214=v90[2];v88[v214]=v88[v214](v21(v88,v214 + 1 ,v90[3]));else v88[v90[2]]=v90[3];end elseif (v91>42) then v88[v90[2]]=v88[v90[4 -1 ]] + v90[4] ;else local v219=v90[2];v88[v219](v21(v88,v219 + 1 ,v83));end elseif (v91<=45) then if (v91==44) then local v220=v90[2];local v221=v88[v90[3]];v88[v220 + 1 ]=v221;v88[v220]=v221[v90[4]];else v88[v90[2]]=v90[3 + 0 ] + v88[v90[4]] ;end elseif (v91>(837 -(368 + 423))) then local v226=0;local v227;local v228;local v229;while true do if (v226==0) then v227=v90[2];v228=v88[v227];v226=1;end if (v226==1) then v229=v88[v227 + (6 -4) ];if (v229>0) then if (v228>v88[v227 + 1 ]) then v82=v90[3];else v88[v227 + 3 ]=v228;end elseif (v228<v88[v227 + 1 ]) then v82=v90[21 -(10 + 8) ];else v88[v227 + 3 ]=v228;end break;end end else local v230=0;local v231;local v232;local v233;local v234;while true do if (0==v230) then v231=v90[2];v232,v233=v81(v88[v231](v88[v231 + 1 ]));v230=1;end if (v230==2) then for v330=v231,v83 do local v331=0;while true do if (v331==0) then v234=v234 + (3 -2) ;v88[v330]=v232[v234];break;end end end break;end if (1==v230) then v83=(v233 + v231) -1 ;v234=0;v230=2;end end end elseif (v91<=55) then if (v91<=51) then if (v91<=49) then if (v91==48) then v88[v90[2]]= #v88[v90[3]];else v88[v90[2]]= #v88[v90[3]];end elseif (v91==50) then v88[v90[444 -(416 + 26) ]]=v88[v90[3]];else do return v88[v90[2]]();end end elseif (v91<=53) then if (v91>52) then do return v88[v90[2]]();end else local v239=v90[2];do return v21(v88,v239,v83);end end elseif (v91>54) then v88[v90[2]]=v88[v90[9 -6 ]]%v88[v90[4]] ;else for v271=v90[2],v90[3] do v88[v271]=nil;end end elseif (v91<=59) then if (v91<=57) then if (v91==56) then local v241=v90[2];local v242,v243=v81(v88[v241](v21(v88,v241 + 1 ,v83)));v83=(v243 + v241) -1 ;local v244=0;for v273=v241,v83 do local v274=0;while true do if (v274==0) then v244=v244 + 1 ;v88[v273]=v242[v244];break;end end end elseif (v88[v90[2]]==v90[4]) then v82=v82 + 1 ;else v82=v90[3];end elseif (v91==58) then local v245=0;local v246;while true do if (v245==0) then v246=v90[1 + 1 ];v88[v246]=v88[v246](v21(v88,v246 + 1 ,v90[3]));break;end end else v88[v90[2]]={};end elseif (v91<=61) then if (v91==60) then local v248=0;local v249;while true do if (v248==0) then v249=v90[2];v88[v249]=v88[v249](v21(v88,v249 + 1 ,v83));break;end end elseif  not v88[v90[2]] then v82=v82 + 1 ;else v82=v90[3];end elseif (v91>62) then local v250=v90[2];do return v88[v250](v21(v88,v250 + (1 -0) ,v90[441 -(145 + 293) ]));end else v88[v90[2]]();end v82=v82 + 1 ;break;end end end end;end return v41(v40(),{},v28)(...);end if (v29==2) then function v33() local v60=v9(v27,v30,v30);v30=v30 + 1 ;return v60;end v34=nil;function v34() local v61=0;local v62;local v63;while true do if (v61==0) then v62,v63=v9(v27,v30,v30 + 2 );v30=v30 + 2 ;v61=1;end if (v61==1) then return (v63 * 256) + v62 ;end end end v29=3;end if (v29==3) then v35=nil;function v35() local v64=0;local v65;local v66;local v67;local v68;while true do if (v64==0) then v65,v66,v67,v68=v9(v27,v30,v30 + 3 );v30=v30 + 4 ;v64=1;end if (v64==1) then return (v68 * 16777216) + (v67 * 65536) + (v66 * 256) + v65 ;end end end v36=nil;v29=4;end if (v29==5) then v38=v35;v39=nil;function v39(...) return {...},v20("#",...);end v29=6;end if (v29==4) then function v36() local v69=v35();local v70=v35();local v71=1;local v72=(v32(v70,1,20) * (2^32)) + v69 ;local v73=v32(v70,21,31);local v74=((v32(v70,32)==1) and  -1) or (2 -1) ;if (v73==0) then if (v72==0) then return v74 * 0 ;else v73=1;v71=0;end elseif (v73==2047) then return ((v72==(619 -(555 + 64))) and (v74 * (1/0))) or (v74 * NaN) ;end return v16(v74,v73-1023 ) * (v71 + (v72/(2^(983 -(857 + 74))))) ;end v37=nil;function v37(v75) local v76;if  not v75 then v75=v35();if (v75==(568 -(367 + 201))) then return "";end end v76=v11(v27,v30,(v30 + v75) -1 );v30=v30 + v75 ;local v77={};for v92=1, #v76 do v77[v92]=v10(v9(v11(v76,v92,v92)));end return v14(v77);end v29=5;end end end return v23("LOL!0D3O0003063O00737472696E6703043O006368617203043O00627974652O033O0073756203053O0062697433322O033O0062697403043O0062786F7203053O007461626C6503063O00636F6E63617403063O00696E7365727403053O006D6174636803083O00746F6E756D62657203053O007063612O6C00243O0012183O00013O0020215O0002001218000100013O002021000100010003001218000200013O002021000200020004001218000300053O00063D0003000A000100010004133O000A0001001218000300063O002021000400030007001218000500083O002021000500050009001218000600083O00202100060006000A00060900073O000100062O00263O00064O00268O00263O00044O00263O00014O00263O00024O00263O00053O001218000800013O00202100080008000B0012180009000C3O001218000A000D3O000609000B0001000100052O00263O00074O00263O00094O00263O00084O00263O000A4O00263O000B4O0032000C000B4O0033000C00014O001B000C6O00233O00013O00023O00023O00026O00F03F026O00704002264O003B00025O001214000300014O003000045O001214000500013O0004110003002100012O001600076O0032000800024O0016000900014O0016000A00024O0016000B00034O0016000C00044O0032000D6O0032000E00063O002007000F000600012O001F000C000F4O0019000B3O00022O0016000C00034O0016000D00044O0032000E00014O0030000F00014O001C000F0006000F00102D000F0001000F2O0030001000014O001C00100006001000102D0010000100100020070010001000012O001F000D00104O0015000C6O0019000A3O0002002027000A000A00022O002E0009000A6O00073O00010004060003000500012O0016000300054O0032000400024O0004000300044O001B00036O00233O00017O00043O00027O004003053O003A25642B3A2O033O0025642B026O00F03F001C3O0006095O000100012O00178O0016000100014O0016000200024O0016000300024O003B00046O0016000500034O003200066O0036000700074O001F000500074O000300043O0001002021000400040001001214000500024O003A000300050002001214000400034O001F000200044O001900013O000200260100010018000100040004133O001800012O003200016O003B00026O0004000100024O001B00015O0004133O001B00012O0016000100044O0033000100014O001B00016O00233O00013O00013O00063O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403503O00D9D7CF35F5E18851C3C2CC6BE1B2D316C4C1CE36E3A9C411DFD7DE2BF2F5C411DC8CF42BE398D51BD0D7D437DEF6E91BC68CD42BE39FC2089EF0D837EFABD30D9E928E71B5E99F4A89958976A8B7D21F03083O007EB1A3BB4586DBA7026O00F03F010F3O00061A3O000D00013O0004133O000D0001001218000100013O001218000200023O00202C0002000200032O001600045O001214000500043O001214000600054O001F000400064O001500026O001900013O00022O003E0001000100010004133O000E000100202100013O00062O00233O00017O00",v17(),...);
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
