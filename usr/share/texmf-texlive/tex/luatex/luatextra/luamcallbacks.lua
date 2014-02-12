-- 
--  This is file `luamcallbacks.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luamcallbacks.dtx  (with options: `lua')
--  This is a generated file.
--  
--  Copyright (C) 2009 by Elie Roux <elie.roux@telecom-bretagne.eu>
--  
--  This work is under the CC0 license.
--  
--  This work consists of the main source file luamcallbacks.dtx
--  and the derived files
--    luamcallbacks.lua, luamcallbacks-test.tex, luamcallbacks.pdf.
--  

luamcallbacks          = { }

luamcallbacks.module = {
    name          = "luamcallbacks",
    version       = 0.93,
    date          = "2009/09/18",
    description   = "Module to register several functions in a callback.",
    author        = "Hans Hagen & Elie Roux",
    copyright     = "Hans Hagen & Elie Roux",
    license       = "CC0",
}

luatextra.provides_module(luamcallbacks.module)


luamcallbacks.callbacklist = luamcallbacks.callbacklist or { }


luamcallbacks.lua_callbacks_defaults = { }

local format = string.format


local list = 1
local data = 2
local first = 3
local simple = 4


luamcallbacks.callbacktypes = luamcallbacks.callbacktypes or {
buildpage_filter = simple,
token_filter = first,
pre_output_filter = list,
hpack_filter = list,
process_input_buffer = data,
mlist_to_hlist = list,
vpack_filter = list,
define_font = first,
open_read_file = first,
linebreak_filter = list,
post_linebreak_filter = list,
pre_linebreak_filter = list,
start_page_number = simple,
stop_page_number = simple,
start_run = simple,
show_error_hook = simple,
stop_run = simple,
hyphenate = simple,
ligaturing = simple,
kerning = data,
find_write_file = first,
find_read_file = first,
find_vf_file = data,
find_map_file = data,
find_format_file = data,
find_opentype_file = data,
find_output_file = data,
find_truetype_file = data,
find_type1_file = data,
find_data_file = data,
find_pk_file = data,
find_font_file = data,
find_image_file = data,
find_ocp_file = data,
find_sfd_file = data,
find_enc_file = data,
read_sfd_file = first,
read_map_file = first,
read_pk_file = first,
read_enc_file = first,
read_vf_file = first,
read_ocp_file = first,
read_opentype_file = first,
read_truetype_file = first,
read_font_file = first,
read_type1_file = first,
read_data_file = first,
}


if tex.luatexversion > 42 then
    luamcallbacks.callbacktypes["process_output_buffer"] = data
end


luamcallbacks.internalregister = luamcallbacks.internalregister or callback.register

local callbacktypes = luamcallbacks.callbacktypes

luamcallbacks.log = luamcallbacks.log or function(...)
  luatextra.module_log('luamcallbacks', format(...))
end

luamcallbacks.info = luamcallbacks.info or function(...)
  luatextra.module_info('luamcallbacks', format(...))
end

luamcallbacks.warning = luamcallbacks.warning or function(...)
  luatextra.module_warning('luamcallbacks', format(...))
end

luamcallbacks.error = luamcallbacks.error or function(...)
  luatextra.module_error('luamcallbacks', format(...))
end


function luamcallbacks.str_to_type(str)
    if str == 'list' then
        return list
    elseif str == 'data' then
        return data
    elseif str == 'first' then
        return first
    elseif str == 'simple' then
        return simple
    else
        return nil
    end
end


function luamcallbacks.create(name, ctype, default)
    if not name then
        luamcallbacks.error(format("unable to call callback, no proper name passed", name))
        return nil
    end
    if not ctype or not default then
        luamcallbacks.error(format("unable to create callback '%s', callbacktype or default function not specified", name))
        return nil
    end
    if callbacktypes[name] then
        luamcallbacks.error(format("unable to create callback '%s', callback already exists", name))
        return nil
    end
    local temp = luamcallbacks.str_to_type(ctype)
    if not temp then
        luamcallbacks.error(format("unable to create callback '%s', type '%s' undefined", name, ctype))
        return nil
    end
    ctype = temp
    luamcallbacks.lua_callbacks_defaults[name] = default
    callbacktypes[name] = ctype
end


function luamcallbacks.call(name, ...)
    if not name then
        luamcallbacks.error(format("unable to call callback, no proper name passed", name))
        return nil
    end
    if not luamcallbacks.lua_callbacks_defaults[name] then
        luamcallbacks.error(format("unable to call lua callback '%s', unknown callback", name))
        return nil
    end
    local l = luamcallbacks.callbacklist[name]
    local f
    if not l then
        f = luamcallbacks.lua_callbacks_defaults[name]
    else
        if callbacktypes[name] == list then
            f = luamcallbacks.listhandler(name)
        elseif callbacktypes[name] == data then
            f = luamcallbacks.datahandler(name)
        elseif callbacktypes[name] == simple then
            f = luamcallbacks.simplehandler(name)
        elseif callbacktypes[name] == first then
            f = luamcallbacks.firsthandler(name)
        else
            luamcallbacks.error("unknown callback type")
        end
    end
    return f(...)
end


