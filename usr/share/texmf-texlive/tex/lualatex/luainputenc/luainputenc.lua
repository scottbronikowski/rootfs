-- 
--  This is file `luainputenc.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luainputenc.dtx  (with options: `lua')
--  This is a generated file.
--  
--  Copyright (C) 2009 by Elie Roux <elie.roux@telecom-bretagne.eu>
--  
--  This work is under the CC0 license. As an exception, the files
--  luainputenc.sty, lutf8.def and lutf8x.def have more restrictions.
--  See these file for more details.
--  
--  People who helped on this package:
--    Javier Bezos
--    Will Robertson
--    Hans Hagen
--    Heiko Oberdiek
--    Javier Mugica
--  
--  This work consists of the main source file luainputenc.dtx
--  and the derived files
--     luainputenc.sty, luainputenc.lua, lutf8.def, lutf8x.def,
--     eu2enc.def, eu2lmr.fd and luainputenc.pdf
--  

luainputenc = { }

luainputenc.module = {
    name          = "luainputenc",
    version       =  0.95,
    date          = "2009/11/20",
    description   = "Lua simple inputenc package.",
    author        = "Elie Roux",
    copyright     = "Elie Roux",
    license       = "CC0",
}

luatextra.provides_module(luainputenc.module)

local format = string.format

luainputenc.log = luainputenc.log or function(...)
  luatextra.module_log('luainputenc', format(...))
end

local char, utfchar, byte, format, gsub, utfbyte, utfgsub =
string.char, unicode.utf8.char, string.byte, string.format, string.gsub, unicode.utf8.byte, unicode.utf8.gsub


function luainputenc.byte_to_utf(ch)
    return utfchar(byte(ch))
end


function luainputenc.fake_utf_read(buf)
    return gsub(buf,"(.)", luainputenc.byte_to_utf)
end


function luainputenc.utf_to_byte(ch)
    return char(utfbyte(ch))
end


function luainputenc.fake_utf_write(buf)
    return utfgsub(buf,"(.)", luainputenc.utf_to_byte)
end


if tex.luatexversion > 42 then

    function luainputenc.register_callbacks()
        callback.add('process_output_buffer', luainputenc.fake_utf_write, 'luainputenc.fake_utf_write')
        callback.add('process_input_buffer', luainputenc.fake_utf_read, 'luainputenc.fake_utf_read')
    end

