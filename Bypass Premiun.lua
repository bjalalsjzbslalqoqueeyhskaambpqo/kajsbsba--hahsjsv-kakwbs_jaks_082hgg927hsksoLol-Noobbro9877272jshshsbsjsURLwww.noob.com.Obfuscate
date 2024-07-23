--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.6) ~  Much Love, Ferib 

]]--

local StrToNumber = tonumber;
local Byte = string.byte;
local Char = string.char;
local Sub = string.sub;
local Subg = string.gsub;
local Rep = string.rep;
local Concat = table.concat;
local Insert = table.insert;
local LDExp = math.ldexp;
local GetFEnv = getfenv or function()
	return _ENV;
end;
local Setmetatable = setmetatable;
local PCall = pcall;
local Select = select;
local Unpack = unpack or table.unpack;
local ToNumber = tonumber;
local function VMCall(ByteString, vmenv, ...)
	local DIP = 1;
	local repeatNext;
	ByteString = Subg(Sub(ByteString, 5), "..", function(byte)
		if (Byte(byte, 2) == 79) then
			repeatNext = StrToNumber(Sub(byte, 1, 1));
			return "";
		else
			local a = Char(StrToNumber(byte, 16));
			if repeatNext then
				local FlatIdent_95CAC = 0;
				local b;
				while true do
					if (FlatIdent_95CAC == 1) then
						return b;
					end
					if (FlatIdent_95CAC == 0) then
						b = Rep(a, repeatNext);
						repeatNext = nil;
						FlatIdent_95CAC = 1;
					end
				end
			else
				return a;
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local Res = (Bit / (2 ^ (Start - 1))) % (2 ^ (((End - 1) - (Start - 1)) + 1));
			return Res - (Res % 1);
		else
			local FlatIdent_8D327 = 0;
			local Plc;
			while true do
				if (FlatIdent_8D327 == 0) then
					Plc = 2 ^ (Start - 1);
					return (((Bit % (Plc + Plc)) >= Plc) and 1) or 0;
				end
			end
		end
	end
	local function gBits8()
		local a = Byte(ByteString, DIP, DIP);
		DIP = DIP + 1;
		return a;
	end
	local function gBits16()
		local a, b = Byte(ByteString, DIP, DIP + 2);
		DIP = DIP + 2;
		return (b * 256) + a;
	end
	local function gBits32()
		local FlatIdent_24A02 = 0;
		local a;
		local b;
		local c;
		local d;
		while true do
			if (FlatIdent_24A02 == 1) then
				return (d * 16777216) + (c * 65536) + (b * 256) + a;
			end
			if (FlatIdent_24A02 == 0) then
				a, b, c, d = Byte(ByteString, DIP, DIP + 3);
				DIP = DIP + 4;
				FlatIdent_24A02 = 1;
			end
		end
	end
	local function gFloat()
		local Left = gBits32();
		local Right = gBits32();
		local IsNormal = 1;
		local Mantissa = (gBit(Right, 1, 20) * (2 ^ 32)) + Left;
		local Exponent = gBit(Right, 21, 31);
		local Sign = ((gBit(Right, 32) == 1) and -1) or 1;
		if (Exponent == 0) then
			if (Mantissa == 0) then
				return Sign * 0;
			else
				local FlatIdent_89ECE = 0;
				while true do
					if (FlatIdent_89ECE == 0) then
						Exponent = 1;
						IsNormal = 0;
						break;
					end
				end
			end
		elseif (Exponent == 2047) then
			return ((Mantissa == 0) and (Sign * (1 / 0))) or (Sign * NaN);
		end
		return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
	end
	local function gString(Len)
		local Str;
		if not Len then
			Len = gBits32();
			if (Len == 0) then
				return "";
			end
		end
		Str = Sub(ByteString, DIP, (DIP + Len) - 1);
		DIP = DIP + Len;
		local FStr = {};
		for Idx = 1, #Str do
			FStr[Idx] = Char(Byte(Sub(Str, Idx, Idx)));
		end
		return Concat(FStr);
	end
	local gInt = gBits32;
	local function _R(...)
		return {...}, Select("#", ...);
	end
	local function Deserialize()
		local Instrs = {};
		local Functions = {};
		local Lines = {};
		local Chunk = {Instrs,Functions,nil,Lines};
		local ConstCount = gBits32();
		local Consts = {};
		for Idx = 1, ConstCount do
			local FlatIdent_7366E = 0;
			local Type;
			local Cons;
			while true do
				if (FlatIdent_7366E == 1) then
					if (Type == 1) then
						Cons = gBits8() ~= 0;
					elseif (Type == 2) then
						Cons = gFloat();
					elseif (Type == 3) then
						Cons = gString();
					end
					Consts[Idx] = Cons;
					break;
				end
				if (0 == FlatIdent_7366E) then
					Type = gBits8();
					Cons = nil;
					FlatIdent_7366E = 1;
				end
			end
		end
		Chunk[3] = gBits8();
		for Idx = 1, gBits32() do
			local Descriptor = gBits8();
			if (gBit(Descriptor, 1, 1) == 0) then
				local Type = gBit(Descriptor, 2, 3);
				local Mask = gBit(Descriptor, 4, 6);
				local Inst = {gBits16(),gBits16(),nil,nil};
				if (Type == 0) then
					local FlatIdent_7DD24 = 0;
					while true do
						if (FlatIdent_7DD24 == 0) then
							Inst[3] = gBits16();
							Inst[4] = gBits16();
							break;
						end
					end
				elseif (Type == 1) then
					Inst[3] = gBits32();
				elseif (Type == 2) then
					Inst[3] = gBits32() - (2 ^ 16);
				elseif (Type == 3) then
					local FlatIdent_781F8 = 0;
					while true do
						if (FlatIdent_781F8 == 0) then
							Inst[3] = gBits32() - (2 ^ 16);
							Inst[4] = gBits16();
							break;
						end
					end
				end
				if (gBit(Mask, 1, 1) == 1) then
					Inst[2] = Consts[Inst[2]];
				end
				if (gBit(Mask, 2, 2) == 1) then
					Inst[3] = Consts[Inst[3]];
				end
				if (gBit(Mask, 3, 3) == 1) then
					Inst[4] = Consts[Inst[4]];
				end
				Instrs[Idx] = Inst;
			end
		end
		for Idx = 1, gBits32() do
			Functions[Idx - 1] = Deserialize();
		end
		return Chunk;
	end
	local function Wrap(Chunk, Upvalues, Env)
		local Instr = Chunk[1];
		local Proto = Chunk[2];
		local Params = Chunk[3];
		return function(...)
			local Instr = Instr;
			local Proto = Proto;
			local Params = Params;
			local _R = _R;
			local VIP = 1;
			local Top = -1;
			local Vararg = {};
			local Args = {...};
			local PCount = Select("#", ...) - 1;
			local Lupvals = {};
			local Stk = {};
			for Idx = 0, PCount do
				if (Idx >= Params) then
					Vararg[Idx - Params] = Args[Idx + 1];
				else
					Stk[Idx] = Args[Idx + 1];
				end
			end
			local Varargsz = (PCount - Params) + 1;
			local Inst;
			local Enum;
			while true do
				local FlatIdent_6FA1 = 0;
				while true do
					if (FlatIdent_6FA1 == 1) then
						if (Enum <= 45) then
							if (Enum <= 22) then
								if (Enum <= 10) then
									if (Enum <= 4) then
										if (Enum <= 1) then
											if (Enum > 0) then
												local FlatIdent_940A0 = 0;
												local Edx;
												local Results;
												local Limit;
												local B;
												local A;
												while true do
													if (FlatIdent_940A0 == 3) then
														VIP = VIP + 1;
														Inst = Instr[VIP];
														Stk[Inst[2]] = Upvalues[Inst[3]];
														VIP = VIP + 1;
														FlatIdent_940A0 = 4;
													end
													if (FlatIdent_940A0 == 4) then
														Inst = Instr[VIP];
														Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
														VIP = VIP + 1;
														Inst = Instr[VIP];
														FlatIdent_940A0 = 5;
													end
													if (FlatIdent_940A0 == 5) then
														A = Inst[2];
														B = Stk[Inst[3]];
														Stk[A + 1] = B;
														Stk[A] = B[Inst[4]];
														FlatIdent_940A0 = 6;
													end
													if (FlatIdent_940A0 == 9) then
														A = Inst[2];
														Stk[A](Unpack(Stk, A + 1, Top));
														VIP = VIP + 1;
														Inst = Instr[VIP];
														FlatIdent_940A0 = 10;
													end
													if (FlatIdent_940A0 == 7) then
														Inst = Instr[VIP];
														A = Inst[2];
														Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
														Top = (Limit + A) - 1;
														FlatIdent_940A0 = 8;
													end
													if (FlatIdent_940A0 == 6) then
														VIP = VIP + 1;
														Inst = Instr[VIP];
														Stk[Inst[2]] = Inst[3];
														VIP = VIP + 1;
														FlatIdent_940A0 = 7;
													end
													if (0 == FlatIdent_940A0) then
														Edx = nil;
														Results, Limit = nil;
														B = nil;
														A = nil;
														FlatIdent_940A0 = 1;
													end
													if (FlatIdent_940A0 == 8) then
														Edx = 0;
														for Idx = A, Top do
															Edx = Edx + 1;
															Stk[Idx] = Results[Edx];
														end
														VIP = VIP + 1;
														Inst = Instr[VIP];
														FlatIdent_940A0 = 9;
													end
													if (FlatIdent_940A0 == 10) then
														Stk[Inst[2]] = Inst[3];
														break;
													end
													if (2 == FlatIdent_940A0) then
														Stk[A](Stk[A + 1]);
														VIP = VIP + 1;
														Inst = Instr[VIP];
														Stk[Inst[2]] = Env[Inst[3]];
														FlatIdent_940A0 = 3;
													end
													if (FlatIdent_940A0 == 1) then
														Stk[Inst[2]] = Upvalues[Inst[3]];
														VIP = VIP + 1;
														Inst = Instr[VIP];
														A = Inst[2];
														FlatIdent_940A0 = 2;
													end
												end
											else
												local FlatIdent_74348 = 0;
												local B;
												local A;
												while true do
													if (FlatIdent_74348 == 7) then
														VIP = VIP + 1;
														Inst = Instr[VIP];
														A = Inst[2];
														B = Stk[Inst[3]];
														Stk[A + 1] = B;
														FlatIdent_74348 = 8;
													end
													if (FlatIdent_74348 == 1) then
														A = Inst[2];
														B = Stk[Inst[3]];
														Stk[A + 1] = B;
														Stk[A] = B[Inst[4]];
														VIP = VIP + 1;
														FlatIdent_74348 = 2;
													end
													if (FlatIdent_74348 == 4) then
														Inst = Instr[VIP];
														A = Inst[2];
														B = Stk[Inst[3]];
														Stk[A + 1] = B;
														Stk[A] = B[Inst[4]];
														FlatIdent_74348 = 5;
													end
													if (FlatIdent_74348 == 0) then
														B = nil;
														A = nil;
														Stk[Inst[2]] = Env[Inst[3]];
														VIP = VIP + 1;
														Inst = Instr[VIP];
														FlatIdent_74348 = 1;
													end
													if (FlatIdent_74348 == 6) then
														A = Inst[2];
														Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
														VIP = VIP + 1;
														Inst = Instr[VIP];
														Stk[Inst[2]] = Env[Inst[3]];
														FlatIdent_74348 = 7;
													end
													if (FlatIdent_74348 == 5) then
														VIP = VIP + 1;
														Inst = Instr[VIP];
														Stk[Inst[2]] = Inst[3];
														VIP = VIP + 1;
														Inst = Instr[VIP];
														FlatIdent_74348 = 6;
													end
													if (FlatIdent_74348 == 3) then
														Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
														VIP = VIP + 1;
														Inst = Instr[VIP];
														Stk[Inst[2]] = Env[Inst[3]];
														VIP = VIP + 1;
														FlatIdent_74348 = 4;
													end
													if (FlatIdent_74348 == 8) then
														Stk[A] = B[Inst[4]];
														break;
													end
													if (FlatIdent_74348 == 2) then
														Inst = Instr[VIP];
														Stk[Inst[2]] = Inst[3];
														VIP = VIP + 1;
														Inst = Instr[VIP];
														A = Inst[2];
														FlatIdent_74348 = 3;
													end
												end
											end
										elseif (Enum <= 2) then
											Stk[Inst[2]] = Env[Inst[3]];
										elseif (Enum > 3) then
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										else
											local FlatIdent_40B41 = 0;
											local B;
											while true do
												if (FlatIdent_40B41 == 0) then
													B = Stk[Inst[4]];
													if not B then
														VIP = VIP + 1;
													else
														Stk[Inst[2]] = B;
														VIP = Inst[3];
													end
													break;
												end
											end
										end
									elseif (Enum <= 7) then
										if (Enum <= 5) then
											local FlatIdent_AC2F = 0;
											local A;
											while true do
												if (FlatIdent_AC2F == 6) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													FlatIdent_AC2F = 7;
												end
												if (FlatIdent_AC2F == 2) then
													Stk[Inst[2]] = Upvalues[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													FlatIdent_AC2F = 3;
												end
												if (1 == FlatIdent_AC2F) then
													A = Inst[2];
													Stk[A](Stk[A + 1]);
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_AC2F = 2;
												end
												if (FlatIdent_AC2F == 5) then
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													FlatIdent_AC2F = 6;
												end
												if (0 == FlatIdent_AC2F) then
													A = nil;
													Stk[Inst[2]] = Upvalues[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_AC2F = 1;
												end
												if (FlatIdent_AC2F == 9) then
													if (Stk[Inst[2]] == Stk[Inst[4]]) then
														VIP = VIP + 1;
													else
														VIP = Inst[3];
													end
													break;
												end
												if (FlatIdent_AC2F == 7) then
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_AC2F = 8;
												end
												if (FlatIdent_AC2F == 3) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Env[Inst[3]];
													VIP = VIP + 1;
													FlatIdent_AC2F = 4;
												end
												if (8 == FlatIdent_AC2F) then
													A = Inst[2];
													Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_AC2F = 9;
												end
												if (FlatIdent_AC2F == 4) then
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_AC2F = 5;
												end
											end
										elseif (Enum > 6) then
											Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
										else
											local FlatIdent_61800 = 0;
											local B;
											local A;
											while true do
												if (FlatIdent_61800 == 4) then
													Inst = Instr[VIP];
													A = Inst[2];
													do
														return Stk[A](Unpack(Stk, A + 1, Inst[3]));
													end
													VIP = VIP + 1;
													FlatIdent_61800 = 5;
												end
												if (FlatIdent_61800 == 2) then
													Stk[A] = B[Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Upvalues[Inst[3]];
													FlatIdent_61800 = 3;
												end
												if (FlatIdent_61800 == 3) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													FlatIdent_61800 = 4;
												end
												if (FlatIdent_61800 == 0) then
													B = nil;
													A = nil;
													Stk[Inst[2]] = Upvalues[Inst[3]];
													VIP = VIP + 1;
													FlatIdent_61800 = 1;
												end
												if (FlatIdent_61800 == 5) then
													Inst = Instr[VIP];
													A = Inst[2];
													do
														return Unpack(Stk, A, Top);
													end
													VIP = VIP + 1;
													FlatIdent_61800 = 6;
												end
												if (FlatIdent_61800 == 6) then
													Inst = Instr[VIP];
													do
														return;
													end
													break;
												end
												if (1 == FlatIdent_61800) then
													Inst = Instr[VIP];
													A = Inst[2];
													B = Stk[Inst[3]];
													Stk[A + 1] = B;
													FlatIdent_61800 = 2;
												end
											end
										end
									elseif (Enum <= 8) then
										local FlatIdent_67691 = 0;
										local NewProto;
										local NewUvals;
										local Indexes;
										while true do
											if (FlatIdent_67691 == 1) then
												Indexes = {};
												NewUvals = Setmetatable({}, {__index=function(_, Key)
													local Val = Indexes[Key];
													return Val[1][Val[2]];
												end,__newindex=function(_, Key, Value)
													local Val = Indexes[Key];
													Val[1][Val[2]] = Value;
												end});
												FlatIdent_67691 = 2;
											end
											if (FlatIdent_67691 == 2) then
												for Idx = 1, Inst[4] do
													VIP = VIP + 1;
													local Mvm = Instr[VIP];
													if (Mvm[1] == 70) then
														Indexes[Idx - 1] = {Stk,Mvm[3]};
													else
														Indexes[Idx - 1] = {Upvalues,Mvm[3]};
													end
													Lupvals[#Lupvals + 1] = Indexes;
												end
												Stk[Inst[2]] = Wrap(NewProto, NewUvals, Env);
												break;
											end
											if (FlatIdent_67691 == 0) then
												NewProto = Proto[Inst[3]];
												NewUvals = nil;
												FlatIdent_67691 = 1;
											end
										end
									elseif (Enum == 9) then
										if (Stk[Inst[2]] < Inst[4]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local FlatIdent_1013A = 0;
										local B;
										local A;
										while true do
											if (FlatIdent_1013A == 0) then
												B = nil;
												A = nil;
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_1013A = 1;
											end
											if (FlatIdent_1013A == 3) then
												Stk[A] = B[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_1013A = 4;
											end
											if (FlatIdent_1013A == 2) then
												Inst = Instr[VIP];
												A = Inst[2];
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												FlatIdent_1013A = 3;
											end
											if (FlatIdent_1013A == 4) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_1013A = 5;
											end
											if (FlatIdent_1013A == 1) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												FlatIdent_1013A = 2;
											end
											if (FlatIdent_1013A == 5) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												break;
											end
										end
									end
								elseif (Enum <= 16) then
									if (Enum <= 13) then
										if (Enum <= 11) then
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
										elseif (Enum > 12) then
											local FlatIdent_6AEED = 0;
											local B;
											local A;
											while true do
												if (FlatIdent_6AEED == 6) then
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Env[Inst[3]];
													break;
												end
												if (FlatIdent_6AEED == 0) then
													B = nil;
													A = nil;
													A = Inst[2];
													Stk[A](Unpack(Stk, A + 1, Inst[3]));
													VIP = VIP + 1;
													FlatIdent_6AEED = 1;
												end
												if (3 == FlatIdent_6AEED) then
													Stk[Inst[2]] = Env[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													FlatIdent_6AEED = 4;
												end
												if (FlatIdent_6AEED == 5) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_6AEED = 6;
												end
												if (FlatIdent_6AEED == 2) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_6AEED = 3;
												end
												if (FlatIdent_6AEED == 4) then
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Env[Inst[3]];
													FlatIdent_6AEED = 5;
												end
												if (FlatIdent_6AEED == 1) then
													Inst = Instr[VIP];
													A = Inst[2];
													B = Stk[Inst[3]];
													Stk[A + 1] = B;
													Stk[A] = B[Inst[4]];
													FlatIdent_6AEED = 2;
												end
											end
										else
											for Idx = Inst[2], Inst[3] do
												Stk[Idx] = nil;
											end
										end
									elseif (Enum <= 14) then
										local FlatIdent_8B272 = 0;
										local A;
										local K;
										local B;
										while true do
											if (FlatIdent_8B272 == 5) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_8B272 = 6;
											end
											if (FlatIdent_8B272 == 0) then
												A = nil;
												K = nil;
												B = nil;
												Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
												FlatIdent_8B272 = 1;
											end
											if (FlatIdent_8B272 == 1) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_8B272 = 2;
											end
											if (FlatIdent_8B272 == 2) then
												Inst = Instr[VIP];
												B = Inst[3];
												K = Stk[B];
												for Idx = B + 1, Inst[4] do
													K = K .. Stk[Idx];
												end
												FlatIdent_8B272 = 3;
											end
											if (4 == FlatIdent_8B272) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												FlatIdent_8B272 = 5;
											end
											if (FlatIdent_8B272 == 6) then
												A = Inst[2];
												Stk[A](Stk[A + 1]);
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_8B272 = 7;
											end
											if (FlatIdent_8B272 == 3) then
												Stk[Inst[2]] = K;
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												FlatIdent_8B272 = 4;
											end
											if (FlatIdent_8B272 == 7) then
												Stk[Inst[2]] = Inst[3];
												break;
											end
										end
									elseif (Enum > 15) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									elseif (Stk[Inst[2]] == Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum <= 19) then
									if (Enum <= 17) then
										local A = Inst[2];
										Stk[A](Stk[A + 1]);
									elseif (Enum > 18) then
										local A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
									else
										local A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
									end
								elseif (Enum <= 20) then
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return;
									end
								elseif (Enum > 21) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									Upvalues[Inst[3]] = Stk[Inst[2]];
								end
							elseif (Enum <= 33) then
								if (Enum <= 27) then
									if (Enum <= 24) then
										if (Enum > 23) then
											local FlatIdent_89917 = 0;
											local A;
											while true do
												if (FlatIdent_89917 == 2) then
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
													VIP = VIP + 1;
													FlatIdent_89917 = 3;
												end
												if (FlatIdent_89917 == 0) then
													A = nil;
													Stk[Inst[2]] = Stk[Inst[3]];
													VIP = VIP + 1;
													FlatIdent_89917 = 1;
												end
												if (FlatIdent_89917 == 1) then
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]];
													VIP = VIP + 1;
													FlatIdent_89917 = 2;
												end
												if (3 == FlatIdent_89917) then
													Inst = Instr[VIP];
													A = Inst[2];
													Stk[A](Unpack(Stk, A + 1, Inst[3]));
													FlatIdent_89917 = 4;
												end
												if (FlatIdent_89917 == 4) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													VIP = Inst[3];
													break;
												end
											end
										else
											local A = Inst[2];
											local C = Inst[4];
											local CB = A + 2;
											local Result = {Stk[A](Stk[A + 1], Stk[CB])};
											for Idx = 1, C do
												Stk[CB + Idx] = Result[Idx];
											end
											local R = Result[1];
											if R then
												Stk[CB] = R;
												VIP = Inst[3];
											else
												VIP = VIP + 1;
											end
										end
									elseif (Enum <= 25) then
										local B;
										local A;
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									elseif (Enum > 26) then
										local B = Inst[3];
										local K = Stk[B];
										for Idx = B + 1, Inst[4] do
											K = K .. Stk[Idx];
										end
										Stk[Inst[2]] = K;
									else
										local A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									end
								elseif (Enum <= 30) then
									if (Enum <= 28) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									elseif (Enum == 29) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									else
										local A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
								elseif (Enum <= 31) then
									local FlatIdent_55D83 = 0;
									local A;
									while true do
										if (FlatIdent_55D83 == 13) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											FlatIdent_55D83 = 14;
										end
										if (FlatIdent_55D83 == 6) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_55D83 = 7;
										end
										if (3 == FlatIdent_55D83) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_55D83 = 4;
										end
										if (FlatIdent_55D83 == 16) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											break;
										end
										if (FlatIdent_55D83 == 11) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_55D83 = 12;
										end
										if (FlatIdent_55D83 == 9) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_55D83 = 10;
										end
										if (4 == FlatIdent_55D83) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											FlatIdent_55D83 = 5;
										end
										if (8 == FlatIdent_55D83) then
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_55D83 = 9;
										end
										if (FlatIdent_55D83 == 1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_55D83 = 2;
										end
										if (FlatIdent_55D83 == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_55D83 = 6;
										end
										if (FlatIdent_55D83 == 7) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_55D83 = 8;
										end
										if (14 == FlatIdent_55D83) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_55D83 = 15;
										end
										if (FlatIdent_55D83 == 12) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_55D83 = 13;
										end
										if (15 == FlatIdent_55D83) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_55D83 = 16;
										end
										if (FlatIdent_55D83 == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											FlatIdent_55D83 = 3;
										end
										if (FlatIdent_55D83 == 10) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											FlatIdent_55D83 = 11;
										end
										if (FlatIdent_55D83 == 0) then
											A = nil;
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_55D83 = 1;
										end
									end
								elseif (Enum == 32) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									local A = Inst[2];
									local Cls = {};
									for Idx = 1, #Lupvals do
										local FlatIdent_5077 = 0;
										local List;
										while true do
											if (FlatIdent_5077 == 0) then
												List = Lupvals[Idx];
												for Idz = 0, #List do
													local Upv = List[Idz];
													local NStk = Upv[1];
													local DIP = Upv[2];
													if ((NStk == Stk) and (DIP >= A)) then
														Cls[DIP] = NStk[DIP];
														Upv[1] = Cls;
													end
												end
												break;
											end
										end
									end
								end
							elseif (Enum <= 39) then
								if (Enum <= 36) then
									if (Enum <= 34) then
										local FlatIdent_6EF7B = 0;
										local A;
										while true do
											if (FlatIdent_6EF7B == 4) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												FlatIdent_6EF7B = 5;
											end
											if (1 == FlatIdent_6EF7B) then
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												FlatIdent_6EF7B = 2;
											end
											if (FlatIdent_6EF7B == 3) then
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Stk[A + 1]);
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]];
												FlatIdent_6EF7B = 4;
											end
											if (FlatIdent_6EF7B == 7) then
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												break;
											end
											if (FlatIdent_6EF7B == 2) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_6EF7B = 3;
											end
											if (FlatIdent_6EF7B == 0) then
												A = nil;
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												FlatIdent_6EF7B = 1;
											end
											if (FlatIdent_6EF7B == 6) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_6EF7B = 7;
											end
											if (FlatIdent_6EF7B == 5) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_6EF7B = 6;
											end
										end
									elseif (Enum > 35) then
										do
											return Stk[Inst[2]];
										end
									else
										local FlatIdent_22A5C = 0;
										local A;
										while true do
											if (0 == FlatIdent_22A5C) then
												A = Inst[2];
												Stk[A](Unpack(Stk, A + 1, Top));
												break;
											end
										end
									end
								elseif (Enum <= 37) then
									local FlatIdent_52EE1 = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_52EE1 == 0) then
											B = nil;
											A = nil;
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											FlatIdent_52EE1 = 1;
										end
										if (1 == FlatIdent_52EE1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											FlatIdent_52EE1 = 2;
										end
										if (6 == FlatIdent_52EE1) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_52EE1 = 7;
										end
										if (FlatIdent_52EE1 == 8) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											FlatIdent_52EE1 = 9;
										end
										if (FlatIdent_52EE1 == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_52EE1 = 4;
										end
										if (FlatIdent_52EE1 == 4) then
											Stk[Inst[2]] = {};
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_52EE1 = 5;
										end
										if (FlatIdent_52EE1 == 2) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_52EE1 = 3;
										end
										if (10 == FlatIdent_52EE1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_52EE1 = 11;
										end
										if (FlatIdent_52EE1 == 11) then
											VIP = Inst[3];
											break;
										end
										if (5 == FlatIdent_52EE1) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_52EE1 = 6;
										end
										if (9 == FlatIdent_52EE1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											FlatIdent_52EE1 = 10;
										end
										if (FlatIdent_52EE1 == 7) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											FlatIdent_52EE1 = 8;
										end
									end
								elseif (Enum == 38) then
									if (Inst[2] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local FlatIdent_23B66 = 0;
									local A;
									while true do
										if (FlatIdent_23B66 == 0) then
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											break;
										end
									end
								end
							elseif (Enum <= 42) then
								if (Enum <= 40) then
									local FlatIdent_78A9D = 0;
									local Edx;
									local Results;
									local Limit;
									local B;
									local A;
									while true do
										if (FlatIdent_78A9D == 6) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_78A9D = 7;
										end
										if (FlatIdent_78A9D == 9) then
											Stk[Inst[2]] = Inst[3];
											break;
										end
										if (2 == FlatIdent_78A9D) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_78A9D = 3;
										end
										if (FlatIdent_78A9D == 1) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											FlatIdent_78A9D = 2;
										end
										if (FlatIdent_78A9D == 8) then
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_78A9D = 9;
										end
										if (7 == FlatIdent_78A9D) then
											A = Inst[2];
											Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
											Top = (Limit + A) - 1;
											Edx = 0;
											for Idx = A, Top do
												local FlatIdent_2B986 = 0;
												while true do
													if (FlatIdent_2B986 == 0) then
														Edx = Edx + 1;
														Stk[Idx] = Results[Edx];
														break;
													end
												end
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_78A9D = 8;
										end
										if (FlatIdent_78A9D == 3) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_78A9D = 4;
										end
										if (FlatIdent_78A9D == 0) then
											Edx = nil;
											Results, Limit = nil;
											B = nil;
											A = nil;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_78A9D = 1;
										end
										if (FlatIdent_78A9D == 4) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											FlatIdent_78A9D = 5;
										end
										if (FlatIdent_78A9D == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_78A9D = 6;
										end
									end
								elseif (Enum == 41) then
									VIP = Inst[3];
								else
									local FlatIdent_C79F = 0;
									local A;
									local Results;
									local Limit;
									local Edx;
									while true do
										if (FlatIdent_C79F == 1) then
											Top = (Limit + A) - 1;
											Edx = 0;
											FlatIdent_C79F = 2;
										end
										if (FlatIdent_C79F == 2) then
											for Idx = A, Top do
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
											end
											break;
										end
										if (0 == FlatIdent_C79F) then
											A = Inst[2];
											Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
											FlatIdent_C79F = 1;
										end
									end
								end
							elseif (Enum <= 43) then
								local B;
								local A;
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							elseif (Enum > 44) then
								Stk[Inst[2]]();
							elseif not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 68) then
							if (Enum <= 56) then
								if (Enum <= 50) then
									if (Enum <= 47) then
										if (Enum > 46) then
											local FlatIdent_87C42 = 0;
											local B;
											local A;
											while true do
												if (5 == FlatIdent_87C42) then
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_87C42 = 6;
												end
												if (FlatIdent_87C42 == 0) then
													B = nil;
													A = nil;
													A = Inst[2];
													B = Stk[Inst[3]];
													Stk[A + 1] = B;
													Stk[A] = B[Inst[4]];
													FlatIdent_87C42 = 1;
												end
												if (FlatIdent_87C42 == 6) then
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_87C42 = 7;
												end
												if (FlatIdent_87C42 == 2) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Inst[3];
													FlatIdent_87C42 = 3;
												end
												if (FlatIdent_87C42 == 4) then
													Stk[Inst[2]] = {};
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Env[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_87C42 = 5;
												end
												if (FlatIdent_87C42 == 7) then
													Stk[Inst[2]] = Inst[3];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													A = Inst[2];
													Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
													VIP = VIP + 1;
													FlatIdent_87C42 = 8;
												end
												if (FlatIdent_87C42 == 3) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													A = Inst[2];
													Stk[A] = Stk[A](Stk[A + 1]);
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_87C42 = 4;
												end
												if (FlatIdent_87C42 == 10) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													A = Inst[2];
													Stk[A](Stk[A + 1]);
													VIP = VIP + 1;
													Inst = Instr[VIP];
													FlatIdent_87C42 = 11;
												end
												if (11 == FlatIdent_87C42) then
													VIP = Inst[3];
													break;
												end
												if (FlatIdent_87C42 == 8) then
													Inst = Instr[VIP];
													Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													A = Inst[2];
													Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
													FlatIdent_87C42 = 9;
												end
												if (FlatIdent_87C42 == 9) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													A = Inst[2];
													B = Stk[Inst[3]];
													Stk[A + 1] = B;
													Stk[A] = B[Inst[4]];
													FlatIdent_87C42 = 10;
												end
												if (FlatIdent_87C42 == 1) then
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Upvalues[Inst[3]];
													VIP = VIP + 1;
													Inst = Instr[VIP];
													Stk[Inst[2]] = Env[Inst[3]];
													FlatIdent_87C42 = 2;
												end
											end
										else
											local B;
											local A;
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
									elseif (Enum <= 48) then
										Stk[Inst[2]][Inst[3]] = Inst[4];
									elseif (Enum == 49) then
										local A;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									else
										local FlatIdent_31791 = 0;
										local A;
										while true do
											if (FlatIdent_31791 == 0) then
												A = Inst[2];
												Stk[A] = Stk[A]();
												break;
											end
										end
									end
								elseif (Enum <= 53) then
									if (Enum <= 51) then
										local FlatIdent_82AB4 = 0;
										local A;
										while true do
											if (2 == FlatIdent_82AB4) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												FlatIdent_82AB4 = 3;
											end
											if (1 == FlatIdent_82AB4) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_82AB4 = 2;
											end
											if (5 == FlatIdent_82AB4) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Stk[A + 1]);
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_82AB4 = 6;
											end
											if (FlatIdent_82AB4 == 4) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_82AB4 = 5;
											end
											if (FlatIdent_82AB4 == 0) then
												A = nil;
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_82AB4 = 1;
											end
											if (FlatIdent_82AB4 == 6) then
												Stk[Inst[2]] = Stk[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												break;
											end
											if (FlatIdent_82AB4 == 3) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												FlatIdent_82AB4 = 4;
											end
										end
									elseif (Enum == 52) then
										local FlatIdent_3C1AA = 0;
										local A;
										local Results;
										local Limit;
										local Edx;
										while true do
											if (FlatIdent_3C1AA == 0) then
												A = Inst[2];
												Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
												FlatIdent_3C1AA = 1;
											end
											if (FlatIdent_3C1AA == 2) then
												for Idx = A, Top do
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
												end
												break;
											end
											if (FlatIdent_3C1AA == 1) then
												Top = (Limit + A) - 1;
												Edx = 0;
												FlatIdent_3C1AA = 2;
											end
										end
									else
										local FlatIdent_81DE9 = 0;
										local A;
										local Results;
										local Edx;
										while true do
											if (FlatIdent_81DE9 == 0) then
												A = Inst[2];
												Results = {Stk[A](Unpack(Stk, A + 1, Inst[3]))};
												FlatIdent_81DE9 = 1;
											end
											if (FlatIdent_81DE9 == 1) then
												Edx = 0;
												for Idx = A, Inst[4] do
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
												end
												break;
											end
										end
									end
								elseif (Enum <= 54) then
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, A + Inst[3]);
									end
								elseif (Enum > 55) then
									local FlatIdent_7DB9E = 0;
									local A;
									local B;
									while true do
										if (FlatIdent_7DB9E == 1) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											break;
										end
										if (FlatIdent_7DB9E == 0) then
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_7DB9E = 1;
										end
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 62) then
								if (Enum <= 59) then
									if (Enum <= 57) then
										local FlatIdent_67408 = 0;
										local T;
										local Edx;
										local Results;
										local Limit;
										local A;
										while true do
											if (FlatIdent_67408 == 6) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_67408 = 7;
											end
											if (FlatIdent_67408 == 14) then
												T = Stk[A];
												for Idx = A + 1, Top do
													Insert(T, Stk[Idx]);
												end
												break;
											end
											if (FlatIdent_67408 == 1) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_67408 = 2;
											end
											if (FlatIdent_67408 == 3) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_67408 = 4;
											end
											if (FlatIdent_67408 == 10) then
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_67408 = 11;
											end
											if (FlatIdent_67408 == 13) then
												A = Inst[2];
												Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
												Top = (Limit + A) - 1;
												Edx = 0;
												for Idx = A, Top do
													local FlatIdent_44652 = 0;
													while true do
														if (FlatIdent_44652 == 0) then
															Edx = Edx + 1;
															Stk[Idx] = Results[Edx];
															break;
														end
													end
												end
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												FlatIdent_67408 = 14;
											end
											if (FlatIdent_67408 == 11) then
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												FlatIdent_67408 = 12;
											end
											if (FlatIdent_67408 == 4) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = {};
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												FlatIdent_67408 = 5;
											end
											if (FlatIdent_67408 == 5) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												FlatIdent_67408 = 6;
											end
											if (FlatIdent_67408 == 7) then
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
												FlatIdent_67408 = 8;
											end
											if (FlatIdent_67408 == 0) then
												T = nil;
												Edx = nil;
												Results, Limit = nil;
												A = nil;
												Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]][Inst[3]] = Inst[4];
												FlatIdent_67408 = 1;
											end
											if (FlatIdent_67408 == 2) then
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Stk[A + 1]);
												FlatIdent_67408 = 3;
											end
											if (FlatIdent_67408 == 8) then
												Top = (Limit + A) - 1;
												Edx = 0;
												for Idx = A, Top do
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
												end
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
												VIP = VIP + 1;
												FlatIdent_67408 = 9;
											end
											if (FlatIdent_67408 == 9) then
												Inst = Instr[VIP];
												Stk[Inst[2]] = Env[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												FlatIdent_67408 = 10;
											end
											if (FlatIdent_67408 == 12) then
												Inst = Instr[VIP];
												A = Inst[2];
												Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
												Top = (Limit + A) - 1;
												Edx = 0;
												for Idx = A, Top do
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
												end
												VIP = VIP + 1;
												Inst = Instr[VIP];
												FlatIdent_67408 = 13;
											end
										end
									elseif (Enum > 58) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									else
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = {};
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									end
								elseif (Enum <= 60) then
									local A;
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								elseif (Enum > 61) then
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A = Inst[2];
									do
										return Unpack(Stk, A, A + Inst[3]);
									end
								end
							elseif (Enum <= 65) then
								if (Enum <= 63) then
									local A = Inst[2];
									do
										return Stk[A], Stk[A + 1];
									end
								elseif (Enum == 64) then
									local A = Inst[2];
									local Results = {Stk[A]()};
									local Limit = Inst[4];
									local Edx = 0;
									for Idx = A, Limit do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								else
									local FlatIdent_28E8A = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_28E8A == 12) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 13;
										end
										if (FlatIdent_28E8A == 13) then
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 14;
										end
										if (FlatIdent_28E8A == 8) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											FlatIdent_28E8A = 9;
										end
										if (FlatIdent_28E8A == 10) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_28E8A = 11;
										end
										if (FlatIdent_28E8A == 9) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											FlatIdent_28E8A = 10;
										end
										if (FlatIdent_28E8A == 3) then
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 4;
										end
										if (FlatIdent_28E8A == 1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3] + Stk[Inst[4]];
											FlatIdent_28E8A = 2;
										end
										if (FlatIdent_28E8A == 11) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											FlatIdent_28E8A = 12;
										end
										if (FlatIdent_28E8A == 6) then
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 7;
										end
										if (FlatIdent_28E8A == 14) then
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											VIP = Inst[3];
											break;
										end
										if (FlatIdent_28E8A == 0) then
											B = nil;
											A = nil;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_28E8A = 1;
										end
										if (7 == FlatIdent_28E8A) then
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = {};
											VIP = VIP + 1;
											FlatIdent_28E8A = 8;
										end
										if (5 == FlatIdent_28E8A) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 6;
										end
										if (4 == FlatIdent_28E8A) then
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 5;
										end
										if (FlatIdent_28E8A == 2) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_28E8A = 3;
										end
									end
								end
							elseif (Enum <= 66) then
								Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];
							elseif (Enum == 67) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								local FlatIdent_91AD1 = 0;
								local DIP;
								local NStk;
								local Upv;
								local List;
								local Cls;
								local B;
								local A;
								while true do
									if (FlatIdent_91AD1 == 7) then
										A = Inst[2];
										Cls = {};
										for Idx = 1, #Lupvals do
											List = Lupvals[Idx];
											for Idz = 0, #List do
												Upv = List[Idz];
												NStk = Upv[1];
												DIP = Upv[2];
												if ((NStk == Stk) and (DIP >= A)) then
													local FlatIdent_1FAE6 = 0;
													while true do
														if (FlatIdent_1FAE6 == 0) then
															Cls[DIP] = NStk[DIP];
															Upv[1] = Cls;
															break;
														end
													end
												end
											end
										end
										FlatIdent_91AD1 = 8;
									end
									if (FlatIdent_91AD1 == 0) then
										DIP = nil;
										NStk = nil;
										Upv = nil;
										FlatIdent_91AD1 = 1;
									end
									if (FlatIdent_91AD1 == 4) then
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										FlatIdent_91AD1 = 5;
									end
									if (FlatIdent_91AD1 == 8) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										do
											return;
										end
										break;
									end
									if (FlatIdent_91AD1 == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_91AD1 = 4;
									end
									if (2 == FlatIdent_91AD1) then
										A = nil;
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										FlatIdent_91AD1 = 3;
									end
									if (FlatIdent_91AD1 == 6) then
										Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_91AD1 = 7;
									end
									if (FlatIdent_91AD1 == 5) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_91AD1 = 6;
									end
									if (FlatIdent_91AD1 == 1) then
										List = nil;
										Cls = nil;
										B = nil;
										FlatIdent_91AD1 = 2;
									end
								end
							end
						elseif (Enum <= 79) then
							if (Enum <= 73) then
								if (Enum <= 70) then
									if (Enum == 69) then
										local A;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									else
										Stk[Inst[2]] = Stk[Inst[3]];
									end
								elseif (Enum <= 71) then
									Stk[Inst[2]] = Upvalues[Inst[3]];
								elseif (Enum == 72) then
									Stk[Inst[2]] = Inst[3] ~= 0;
									VIP = VIP + 1;
								else
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 76) then
								if (Enum <= 74) then
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								elseif (Enum > 75) then
									local FlatIdent_23AC6 = 0;
									local A;
									local Results;
									local Edx;
									while true do
										if (FlatIdent_23AC6 == 1) then
											Edx = 0;
											for Idx = A, Inst[4] do
												local FlatIdent_69531 = 0;
												while true do
													if (FlatIdent_69531 == 0) then
														Edx = Edx + 1;
														Stk[Idx] = Results[Edx];
														break;
													end
												end
											end
											break;
										end
										if (FlatIdent_23AC6 == 0) then
											A = Inst[2];
											Results = {Stk[A](Stk[A + 1])};
											FlatIdent_23AC6 = 1;
										end
									end
								elseif Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum <= 77) then
								Stk[Inst[2]] = Inst[3] ~= 0;
							elseif (Enum == 78) then
								Stk[Inst[2]] = {};
							else
								Stk[Inst[2]] = Inst[3] + Stk[Inst[4]];
							end
						elseif (Enum <= 85) then
							if (Enum <= 82) then
								if (Enum <= 80) then
									local FlatIdent_6134A = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_6134A == 2) then
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_6134A = 3;
										end
										if (3 == FlatIdent_6134A) then
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											FlatIdent_6134A = 4;
										end
										if (FlatIdent_6134A == 4) then
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_6134A = 5;
										end
										if (FlatIdent_6134A == 1) then
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											FlatIdent_6134A = 2;
										end
										if (FlatIdent_6134A == 5) then
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Upvalues[Inst[3]] = Stk[Inst[2]];
											VIP = VIP + 1;
											FlatIdent_6134A = 6;
										end
										if (6 == FlatIdent_6134A) then
											Inst = Instr[VIP];
											do
												return;
											end
											break;
										end
										if (FlatIdent_6134A == 0) then
											B = nil;
											A = nil;
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_6134A = 1;
										end
									end
								elseif (Enum == 81) then
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 83) then
								Stk[Inst[2]] = Wrap(Proto[Inst[3]], nil, Env);
							elseif (Enum > 84) then
								local A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
							elseif (Stk[Inst[2]] ~= Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 88) then
							if (Enum <= 86) then
								local FlatIdent_8BD63 = 0;
								local Edx;
								local Results;
								local A;
								while true do
									if (FlatIdent_8BD63 == 1) then
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_8BD63 = 2;
									end
									if (2 == FlatIdent_8BD63) then
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_8BD63 = 3;
									end
									if (3 == FlatIdent_8BD63) then
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_8BD63 = 4;
									end
									if (6 == FlatIdent_8BD63) then
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_8BD63 = 7;
									end
									if (0 == FlatIdent_8BD63) then
										Edx = nil;
										Results = nil;
										A = nil;
										FlatIdent_8BD63 = 1;
									end
									if (FlatIdent_8BD63 == 4) then
										A = Inst[2];
										Results = {Stk[A](Unpack(Stk, A + 1, Inst[3]))};
										Edx = 0;
										FlatIdent_8BD63 = 5;
									end
									if (FlatIdent_8BD63 == 5) then
										for Idx = A, Inst[4] do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_8BD63 = 6;
									end
									if (FlatIdent_8BD63 == 8) then
										Stk[Inst[2]] = Inst[3];
										break;
									end
									if (FlatIdent_8BD63 == 7) then
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_8BD63 = 8;
									end
								end
							elseif (Enum > 87) then
								local A = Inst[2];
								local T = Stk[A];
								for Idx = A + 1, Top do
									Insert(T, Stk[Idx]);
								end
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							end
						elseif (Enum <= 89) then
							local B;
							local A;
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
						elseif (Enum > 90) then
							local FlatIdent_30B76 = 0;
							local A;
							while true do
								if (FlatIdent_30B76 == 6) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
									break;
								end
								if (FlatIdent_30B76 == 4) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
									FlatIdent_30B76 = 5;
								end
								if (FlatIdent_30B76 == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									FlatIdent_30B76 = 6;
								end
								if (FlatIdent_30B76 == 0) then
									A = nil;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_30B76 = 1;
								end
								if (FlatIdent_30B76 == 1) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_30B76 = 2;
								end
								if (FlatIdent_30B76 == 3) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									FlatIdent_30B76 = 4;
								end
								if (FlatIdent_30B76 == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									FlatIdent_30B76 = 3;
								end
							end
						else
							do
								return;
							end
						end
						VIP = VIP + 1;
						break;
					end
					if (0 == FlatIdent_6FA1) then
						Inst = Instr[VIP];
						Enum = Inst[1];
						FlatIdent_6FA1 = 1;
					end
				end
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
return VMCall("LOL!1D3O0003043O0067616D65030A3O004765745365727669636503073O00506C6179657273030B3O00482O747053657276696365030C3O0054772O656E53657276696365030B3O00546578745365727669636503053O00737061776E030B3O004C6F63616C506C61796572030C3O0057616974466F724368696C6403093O00506C6179657247756903113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E65637403183O0047657450726F70657274794368616E6765645369676E616C03043O005465787403063O0043726561746503093O0054772O656E496E666F2O033O006E6577026O00E03F03043O00456E756D030B3O00456173696E675374796C6503043O004261636B030F3O00456173696E67446972656374696F6E2O033O004F757403043O0053697A6503053O005544696D32028O00025O00406F40025O00806B4003043O00506C6179006D3O00124O00013O00206O000200122O000200038O0002000200122O000100013O00202O00010001000200122O000300046O00010003000200122O000200013O00202O000200020002001249000400054O000A00020004000200122O000300013O00202O00030003000200122O000500066O00030005000200122O000400073O00025300056O002E00040002000100202O00043O000800202O00050004000900122O0007000A6O000500070002000253000600013O00060800070002000100012O00463O00013O00060800080003000100012O00463O00073O000253000900043O000253000A00053O000608000B0006000100012O00463O00053O000608000C0007000100012O00463O00023O000608000D0008000100052O00463O00084O00463O00094O00463O000A4O00463O000D4O00463O00064O0046000E000B4O0040000E0001001500204A00160011000B00203800160016000C00060800180009000100052O00463O000C4O00463O00114O00463O000D4O00463O00104O00463O00124O001E00160018000100204A00160013000B00203800160016000C0006080018000A000100032O00463O000C4O00463O00134O00463O00124O001E00160018000100204A00160014000B00203800160016000C0006080018000B000100042O00463O000C4O00463O00144O00463O000F4O00463O00024O001E00160018000100204A00160015000B00203800160016000C0006080018000C000100032O00463O000C4O00463O00154O00463O00124O005900160018000100202O00160012000D00122O0018000E6O00160018000200202O00160016000C0006080018000D000100042O00463O000F4O00463O00034O00463O00124O00463O00024O000D00160018000100202O00160002000F4O0018000F3O00122O001900103O00202O00190019001100122O001A00123O00122O001B00133O00202O001B001B001400202O001B001B001500122O001C00133O00204A001C001C001600201C001C001C00174O0019001C00024O001A3O000100122O001B00193O00202O001B001B001100122O001C001A3O00122O001D001B3O00122O001E001A3O00122O001F001C6O001B001F0002001004001A0018001B2O00440016001A000200202O00160016001D4O0016000200019O006O00013O000E3O00043O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403B13O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F626A616C616C736A7A62736C616C716F71752O657968736B2O616D6270716F2F6B616A73627362612O2D686168736A73762D6B616B7762735F6A616B735F303832682O6739323768736B736F4C6F6C2D4E2O6F2O62726F39382O373237326A736873687362736A7355524C3O772E6E2O6F622E636F6D2E4F62667573636174652F6D61696E2F696E666F2E6C756100083O0012143O00013O00122O000100023O00202O00010001000300122O000300046O000100039O0000026O000100016O00017O00043O00028O00026O00F03F034O0003053O007063612O6C001C3O0012493O00014O000C000100013O001249000200013O000E2600010003000100020004293O0003000100260F3O0008000100020004293O000800012O0024000100023O00260F3O0002000100010004293O00020001001249000300013O00260F00030013000100010004293O00130001001249000100033O001202000400043O00060800053O000100012O00463O00014O0011000400020001001249000300023O00260F0003000B000100020004293O000B00010012493O00023O0004293O000200010004293O000B00010004293O000200010004293O000300010004293O000200012O005A3O00013O00013O00043O0003043O0067616D65030A3O004765745365727669636503133O00526278416E616C797469637353657276696365030B3O00476574436C69656E74496400083O0012503O00013O00206O000200122O000200038O0002000200206O00046O000200029O006O00017O00043O00028O0003053O007063612O6C026O00F03F030E3O0052657175657374206661696C656402263O001249000200014O000C000300043O00260F0002001F000100010004293O001F0001001249000500013O00260F0005001A000100010004293O001A0001001202000600023O00060800073O000100032O00468O00478O00463O00014O004C0006000200072O0046000400074O0046000300063O00064B0003001900013O0004293O0019000100064B0004001900013O0004293O00190001001202000600023O00060800070001000100022O00478O00463O00044O0013000600074O001200065O001249000500033O00260F00050005000100030004293O00050001001249000200033O0004293O001F00010004293O0005000100260F00020002000100030004293O000200012O004D00055O001249000600044O003F000500033O0004293O000200012O005A3O00013O00023O000D3O00028O002O033O0073796E03073O007265717565737403043O00682O7470030C3O00682O74705F726571756573742O033O0055726C03063O004D6574686F6403043O00504F535403073O0048656164657273030C3O00436F6E74656E742D5479706503103O00612O706C69636174696F6E2F6A736F6E03043O00426F6479030A3O004A534F4E456E636F646500293O0012493O00014O000C000100013O00260F3O0002000100010004293O00020001001202000200023O00064B0002000B00013O0004293O000B0001001202000200023O00204A00020002000300060300010015000100020004293O00150001001202000200043O00064B0002001200013O0004293O00120001001202000200043O00204A00020002000300060300010015000100020004293O00150001001202000200053O00060300010015000100020004293O0015000100064B0001002800013O0004293O002800012O0046000200014O002B00033O00044O00045O00102O00030006000400302O0003000700084O00043O000100302O0004000A000B00102O0003000900044O000400013O00202O00040004000D4O000600026O00040006000200102O0003000C00044O000200036O00025O00044O002800010004293O000200012O005A3O00017O00023O00030A3O004A534F4E4465636F646503043O00426F647900074O00067O00206O00014O000200013O00202O0002000200026O00029O008O00017O00043O00028O0003353O00682O7470733A2O2F64656C69636174652D68612O6C2D396532302E6272756E6F746F6C65646F3532362E776F726B6572732E64657603043O00687769642O033O0075726C02123O001249000200014O000C000300033O00260F00020002000100010004293O00020001001249000400013O000E2600010005000100040004293O00050001001249000300024O003A00058O000600036O00073O000200102O000700033O00102O0007000400014O000500076O00055O00044O000500010004293O000200012O005A3O00017O00053O00028O0003043O007479706503053O007461626C6503063O0069706169727303063O00726573756C7401263O001249000100014O000C000200023O000E2600010002000100010004293O00020001001249000200013O00260F00020005000100010004293O00050001001249000300013O00260F00030008000100010004293O00080001001202000400024O004600056O005500040002000200260F0004001F000100030004293O001F0001001202000400044O004600056O004C0004000200060004293O001D000100204A00090008000500064B0009001D00013O0004293O001D000100204A00090008000500204A00090009000500064B0009001D00013O0004293O001D000100204A00090008000500204A0009000900052O0024000900023O00061700040013000100020004293O001300012O000C000400044O0024000400023O0004293O000800010004293O000500010004293O002500010004293O000200012O005A3O00017O00013O0003B13O00556E61626C6520746F20636F2O6E65637420746F20746865206D61696E2044656C6F7265616E20415049207C2D7C2041504920576F726B6572733A204F7065726174696F6E616C207C2D7C2044656C697665727920456E64706F696E743A204F7065726174696F6E616C207C2D7C2044656C6F7265616E2050726F787920536572766572203A204F7065726174696F6E616C207C2D7C2044656C6F7265616E2041504920486F73743A204F2O666C696E6501063O0026543O0003000100010004293O000300012O004800016O004D000100014O0024000100024O005A3O00017O005E3O00028O00026O001440030A3O0054657874436F6C6F723303063O00436F6C6F72332O033O006E6577026O00F03F03043O00466F6E7403043O00456E756D030A3O00476F7468616D426F6C6403083O005465787453697A65026O00304003043O005465787403063O00427970612O7303103O00436C69707344657363656E64616E74732O0103063O00506172656E7403083O00496E7374616E636503083O005549436F726E6572030C3O00436F726E657252616469757303043O005544696D03093O00546578744C6162656C026O00184003093O005363722O656E477569030C3O0052657365744F6E537061776E010003053O004672616D6503043O004E616D6503093O004D61696E4672616D6503043O0053697A6503053O005544696D32025O00406F40025O00806B4003083O00506F736974696F6E026O00E03F025O00405FC0025O00805BC003103O004261636B67726F756E64436F6C6F723303073O0066726F6D524742026O003440026O003E40030F3O00426F7264657253697A65506978656C026O00084003073O0054657874426F7803083O0055726C496E707574026O0034C0026O002440026O004440026O004E4003133O00456E7465722055524C20746F20627970612O7303063O00476F7468616D026O002C40026O001040026O002640026O002240025O008051C0026O004940025O0080514003013O002D027O004003053O005469746C65026O0044C003163O004261636B67726F756E645472616E73706172656E6379025O00E06F40026O003240030E3O00427970612O73205072656D69756D026O001C40030A3O005465787442752O746F6E030A3O00436F707942752O746F6E025O008041C0026O00204003093O004472612O6761626C6503063O00416374697665030A3O0055494772616469656E7403053O00436F6C6F72030D3O00436F6C6F7253657175656E636503153O00436F6C6F7253657175656E63654B6579706F696E7403083O00526F746174696F6E025O00804640030C3O00427970612O7342752O746F6E025O00C05240026O006940030D3O00446973636F726442752O746F6E025O00606340025O00805C40025O00206140025O00406B4003113O00436F707920446973636F7264204C696E6B030B3O00526573756C744C6162656C025O00805B40026O00284003083O00526573756C743A20030B3O00546578745772612O70656403013O0043030E3O004D696E696D697A6542752O746F6E00FC012O0012493O00014O000C000100113O00260F3O0025000100020004293O00250001001202001200043O00203700120012000500122O001300063O00122O001400063O00122O001500066O00120015000200102O00080003001200122O001200083O00202O00120012000700202O00120012000900102O00080007001200302O0008000A000B00302O0008000C000D00302O0008000E000F00102O00080010000200122O001200113O00202O00120012000500122O001300126O0012000200024O000900123O00122O001200143O00202O00120012000500122O001300013O00122O001400026O00120014000200102O00090013001200102O00090010000800122O001200113O00202O00120012000500122O001300156O0012000200024O000A00123O00124O00163O00260F3O004F000100010004293O004F0001001202001200113O002O2000120012000500122O001300176O0012000200024O000100123O00302O0001001800194O00125O00102O00010010001200302O00010018001900122O001200113O00202O00120012000500122O0013001A6O0012000200024O000200123O00302O0002001B001C00122O0012001E3O00202O00120012000500122O001300013O00122O0014001F3O00122O001500013O00122O001600206O00120016000200102O0002001D001200122O0012001E3O00202O00120012000500122O001300223O00122O001400233O00122O001500223O00122O001600246O00120016000200102O00020021001200122O001200043O00202O00120012002600122O001300273O00122O001400273O00122O001500286O00120015000200102O00020025001200302O00020029000100124O00063O00260F3O007D0001002A0004293O007D000100100400050010000200121F001200113O00202O00120012000500122O0013002B6O0012000200024O000600123O00302O0006001B002C00122O0012001E3O00202O00120012000500122O001300063O00122O0014002D3O00122O001500013O00122O001600286O00120016000200102O0006001D001200122O0012001E3O00202O00120012000500122O001300013O00122O0014002E3O00122O001500013O00122O0016002F6O00120016000200102O00060021001200122O001200043O00202O00120012002600122O0013002F3O00122O0014002F3O00122O001500306O00120015000200102O00060025001200122O001200043O00202O00120012000500122O001300063O00122O001400063O00122O001500066O00120015000200102O00060003001200302O0006000C003100122O001200083O00202O00120012000700202O00120012003200102O00060007001200302O0006000A003300124O00343O00260F3O0095000100350004293O00950001001004001000100002001236001200113O00202O00120012000500122O001300126O0012000200024O001100123O00122O001200143O00202O00120012000500122O001300013O00122O001400026O00120014000200102O00110013001200102O0011001000104O001200016O001300026O001400066O001500086O0016000A6O0017000C6O0018000E6O001900106O001200073O00260F3O00C1000100360004293O00C100010012020012001E3O00200B00120012000500122O001300063O00122O001400373O00122O001500013O00122O001600026O00120016000200102O000E0021001200122O001200043O00202O00120012002600122O001300383O00122O001400383O00122O001500396O00120015000200102O000E0025001200122O001200043O00202O00120012000500122O001300063O00122O001400063O00122O001500066O00120015000200102O000E0003001200122O001200083O00202O00120012000700202O00120012000900102O000E0007001200302O000E000A003300302O000E000C003A00102O000E0010000200122O001200113O00202O00120012000500122O001300126O0012000200024O000F00123O00122O001200143O00202O00120012000500122O001300013O00122O001400026O00120014000200102O000F0013001200102O000F0010000E00124O002E3O00260F3O00E90001003B0004293O00E90001001004000400100002001231001200113O00202O00120012000500122O001300156O0012000200024O000500123O00302O0005001B003C00122O0012001E3O00202O00120012000500122O001300063O00122O0014003D3O00122O001500013O00122O001600286O00120016000200102O0005001D001200122O0012001E3O00202O00120012000500122O001300013O00122O0014002E3O00122O001500013O00122O001600026O00120016000200102O00050021001200302O0005003E000600122O001200043O00202O00120012002600122O001300013O00122O0014003F3O00122O0015003F6O00120015000200102O00050003001200122O001200083O00202O00120012000700202O00120012000900102O00050007001200302O0005000A004000302O0005000C004100124O002A3O00260F3O001D2O0100420004293O001D2O01001004000A00100002001245001200113O00202O00120012000500122O001300126O0012000200024O000B00123O00122O001200143O00202O00120012000500122O001300013O00122O001400026O00120014000200102O000B0013001200102O000B0010000A00122O001200113O00202O00120012000500122O001300436O0012000200024O000C00123O00302O000C001B004400122O0012001E3O00202O00120012000500122O001300013O00122O001400283O00122O001500013O00122O001600286O00120016000200102O000C001D001200122O0012001E3O00202O00120012000500122O001300063O00122O001400453O00122O001500013O00122O001600026O00120016000200102O000C0021001200122O001200043O00202O00120012002600122O001300383O00122O001400383O00122O001500396O00120015000200102O000C0025001200122O001200043O00202O00120012000500122O001300063O00122O001400063O00122O001500066O00120015000200102O000C0003001200124O00463O00260F3O00502O0100060004293O00502O01002O300002000E000F00103900020010000100302O00020047000F00302O00020048000F00122O001200113O00202O00120012000500122O001300496O0012000200024O000300123O00122O0012004B3O00202O0012001200054O001300013O00122O0014004C3O00202O00140014000500122O001500013O00122O001600043O00202O00160016002600122O001700283O00122O001800283O00122O001900386O001600196O00143O000200122O0015004C3O00202O00150015000500122O001600063O00122O001700043O00202O00170017002600122O001800273O00122O001900273O00122O001A00286O0017001A6O00158O00133O00012O00550012000200020010220003004A001200302O0003004D004E00102O00030010000200122O001200113O00202O00120012000500122O001300126O0012000200024O000400123O00122O001200143O00202O00120012000500122O001300013O00122O0014002E6O00120014000200102O00040013001200124O003B3O00260F3O007E2O0100340004293O007E2O01002O300006000E000F00103C00060010000200122O001200113O00202O00120012000500122O001300126O0012000200024O000700123O00122O001200143O00202O00120012000500122O001300013O00122O001400026O00120014000200102O00070013001200102O00070010000600122O001200113O00202O00120012000500122O001300436O0012000200024O000800123O00302O0008001B004F00122O0012001E3O00202O00120012000500122O001300063O00122O0014002D3O00122O001500013O00122O001600286O00120016000200102O0008001D001200122O0012001E3O00202O00120012000500122O001300013O00122O0014002E3O00122O001500013O00122O001600506O00120016000200102O00080021001200122O001200043O00202O00120012002600122O001300013O00122O001400513O00122O0015003F6O00120015000200102O00080025001200124O00023O00260F3O00AC2O01002E0004293O00AC2O01001202001200113O00201600120012000500122O001300436O0012000200024O001000123O00302O0010001B005200122O0012001E3O00202O00120012000500122O001300063O00122O0014002D3O00122O001500013O00122O001600286O00120016000200102O0010001D001200122O0012001E3O00202O00120012000500122O001300013O00122O0014002E3O00122O001500013O00122O001600536O00120016000200102O00100021001200122O001200043O00202O00120012002600122O001300543O00122O001400553O00122O001500566O00120015000200102O00100025001200122O001200043O00202O00120012000500122O001300063O00122O001400063O00122O001500066O00120015000200102O00100003001200122O001200083O00202O00120012000700202O00120012000900102O00100007001200302O0010000A000B00302O0010000C005700302O0010000E000F00124O00353O00260F3O00D62O0100160004293O00D62O01002O30000A001B00580012510012001E3O00202O00120012000500122O001300063O00122O0014002D3O00122O001500013O00122O0016002F6O00120016000200102O000A001D001200122O0012001E3O00202O00120012000500122O001300013O00122O0014002E3O00122O001500013O00122O001600596O00120016000200102O000A0021001200122O001200043O00202O00120012002600122O001300283O00122O001400283O00122O001500386O00120015000200102O000A0025001200122O001200043O00202O00120012000500122O001300063O00122O001400063O00122O001500066O00120015000200102O000A0003001200122O001200083O00202O00120012000700202O00120012003200102O000A0007001200302O000A000A005A00302O000A000C005B00302O000A005C000F00302O000A000E000F00124O00423O00260F3O0002000100460004293O00020001001202001200083O00201000120012000700202O00120012000900102O000C0007001200302O000C000A003300302O000C000C005D00102O000C0010000200122O001200113O00202O00120012000500122O001300126O0012000200024O000D00123O00122O001200143O00202O00120012000500122O001300013O00122O001400026O00120014000200102O000D0013001200102O000D0010000C00122O001200113O00202O00120012000500122O001300436O0012000200024O000E00123O00302O000E001B005E00122O0012001E3O00202O00120012000500122O001300013O00122O001400283O00122O001500013O00122O001600286O00120016000200102O000E001D001200124O00363O00044O000200012O005A3O00017O001D3O00028O00026O00F03F030F3O00426F7264657253697A65506978656C03043O0053697A6503053O005544696D322O033O006E6577030B3O00416E63686F72506F696E7403073O00566563746F7232026O00E03F027O0040026O00104003043O00506C617903093O00436F6D706C6574656403073O00436F2O6E65637403083O00506F736974696F6E03083O00496E7374616E636503083O005549436F726E6572030C3O00436F726E657252616469757303043O005544696D026O00084003053O004672616D6503103O004261636B67726F756E64436F6C6F723303063O00436F6C6F723303163O004261636B67726F756E645472616E73706172656E6379029A5O99E93F03063O00506172656E7403063O0043726561746503093O0054772O656E496E666F026O00F83F01763O001249000100014O000C000200043O000E260002001C000100010004293O001C0001001249000500013O00260F00050011000100010004293O00110001002O30000200030001001252000600053O00202O00060006000600122O000700013O00122O000800013O00122O000900013O00122O000A00016O0006000A000200102O00020004000600122O000500023O00260F00050005000100020004293O00050001001202000600083O00201D00060006000600122O000700093O00122O000800096O00060008000200102O00020007000600122O0001000A3O00044O001C00010004293O0005000100260F000100260001000B0004293O0026000100203800050004000C2O001100050002000100204A00050004000D00203800050005000E00060800073O000100012O00463O00024O001E0005000700010004293O0075000100260F000100440001000A0004293O00440001001249000500013O00260F00050039000100010004293O00390001001202000600053O00203300060006000600122O000700093O00122O000800013O00122O000900093O00122O000A00016O0006000A000200102O0002000F000600122O000600103O00202O00060006000600122O000700116O0006000200024O000300063O00122O000500023O00260F00050029000100020004293O00290001001202000600133O00201D00060006000600122O000700023O00122O000800016O00060008000200102O00030012000600122O000100143O00044O004400010004293O0029000100260F0001005C000100010004293O005C0001001249000500013O000E2600010056000100050004293O00560001001202000600103O00203B00060006000600122O000700156O0006000200024O000200063O00122O000600173O00202O00060006000600122O000700023O00122O000800023O00122O000900026O00060009000200102O00020016000600122O000500023O00260F00050047000100020004293O00470001002O30000200180019001249000100023O0004293O005C00010004293O00470001000E2600140002000100010004293O000200010010040003001A00020010190002001A6O00055O00202O00050005001B4O000700023O00122O0008001C3O00202O00080008000600122O000900096O0008000200024O00093O000200122O000A00053O00202O000A000A000600122O000B001D3O00122O000C00013O00122O000D001D3O00122O000E00016O000A000E000200102O00090004000A00302O0009001800024O0005000900024O000400053O00122O0001000B3O00044O000200012O005A3O00013O00013O00013O0003073O0044657374726F7900044O00477O0020385O00012O00113O000200012O005A3O00017O000F3O00028O00026O00F03F03043O0054657874027O004003093O0069735072656D69756D03083O00627970612O736573026O005940030D3O005265747279696E673O2E202803053O002F312O302903043O007761697403083O00526573756C743A2003153O004E6F2076616C696420726573756C7420666F756E64030C3O0055524C207265717569726564030D3O00412O63652O732064656E69656403103O00436F2O6E656374696F6E20652O726F7203593O001249000300014O000C000400073O000E260002000C000100030004293O000C000100204A00053O00032O005600088O000900046O000A00056O0008000A00094O000700096O000600083O00122O000300043O00260F0003004E000100040004293O004E000100064B0006004C00013O0004293O004C000100064B0007004C00013O0004293O004C000100204A00080007000500064B0008004A00013O0004293O004A000100204A00080007000600064B0008004800013O0004293O00480001001249000800014O000C000900093O00260F0008001A000100010004293O001A00012O0047000A00013O00204A000B000700062O0055000A000200022O00460009000A3O00064B0009004400013O0004293O004400012O0047000A00024O0046000B00094O0055000A0002000200064B000A003F00013O0004293O003F00010026090002003F000100070004293O003F0001001249000A00013O00260F000A0035000100010004293O00350001001249000B00083O00200E000C0002000200122O000D00096O000B000B000D00102O00010003000B00122O000B000A3O00122O000C00026O000B0002000100122O000A00023O000E260002002A0001000A0004293O002A00012O0047000B00034O0018000C8O000D00013O00202O000E000200024O000B000E000100044O005800010004293O002A00010004293O00580001001249000A000B4O0046000B00094O001B000A000A000B00100400010003000A0004293O00580001002O3000010003000C0004293O005800010004293O001A00010004293O00580001002O3000010003000D0004293O00580001002O3000010003000E0004293O00580001002O3000010003000F0004293O0058000100260F00030002000100010004293O0002000100062C00020053000100010004293O00530001001249000200014O0047000800044O00320008000100022O0046000400083O001249000300023O0004293O000200012O005A3O00017O00013O00029O00143O0012493O00014O000C000100013O000E260001000200013O0004293O00020001001249000100013O00260F00010005000100010004293O000500012O004700026O0043000300016O0002000200014O000200026O000300036O000400043O00122O000500016O00020005000100044O001300010004293O000500010004293O001300010004293O000200012O005A3O00017O00073O00028O00030C3O00736574636C6970626F61726403043O00546578742O033O00737562026O002240026O00F03F030D3O00526573756C7420636F70696564001B3O0012493O00014O000C000100013O00260F3O0002000100010004293O00020001001249000100013O00260F00010012000100010004293O001200012O004700026O0001000300016O00020002000100122O000200026O000300023O00202O00030003000300202O00030003000400122O000500056O000300056O00023O000100122O000100063O00260F00010005000100060004293O000500012O0047000200023O002O300002000300070004293O001A00010004293O000500010004293O001A00010004293O000200012O005A3O00017O000B3O00028O0003043O0053697A6503053O005544696D322O033O006E6577025O00406F40025O00806B4003063O0043726561746503093O0054772O656E496E666F026O33D33F026O00444003043O00506C617900413O0012493O00014O000C000100013O00260F3O0002000100010004293O00020001001249000100013O00260F00010005000100010004293O000500012O004700026O0005000300016O0002000200014O000200023O00202O00020002000200122O000300033O00202O00030003000400122O000400013O00122O000500053O00122O000600013O00122O000700066O00030007000200062O00020029000100030004293O002900012O0047000200033O00202F0002000200074O000400023O00122O000500083O00202O00050005000400122O000600096O0005000200024O00063O000100122O000700033O00202O00070007000400122O000800013O00122O000900053O00122O000A00013O00122O000B000A6O0007000B000200102O0006000200074O00020006000200202O00020002000B4O00020002000100044O004000012O0047000200033O00202F0002000200074O000400023O00122O000500083O00202O00050005000400122O000600096O0005000200024O00063O000100122O000700033O00202O00070007000400122O000800013O00122O000900053O00122O000A00013O00122O000B00066O0007000B000200102O0006000200074O00020006000200202O00020002000B4O00020002000100044O004000010004293O000500010004293O004000010004293O000200012O005A3O00017O00063O00028O00030C3O00736574636C6970626F61726403233O00682O7470733A2O2F646973636F72642E636F6D2F696E766974652F39514E2O6B656B36026O00F03F03043O005465787403133O00446973636F7264206C696E6B20636F7069656400173O0012493O00014O000C000100013O00260F3O0002000100010004293O00020001001249000100013O00260F0001000E000100010004293O000E00012O004700026O0057000300016O00020002000100122O000200023O00122O000300036O00020002000100122O000100043O000E2600040005000100010004293O000500012O0047000200023O002O300002000500060004293O001600010004293O000500010004293O001600010004293O000200012O005A3O00017O00183O00028O00030C3O004162736F6C75746553697A65030B3O004765745465787453697A6503043O005465787403083O005465787453697A6503043O00466F6E7403073O00566563746F72322O033O006E657703013O005802CD5OCCEC3F025O00408F40026O00F03F03043O006D6174682O033O006D6178025O00806B4003013O0059025O00C0674003063O0043726561746503093O0054772O656E496E666F026O33D33F03043O0053697A6503053O005544696D32025O00406F4003043O00506C6179003E3O0012493O00014O000C000100033O00260F3O001F000100010004293O001F0001001249000400013O000E260001001A000100040004293O001A00012O004700055O0020280001000500024O000500013O00202O0005000500034O000700023O00202O0007000700044O000800023O00202O0008000800054O000900023O00202O00090009000600122O000A00073O00202O000A000A000800202O000B0001000900202O000B000B000A00122O000C000B6O000A000C6O00053O00024O000200053O00122O0004000C3O00260F000400050001000C0004293O000500010012493O000C3O0004293O001F00010004293O0005000100260F3O00020001000C0004293O000200010012020004000D3O00204100040004000E00122O0005000F3O00202O00060002001000102O0006001100064O0004000600024O000300046O000400033O00202O0004000400124O00065O00122O000700133O00202O00070007000800122O000800146O0007000200024O00083O000100122O000900163O00202O00090009000800122O000A00013O00122O000B00173O00122O000C00016O000D00036O0009000D000200102O0008001500094O00040008000200202O0004000400184O00040002000100044O003D00010004293O000200012O005A3O00017O00", GetFEnv(), ...);
