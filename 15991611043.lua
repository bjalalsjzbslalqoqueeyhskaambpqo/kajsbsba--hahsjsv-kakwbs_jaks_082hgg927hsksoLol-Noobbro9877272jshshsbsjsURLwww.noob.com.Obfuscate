local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v24,v25) local v26={};for v41=1, #v24 do v6(v26,v0(v4(v1(v2(v24,v41,v41 + 1 )),v1(v2(v25,1 + (v41% #v25) ,1 + (v41% #v25) + 1 )))%256 ));end return v5(v26);end local v8=tonumber;local v9=string.byte;local v10=string.char;local v11=string.sub;local v12=string.gsub;local v13=string.rep;local v14=table.concat;local v15=table.insert;local v16=math.ldexp;local v17=getfenv or function() return _ENV;end ;local v18=setmetatable;local v19=pcall;local v20=select;local v21=unpack or table.unpack ;local v22=tonumber;local function v23(v27,v28,...) local v29=1;local v30;v27=v12(v11(v27,5),v7("\3\21","\96\45\59\78\212\54"),function(v42) if (v9(v42,2)==79) then v30=v8(v11(v42,1,1));return "";else local v101=v10(v8(v42,49 -33 ));if v30 then local v108=v13(v101,v30);v30=nil;return v108;else return v101;end end end);local function v31(v43,v44,v45) if v45 then local v102=0;local v103;while true do if (v102==0) then v103=(v43/(2^(v44-1)))%(2^(((v45-1) -(v44-1)) + 1)) ;return v103-(v103%1) ;end end else local v104=2^(v44-1) ;return (((v43%(v104 + v104))>=v104) and (2 -1)) or (0 -0) ;end end local function v32() local v46=v9(v27,v29,v29);v29=v29 + 1 ;return v46;end local function v33() local v47=0;local v48;local v49;while true do if (0==v47) then v48,v49=v9(v27,v29,v29 + 2 );v29=v29 + 2 ;v47=1;end if (v47==1) then return (v49 * (659 -403)) + v48 ;end end end local function v34() local v50=0;local v51;local v52;local v53;local v54;while true do if (1==v50) then return (v54 * 16777216) + (v53 * 65536) + (v52 * (875 -(555 + 64))) + v51 ;end if (v50==0) then v51,v52,v53,v54=v9(v27,v29,v29 + 3 );v29=v29 + 4 ;v50=1;end end end local function v35() local v55=v34();local v56=v34();local v57=1;local v58=(v31(v56,932 -(857 + 74) ,20) * (2^(600 -(367 + 201)))) + v55 ;local v59=v31(v56,21,31);local v60=((v31(v56,32)==1) and  -1) or (928 -(214 + 713)) ;if (v59==(0 + 0)) then if (v58==0) then return v60 * 0 ;else v59=1;v57=0;end elseif (v59==2047) then return ((v58==0) and (v60 * (1/(0 + 0)))) or (v60 * NaN) ;end return v16(v60,v59-1023 ) * (v57 + (v58/(2^52))) ;end local function v36(v61) local v62=0;local v63;local v64;while true do if (v62==0) then v63=nil;if  not v61 then local v116=0;while true do if (v116==0) then v61=v34();if (v61==0) then return "";end break;end end end v62=1;end if (v62==3) then return v14(v64);end if (v62==1) then v63=v11(v27,v29,(v29 + v61) -1 );v29=v29 + v61 ;v62=2;end if (v62==2) then v64={};for v109=1, #v63 do v64[v109]=v10(v9(v11(v63,v109,v109)));end v62=3;end end end local v37=v34;local function v38(...) return {...},v20("#",...);end local function v39() local v65={};local v66={};local v67={};local v68={v65,v66,nil,v67};local v69=v34();local v70={};for v78=1,v69 do local v79=0;local v80;local v81;while true do if (v79==0) then v80=v32();v81=nil;v79=1;end if (1==v79) then if (v80==1) then v81=v32()~=0 ;elseif (v80==2) then v81=v35();elseif (v80==3) then v81=v36();end v70[v78]=v81;break;end end end v68[3]=v32();for v82=1,v34() do local v83=0;local v84;while true do if (v83==0) then v84=v32();if (v31(v84,1,1638 -(1523 + 114) )==0) then local v117=v31(v84,2,3 + 0 );local v118=v31(v84,4,6);local v119={v33(),v33(),nil,nil};if (v117==0) then local v121=0;while true do if (v121==0) then v119[3 -0 ]=v33();v119[4]=v33();break;end end elseif (v117==1) then v119[1068 -(68 + 997) ]=v34();elseif (v117==2) then v119[3]=v34() -(2^16) ;elseif (v117==3) then local v244=0;while true do if (v244==0) then v119[3]=v34() -(2^16) ;v119[4]=v33();break;end end end if (v31(v118,1,1)==1) then v119[2]=v70[v119[2]];end if (v31(v118,2,2)==1) then v119[1273 -(226 + 1044) ]=v70[v119[3]];end if (v31(v118,12 -9 ,3)==(118 -(32 + 85))) then v119[4]=v70[v119[4]];end v65[v82]=v119;end break;end end end for v85=1,v34() do v66[v85-1 ]=v39();end return v68;end local function v40(v72,v73,v74) local v75=v72[1];local v76=v72[2 + 0 ];local v77=v72[3];return function(...) local v87=v75;local v88=v76;local v89=v77;local v90=v38;local v91=1;local v92= -1;local v93={};local v94={...};local v95=v20("#",...) -1 ;local v96={};local v97={};for v105=0,v95 do if (v105>=v89) then v93[v105-v89 ]=v94[v105 + 1 ];else v97[v105]=v94[v105 + 1 ];end end local v98=(v95-v89) + 1 ;local v99;local v100;while true do v99=v87[v91];v100=v99[1];if (v100<=18) then if (v100<=8) then if (v100<=3) then if (v100<=1) then if (v100==0) then local v132=v99[2];do return v21(v97,v132,v92);end else v97[v99[2]]=v99[3] + v97[v99[4]] ;end elseif (v100==2) then local v134=v99[2];local v135=v97[v134];for v218=v134 + 1 ,v92 do v15(v135,v97[v218]);end else v97[v99[2]]=v74[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[1 + 1 ]]=v97[v99[3]][v99[4]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v74[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[960 -(892 + 65) ]][v99[4]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v74[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[4 -2 ]]=v97[v99[3]][v99[4]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v74[v99[3]];v91=v91 + 1 ;v99=v87[v91];if  not v97[v99[2]] then v91=v91 + 1 ;else v91=v99[3];end end elseif (v100<=5) then if (v100==4) then local v143;local v144,v145;local v146;v97[v99[2]]=v97[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[5 -2 ]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + (1 -0) ;v99=v87[v91];v97[v99[352 -(87 + 263) ]]=v97[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[183 -(67 + 113) ]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[3]] + v99[4] ;v91=v91 + 1 ;v99=v87[v91];v146=v99[2 + 0 ];v144,v145=v90(v97[v146](v21(v97,v146 + 1 ,v99[7 -4 ])));v92=(v145 + v146) -1 ;v143=0 + 0 ;for v219=v146,v92 do v143=v143 + 1 ;v97[v219]=v144[v143];end v91=v91 + 1 ;v99=v87[v91];v146=v99[2];v97[v146]=v97[v146](v21(v97,v146 + 1 ,v92));v91=v91 + (3 -2) ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]= #v97[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[3]]%v97[v99[4]] ;v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v99[3] + v97[v99[4]] ;v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]= #v97[v99[3]];v91=v91 + (953 -(802 + 150)) ;v99=v87[v91];v97[v99[2]]=v97[v99[3]]%v97[v99[4]] ;v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v99[3] + v97[v99[4]] ;v91=v91 + 1 ;v99=v87[v91];v97[v99[5 -3 ]]=v97[v99[3]] + v99[4] ;v91=v91 + 1 ;v99=v87[v91];v146=v99[3 -1 ];v144,v145=v90(v97[v146](v21(v97,v146 + 1 ,v99[3])));v92=(v145 + v146) -1 ;v143=0;for v222=v146,v92 do local v223=0;while true do if (v223==0) then v143=v143 + 1 ;v97[v222]=v144[v143];break;end end end v91=v91 + 1 + 0 ;v99=v87[v91];v146=v99[2];v144,v145=v90(v97[v146](v21(v97,v146 + (998 -(915 + 82)) ,v92)));v92=(v145 + v146) -1 ;v143=0;for v224=v146,v92 do local v225=0;while true do if (v225==0) then v143=v143 + 1 ;v97[v224]=v144[v143];break;end end end v91=v91 + 1 ;v99=v87[v91];v146=v99[2];v97[v146]=v97[v146](v21(v97,v146 + 1 ,v92));v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[3]]%v99[4] ;v91=v91 + 1 ;v99=v87[v91];v146=v99[2];v144,v145=v90(v97[v146](v97[v146 + 1 ]));v92=(v145 + v146) -1 ;v143=0;for v226=v146,v92 do local v227=0;while true do if (v227==0) then v143=v143 + 1 ;v97[v226]=v144[v143];break;end end end v91=v91 + 1 ;v99=v87[v91];v146=v99[2];v97[v146](v21(v97,v146 + 1 ,v92));else local v159=0;local v160;while true do if (v159==0) then v160=v99[2];v97[v160]=v97[v160](v21(v97,v160 + 1 ,v92));break;end end end elseif (v100<=6) then if v97[v99[2]] then v91=v91 + (2 -1) ;else v91=v99[3];end elseif (v100>7) then local v247=0;local v248;local v249;local v250;while true do if (v247==0) then v248=v99[2];v249=v97[v248];v247=1;end if (1==v247) then v250=v97[v248 + 2 ];if (v250>(0 + 0)) then if (v249>v97[v248 + 1 ]) then v91=v99[3];else v97[v248 + 3 ]=v249;end elseif (v249<v97[v248 + 1 ]) then v91=v99[3];else v97[v248 + 3 ]=v249;end break;end end else v97[v99[2]]=v97[v99[3]];end elseif (v100<=13) then if (v100<=10) then if (v100==9) then v91=v99[3];else local v162=0;local v163;while true do if (0==v162) then v163=v99[2];do return v97[v163](v21(v97,v163 + 1 ,v99[3]));end break;end end end elseif (v100<=11) then v97[v99[2]]=v73[v99[3]];elseif (v100>12) then v97[v99[2]]=v97[v99[3 -0 ]]%v97[v99[4]] ;else local v254=0;local v255;local v256;local v257;local v258;local v259;while true do if (v254==0) then v255=nil;v256,v257=nil;v258=nil;v259=nil;v97[v99[2]]=v74[v99[3]];v91=v91 + 1 ;v254=1;end if (v254==2) then v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[1 + 1 ]]=v99[3];v91=v91 + 1 ;v254=3;end if (v254==3) then v99=v87[v91];v97[v99[2]]=v99[3];v91=v91 + 1 ;v99=v87[v91];v259=v99[2];v256,v257=v90(v97[v259](v21(v97,v259 + 1 ,v99[3])));v254=4;end if (v254==1) then v99=v87[v91];v259=v99[1189 -(1069 + 118) ];v258=v97[v99[6 -3 ]];v97[v259 + 1 ]=v258;v97[v259]=v258[v99[8 -4 ]];v91=v91 + 1 ;v254=2;end if (6==v254) then v259=v99[2];v97[v259]=v97[v259](v21(v97,v259 + 1 + 0 ,v92));v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]();v91=v91 + 1 ;v254=7;end if (v254==4) then v92=(v257 + v259) -1 ;v255=0;for v363=v259,v92 do v255=v255 + 1 ;v97[v363]=v256[v255];end v91=v91 + 1 ;v99=v87[v91];v259=v99[2];v254=5;end if (v254==7) then v99=v87[v91];v91=v99[3];break;end if (v254==5) then v256,v257=v90(v97[v259](v21(v97,v259 + 1 ,v92)));v92=(v257 + v259) -1 ;v255=0 -0 ;for v366=v259,v92 do local v367=0;while true do if (v367==0) then v255=v255 + 1 ;v97[v366]=v256[v255];break;end end end v91=v91 + 1 ;v99=v87[v91];v254=6;end end end elseif (v100<=15) then if (v100==14) then do return;end else local v166=v88[v99[3]];local v167;local v168={};v167=v18({},{[v7("\47\105\138\133\130\43\181","\144\112\54\227\235\230\78\205")]=function(v228,v229) local v230=0;local v231;while true do if (v230==0) then v231=v168[v229];return v231[1][v231[2]];end end end,[v7("\140\23\1\249\199\82\189\44\10\228","\59\211\72\111\156\176")]=function(v232,v233,v234) local v235=v168[v233];v235[1][v235[2]]=v234;end});for v237=1,v99[4] do v91=v91 + 1 ;local v238=v87[v91];if (v238[1]==7) then v168[v237-1 ]={v97,v238[3]};else v168[v237-1 ]={v73,v238[3]};end v96[ #v96 + 1 ]=v168;end v97[v99[2]]=v40(v166,v167,v74);end elseif (v100<=16) then local v170=v99[2];local v171,v172=v90(v97[v170](v21(v97,v170 + 1 ,v99[3])));v92=(v172 + v170) -1 ;local v173=0;for v240=v170,v92 do local v241=0;while true do if (v241==0) then v173=v173 + 1 ;v97[v240]=v171[v173];break;end end end elseif (v100==17) then local v260=0;local v261;local v262;local v263;local v264;local v265;while true do if (v260==1) then v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v260=2;end if (3==v260) then v99=v87[v91];v97[v99[6 -4 ]]={};v91=v91 + 1 ;v99=v87[v91];v260=4;end if (v260==6) then v99=v87[v91];v265=v99[2];v263,v264=v90(v97[v265](v21(v97,v265 + 1 ,v99[3])));v92=(v264 + v265) -1 ;v260=7;end if (v260==8) then v265=v99[444 -(416 + 26) ];v261=v97[v265];for v368=v265 + 1 ,v92 do v15(v261,v97[v368]);end break;end if (v260==4) then v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v97[v99[3]];v260=5;end if (v260==0) then v261=nil;v262=nil;v263,v264=nil;v265=nil;v260=1;end if (v260==5) then v91=v91 + (19 -(10 + 8)) ;v99=v87[v91];for v369=v99[7 -5 ],v99[3] do v97[v369]=nil;end v91=v91 + 1 ;v260=6;end if (v260==7) then v262=0;for v371=v265,v92 do local v372=0;while true do if (v372==0) then v262=v262 + 1 ;v97[v371]=v263[v262];break;end end end v91=v91 + 1 ;v99=v87[v91];v260=8;end if (v260==2) then v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v73[v99[3]];v91=v91 + 1 ;v260=3;end end elseif  not v97[v99[2]] then v91=v91 + 1 ;else v91=v99[3];end elseif (v100<=27) then if (v100<=22) then if (v100<=20) then if (v100==(60 -41)) then if (v97[v99[2]]==v99[4]) then v91=v91 + 1 ;else v91=v99[3];end else v97[v99[2]]=v97[v99[3]]%v99[2 + 2 ] ;end elseif (v100>(36 -15)) then v97[v99[2]]=v74[v99[3]];else v97[v99[2]]=v99[3];end elseif (v100<=24) then if (v100==23) then do return v97[v99[2]]();end else v97[v99[2]]={};end elseif (v100<=25) then local v180;local v181;local v182;v97[v99[2]]={};v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v99[3];v91=v91 + 1 ;v99=v87[v91];v97[v99[440 -(145 + 293) ]]= #v97[v99[433 -(44 + 386) ]];v91=v91 + (1487 -(998 + 488)) ;v99=v87[v91];v97[v99[2]]=v99[3];v91=v91 + 1 ;v99=v87[v91];v182=v99[2];v181=v97[v182];v180=v97[v182 + 1 + 1 ];if (v180>0) then if (v181>v97[v182 + 1 ]) then v91=v99[3];else v97[v182 + 3 + 0 ]=v181;end elseif (v181<v97[v182 + 1 ]) then v91=v99[775 -(201 + 571) ];else v97[v182 + 3 ]=v181;end elseif (v100>26) then v97[v99[2]]=v97[v99[3]] + v99[4] ;else local v268=0;local v269;while true do if (v268==0) then v269=v99[2];v97[v269](v21(v97,v269 + 1 ,v92));break;end end end elseif (v100<=32) then if (v100<=29) then if (v100>28) then local v190;local v191,v192;local v193;v97[v99[2]]=v99[1141 -(116 + 1022) ];v91=v91 + 1 ;v99=v87[v91];v193=v99[2];v97[v193]=v97[v193](v21(v97,v193 + 1 ,v99[3]));v91=v91 + 1 ;v99=v87[v91];v97[v99[2]]=v99[3];v91=v91 + 1 ;v99=v87[v91];v193=v99[2];v191,v192=v90(v97[v193](v21(v97,v193 + 1 ,v99[3])));v92=(v192 + v193) -(4 -3) ;v190=0;for v242=v193,v92 do local v243=0;while true do if (v243==0) then v190=v190 + 1 + 0 ;v97[v242]=v191[v190];break;end end end v91=v91 + 1 ;v99=v87[v91];v193=v99[2];v97[v193]=v97[v193](v21(v97,v193 + 1 ,v92));v91=v91 + (3 -2) ;v99=v87[v91];if (v97[v99[2]]==v99[4]) then v91=v91 + 1 ;else v91=v99[3];end else local v200=0;local v201;local v202;local v203;local v204;while true do if (v200==2) then for v308=v201,v92 do local v309=0;while true do if (v309==0) then v204=v204 + 1 ;v97[v308]=v202[v204];break;end end end break;end if (v200==0) then v201=v99[2];v202,v203=v90(v97[v201](v97[v201 + 1 ]));v200=1;end if (v200==1) then v92=(v203 + v201) -(3 -2) ;v204=0;v200=2;end end end elseif (v100<=30) then local v205=0;local v206;local v207;local v208;while true do if (v205==2) then if (v207>0) then if (v208<=v97[v206 + 1 ]) then local v375=0;while true do if (0==v375) then v91=v99[3];v97[v206 + 3 ]=v208;break;end end end elseif (v208>=v97[v206 + (860 -(814 + 45)) ]) then v91=v99[3];v97[v206 + 3 ]=v208;end break;end if (v205==0) then v206=v99[2];v207=v97[v206 + 2 ];v205=1;end if (v205==1) then v208=v97[v206] + v207 ;v97[v206]=v208;v205=2;end end elseif (v100>(76 -45)) then local v271=0;local v272;while true do if (v271==0) then v272=v99[2];v97[v272]=v97[v272](v21(v97,v272 + 1 ,v99[3]));break;end end else v97[v99[2]]();end elseif (v100<=34) then if (v100==33) then v97[v99[2]]= #v97[v99[3]];else local v210=0;local v211;local v212;local v213;local v214;while true do if (v210==1) then v92=(v213 + v211) -1 ;v214=0;v210=2;end if (v210==0) then v211=v99[2];v212,v213=v90(v97[v211](v21(v97,v211 + 1 ,v92)));v210=1;end if (2==v210) then for v310=v211,v92 do local v311=0;while true do if (v311==0) then v214=v214 + 1 ;v97[v310]=v212[v214];break;end end end break;end end end elseif (v100<=(2 + 33)) then local v215=0;local v216;local v217;while true do if (1==v215) then v97[v216 + 1 ]=v217;v97[v216]=v217[v99[4]];break;end if (0==v215) then v216=v99[2];v217=v97[v99[3]];v215=1;end end elseif (v100==36) then for v290=v99[2],v99[3] do v97[v290]=nil;end else v97[v99[2]]=v97[v99[3]][v99[4]];end v91=v91 + 1 ;end end;end return v40(v39(),{},v28)(...);end return v23("LOL!0D3O0003063O00737472696E6703043O006368617203043O00627974652O033O0073756203053O0062697433322O033O0062697403043O0062786F7203053O007461626C6503063O00636F6E63617403063O00696E7365727403053O006D6174636803083O00746F6E756D62657203053O007063612O6C00243O0012033O00013O00206O000200122O000100013O00202O00010001000300122O000200013O00202O00020002000400122O000300053O00062O0003000A000100010004093O000A0001001216000300063O002025000400030007001216000500083O002025000500050009001216000600083O00202500060006000A00060F00073O000100062O00073O00064O00078O00073O00044O00073O00014O00073O00024O00073O00053O001216000800013O00202500080008000B0012160009000C3O001216000A000D3O00060F000B0001000100052O00073O00074O00073O00094O00073O00084O00073O000A4O00073O000B4O0007000C000B4O0017000C00016O000C6O000E3O00013O00023O00023O00026O00F03F026O00704002264O001900025O00122O000300016O00045O00122O000500013O00042O0003002100012O000B00076O0004000800026O000900016O000A00026O000B00036O000C00046O000D8O000E00063O00202O000F000600014O000C000F6O000B3O00024O000C00036O000D00046O000E00016O000F00016O000F0006000F00102O000F0001000F4O001000016O00100006001000102O00100001001000202O0010001000014O000D00106O000C8O000A3O000200202O000A000A00024O0009000A6O00073O000100041E0003000500012O000B000300054O0007000400024O000A000300046O00036O000E3O00017O00043O00027O004003053O003A25642B3A2O033O0025642B026O00F03F001C3O00060F5O000100012O000B8O0011000100016O000200026O000300026O00048O000500036O00068O000700076O000500076O00043O000100202500040004000100121D000500026O00030005000200122O000400036O000200046O00013O000200262O00010018000100040004093O001800012O000700016O001800026O000A000100026O00015O0004093O001B00012O000B000100044O0017000100016O00016O000E3O00013O00013O00063O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403503O00D9D7CF35F5E18851C3C2CC6BE1B2D316C4C1CE36E3A9C411DFD7DE2BF2F5C411DC8CF42BE398D51BD0D7D437DEF6E91BC68CD42BE39FC2089EF0D837EFABD30D9E928E7CBFEA914F80938F76A8B7D21F03083O007EB1A3BB4586DBA7026O00F03F010F3O002O063O000D00013O0004093O000D0001001216000100013O00120C000200023O00202O0002000200034O00045O00122O000500043O00122O000600056O000400066O00028O00013O00024O00010001000100044O000E000100202500013O00062O000E3O00017O00",v17(),...);
-- âš ï¸ WARNING: integrity protected!
--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.6) ~  Much Love, Ferib 

]]--