else


    local started, stopped = 1, 0

    luainputenc.state = stopped

    function luainputenc.setstate(state)
        if state == luainputenc.state then
            return
        elseif state == started then
            luainputenc.start()
        else
            luainputenc.stop()
        end
    end

    function luainputenc.setstarted()
        luainputenc.setstate(started)
    end

    function luainputenc.setstopped()
        luainputenc.setstate(stopped)
    end

    function luainputenc.start()
        callback.add('process_input_buffer', luainputenc.fake_utf_read,
            'luainputenc.fake_utf_read')
        luainputenc.state = started
        if luainputenc.callback_registered == 0 then
            luainputenc.register_callback()
        end
    end

    function luainputenc.stop()
        callback.remove('process_input_buffer', 'luainputenc.fake_utf_read')
        luainputenc.state = stopped
        return
    end


    luainputenc.unicode_extentions = {
      ['.aux'] = 1, -- basic files
      ['.toc'] = 1,
      ['.gls'] = 1,
      ['.ind'] = 1,
      ['.idx'] = 1,
      ['.vrb'] = 1, -- beamer and powerdot
      ['.nav'] = 1, -- other beamer extentions
      ['.sol'] = 1,
      ['.qsl'] = 1,
      ['.snm'] = 1,
      ['.pgn'] = 1, -- pagereference
      ['.cpg'] = 1, -- AlProTeX
      ['.pst'] = 1, -- pst-tree
      ['.tmp'] = 1, -- sauerj/collect
      ['.sym'] = 1, -- listofsymbols
      ['.sub'] = 1, -- listofsymbols
      ['.lof'] = 1, -- preprint
      ['.lot'] = 1, -- preprint
      ['mtc1'] = 1, -- minitoc
      ['.ovr'] = 1, -- thumbss
      ['.fff'] = 1, -- endplate
      ['.sbb'] = 1, -- splitbib
      ['.bbl'] = 1, -- latex
      ['.ain'] = 1, -- authorindex
      ['.abb'] = 1, -- juraabbrev
      ['.ent'] = 1, -- endnotes
      ['.end'] = 1, -- fn2end
      ['.thm'] = 1, -- ntheorem
      ['.xtr'] = 1, -- extract
      ['.han'] = 1, -- linguho
      ['.bnd'] = 1, -- bibref
      ['.bbl'] = 1, -- bibref
      ['.col'] = 1, -- mwrite
      ['.ttt'] = 1, -- endfloat
      ['.fax'] = 1, -- lettre
      ['.tns'] = 1, -- lettre
      ['.odt'] = 1, -- lettre
      ['.etq'] = 1, -- lettre
      ['.emd'] = 1, -- poemscol
      ['.emx'] = 1, -- poemscol
      ['.ctn'] = 1, -- poemscol
      ['.hst'] = 1, -- vhistory
      ['.acr'] = 1, -- crosswrd
      ['.dwn'] = 1, -- crosswrd
      ['.ttc'] = 1, -- talk
      -- ['.txt'] = 1, -- coverpage, but not sure it's safe to include it...
      ['.eve'] = 1, -- calend0
      ['.scn'] = 1, -- cwebmac
      }


    luainputenc.unicode_files = {}

    luainputenc.non_unicode_files = {}

    function luainputenc.set_unicode_file(filename)
        if luainputenc.non_unicode_files[filename] == 1 then
            luainputenc.non_unicode_files[filename] = nil
        end
        luainputenc.unicode_files[filename] = 1
    end

    function luainputenc.set_non_unicode_file(filename)
        if luainputenc.unicode_files[filename] == 1 then
            luainputenc.unicode_files[filename] = nil
        end
        luainputenc.non_unicode_files[filename] = 1
    end

    function luainputenc.set_unicode_extention(ext)
        luainputenc.unicode_extention[ext] = 1
    end

    function luainputenc.set_non_unicode_extention(ext)
        if luainputenc.unicode_extentions[ext] == 1 then
            luainputenc.unicode_extentions[ext] = nil
        end
    end

    function luainputenc.unset_file(filename)
        if luainputenc.unicode_files[filename] == 1 then
            luainputenc.unicode_files[filename] = nil
        elseif luainputenc.non_unicode_files[filename] == 1 then
            luainputenc.non_unicode_files[filename] = nil
        end
    end

    local unicode, non_unicode = stopped, started

    function luainputenc.find_state(filename)
        if luainputenc.unicode_files[filename] == 1 then
            return unicode
        elseif luainputenc.non_unicode_files[filename] == 1 then
            return non_unicode
        else
            local ext = filename:sub(-4)
             if luainputenc.unicode_extentions[ext] == 1 then
                 return unicode
             else
                return non_unicode
             end
        end
    end


    function luainputenc.pre_read_file(env)
        if not env.path then
            return
        end
        local currentstate = luainputenc.state
        luainputenc.setstate(luainputenc.find_state(env.filename))
        env.previousstate = currentstate
    end

    function luainputenc.close(env)
        luainputenc.setstate(env.previousstate)
    end

    luainputenc.callback_registered = 0

    function luainputenc.register_callback()
        if luainputenc.callback_registered == 0 then
            callback.add('pre_read_file', luainputenc.pre_read_file,
                'luainputenc.pre_read_file')
            callback.add('file_close', luainputenc.close, 'luainputenc.close')
            luainputenc.callback_registered = 1
        end
    end

end


luainputenc.activated_characters = {}
luainputenc.characters_are_activated = false

function luainputenc.declare_character(c)
    luainputenc.activated_characters[tonumber(c)] = true
end

function luainputenc.force_characters_activated ()
    luainputenc.characters_are_activated = true
end

function luainputenc.activate_characters()
    if not luainputenc.characters_are_activated then
        for n, _ in pairs(luainputenc.activated_characters) do
            tex.sprint(string.format('\\catcode %d\\active',n))
        end
        luainputenc.characters_are_activated = true
    end
end

function luainputenc.desactivate_characters()
    if luainputenc.characters_are_activated then
        for n, _ in pairs(luainputenc.activated_characters) do
            tex.sprint(string.format('\\catcode %d=11',n))
        end
        luainputenc.characters_are_activated = false
    end
end

-- 
--  End of File `luainputenc.lua'.
