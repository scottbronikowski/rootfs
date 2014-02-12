-- 
--  This is file `luaotfload.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luaotfload.dtx  (with options: `lua')
--  This is a generated file.
--  
--  Copyright (C) 2009 by Elie Roux <elie.roux@telecom-bretagne.eu>
--  
--  This work is under the CC0 license.
--  
--  This work consists of the main source file luaotfload.dtx
--  and the derived files
--      luaotfload.sty, luaotfload.lua
--  
luaotfload          = { }

luaotfload.module = {
    name          = "luaotfload",
    version       = 1.04,
    date          = "2009/09/22",
    description   = "ConTeXt font loading system.",
    author        = "Elie Roux & Hans Hagen",
    copyright     = "Elie Roux",
    license       = "CC0"
}

luatextra.provides_module(luaotfload.module)


function luaotfload.loadmodule(name)
    local foundname = kpse.find_file('otfl-'..name,"tex")
    if not foundname then
      luatextra.module_error('luaotfload', string.format('file otfl-%s not found.', name))
      return
    end
    dofile(foundname)
end


string.strip = string.stripspaces

file = fpath
file.extname = fpath.suffix


local splitters_s, splitters_m = { }, { }

function lpeg.splitat(separator,single)
    local splitter = (single and splitters_s[separator]) or splitters_m[separator]
    if not splitter then
        separator = lpeg.P(separator)
        if single then
            local other, any = lpeg.C((1 - separator)^0), lpeg.P(1)
            splitter = other * (separator * lpeg.C(any^0) + "")
            splitters_s[separator] = splitter
        else
            local other = lpeg.C((1 - separator)^0)
            splitter = other * (separator * other)^0
            splitters_m[separator] = splitter
        end
    end
    return splitter
end

function table.compact(t)
    if t then
        for k,v in next, t do
            if not next(v) then
                t[k] = nil
            end
        end
    end
end

function table.sortedhashkeys(tab) -- fast one
    local srt = { }
    for key,_ in next, tab do
        srt[#srt+1] = key
    end
    table.sort(srt)
    return srt
end

function table.reverse_hash(h)
    local r = { }
    for k,v in next, h do
        r[v] = string.lower(string.gsub(k," ",""))
    end
    return r
end

function table.reverse(t)
    local tt = { }
    if #t > 0 then
        for i=#t,1,-1 do
            tt[#tt+1] = t[i]
        end
    end
    return tt
end


luaotfload.loadmodule('luat-dum.lua') -- not used in context at all
luaotfload.loadmodule('data-con.lua') -- maybe some day we don't need this one


luaotfload.loadmodule('node-ini.lua')


function attributes.private(name)
    local number = tex.attributenumber['otfl@'..name]
    if not number then
        luatextra.module_error('luaotfload', string.format('asking for attribute %s, but not declared. Please report to the maintainer of luaotfload.', name))
    end
    return number
end


luaotfload.loadmodule('node-res.lua')
luaotfload.loadmodule('node-inj.lua')
luaotfload.loadmodule('node-fnt.lua')
luaotfload.loadmodule('node-dum.lua')

luaotfload.loadmodule('font-ini.lua')
luaotfload.loadmodule('font-tfm.lua')
luaotfload.loadmodule('font-cid.lua')
luaotfload.loadmodule('font-ott.lua')
luaotfload.loadmodule('font-otf.lua')
luaotfload.loadmodule('font-otd.lua')
luaotfload.loadmodule('font-oti.lua')
luaotfload.loadmodule('font-otb.lua')
luaotfload.loadmodule('font-otn.lua')
luaotfload.loadmodule('font-ota.lua')
luaotfload.loadmodule('font-otc.lua')


do
  local temp = callback.register
  callback.register = function (...)
    return
  end
  luaotfload.loadmodule('font-def.lua')
  callback.register = temp
end

luaotfload.loadmodule('font-xtx.lua')
luaotfload.loadmodule('font-map.lua')
luaotfload.loadmodule('font-dum.lua')


fonts.enc.known = {}


function luaotfload.find_vf_file(name)
    name = file.removesuffix(file.basename(name))
    local result = kpse.find_file(name, "vf") or ""
    if result == "" then
        result = kpse.find_file(name, "ovf") or ""
    end
    return result
end


function luaotfload.register_callbacks()
    callback.add('pre_linebreak_filter', nodes.simple_font_handler, 'luaotfload.pre_linebreak_filter')
    callback.add('hpack_filter',         nodes.simple_font_handler, 'luaotfload.hpack_filter')
    callback.reset('define_font')
    callback.add('define_font', fonts.define.read, 'luaotfload.define_font', 1)
    callback.add('find_vf_file', luaotfload.find_vf_file, 'luaotfload.find_vf_file')
end

function luaotfload.unregister_callbacks()
    callback.remove('pre_linebreak_filter', 'luaotfload.pre_linebreak_filter')
    callback.remove('hpack_filter', 'luaotfload.hpack_filter')
    callback.remove('define_font', 'luaotfload.define_font')
    callback.remove('find_vf_file', 'luaotfload.find_vf_file')
end
-- 
--  End of File `luaotfload.lua'.
