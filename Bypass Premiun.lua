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
			local FlatIdent_129E6 = 0;
			local a;
			while true do
				if (0 == FlatIdent_129E6) then
					a = Char(StrToNumber(byte, 16));
					if repeatNext then
						local FlatIdent_2C0A2 = 0;
						local b;
						while true do
							if (FlatIdent_2C0A2 == 0) then
								b = Rep(a, repeatNext);
								repeatNext = nil;
								FlatIdent_2C0A2 = 1;
							end
							if (FlatIdent_2C0A2 == 1) then
								return b;
							end
						end
					else
						return a;
					end
					break;
				end
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local FlatIdent_77CC3 = 0;
			local Res;
			while true do
				if (FlatIdent_77CC3 == 0) then
					Res = (Bit / (2 ^ (Start - 1))) % (2 ^ (((End - 1) - (Start - 1)) + 1));
					return Res - (Res % 1);
				end
			end
		else
			local FlatIdent_3416F = 0;
			local Plc;
			while true do
				if (FlatIdent_3416F == 0) then
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
		local FlatIdent_95CAC = 0;
		local a;
		local b;
		while true do
			if (FlatIdent_95CAC == 1) then
				return (b * 256) + a;
			end
			if (FlatIdent_95CAC == 0) then
				a, b = Byte(ByteString, DIP, DIP + 2);
				DIP = DIP + 2;
				FlatIdent_95CAC = 1;
			end
		end
	end
	local function gBits32()
		local a, b, c, d = Byte(ByteString, DIP, DIP + 3);
		DIP = DIP + 4;
		return (d * 16777216) + (c * 65536) + (b * 256) + a;
	end
	local function gFloat()
		local FlatIdent_8D327 = 0;
		local Left;
		local Right;
		local IsNormal;
		local Mantissa;
		local Exponent;
		local Sign;
		while true do
			if (FlatIdent_8D327 == 2) then
				Exponent = gBit(Right, 21, 31);
				Sign = ((gBit(Right, 32) == 1) and -1) or 1;
				FlatIdent_8D327 = 3;
			end
			if (FlatIdent_8D327 == 1) then
				IsNormal = 1;
				Mantissa = (gBit(Right, 1, 20) * (2 ^ 32)) + Left;
				FlatIdent_8D327 = 2;
			end
			if (FlatIdent_8D327 == 3) then
				if (Exponent == 0) then
					if (Mantissa == 0) then
						return Sign * 0;
					else
						Exponent = 1;
						IsNormal = 0;
					end
				elseif (Exponent == 2047) then
					return ((Mantissa == 0) and (Sign * (1 / 0))) or (Sign * NaN);
				end
				return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
			end
			if (FlatIdent_8D327 == 0) then
				Left = gBits32();
				Right = gBits32();
				FlatIdent_8D327 = 1;
			end
		end
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
		local FlatIdent_47A9C = 0;
		local Instrs;
		local Functions;
		local Lines;
		local Chunk;
		local ConstCount;
		local Consts;
		while true do
			if (FlatIdent_47A9C == 0) then
				Instrs = {};
				Functions = {};
				Lines = {};
				Chunk = {Instrs,Functions,nil,Lines};
				FlatIdent_47A9C = 1;
			end
			if (FlatIdent_47A9C == 2) then
				for Idx = 1, gBits32() do
					local Descriptor = gBits8();
					if (gBit(Descriptor, 1, 1) == 0) then
						local FlatIdent_8199B = 0;
						local Type;
						local Mask;
						local Inst;
						while true do
							if (FlatIdent_8199B == 2) then
								if (gBit(Mask, 1, 1) == 1) then
									Inst[2] = Consts[Inst[2]];
								end
								if (gBit(Mask, 2, 2) == 1) then
									Inst[3] = Consts[Inst[3]];
								end
								FlatIdent_8199B = 3;
							end
							if (1 == FlatIdent_8199B) then
								Inst = {gBits16(),gBits16(),nil,nil};
								if (Type == 0) then
									Inst[3] = gBits16();
									Inst[4] = gBits16();
								elseif (Type == 1) then
									Inst[3] = gBits32();
								elseif (Type == 2) then
									Inst[3] = gBits32() - (2 ^ 16);
								elseif (Type == 3) then
									local FlatIdent_4D69A = 0;
									while true do
										if (0 == FlatIdent_4D69A) then
											Inst[3] = gBits32() - (2 ^ 16);
											Inst[4] = gBits16();
											break;
										end
									end
								end
								FlatIdent_8199B = 2;
							end
							if (FlatIdent_8199B == 0) then
								Type = gBit(Descriptor, 2, 3);
								Mask = gBit(Descriptor, 4, 6);
								FlatIdent_8199B = 1;
							end
							if (FlatIdent_8199B == 3) then
								if (gBit(Mask, 3, 3) == 1) then
									Inst[4] = Consts[Inst[4]];
								end
								Instrs[Idx] = Inst;
								break;
							end
						end
					end
				end
				for Idx = 1, gBits32() do
					Functions[Idx - 1] = Deserialize();
				end
				return Chunk;
			end
			if (FlatIdent_47A9C == 1) then
				ConstCount = gBits32();
				Consts = {};
				for Idx = 1, ConstCount do
					local Type = gBits8();
					local Cons;
					if (Type == 1) then
						Cons = gBits8() ~= 0;
					elseif (Type == 2) then
						Cons = gFloat();
					elseif (Type == 3) then
						Cons = gString();
					end
					Consts[Idx] = Cons;
				end
				Chunk[3] = gBits8();
				FlatIdent_47A9C = 2;
			end
		end
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
				Inst = Instr[VIP];
				Enum = Inst[1];
				if (Enum <= 30) then
					if (Enum <= 14) then
						if (Enum <= 6) then
							if (Enum <= 2) then
								if (Enum <= 0) then
									local FlatIdent_61B23 = 0;
									local A;
									while true do
										if (FlatIdent_61B23 == 0) then
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											break;
										end
									end
								elseif (Enum == 1) then
									if (Inst[2] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
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
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
							elseif (Enum <= 4) then
								if (Enum > 3) then
									local FlatIdent_E652 = 0;
									local A;
									local Results;
									local Limit;
									local Edx;
									while true do
										if (0 == FlatIdent_E652) then
											A = Inst[2];
											Results, Limit = _R(Stk[A]());
											FlatIdent_E652 = 1;
										end
										if (2 == FlatIdent_E652) then
											for Idx = A, Top do
												local FlatIdent_49AED = 0;
												while true do
													if (FlatIdent_49AED == 0) then
														Edx = Edx + 1;
														Stk[Idx] = Results[Edx];
														break;
													end
												end
											end
											break;
										end
										if (FlatIdent_E652 == 1) then
											Top = (Limit + A) - 1;
											Edx = 0;
											FlatIdent_E652 = 2;
										end
									end
								else
									local FlatIdent_1E844 = 0;
									local B;
									while true do
										if (FlatIdent_1E844 == 0) then
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
							elseif (Enum > 5) then
								local A;
								local K;
								local B;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								B = Inst[3];
								K = Stk[B];
								for Idx = B + 1, Inst[4] do
									K = K .. Stk[Idx];
								end
								Stk[Inst[2]] = K;
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
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
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							elseif not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 10) then
							if (Enum <= 8) then
								if (Enum == 7) then
									local FlatIdent_99389 = 0;
									local A;
									while true do
										if (FlatIdent_99389 == 5) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Stk[A](Unpack(Stk, A + 1, Inst[3]));
											end
											FlatIdent_99389 = 6;
										end
										if (FlatIdent_99389 == 3) then
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_99389 = 4;
										end
										if (FlatIdent_99389 == 0) then
											A = nil;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_99389 = 1;
										end
										if (FlatIdent_99389 == 1) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = {};
											FlatIdent_99389 = 2;
										end
										if (FlatIdent_99389 == 2) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_99389 = 3;
										end
										if (FlatIdent_99389 == 6) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Unpack(Stk, A, Top);
											end
											FlatIdent_99389 = 7;
										end
										if (FlatIdent_99389 == 4) then
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
											FlatIdent_99389 = 5;
										end
										if (FlatIdent_99389 == 7) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											do
												return;
											end
											break;
										end
									end
								else
									local FlatIdent_8BF78 = 0;
									local A;
									while true do
										if (FlatIdent_8BF78 == 0) then
											A = Inst[2];
											Stk[A](Unpack(Stk, A + 1, Top));
											break;
										end
									end
								end
							elseif (Enum == 9) then
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							else
								Stk[Inst[2]] = Upvalues[Inst[3]];
							end
						elseif (Enum <= 12) then
							if (Enum > 11) then
								local FlatIdent_817B0 = 0;
								local A;
								while true do
									if (FlatIdent_817B0 == 0) then
										A = Inst[2];
										do
											return Unpack(Stk, A, A + Inst[3]);
										end
										break;
									end
								end
							else
								local B;
								local A;
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
						elseif (Enum > 13) then
							local FlatIdent_52551 = 0;
							local A;
							local B;
							while true do
								if (FlatIdent_52551 == 0) then
									A = Inst[2];
									B = Stk[Inst[3]];
									FlatIdent_52551 = 1;
								end
								if (FlatIdent_52551 == 1) then
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									break;
								end
							end
						else
							Stk[Inst[2]][Inst[3]] = Inst[4];
						end
					elseif (Enum <= 22) then
						if (Enum <= 18) then
							if (Enum <= 16) then
								if (Enum > 15) then
									local FlatIdent_98E39 = 0;
									local A;
									while true do
										if (FlatIdent_98E39 == 1) then
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											FlatIdent_98E39 = 2;
										end
										if (6 == FlatIdent_98E39) then
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_98E39 = 7;
										end
										if (2 == FlatIdent_98E39) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											FlatIdent_98E39 = 3;
										end
										if (FlatIdent_98E39 == 7) then
											VIP = Inst[3];
											break;
										end
										if (FlatIdent_98E39 == 5) then
											Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_98E39 = 6;
										end
										if (0 == FlatIdent_98E39) then
											A = nil;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											FlatIdent_98E39 = 1;
										end
										if (3 == FlatIdent_98E39) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											FlatIdent_98E39 = 4;
										end
										if (FlatIdent_98E39 == 4) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_98E39 = 5;
										end
									end
								elseif (Stk[Inst[2]] < Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 17) then
								local FlatIdent_2D88C = 0;
								local A;
								while true do
									if (FlatIdent_2D88C == 0) then
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										break;
									end
								end
							else
								local FlatIdent_D79D = 0;
								local A;
								while true do
									if (FlatIdent_D79D == 0) then
										A = nil;
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 1;
									end
									if (FlatIdent_D79D == 26) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_D79D = 27;
									end
									if (FlatIdent_D79D == 30) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_D79D = 31;
									end
									if (FlatIdent_D79D == 24) then
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_D79D = 25;
									end
									if (FlatIdent_D79D == 19) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_D79D = 20;
									end
									if (FlatIdent_D79D == 1) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										FlatIdent_D79D = 2;
									end
									if (FlatIdent_D79D == 15) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_D79D = 16;
									end
									if (FlatIdent_D79D == 18) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 19;
									end
									if (FlatIdent_D79D == 10) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_D79D = 11;
									end
									if (FlatIdent_D79D == 25) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_D79D = 26;
									end
									if (FlatIdent_D79D == 22) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_D79D = 23;
									end
									if (3 == FlatIdent_D79D) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 4;
									end
									if (FlatIdent_D79D == 8) then
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_D79D = 9;
									end
									if (21 == FlatIdent_D79D) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_D79D = 22;
									end
									if (FlatIdent_D79D == 17) then
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_D79D = 18;
									end
									if (4 == FlatIdent_D79D) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_D79D = 5;
									end
									if (FlatIdent_D79D == 9) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 10;
									end
									if (FlatIdent_D79D == 13) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_D79D = 14;
									end
									if (FlatIdent_D79D == 27) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_D79D = 28;
									end
									if (12 == FlatIdent_D79D) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										FlatIdent_D79D = 13;
									end
									if (FlatIdent_D79D == 23) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 24;
									end
									if (FlatIdent_D79D == 28) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										FlatIdent_D79D = 29;
									end
									if (FlatIdent_D79D == 20) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_D79D = 21;
									end
									if (FlatIdent_D79D == 16) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 17;
									end
									if (2 == FlatIdent_D79D) then
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Inst[4];
										FlatIdent_D79D = 3;
									end
									if (FlatIdent_D79D == 31) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										break;
									end
									if (FlatIdent_D79D == 29) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_D79D = 30;
									end
									if (FlatIdent_D79D == 7) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 8;
									end
									if (FlatIdent_D79D == 11) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_D79D = 12;
									end
									if (FlatIdent_D79D == 6) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_D79D = 7;
									end
									if (5 == FlatIdent_D79D) then
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 6;
									end
									if (14 == FlatIdent_D79D) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_D79D = 15;
									end
								end
							end
						elseif (Enum <= 20) then
							if (Enum == 19) then
								local A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							else
								local FlatIdent_202CC = 0;
								local A;
								while true do
									if (FlatIdent_202CC == 4) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_202CC = 5;
									end
									if (FlatIdent_202CC == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_202CC = 1;
									end
									if (FlatIdent_202CC == 6) then
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										FlatIdent_202CC = 7;
									end
									if (FlatIdent_202CC == 5) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										FlatIdent_202CC = 6;
									end
									if (7 == FlatIdent_202CC) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
										break;
									end
									if (2 == FlatIdent_202CC) then
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										FlatIdent_202CC = 3;
									end
									if (3 == FlatIdent_202CC) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_202CC = 4;
									end
									if (FlatIdent_202CC == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_202CC = 2;
									end
								end
							end
						elseif (Enum == 21) then
							Stk[Inst[2]] = Wrap(Proto[Inst[3]], nil, Env);
						else
							Stk[Inst[2]] = Stk[Inst[3]];
						end
					elseif (Enum <= 26) then
						if (Enum <= 24) then
							if (Enum == 23) then
								local B;
								local A;
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
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
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
								Stk[Inst[2]] = Stk[Inst[3]];
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
							elseif (Stk[Inst[2]] ~= Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 25) then
							local FlatIdent_63AE4 = 0;
							local A;
							local Cls;
							while true do
								if (1 == FlatIdent_63AE4) then
									for Idx = 1, #Lupvals do
										local List = Lupvals[Idx];
										for Idz = 0, #List do
											local Upv = List[Idz];
											local NStk = Upv[1];
											local DIP = Upv[2];
											if ((NStk == Stk) and (DIP >= A)) then
												Cls[DIP] = NStk[DIP];
												Upv[1] = Cls;
											end
										end
									end
									break;
								end
								if (FlatIdent_63AE4 == 0) then
									A = Inst[2];
									Cls = {};
									FlatIdent_63AE4 = 1;
								end
							end
						else
							do
								return;
							end
						end
					elseif (Enum <= 28) then
						if (Enum == 27) then
							local A = Inst[2];
							Stk[A] = Stk[A]();
						elseif (Stk[Inst[2]] == Inst[4]) then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					elseif (Enum > 29) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
						VIP = Inst[3];
					end
				elseif (Enum <= 46) then
					if (Enum <= 38) then
						if (Enum <= 34) then
							if (Enum <= 32) then
								if (Enum == 31) then
									local FlatIdent_31ECC = 0;
									local B;
									local A;
									while true do
										if (FlatIdent_31ECC == 2) then
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											FlatIdent_31ECC = 3;
										end
										if (FlatIdent_31ECC == 0) then
											B = nil;
											A = nil;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											FlatIdent_31ECC = 1;
										end
										if (FlatIdent_31ECC == 6) then
											Inst = Instr[VIP];
											do
												return;
											end
											break;
										end
										if (FlatIdent_31ECC == 1) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_31ECC = 2;
										end
										if (FlatIdent_31ECC == 3) then
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											FlatIdent_31ECC = 4;
										end
										if (5 == FlatIdent_31ECC) then
											A = Inst[2];
											do
												return Unpack(Stk, A, Top);
											end
											VIP = VIP + 1;
											FlatIdent_31ECC = 6;
										end
										if (4 == FlatIdent_31ECC) then
											do
												return Stk[A](Unpack(Stk, A + 1, Inst[3]));
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											FlatIdent_31ECC = 5;
										end
									end
								else
									local A = Inst[2];
									local Results = {Stk[A](Unpack(Stk, A + 1, Inst[3]))};
									local Edx = 0;
									for Idx = A, Inst[4] do
										local FlatIdent_43337 = 0;
										while true do
											if (FlatIdent_43337 == 0) then
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
												break;
											end
										end
									end
								end
							elseif (Enum == 33) then
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							else
								local FlatIdent_1F33B = 0;
								local B;
								local A;
								while true do
									if (FlatIdent_1F33B == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1F33B = 4;
									end
									if (5 == FlatIdent_1F33B) then
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										break;
									end
									if (FlatIdent_1F33B == 4) then
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										FlatIdent_1F33B = 5;
									end
									if (FlatIdent_1F33B == 2) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_1F33B = 3;
									end
									if (FlatIdent_1F33B == 0) then
										B = nil;
										A = nil;
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										FlatIdent_1F33B = 1;
									end
									if (1 == FlatIdent_1F33B) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_1F33B = 2;
									end
								end
							end
						elseif (Enum <= 36) then
							if (Enum == 35) then
								local FlatIdent_1468D = 0;
								local A;
								while true do
									if (FlatIdent_1468D == 3) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1468D = 4;
									end
									if (FlatIdent_1468D == 1) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1468D = 2;
									end
									if (4 == FlatIdent_1468D) then
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										FlatIdent_1468D = 5;
									end
									if (FlatIdent_1468D == 0) then
										A = nil;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_1468D = 1;
									end
									if (FlatIdent_1468D == 2) then
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_1468D = 3;
									end
									if (8 == FlatIdent_1468D) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										break;
									end
									if (FlatIdent_1468D == 7) then
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										FlatIdent_1468D = 8;
									end
									if (FlatIdent_1468D == 5) then
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										FlatIdent_1468D = 6;
									end
									if (FlatIdent_1468D == 6) then
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										FlatIdent_1468D = 7;
									end
								end
							else
								Stk[Inst[2]] = Inst[3] ~= 0;
							end
						elseif (Enum > 37) then
							local A = Inst[2];
							local Results = {Stk[A](Stk[A + 1])};
							local Edx = 0;
							for Idx = A, Inst[4] do
								local FlatIdent_1E39B = 0;
								while true do
									if (FlatIdent_1E39B == 0) then
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
										break;
									end
								end
							end
						else
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
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
							Stk[Inst[2]] = Stk[Inst[3]];
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
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						end
					elseif (Enum <= 42) then
						if (Enum <= 40) then
							if (Enum > 39) then
								local FlatIdent_3ACCC = 0;
								local B;
								local K;
								while true do
									if (FlatIdent_3ACCC == 1) then
										for Idx = B + 1, Inst[4] do
											K = K .. Stk[Idx];
										end
										Stk[Inst[2]] = K;
										break;
									end
									if (FlatIdent_3ACCC == 0) then
										B = Inst[3];
										K = Stk[B];
										FlatIdent_3ACCC = 1;
									end
								end
							elseif Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum > 41) then
							local A;
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
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
						else
							local FlatIdent_8A1DB = 0;
							local B;
							local A;
							while true do
								if (FlatIdent_8A1DB == 5) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_8A1DB = 6;
								end
								if (7 == FlatIdent_8A1DB) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									FlatIdent_8A1DB = 8;
								end
								if (FlatIdent_8A1DB == 4) then
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									FlatIdent_8A1DB = 5;
								end
								if (FlatIdent_8A1DB == 8) then
									Stk[A] = B[Inst[4]];
									break;
								end
								if (FlatIdent_8A1DB == 3) then
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									FlatIdent_8A1DB = 4;
								end
								if (FlatIdent_8A1DB == 6) then
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									FlatIdent_8A1DB = 7;
								end
								if (FlatIdent_8A1DB == 2) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									FlatIdent_8A1DB = 3;
								end
								if (FlatIdent_8A1DB == 1) then
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									FlatIdent_8A1DB = 2;
								end
								if (FlatIdent_8A1DB == 0) then
									B = nil;
									A = nil;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_8A1DB = 1;
								end
							end
						end
					elseif (Enum <= 44) then
						if (Enum == 43) then
							Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
						else
							do
								return Stk[Inst[2]];
							end
						end
					elseif (Enum > 45) then
						Stk[Inst[2]] = Env[Inst[3]];
					else
						local Edx;
						local Results;
						local A;
						A = Inst[2];
						Stk[A] = Stk[A]();
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Results = {Stk[A](Unpack(Stk, A + 1, Inst[3]))};
						Edx = 0;
						for Idx = A, Inst[4] do
							local FlatIdent_2C2F3 = 0;
							while true do
								if (FlatIdent_2C2F3 == 0) then
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
									break;
								end
							end
						end
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
					end
				elseif (Enum <= 54) then
					if (Enum <= 50) then
						if (Enum <= 48) then
							if (Enum == 47) then
								local A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
								Stk[Inst[2]][Inst[3]] = Inst[4];
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
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
							end
						elseif (Enum > 49) then
							local A = Inst[2];
							do
								return Unpack(Stk, A, Top);
							end
						else
							local FlatIdent_630B0 = 0;
							local NewProto;
							local NewUvals;
							local Indexes;
							while true do
								if (FlatIdent_630B0 == 0) then
									NewProto = Proto[Inst[3]];
									NewUvals = nil;
									FlatIdent_630B0 = 1;
								end
								if (FlatIdent_630B0 == 2) then
									for Idx = 1, Inst[4] do
										VIP = VIP + 1;
										local Mvm = Instr[VIP];
										if (Mvm[1] == 22) then
											Indexes[Idx - 1] = {Stk,Mvm[3]};
										else
											Indexes[Idx - 1] = {Upvalues,Mvm[3]};
										end
										Lupvals[#Lupvals + 1] = Indexes;
									end
									Stk[Inst[2]] = Wrap(NewProto, NewUvals, Env);
									break;
								end
								if (1 == FlatIdent_630B0) then
									Indexes = {};
									NewUvals = Setmetatable({}, {__index=function(_, Key)
										local FlatIdent_835BC = 0;
										local Val;
										while true do
											if (0 == FlatIdent_835BC) then
												Val = Indexes[Key];
												return Val[1][Val[2]];
											end
										end
									end,__newindex=function(_, Key, Value)
										local FlatIdent_145D2 = 0;
										local Val;
										while true do
											if (FlatIdent_145D2 == 0) then
												Val = Indexes[Key];
												Val[1][Val[2]] = Value;
												break;
											end
										end
									end});
									FlatIdent_630B0 = 2;
								end
							end
						end
					elseif (Enum <= 52) then
						if (Enum == 51) then
							local FlatIdent_6D884 = 0;
							local A;
							while true do
								if (FlatIdent_6D884 == 2) then
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									FlatIdent_6D884 = 3;
								end
								if (3 == FlatIdent_6D884) then
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									FlatIdent_6D884 = 4;
								end
								if (FlatIdent_6D884 == 4) then
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									FlatIdent_6D884 = 5;
								end
								if (FlatIdent_6D884 == 6) then
									VIP = Inst[3];
									break;
								end
								if (FlatIdent_6D884 == 5) then
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_6D884 = 6;
								end
								if (FlatIdent_6D884 == 1) then
									A = Inst[2];
									Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_6D884 = 2;
								end
								if (FlatIdent_6D884 == 0) then
									A = nil;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									FlatIdent_6D884 = 1;
								end
							end
						else
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum > 53) then
						local FlatIdent_90A69 = 0;
						local A;
						while true do
							if (FlatIdent_90A69 == 0) then
								A = nil;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								FlatIdent_90A69 = 1;
							end
							if (FlatIdent_90A69 == 22) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								FlatIdent_90A69 = 23;
							end
							if (FlatIdent_90A69 == 31) then
								Stk[Inst[2]] = Stk[Inst[3]];
								break;
							end
							if (FlatIdent_90A69 == 4) then
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								FlatIdent_90A69 = 5;
							end
							if (5 == FlatIdent_90A69) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 6;
							end
							if (FlatIdent_90A69 == 29) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								FlatIdent_90A69 = 30;
							end
							if (FlatIdent_90A69 == 25) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 26;
							end
							if (FlatIdent_90A69 == 23) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								FlatIdent_90A69 = 24;
							end
							if (FlatIdent_90A69 == 9) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_90A69 = 10;
							end
							if (FlatIdent_90A69 == 16) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 17;
							end
							if (FlatIdent_90A69 == 3) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 4;
							end
							if (FlatIdent_90A69 == 24) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								FlatIdent_90A69 = 25;
							end
							if (FlatIdent_90A69 == 2) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								FlatIdent_90A69 = 3;
							end
							if (FlatIdent_90A69 == 7) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 8;
							end
							if (FlatIdent_90A69 == 10) then
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_90A69 = 11;
							end
							if (FlatIdent_90A69 == 30) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 31;
							end
							if (21 == FlatIdent_90A69) then
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								FlatIdent_90A69 = 22;
							end
							if (12 == FlatIdent_90A69) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								FlatIdent_90A69 = 13;
							end
							if (FlatIdent_90A69 == 26) then
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_90A69 = 27;
							end
							if (FlatIdent_90A69 == 8) then
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_90A69 = 9;
							end
							if (14 == FlatIdent_90A69) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 15;
							end
							if (FlatIdent_90A69 == 18) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 19;
							end
							if (11 == FlatIdent_90A69) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								FlatIdent_90A69 = 12;
							end
							if (FlatIdent_90A69 == 20) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_90A69 = 21;
							end
							if (15 == FlatIdent_90A69) then
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_90A69 = 16;
							end
							if (FlatIdent_90A69 == 28) then
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								FlatIdent_90A69 = 29;
							end
							if (FlatIdent_90A69 == 13) then
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Inst[4];
								FlatIdent_90A69 = 14;
							end
							if (FlatIdent_90A69 == 1) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								FlatIdent_90A69 = 2;
							end
							if (FlatIdent_90A69 == 6) then
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_90A69 = 7;
							end
							if (27 == FlatIdent_90A69) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_90A69 = 28;
							end
							if (FlatIdent_90A69 == 17) then
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_90A69 = 18;
							end
							if (FlatIdent_90A69 == 19) then
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								FlatIdent_90A69 = 20;
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
				elseif (Enum <= 58) then
					if (Enum <= 56) then
						if (Enum == 55) then
							Stk[Inst[2]] = {};
						else
							local FlatIdent_7308B = 0;
							local A;
							while true do
								if (FlatIdent_7308B == 0) then
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									break;
								end
							end
						end
					elseif (Enum == 57) then
						local FlatIdent_30E68 = 0;
						local Edx;
						local Results;
						local Limit;
						local A;
						while true do
							if (FlatIdent_30E68 == 6) then
								Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								break;
							end
							if (FlatIdent_30E68 == 3) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								FlatIdent_30E68 = 4;
							end
							if (FlatIdent_30E68 == 2) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_30E68 = 3;
							end
							if (FlatIdent_30E68 == 0) then
								Edx = nil;
								Results, Limit = nil;
								A = nil;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								FlatIdent_30E68 = 1;
							end
							if (FlatIdent_30E68 == 1) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								FlatIdent_30E68 = 2;
							end
							if (FlatIdent_30E68 == 5) then
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								FlatIdent_30E68 = 6;
							end
							if (FlatIdent_30E68 == 4) then
								A = Inst[2];
								Results, Limit = _R(Stk[A]());
								Top = (Limit + A) - 1;
								Edx = 0;
								FlatIdent_30E68 = 5;
							end
						end
					else
						local FlatIdent_943B = 0;
						local A;
						while true do
							if (FlatIdent_943B == 2) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_943B = 3;
							end
							if (FlatIdent_943B == 3) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_943B = 4;
							end
							if (FlatIdent_943B == 4) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_943B = 5;
							end
							if (FlatIdent_943B == 1) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								FlatIdent_943B = 2;
							end
							if (FlatIdent_943B == 5) then
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								FlatIdent_943B = 6;
							end
							if (FlatIdent_943B == 8) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								break;
							end
							if (FlatIdent_943B == 7) then
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								FlatIdent_943B = 8;
							end
							if (FlatIdent_943B == 0) then
								A = nil;
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								FlatIdent_943B = 1;
							end
							if (6 == FlatIdent_943B) then
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								FlatIdent_943B = 7;
							end
						end
					end
				elseif (Enum <= 60) then
					if (Enum == 59) then
						local A;
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
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
						Stk[Inst[2]] = Env[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
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
					else
						local FlatIdent_559FF = 0;
						while true do
							if (FlatIdent_559FF == 0) then
								Stk[Inst[2]] = Inst[3] ~= 0;
								VIP = VIP + 1;
								break;
							end
						end
					end
				elseif (Enum > 61) then
					Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
				else
					local B = Stk[Inst[4]];
					if B then
						VIP = VIP + 1;
					else
						Stk[Inst[2]] = B;
						VIP = Inst[3];
					end
				end
				VIP = VIP + 1;
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
return VMCall("LOL!4A3O0003043O0067616D65030A3O004765745365727669636503073O00506C617965727303133O00526278416E616C797469637353657276696365030B3O00482O747053657276696365030C3O0054772O656E53657276696365030B3O004C6F63616C506C61796572030C3O0057616974466F724368696C6403093O00506C6179657247756903083O00496E7374616E63652O033O006E657703093O005363722O656E477569030C3O0052657365744F6E537061776E010003053O004672616D6503043O0053697A6503053O005544696D32028O00025O00C07240026O00694003083O00506F736974696F6E026O00E03F025O00C062C0026O0059C003103O004261636B67726F756E64436F6C6F723303063O00436F6C6F7233029A5O99B93F030F3O00426F7264657253697A65506978656C03103O00436C69707344657363656E64616E74732O0103093O004472612O6761626C6503063O0041637469766503083O005549436F726E6572030C3O00436F726E657252616469757303043O005544696D026O00244003093O00546578744C6162656C026O00F03F029A5O99C93F03163O004261636B67726F756E645472616E73706172656E6379030A3O0054657874436F6C6F723303043O00466F6E7403043O00456E756D030A3O00476F7468616D426F6C6403083O005465787453697A65026O00324003043O0054657874030E3O00427970612O73205072656D69756E03073O0054657874426F7802CD5OCCEC3F029A5O99A93F026O00D03F030A3O0055524C20427970612O7303063O00476F7468616D026O002C40026O001440030A3O005465787442752O746F6E026O00304003063O00427970612O73026O66E63F026O00E83F026O33C33F030B3O00526573756C7461646F3A20026O00284003043O00436F707903073O00436F707920494403073O00446973636F726403113O004D6F75736542752O746F6E31436C69636B03073O00436F2O6E65637403063O0043726561746503093O0054772O656E496E666F030B3O00456173696E675374796C6503043O004261636B03043O00506C617900E1012O0012293O00013O00206O000200122O000200038O0002000200122O000100013O00202O00010001000200122O000300046O00010003000200122O000200013O00202O000200020002001234000400054O000B00020004000200122O000300013O00202O00030003000200122O000500066O00030005000200202O00043O000700202O00050004000800122O000700096O00050007000200063100063O000100012O00163O00013O00063100070001000100012O00163O00023O00063100080002000100012O00163O00073O000215000900033O000215000A00043O001236000B000A3O00202O000B000B000B00122O000C000C6O000D00056O000B000D000200302O000B000D000E00122O000C000A3O00202O000C000C000B00122O000D000F6O000E000B6O000C000E000200122O000D00113O00202O000D000D000B00122O000E00123O00122O000F00133O00122O001000123O00122O001100146O000D0011000200102O000C0010000D00122O000D00113O00202O000D000D000B00122O000E00163O00122O000F00173O00122O001000163O00122O001100186O000D0011000200102O000C0015000D00122O000D001A3O00202O000D000D000B00122O000E001B3O00122O000F001B3O00122O0010001B6O000D0010000200102O000C0019000D00302O000C001C001200302O000C001D001E00302O000C001F001E00302O000C0020001E00122O000D000A3O00202O000D000D000B00122O000E00216O000F000C6O000D000F000200122O000E00233O00202O000E000E000B00122O000F00123O00122O001000246O000E0010000200102O000D0022000E00122O000E000A3O00202O000E000E000B00122O000F00256O0010000C6O000E0010000200122O000F00113O00202O000F000F000B00122O001000263O00122O001100123O00122O001200273O00122O001300126O000F0013000200102O000E0010000F00302O000E0028002600122O000F001A3O00202O000F000F000B00122O001000263O00122O001100263O00122O001200266O000F0012000200102O000E0029000F00122O000F002B3O00202O000F000F002A00202O000F000F002C00102O000E002A000F00302O000E002D002E00302O000E002F003000122O000F000A3O00202O000F000F000B00122O001000316O0011000C4O0013000F00110002001230001000113O00202O00100010000B00122O001100323O00122O001200123O00122O001300273O00122O001400126O00100014000200102O000F0010001000122O001000113O00202O00100010000B00122O001100333O00122O001200123O00122O001300343O00122O001400126O00100014000200102O000F0015001000122O0010001A3O00202O00100010000B00122O001100273O00122O001200273O00122O001300276O00100013000200102O000F0019001000122O0010001A3O00202O00100010000B00122O001100263O00122O001200263O00122O001300266O00100013000200102O000F0029001000302O000F002F003500122O0010002B3O00202O00100010002A00202O00100010003600102O000F002A001000302O000F002D003700302O000F001D001E00122O0010000A3O00202O00100010000B00122O001100216O0012000F6O00100012000200122O001100233O00202O00110011000B00122O001200123O00122O001300386O00110013000200102O00100022001100122O0011000A3O00202O00110011000B00122O001200396O0013000C6O00110013000200122O001200113O00202O00120012000B00122O001300323O00122O001400123O00122O001500273O00122O001600126O00120016000200102O00110010001200122O001200113O00202O00120012000B00122O001300333O00122O001400123O00122O001500163O00122O001600126O00120016000200102O00110015001200122O0012001A3O00202O00120012000B00122O001300123O00122O001400163O00122O001500266O00120015000200102O00110019001200122O0012001A3O00202O00120012000B00122O001300263O00122O001400263O001234001500264O001100120015000200102O00110029001200122O0012002B3O00202O00120012002A00202O00120012002C00102O0011002A001200302O0011002D003A00302O0011002F003B00302O0011001D001E00122O0012000A3O00202O00120012000B00122O001300216O001400116O00120014000200122O001300233O00202O00130013000B00122O001400123O00122O001500386O00130015000200102O00120022001300122O0013000A3O00202O00130013000B00122O001400256O0015000C6O00130015000200122O001400113O00202O00140014000B00122O0015003C3O00122O001600123O00122O001700273O00122O001800126O00140018000200102O00130010001400122O001400113O00202O00140014000B00122O001500333O00122O001600123O00122O0017003D3O00122O001800126O00140018000200102O00130015001400122O0014001A3O00202O00140014000B00122O0015003E3O00122O0016003E3O00122O0017003E6O00140017000200102O00130019001400122O0014001A3O00202O00140014000B00122O001500263O00122O001600263O00122O001700266O00140017000200102O00130029001400122O0014002B3O00202O00140014002A00202O00140014003600102O0013002A001400302O0013002D003700302O0013002F003F00302O0013001D001E00122O0014000A3O00202O00140014000B00122O001500216O001600136O00140016000200122O001500233O00202O00150015000B00122O001600123O00122O001700386O00150017000200102O00140022001500122O0015000A3O00202O00150015000B00122O001600396O0017000C6O00150017000200122O001600113O00202O00160016000B0012340017001B3O00123B001800123O00122O0019001B3O00122O001A00126O0016001A000200102O00150010001600122O001600113O00202O00160016000B00122O0017003D3O00122O001800123O00122O0019003D3O00122O001A00126O0016001A000200102O00150015001600122O0016001A3O00202O00160016000B00122O001700273O00122O001800273O00122O001900276O00160019000200102O00150019001600122O0016001A3O00202O00160016000B00122O001700263O00122O001800263O00122O001900266O00160019000200102O00150029001600122O0016002B3O00202O00160016002A00202O00160016002C00102O0015002A001600302O0015002D004000302O0015002F004100122O0016000A3O00202O00160016000B00122O001700216O001800156O00160018000200122O001700233O00202O00170017000B00122O001800123O00122O001900386O00170019000200102O00160022001700122O0017000A3O00202O00170017000B00122O001800396O0019000C6O00170019000200122O001800113O00202O00180018000B00122O001900273O00122O001A00123O00122O001B001B3O00122O001C00126O0018001C000200102O00170010001800122O001800113O00202O00180018000B00122O001900333O00122O001A00123O00122O001B00323O00122O001C00126O0018001C000200102O00170015001800122O0018001A3O00202O00180018000B00122O001900273O00122O001A00273O00122O001B00276O0018001B000200102O00170019001800122O0018001A3O00202O00180018000B00122O001900263O00122O001A00263O00122O001B00266O0018001B000200102O00170029001800122O0018002B3O00200900180018002A00202A00180018002C00102O0017002A001800302O0017002D004000302O0017002F004200122O0018000A3O00202O00180018000B00122O001900216O001A00176O0018001A000200122O001900233O00202O00190019000B00122O001A00123O00122O001B00386O0019001B000200102O00180022001900122O0019000A3O00202O00190019000B00122O001A00396O001B000C6O0019001B000200122O001A00113O00202O001A001A000B00122O001B00273O00122O001C00123O00122O001D001B3O00122O001E00126O001A001E000200102O00190010001A00122O001A00113O00202O001A001A000B00122O001B003D3O00122O001C00123O00122O001D00323O00122O001E00126O001A001E000200102O00190015001A00122O001A001A3O00202O001A001A000B00122O001B00273O00122O001C00273O00122O001D00276O001A001D000200102O00190019001A00122O001A001A3O00202O001A001A000B00122O001B00263O00122O001C00263O00122O001D00266O001A001D000200102O00190029001A00122O001A002B3O00202O001A001A002A00202O001A001A002C00102O0019002A001A00302O0019002D004000302O0019002F004300122O001A000A3O00202O001A001A000B00122O001B00216O001C00196O001A001C000200122O001B00233O00202O001B001B000B00122O001C00123O00122O001D00386O001B001D000200102O001A0022001B000631001B0005000100012O00163O00033O000631001C0006000100092O00163O00064O00163O000F4O00163O00084O00163O00094O00163O000A4O00163O001C4O00163O00134O00163O001B4O00163O00113O002009001D0011004400200E001D001D0045000631001F0007000100012O00163O001C4O002F001D001F0001002009001D0017004400200E001D001D0045000631001F0008000100042O00163O001B4O00163O00174O00163O00064O00163O00134O002F001D001F0001002009001D0019004400200E001D001D0045000631001F0009000100032O00163O00134O00163O001B4O00163O00194O002F001D001F0001002009001D0015004400200E001D001D0045000631001F000A000100032O00163O00134O00163O001B4O00163O00154O0002001D001F000100202O001D000300464O001F000C3O00122O002000473O00202O00200020000B00122O002100163O00122O0022002B3O00202O00220022004800202O0022002200494O0020002200022O003700213O0001001222002200113O00202O00220022000B00122O002300123O00122O002400133O00122O002500123O00122O002600146O00220026000200102O0021001000224O001D0021000200202O001D001D004A4O001D000200012O00198O001A3O00013O000B3O00013O00030B3O00476574436C69656E74496400054O001F7O00206O00016O00019O008O00017O000E3O00028O00030C3O00682O74705F7265717565737403073O00726571756573742O033O0073796E03043O00682O7470030A3O004A534F4E4465636F64652O033O0055726C03063O004D6574686F6403043O00504F535403073O0048656164657273030C3O00436F6E74656E742D5479706503103O00612O706C69636174696F6E2F6A736F6E03043O00426F6479030A3O004A534F4E456E636F6465022A3O001234000200014O0021000300033O00261C000200020001000100041D3O00020001001234000400013O00261C000400050001000100041D3O0005000100122E000500023O000603000300130001000500041D3O0013000100122E000500033O000603000300130001000500041D3O0013000100122E000500043O002009000500050003000603000300130001000500041D3O0013000100122E000500053O00200900030005000300063D000500260001000300041D3O002600012O000A00055O0020250005000500064O000700036O00083O000400102O000800073O00302O0008000800094O00093O000100302O0009000B000C00102O0008000A00094O00095O00202O00090009000E4O000B00016O0009000B000200102O0008000D00094O00070002000200202O00070007000D4O0005000700022O002C000500023O00041D3O0005000100041D3O000200012O001A3O00017O00033O00028O0003353O00682O7470733A2O2F64656C69636174652D68612O6C2D396532302E6272756E6F746F6C65646F3532362E776F726B6572732E64657603053O007063612O6C020F3O001234000200014O0021000300033O00261C000200020001000100041D3O00020001001234000300023O00122E000400033O00063100053O000100042O000A8O00163O00034O00168O00163O00014O0038000400054O003200045O00041D3O000200012O001A3O00013O00013O00023O0003043O00687769642O033O0075726C000A4O00079O00000100016O00023O00024O000300023O00102O0002000100034O000300033O00102O0002000200036O00029O008O00017O00033O00028O0003063O0069706169727303063O00726573756C7401133O001234000100013O000E01000100010001000100041D3O0001000100122E000200024O001600036O002600020002000400041D3O000D00010020090007000600030006270007000D00013O00041D3O000D00010020090007000600030020090007000700032O002C000700023O000635000200070001000200041D3O000700012O0021000200024O002C000200023O00041D3O000100012O001A3O00017O00013O0003B13O00556E61626C6520746F20636F2O6E65637420746F20746865206D61696E2044656C6F7265616E20415049207C2D7C2041504920576F726B6572733A204F7065726174696F6E616C207C2D7C2044656C697665727920456E64706F696E743A204F7065726174696F6E616C207C2D7C2044656C6F7265616E2050726F787920536572766572203A204F7065726174696F6E616C207C2D7C2044656C6F7265616E2041504920486F73743A204F2O666C696E6501063O0026183O00030001000100041D3O000300012O003C00016O0024000100014O002C000100024O001A3O00017O001B3O00028O00026O00F03F027O0040030B3O00416E63686F72506F696E7403073O00566563746F72322O033O006E6577026O00E03F03083O00506F736974696F6E03053O005544696D32026O00084003163O004261636B67726F756E645472616E73706172656E6379029A5O99E93F03043O0053697A65026O00104003063O0043726561746503093O0054772O656E496E666F03043O00506C617903043O0067616D6503063O0044656272697303073O00412O644974656D03083O00496E7374616E636503053O004672616D6503103O004261636B67726F756E64436F6C6F723303063O00436F6C6F723303083O005549436F726E6572030C3O00436F726E657252616469757303043O005544696D01773O001234000100014O0021000200043O00261C000100700001000200041D3O007000012O0021000400043O00261C000200160001000300041D3O0016000100122E000500053O00202300050005000600122O000600073O00122O000700076O00050007000200102O00030004000500122O000500093O00202O00050005000600122O000600073O00122O000700013O00122O000800073O00122O000900016O00050009000200102O00030008000500122O0002000A3O00261C000200220001000200041D3O0022000100300D0003000B000C00123A000500093O00202O00050005000600122O000600013O00122O000700013O00122O000800013O00122O000900016O00050009000200102O0003000D000500122O000200033O00261C0002003F0001000E00041D3O003F00012O000A00055O00201700050005000F4O000700033O00122O000800103O00202O00080008000600122O000900076O0008000200024O00093O000200122O000A00093O00202O000A000A000600122O000B00033O00122O000C00013O00122O000D00033O00122O000E00016O000A000E000200102O0009000D000A00302O0009000B00024O00050009000200202O0005000500114O00050002000100122O000500123O00202O00050005001300202O0005000500144O000700033O00122O000800076O00050008000100044O0076000100261C000200570001000100041D3O00570001001234000500013O00261C000500520001000100041D3O0052000100122E000600153O00201E00060006000600122O000700166O00088O0006000800024O000300063O00122O000600183O00202O00060006000600122O000700023O00122O000800023O00122O000900026O00060009000200102O00030017000600122O000500023O00261C000500420001000200041D3O00420001001234000200023O00041D3O0057000100041D3O0042000100261C000200050001000A00041D3O00050001001234000500013O00261C0005005E0001000200041D3O005E00010012340002000E3O00041D3O0005000100261C0005005A0001000100041D3O005A000100122E000600153O00201400060006000600122O000700196O000800036O0006000800024O000400063O00122O0006001B3O00202O00060006000600122O000700023O00122O000800016O00060008000200102O0004001A000600122O000500023O00044O005A000100041D3O0005000100041D3O00760001000E01000100020001000100041D3O00020001001234000200014O0021000300033O001234000100023O00041D3O000200012O001A3O00017O000E3O00028O00026O00F03F03043O0054657874027O004003093O0069735072656D69756D03083O00627970612O736573026O00594003113O005265696E74656E74616E646F3O2E202803053O002F312O302903043O007761697403243O004E6F20736520656E636F6E7472C3B320756E20726573756C7461646F2076C3A16C69646F030D3O0055524C20726571756572696461030F3O00412O6365736F2064656E656761646F03123O00452O726F7220646520636F6E657869C3B36E016C3O001234000100014O0021000200053O00261C000100180001000200041D3O00180001001234000600013O000E01000100130001000600041D3O001300012O000A00076O002D0007000100024O000800013O00202O0003000800034O000200076O000700026O000800026O000900036O0007000900084O000500086O000400073O00122O000600023O000E01000200050001000600041D3O00050001001234000100043O00041D3O0018000100041D3O0005000100261C000100610001000400041D3O006100010006270004005E00013O00041D3O005E00010006270005005E00013O00041D3O005E00010020090006000500050006270006005B00013O00041D3O005B00010020090006000500060006270006005800013O00041D3O00580001001234000600014O0021000700073O00261C000600260001000100041D3O002600012O000A000800033O0020090009000500062O00120008000200022O0016000700083O0006270007005300013O00041D3O005300012O000A000800044O0016000900074O00120008000200020006270008005000013O00041D3O0050000100260F3O00500001000700041D3O00500001001234000800014O0021000900093O00261C000800370001000100041D3O00370001001234000900013O00261C000900400001000200041D3O004000012O000A000A00053O00202B000B3O00024O000A0002000100041D3O006B000100261C0009003A0001000100041D3O003A00012O000A000A00063O001206000B00083O00202O000C3O000200122O000D00096O000B000B000D00102O000A0003000B00122O000A000A3O00122O000B00026O000A0002000100122O000900023O00044O003A000100041D3O006B000100041D3O0037000100041D3O006B00012O000A000800063O00103E00080003000700041D3O006B00012O000A000800063O00300D00080003000B00041D3O006B000100041D3O0026000100041D3O006B00012O000A000600063O00300D00060003000C00041D3O006B00012O000A000600063O00300D00060003000D00041D3O006B00012O000A000600063O00300D00060003000E00041D3O006B000100261C000100020001000100041D3O000200010006053O00660001000100041D3O006600010012343O00014O000A000600074O000A000700086O000600020001001234000100023O00041D3O000200012O001A3O00017O00013O00029O00044O000A7O001234000100018O000200012O001A3O00017O00053O00028O00030C3O00736574636C6970626F617264026O00F03F03043O0054657874031A3O00494420636F706961646F20616C20706F727461706170656C657300183O0012343O00014O0021000100013O000E010001000200013O00041D3O00020001001234000100013O00261C0001000F0001000100041D3O000F00012O000A00026O0039000300016O00020002000100122O000200026O000300026O000300016O00023O000100122O000100033O00261C000100050001000300041D3O000500012O000A000200033O00300D00020004000500041D3O0017000100041D3O0005000100041D3O0017000100041D3O000200012O001A3O00017O00063O00028O00026O00F03F03043O005465787403173O004C696E6B20646520446973636F726420636F706961646F030C3O00736574636C6970626F61726403233O00682O7470733A2O2F646973636F72642E636F6D2F696E766974652F3539426B7456686200113O0012343O00013O00261C3O00060001000200041D3O000600012O000A00015O00300D00010003000400041D3O0010000100261C3O00010001000100041D3O000100012O000A000100014O0010000200026O00010002000100122O000100053O00122O000200066O00010002000100124O00023O00044O000100012O001A3O00017O00053O00028O00026O00F03F03043O005465787403113O00526573756C7461646F20636F706961646F030C3O00736574636C6970626F61726400183O0012343O00014O0021000100013O00261C3O00020001000100041D3O00020001001234000100013O00261C0001000A0001000200041D3O000A00012O000A00025O00300D00020003000400041D3O00170001000E01000100050001000100041D3O000500012O000A000200014O0033000300026O00020002000100122O000200056O00035O00202O0003000300034O00020002000100122O000100023O00044O0005000100041D3O0017000100041D3O000200012O001A3O00017O00", GetFEnv(), ...);