function luamcallbacks.add (name,func,description,priority)
    if type(func) ~= "function" then
        luamcallbacks.error("unable to add function, no proper function passed")
        return
    end
    if not name or name == "" then
        luamcallbacks.error("unable to add function, no proper callback name passed")
        return
    elseif not callbacktypes[name] then
        luamcallbacks.error(
          format("unable to add function, '%s' is not a valid callback",
          name))
        return
    end
    if not description or description == "" then
        luamcallbacks.error(
          format("unable to add function to '%s', no proper description passed",
          name))
        return
    end
    if luamcallbacks.get_priority(name, description) ~= 0 then
        luamcallbacks.warning(
          format("function '%s' already registered in callback '%s'",
          description, name))
    end
    local l = luamcallbacks.callbacklist[name]
    if not l then
        l = {}
        luamcallbacks.callbacklist[name] = l
        if not luamcallbacks.lua_callbacks_defaults[name] then
            if callbacktypes[name] == list then
                luamcallbacks.internalregister(name, luamcallbacks.listhandler(name))
            elseif callbacktypes[name] == data then
                luamcallbacks.internalregister(name, luamcallbacks.datahandler(name))
            elseif callbacktypes[name] == simple then
                luamcallbacks.internalregister(name, luamcallbacks.simplehandler(name))
            elseif callbacktypes[name] == first then
                luamcallbacks.internalregister(name, luamcallbacks.firsthandler(name))
            else
                luamcallbacks.error("unknown callback type")
            end
        end
    end
    local f = {
        func = func,
        description = description,
    }
    priority = tonumber(priority)
    if not priority or priority > #l then
        priority = #l+1
    elseif priority < 1 then
        priority = 1
    end
    if callbacktypes[name] == first and (priority ~= 1 or #l ~= 0) then
        luamcallbacks.warning(format("several callbacks registered in callback '%s', only the first function will be active.", name))
    end
    table.insert(l,priority,f)
    luamcallbacks.log(
      format("inserting function '%s' at position %s in callback list for '%s'",
      description,priority,name))
end


function luamcallbacks.get_priority (name, description)
    if not name or name == "" or not callbacktypes[name] or not description then
        return 0
    end
    local l = luamcallbacks.callbacklist[name]
    if not l then return 0 end
    for p, f in pairs(l) do
        if f.description == description then
            return p
        end
    end
    return 0
end


function luamcallbacks.remove (name, description)
    if not name or name == "" then
        luamcallbacks.error("unable to remove function, no proper callback name passed")
        return
    elseif not callbacktypes[name] then
        luamcallbacks.error(
          format("unable to remove function, '%s' is not a valid callback",
          name))
        return
    end
    if not description or description == "" then
        luamcallbacks.error(
          format("unable to remove function from '%s', no proper description passed",
          name))
        return
    end
    local l = luamcallbacks.callbacklist[name]
    if not l then
        luamcallbacks.error(format("no callback list for '%s'",name))
        return
    end
    for k,v in ipairs(l) do
        if v.description == description then
            table.remove(l,k)
            luamcallbacks.log(
              format("removing function '%s' from '%s'",description,name))
            if not next(l) then
              luamcallbacks.callbacklist[name] = nil
              if not luamcallbacks.lua_callbacks_defaults[name] then
                luamcallbacks.internalregister(name, nil)
              end
            end
            return
        end
    end
    luamcallbacks.warning(
      format("unable to remove function '%s' from '%s'",description,name))
end


function luamcallbacks.reset (name)
    if not name or name == "" then
        luamcallbacks.error("unable to reset, no proper callback name passed")
        return
    elseif not callbacktypes[name] then
        luamcallbacks.error(
          format("reset error, '%s' is not a valid callback",
          name))
        return
    end
    if not luamcallbacks.lua_callbacks_defaults[name] then
        luamcallbacks.internalregister(name, nil)
    end
    local l = luamcallbacks.callbacklist[name]
    if l then
        luamcallbacks.log(format("resetting callback list '%s'",name))
        luamcallbacks.callbacklist[name] = nil
    end
end


function luamcallbacks.listhandler (name)
    return function(head,...)
        local l = luamcallbacks.callbacklist[name]
        if l then
            local done = true
            for _, f in ipairs(l) do
                -- the returned value can be either true or a new head plus true
                rtv1, rtv2 = f.func(head,...)
                if type(rtv1) == 'boolean' then
                    done = rtv1
                elseif type (rtv1) == 'userdata' then
                    head = rtv1
                end
                if type(rtv2) == 'boolean'  then
                    done = rtv2
                elseif type(rtv2) == 'userdata' then
                    head = rtv2
                end
                if done == false then
                    luamcallbacks.error(format(
                      "function \"%s\" returned false in callback '%s'",
                      f.description, name))
                end
            end
            return head, done
        else
            return head, false
        end
    end
end


function luamcallbacks.datahandler (name)
    return function(data,...)
        local l = luamcallbacks.callbacklist[name]
        if l then
            for _, f in ipairs(l) do
                data = f.func(data,...)
            end
        end
        return data
    end
end


function luamcallbacks.firsthandler (name)
    return function(...)
        local l = luamcallbacks.callbacklist[name]
        if l then
            local f = l[1].func
            return f(...)
        else
            return nil, false
        end
    end
end


function luamcallbacks.simplehandler (name)
    return function(...)
        local l = luamcallbacks.callbacklist[name]
        if l then
            for _, f in ipairs(l) do
                f.func(...)
            end
        end
    end
end


callback.add = luamcallbacks.add
callback.remove = luamcallbacks.remove
callback.reset = luamcallbacks.reset
callback.create = luamcallbacks.create
callback.call = luamcallbacks.call
callback.get_priority = luamcallbacks.get_priority

callback.register = function (...)
luamcallbacks.error("function callback.register has been deleted by luamcallbacks, please use callback.add instead.")
end

-- 
--  End of File `luamcallbacks.lua'.
