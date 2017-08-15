local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '*for sudo only ¦ *💡'
else
     return '_ للمطورين فقط_ ¦💡'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '*¦ bot is already started ¦* 💡'
else
return '_ البوت تم تفعيله مسبقا_ ¦💡'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
          },
   mutes = {
                  mute_fwd = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photos = 'no',
                  mute_gif = 'no',
                  mute_loc = 'no',
                  mute_doc = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                   mute_all = 'no',
				   mute_keyboard = 'no'
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*¦ BOT HAS BEEN STARTED ¦* ✔️'
else
  return '_ تم تفعيل البوت_ ¦✔️ '
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '*for sudo only ¦ *💡'
else
     return '_ للمطورين فقط_ ¦💡'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '*¦ bot is already stopped ¦ ❌*'
else
    return 'البوت تم ايقافه بلفعل ¦❌'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*¦ BOT HAS BEEN STOP ¦🗿*'
 else
  return '_تم ايقاف البوت بنجاح_¦ ❌'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "*¦~ this word* *"..word.."* *is already muted* ¦🔇"
            else
         return "¦~ *"..word.."*\n_ هذه الكلمه تم حضرها بلفعل_ ¦🔇"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "*¦~ this word* *"..word.."* *has been muted* ¦🔇"
            else
         return "¦~ *"..word.."*\n_ تم حظر هذه الكلمه بنجاح _ ¦🔇"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "*This Word* *"..word.."* *deleted fron words list* ¦✔️"
       elseif lang then
         return "¦~ *"..word.."*\n_تم حذفها من قائمه المنع _ ¦✔️"
     end
      else
       if not lang then
         return "*this word* *"..word.."* *not added from mutelist* ¦❌"
       elseif lang then
         return "¦~ *"..word.."*\n_هذه الكلمه ليست مضافه لقائمه المنع_ ¦❌"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "*bot is not started* ¦❌"
 else
    return "_البوت غير مفعل هنا _¦❌"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "*no admins here* ¦❌"
else
   return "_لا يوجد ادمنيه هنا_ ¦❌"
  end
end
if not lang then
   message = '*admins list ¦*💡\n'
else
   message = '*_قائمة الادمنية_ 💡:*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "*bot is not started* ¦❌"
 else
    return "_البوت غير مفعل هنا _¦❌"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "*groub haven't manger* ¦❌"
else
    return "_لا يوجد مدير هنا _ ¦❌"
  end
end
if not lang then
   message = '*manger list ¦💡*\n'
else
   message = '*"قائمة المدراء ¦*💡\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*bot is not started ¦❌*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0,  "❌┋البوت غير مفعل هنا", 0, "md")
     end
  end
if cmd == "رفع المدير" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is already manger ┆💡*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, " المعرف 💡┆"..user_name.."\n  الايدي 💡┆*"..data.id_.."*\n * ┆هو مدير المجموعه *✔️", 0, "md")
end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is now GB owner ┆✔️*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم ترقيتك الى مدير  ¦✔️*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "رفع ادمن" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is already admin ¦💡*", 0, "md")
else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * هو اداري بلفعل*", 0, "md")
end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is admin now ¦✔️*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم ترقيتك الى ادمن ¦✔️*", 0, "md")
end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "تنزيل المدير" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is not GB manger ¦❌*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تنزيله الى عضو ¦✔️ *", 0, "md")
end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is not GB manger ¦❌*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تنزيله الى عضو ¦✔️ *", 0, "md")
end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "تنزيل ادمن" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is not admin ¦❌*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * هو عضو بلفعل ¦❌ *", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he demoted to user ¦✔️*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تخفيضه الى عضو ¦✔️ *", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "ايدي" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "¦❌ لم يتم العثور على العضو", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*he is not found here ¦❌*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*bot is not started ¦❌*", 0, "md")
    else
    return tdcli.sendMessage(data.chat_id_, "", 0, "¦❌ البوت غير مفعل هنا", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "رفع المدير" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is GB manger ¦‼️*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *هو مدير المجموعه بلفعل ¦‼️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is now GB manger ¦✔️*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * تم ترقيتك الى مدير ¦✔️*", 0, "md")
   end
end
  if cmd == "رفع ادمن" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is already admin ¦❌*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف  ¦💡"..user_name.."\n الايدي  ¦💡*"..data.id_.."*\n *هو ادمن بلفعل ¦❌*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is admin now ¦✔️*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم ترقيتك الى ادمن ¦✔️*", 0, "md")
   end
end
   if cmd == "تنزيل المدير" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is not GB manger ¦❌*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تنزيله الى عضو ¦✔️ *", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is not GB manger ¦❌*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تنزيله الى عضو ¦✔️ *", 0, "md")
   end
end
   if cmd == "تنزيل ادمن" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is not admin ¦❌*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * هو عضو بلفعل ¦❌ *", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he demoted to user ¦✔️*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تخفيضه الى عضو ¦✔️ *", 0, "md")
   end
end
   if cmd == "ايدي" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "معلومات" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "💡¦ معلومات: [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "¦❌ لم يتم العثور على العضو", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*user is not found ¦❌*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*bot is not started ¦❌*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "¦❌البوت غير مفعل ", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "رفع المدير" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is GB manger ¦‼️*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *هو مدير المجموعه بلفعل ¦‼️*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is now GB manger ¦✔️*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * تم ترقيتك الى مدير ¦✔️*", 0, "md")
   end
end
  if cmd == "رفع ادمن" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is not admin ¦❌*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * هو عضو بلفعل ¦❌ *", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is admin now ¦✔️*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم ترقيتك الى ادمن ¦✔️*", 0, "md")
   end
end
   if cmd == "تنزيل عضو" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is not GB manger ¦❌*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تنزيله الى عضو ¦✔️ *", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* he is not GB manger ¦❌*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تنزيله الى عضو ¦✔️ *", 0, "md")
   end
end
   if cmd == "تنزيل ادمن" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he is not admin ¦❌*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف ¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n * هو عضو بلفعل ¦❌ *", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *he demoted to user ¦✔️*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "المعرف¦💡"..user_name.."\n الايدي ¦💡*"..data.id_.."*\n *تم تخفيضه الى عضو ¦✔️ *", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'لا يوجد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'معلومات : [ '..data.id_..' ] :\nالمعرف : '..username..'\nالاسم : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not found_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, " ❌¦لم يتم العثور على العضو", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, " ❌¦لم يتم العثور على العضو", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not found_", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "*LINKS is Already Locked ¦🔐*"
elseif lang then
 return " تہٰٰمہ ٰٰقہٰٰفہٰٰلہٖٖہ آٰلﮧڔﯢّٱٰبہٖٖطہٖٖہ مہٖٖسہٖٖبہٖٖقہٖٖـﮧٰۛٱٰ،ֆ💗💰"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*The Links Locked now ¦🔐*"
else
 return "تہٰٰمہ ٰٰقہٰٰفہٰٰلہٖٖہ آٰلﮧڔﯢّٱٰبہٖٖطہٖٖہ بہٰٰنہٰٰجہٰٰاحہٰٰحہ 😾✌🏿" 
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "*LINKS is Already Unlocked *¦💡 " 
elseif lang then
return " آٰلہٰٰڕﯢّٱٰبہٖٖطہٖٖہ مہٖٖفہٖٖتہٖٖﯢّحہٖٖهہٖٖہ مہٖٖسہٖٖبہٖٖقہٖٖآ 😼🔓" 
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*The Links unlocked now*¦🔓" 
else
return " تہٰٰمہ ٰٰفہٰٰتہٖٖحہٰٰہ آٰلﮧڔﯢّٱٰبہٖٖطہٖٖہ بہٰٰنہٰٰجہٰٰاحہٰٰحہ 😽👐🏿" 
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "*TAG is Already Locked ¦🔐*"
elseif lang then
 return "تہٰٰمہ ٰٰقہٰٰفہٰٰلہٖٖہ آٰلہٖٖيہٖٖﯢّزر مۛہٰۦـہۛسہٖٖبہٖٖقہٖٖآٰ̯💰║☻💗"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "*The TAG locked now*¦🔓"
else
 return "تہٰٰمہ ٰٰقہٰٰفہٰٰلہٖٖہ آٰلہٖٖيہٖٖﯢّزر بہٖٖنہٖٖجہٖٖاحہٖٖہ💰║☻💗" 
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "*TAG is Already unLocked ¦🔐*"
elseif lang then
 return "تہٰٰمہ ٰٰفہٖٖتہٖٖحہٖٖہ آٰلہٖٖيہٖٖﯢّزر مۛہٰۦـہۛسہٖٖبہٖٖقہٖٖآٰ̯💰║☻💗" 
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*The TAG unlocked now*¦🔓"
else
 return " ٰٰتہٰٰمہ ٰٰفہٖٖتہٖٖحٖٖہٖٖہ آٰلہٖٖيہٖٖﯢّزر بہٖٖنہٖٖجہٖٖاحہٖٖہ💰☻ " 
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
return "*Mention Is Already Locked ¦🔓*"
elseif lang then
return "تہٰمہٰہ قہٰفہٰلہٰہ ٱٰلہٖٖآٰشہٖٖآٰرهہٰہ مہٖٖسہٖٖبہٖٖقہٖٖٱٰ 😣👐🏿💗" 
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "*Mention Locked now ¦🔓*"
else 
return "تہٰمہٰہ قہٰفہٰلہٰہ ٱٰلہٖٖآٰشہٖٖآٰرهہٰہ بہٰۧنہٰۧجہٰۧاحہٰۧہ 👽💰" 
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "*Mention is unLocked  ¦🔓*"
elseif lang then
return "تہٰمہٰہ فہٖٖتہٖٖحہٖۧہ ٱٰلہٖٖآٰشہٖٖآٰرهہٰہ مہٖٖسہٖۧبہٖۧقہٖۧٱٰ 👽¦🔓"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Mention unLocked now ¦🔓*"
else
return "تہٰمہٰہ فہٖٖتہٖٖحہٖۧہ ٱٰلہٖٖآٰشہٖٖآٰرهہٰہ بہٰۧنہٰۧجہٰۧاحہٰۧہ 👽🔐"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "*Arabic is already locked ¦🔓*"
elseif lang then
 return "تہٰۧمہٰۧہ قہٰۧفہٰۧلہٰۧہ ٱٰٰلہٰۧلہٰۧغہٰۧۿّﮧ ٱٰلہٰۧہﻋﮧڕبہٰۧيہٰۧۿّﮧ مہٰۧسہٰۧبہٰۧقہٰۧہٰا 😾🔐✌🏿"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Arabic locked now ¦🔓*"
else
 return "تہٖٖمہٖٖہ قہٖۧفہٖٖلہٖۧہ ٰٱٰلہٖۧلہٖۧغہٖۧۿّﮧ ٱٰلہٖٖہﻋﮧڕبہٖٖيہٖٖۿّﮧ بہٰۧنہٰۧجہٰۧاحہٰۧہ 🙀➰💰"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
 return "*Arabicnis already unlocked ¦🔓*"
elseif lang then
 return "تہٰۧمہٰۧہ فہٰۧتہٰۧحہٰۧہ ٱٰٰلہٰۧلہٰۧغہٰۧۿّﮧ ٱٰلہٰۧہﻋﮧڕبہٰۧيہٰۧۿّﮧ مہٰۧسہٰۧبہٰۧقہٰۧہٰﻟٰ 💰💗"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Arabic unlocked now ¦🔓*"
else
 return "تہٰۧمہٰۧہ فہٰۧتہٰۧحہٰۧہ ٱٰٰلہٰۧلہٰۧغہٰۧۿّﮧ ٱٰلہٰۧہﻋﮧڕبہٰۧيہٰۧۿّﮧ بہٰۧنہٰۧجہٰۧاحہٰۧہ 🙀🔓"
end
end
end     

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "*Edit Is Already Locked ¦🔓*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧتہﻋہٖٖہﺩيہٖٖلہٖٖہ مہٖۧسہٖٖبہٖۧقہٖۧآ 🔃📍"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Edit Locked now ¦🔓*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧتہﻋہٖٖہﺩيہٖٖلہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 💗✌🏿"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
 return "*Edit is already unLocked ¦🔓*"
elseif lang then
 return "تہٖٖمہٖۧہ فہٖۧتہٖۧحہٖۧہ ٱٰلہٖۧتہﻋہٖٖہﺩيہٖٖلہٖٖہ مہٖۧسہٖٖبہٖۧقہٖۧآ 🙇🏻🍷"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Edit unLocked now ¦🔓*"
else
 return "تہٖٖمہٖۧہ فہٖۧتہٖۧحہٖۧہ ٱٰلہٖۧتہﻋہٖٖہﺩيہٖٖلہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🙀➰💗"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "*list is already locked ¦🔓*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧکگہٖۧلہايہٖۧشہٖٖہٖۧ مہٖۧسہٖٖبہٖۧقہٖۧآ 👽➰💔"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*list locked now ¦🔓*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧکگہٖۧلہايہٖۧشہٖٖہٖۧ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🙇🏻🍷"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
 return "*list is already unlocked ¦🔓*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧکگہٖۧلہايہٖۧشہٖٖہٖۧ مہٖۧسہٖٖبہٖۧقہٖۧآ 👽➰💔"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
 return "*list unlocked now ¦🔓*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧکگہٖۧلہايہٖۧشہٖٖہٖۧ بہٖۧنہٖۧجہٖۧآحہٖٖہ 👽➰💔"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "* flood Is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧتہٖۧکگہٖٖرٰآٰړ مہٖۧسہٖٖبہٖۧقہٖۧآ 🌝🍷"
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "* flood locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧتہٖۧکگہٖٖرٰآٰړ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
 return "* flood is already unlocked ¦✔️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧتہٖۧکگہٖٖرٰآٰړ مہٖۧسہٖٖبہٖۧقہٖۧآ 🌝🍷"
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "* flood unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧتہٖۧکگہٖٖرٰآٰړ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "*bot join already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ألـبوؤتـات مہٖۧسہٖٖبہٖۧقہٖۧآ 😼✌🏿"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*bot join locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ألـبوؤتـات بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😼✌🏿"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
 return "*bot join already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ألـبوؤتـات مہٖۧسہٖٖبہٖۧقہٖۧآ 😼✌🏿"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*bot join unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ألـبوؤتـات بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😼✌🏿"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "*markdawn is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧ قہٖۧفہٖۧل ٱٰلہٖۧمہٖٖآٰرگہٖۧدواٱٰنہ مسہٖٖبہٖۧقہٖۧآ 🌟💗"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*markdawn unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧ قہٖۧفہٖۧل ٱٰلہٖۧمہٖٖآٰرگہٖۧدواٱٰنہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌟💗"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
 return "*markdawn is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧ فہۧتہۧحہۧہ ٱٰلہٖۧمہٖٖآٰرگہٖۧدواٱٰنہ مہٖۧسہٖٖبہٖۧقہٖۧآ 🌟💗"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*markdawn unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧ فہۧتہۧحہۧہ ٱٰلہٖۧمہٖٖآٰرگہٖۧدواٱٰنہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌟💗"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "*web bage is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ألـويب مہٖۧسہٖٖبہٖۧقہٖۧآ 🙇🏻🍷"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*web bage locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ألـويب بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🙇🏻🍷"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
 return "*web bage is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ألـويب مہٖۧسہٖٖبہٖۧقہٖۧآ 🙇🏻🍷"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
 return "*web bage unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ألـويب بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🙇🏻🍷"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "*Pin msg is already locked ¦‼️"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖٖتہۧثٖٖہٖٖبہٖٖيہٖۧتہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 💔✌🏿"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Pin msg locked now ¦✔️"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖٖتہۧثٖٖہٖٖبہٖٖيہٖۧتہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ ✌🏿💗"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
 return "*Pin msg is already unlocked ¦‼️"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱلہٖٖتہۧثٖٖہٖٖبہٖٖيہٖۧتہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 💔✌🏿"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Pin msg unlocked now ¦✔️"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱلہٖٖتہۧثٖٖہٖٖبہٖٖيہٖۧتہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🙇🏻🍷"
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'غير محدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' يوم'
else
	expire_date = day..' Days'
end
end
if not lang then

local settings = data[tostring(target)]["settings"] 
 text = "_ارسل كلمه الوسائط لمعرفه اعدادات المجموعه_✔️"
else
local settings = data[tostring(target)]["settings"] 
 text = "_ارسل كلمه الوسائط لمعرفه اعدادات المجموعه_✔️"
end
return text
end
--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "yes" then 
if not lang then
return "*mute all is already locked ¦‼️*" 
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٰٰٱٰلہٖۧکگہٖٖلۧہٖٖہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😾✌🏿"
 end
else 
data[tostring(target)]["mutes"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "*mute all locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٰٰٱٰلہٖۧکگہٖٖلۧہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ ✨🍷"
 end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "no" then 
if not lang then
return "*mute all is already unlocked ¦‼️*" 
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٰٰٱٰلہٖۧکگہٖٖلۧہٖٖہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😾✌🏿"
 end
else 
data[tostring(target)]["mutes"]["mute_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*mute all unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٰٰٱٰلہٖۧکگہٖٖلۧہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ ✨🍷"
 end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
 return "*gifs is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧمہٖٖتہٖۧحہٖۧرکگہٖٖهہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 🌄✨💔"
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "*gifs locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧمہٖٖتہٖۧحہٖۧرکگہٖٖهہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌄➰💔"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
 return "*gifs is already unlocked ¦‼️*"
elseif lang then
return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧمہٖٖتہٖۧحہٖۧرکگہٖٖهہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ ✌🏿💗" 
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*gifs locked now ¦✔️*"
else
return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧمہٖٖتہٖۧحہٖۧرکگہٖٖهہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ ✌🏿💗"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "yes" then
if not lang then
 return "*bots game is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ بہٖۧہﯢّٰتات الہٖۧاٴلہۧعہۧابہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😾✌🏿"
end
else
 data[tostring(target)]["mutes"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*bots game locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ بہٖۧہﯢّٰتات الہٖۧاٴلہۧعہۧابہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😾✌🏿"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "no" then
if not lang then
 return "*bots game is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ بہٖۧہﯢّٰتات الہٖۧاٴلہۧعہۧابہٖۧہ مسہٖٖبہٖۧقہٖۧآ 😾✌🏿"
end
else 
data[tostring(target)]["mutes"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
 return "*bots game unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ بہٖۧہﯢّٰتات الہٖۧاٴلہۧعہۧابہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😾✌🏿"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
return "*inline is already locked ¦‼️*" 
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧہעنہٖٖلہٖٖآيہٖٖنہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 🌞🍷"
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
return "*inline unlocked now ¦✔️*" 
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧہעنہٖٖلہٖٖآيہٖٖنہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌞✌🏿"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "*inline is already unlocked ¦‼️*" 
elseif lang then
return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧہעنہٖٖلہٖٖآيہٖٖنہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 🌞🍷" 
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*inline locked now ¦✔️*" 
else
return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧہעنہٖٖلہٖٖآيہٖٖنہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌞✌🏿"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦����*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "yes" then
if not lang then
 return "*text is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧکگہٖٖتہٖۧابہٖۧۿّﮧ مہٖۧسہٖٖبہٖۧقہٖۧآ 😴✌🏿"
end
else
 data[tostring(target)]["mutes"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*text locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧکگہٖٖتہٖۧابہٖۧۿّﮧ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😴🍷"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "no" then
if not lang then
 return "*text is already unlocked ¦‼️*"
elseif lang then
return " تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧکگہٖٖتہٖۧابہٖۧۿّﮧ مہٖۧسہٖٖبہٖۧقہٖۧآ 😴✌🏿" 
end
else 
data[tostring(target)]["mutes"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*text unlocked now ¦✔️*"
else
return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧکگہٖٖتہٖۧابہٖۧۿّﮧ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😴🍷"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
 return "*photo is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱلہٖٖصہٖٖہﯢّٰر مہٖۧسہٖبہۧقہٖۧآ 😾🖕🏿"
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*photo locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱلہٖٖصہٖٖہﯢّٰر بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😾🖕🏿"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
 return "*photo is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱلہٖٖصہٖٖہﯢّٰر مہٖۧسہٖٖبہٖۧقہٖۧآ 😾🖕🏿"
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*photo unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱلہٖٖصہٖٖہﯢّٰر بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😾🖕🏿"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "yes" then
if not lang then
 return "*video is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱٰلہٖۧفہٖٖيہٖۧديو مہٖۧسہٖبہٖۧقہٖۧآ 😾🖕🏿"
end
else
 data[tostring(target)]["mutes"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "*vide locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱٰلہٖۧفہٖٖيہٖۧديو بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😾🖕🏿"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "no" then
if not lang then
 return "*video is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧفہٖٖيہٖۧديو مہٖۧسہٖبہٖۧقہٖۧآ 😾🖕🏿"
end
else 
data[tostring(target)]["mutes"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*video unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧفہٖٖيہٖۧديو بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😾🖕🏿"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
 return "*audio is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱٰلہٖۧصہٖٖہﯢّٰتيات مہٖۧسہٖٖبہٖۧقہٖۧآ 👾🍷"
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*audio locked now ¦✔️*"
else 
return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱٰلہٖۧصہٖٖہﯢّٰتيات بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
 return "*audio is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧصہٖٖہﯢّٰتيات مہٖۧسہٖٖبہٖۧقہٖۧآ 👾🍷"
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
 return "*audio unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧصہٖٖہﯢّٰتيات بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
 return "*voice is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧبصمات مہٖۧسہٖٖبہٖۧقہٖۧآ 👾🖕🏿"
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*voice locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱٰلہٖۧبصمات بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🖕🏿"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
 return "*voice is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧبصمات مہٖۧسہٖٖبہٖۧقہٖۧآ 👾🖕🏿"
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
 return "*voice unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱٰلہٖۧبصمات بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🖕🏿"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
 return "*sticker is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧمہٖۧلہٖٖصہٖۧقہٖۧآتہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 👾🖕🏿"
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*sticker locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧمہٖۧلہٖٖصہٖۧقہٖۧآتہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
 return "*sticker is already unlocked ¦‼️*"
elseif lang then
return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱلہٖۧمہٖۧلہٖٖصہٖۧقہٖۧآتہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 👾🖕🏿" 
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
 return "*sticker unlocked now ¦✔️*"
else
return "تہٖٖمہٖۧہ فہۧتہۧحہۧہ ٱلہٖۧمہٖۧلہٖٖصہٖۧقہٖۧآتہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
 return "*contact is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧجہٖٖهہٖٖاتہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😼🍷"
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*contact locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧجہٖٖهہٖٖاتہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😼✌🏿"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
 return "*contact is already unlocked ¦‼️*"
elseif lang then
return " تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧجہٖٖهہٖٖاتہٖۧہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😼🍷" 
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*contact unlocked now ¦✔️*"
else
return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧجہٖٖهہٖٖاتہٖۧہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😼✌🏿"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
 return "*FWD is already locked ¦‼️*"
elseif lang then
 return "تہٖٖم قہٖۧفہٖۧل ٱلہۧتہۧہﯢٰجيه مہٖۧسہٖٖبہٖۧقہٖۧآ 🤖🍷"
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*FWD locked now ¦✔️*"
else
 return "تہٖٖم قہٖۧفہٖۧلہٖۧہ ٱلہۧتہۧہﯢٰجيه بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🤖🍷"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "*Mute Forward* _Is Already Disabled_"
elseif lang then
 return "*FWD is already unlocked ¦‼️*"
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
 return "*FWD unlocked now ¦✔️*"
else
 return "تہٖٖم فہٖٖتہٖۧحہٖٖہ ٱلہۧتہۧہﯢٰجيه بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🤖🍷"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "yes" then
if not lang then
 return "*location is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱلہٖۧمْوآقہٖۧع مہٖۧسہٖٖبہٖۧقہٖۧآ 😩🍷" 
end
else
 data[tostring(target)]["mutes"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "*location locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱلہٖۧمْوآقہٖۧع بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😩🍷"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "no" then
if not lang then
 return "*location is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧمْوآقہٖۧع مہٖۧسہٖٖبہٖۧقہٖۧآ 🤖🍷"
end
else 
data[tostring(target)]["mutes"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*location unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧمْوآقہٖۧع بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🤖🍷"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "yes" then
if not lang then
 return "*files is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧمہٖۧلہٖۧفہٖٖآتہٖٖہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😽🍷"
end
else
 data[tostring(target)]["mutes"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*files locked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧلہٖۧہ ٱلہٖۧمہٖۧلہٖۧفہٖٖآتہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌝✌🏿"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "no" then
if not lang then
 return "*files is already unlocked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧمہٖۧلہٖۧفہٖٖآتہٖٖہ مہٖۧسہٖٖبہٖۧقہٖۧآ 😽🍷"
end
else 
data[tostring(target)]["mutes"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*files unlocked now ¦✔️*"
else
 return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧمہٖۧلہٖۧفہٖٖآتہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🌝✌🏿"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
 return "*notifications is already locked ¦‼️*"
elseif lang then
return "تہٖٖمہٖٖہ قہٖۧفہٖٖلہٖٖہ ٱلہٖۧآشہۦ﴿🗞﴾ہٖۧعہٖۧارٱٰتہٖٖہ مہٖۧسہٖۧبہٖۧقہٖۧآ 🔃✨🍷"
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*notifications locked now ¦✔️*"
else
return "تہٖٖمہٖٖہ قہٖۧفہٖٖلہٖٖہ ٱلہٖۧآشہۦ﴿🗞﴾ہٖۧعہٖۧارٱٰتہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 👾🍷"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
 return "*notifications is already unlocked ¦‼️*"
elseif lang then
return "تہٖٖمہٖٖہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧآشہۦ﴿🗞﴾ہٖۧعہٖۧارٱٰتہٖٖہ مہٖۧسہٖۧبہٖۧقہٖۧآ 🔃✨🍷"
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*notifications unlocked now ¦✔️*"
else
return "تہٖٖمہٖٖہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧآشہۦ﴿🗞﴾ہٖۧعہٖۧارٱٰتہٖٖہ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 🔃✨🍷"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "yes" then
if not lang then
 return "*keyboard Is already locked ¦‼️*"
elseif lang then
 return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱلہٖۧکہٖٖيہٖۧبہٖۧۅٰړډ مہٖۧسہٖٖبہٖۧقہٖۧآ 😽🍷"
end
else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*keyboard locked now ¦✔️*"
else
return "تہٖٖمہٖۧہ قہٖۧفہٖۧل ٱلہٖۧکہٖٖيہٖۧبہٖۧۅٰړډ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😴✌🏿"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end 
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
 return "*keyboard Is already unlocked ¦‼️*"
elseif lang then
return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧکہٖٖيہٖۧبہٖۧۅٰړډ مہٖۧسہٖٖبہٖۧقہٖۧآ 😽👐🏿"
end 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
 return "*keyboard unlocked now ¦✔️*"
else
return "تہٖٖمہٖۧہ فہٖٖتہٖۧحہٖٖہ ٱلہٖۧکہٖٖيہٖۧبہٖۧۅٰړډ بہٖۧنہٖۧجہٖۧآٰۧحہٖٖہ 😴✌🏿"
end 
end
end
----------MuteList---------
local function mutes(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_*you are not admin ¦💡*"
else
 return "_ للادمنيه والمدراء فقط _¦💡"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_all"] then			
data[tostring(target)]["mutes"]["mute_all"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "no"		
end
end
if not lang then
local mutes = data[tostring(target)]["mutes"] 
 text = " *Group Mute List* : \n_Mute all : _ *"..mutes.mute_all.."*\n_Mute gif :_ *"..mutes.mute_gif.."*\n_Mute text :_ *"..mutes.mute_text.."*\n_Mute inline :_ *"..mutes.mute_inline.."*\n_Mute game :_ *"..mutes.mute_game.."*\n_Mute photo :_ *"..mutes.mute_photo.."*\n_Mute video :_ *"..mutes.mute_video.."*\n_Mute audio :_ *"..mutes.mute_audio.."*\n_Mute voice :_ *"..mutes.mute_voice.."*\n_Mute sticker :_ *"..mutes.mute_sticker.."*\n_Mute contact :_ *"..mutes.mute_contact.."*\n_Mute forward :_ *"..mutes.mute_forward.."*\n_Mute location :_ *"..mutes.mute_location.."*\n_Mute document :_ *"..mutes.mute_document.."*\n_Mute TgService :_ *"..mutes.mute_tgservice.."*\n_Mute Keyboard :_ *"..mutes.mute_keyboard.."*\n*____________________*\n*Bot channel*: @BeyondTeam\n*Group Language* : *EN*"
else
local mutes = data[tostring(target)]["mutes"] 
text = "<i> ••৩﴾ جميع اعدادات الوسائط  ﴿৩•۪۫• </i>\n"
text = text.."<b>* ¦  •┈•✦•۪۫•৩﴾ ❊ ﴿৩•۪۫•✦•┈• ¦ *</b>\n\n"
text = text.."<i>* ¦ الكل ¦ * « </i><b>"..mutes.mute_all.."</b>\n"
text = text.."<i>* ¦ المتحركه ¦ * « </i><b>"..mutes.mute_gif.."</b>\n"
text = text.."<i>* ¦ الدردشه ¦ * « </i><b>"..mutes.mute_text.."</b>\n"
text = text.."<i>* ¦ الانلاين ¦ * « </i><b>"..mutes.mute_inline.."</b>\n"
text = text.."<i>* ¦ بوتات الالعاب ¦ * « </i><b>"..mutes.mute_game.."</b>\n"
text = text.."<i>* ¦ الصور ¦ * « </i><b>"..mutes.mute_photo.."</b>\n"
text = text.."<i>* ¦ الفيديو ¦ * « </i><b>"..mutes.mute_video.."</b>\n"
text = text.."<i>* ¦ الصوت ¦ * « </i><b>"..mutes.mute_audio.."</b>\n"
text = text.."<i>* ¦ البصمات ¦ * « </i><b>"..mutes.mute_voice.."</b>\n"
text = text.."<i>* ¦ الملصقات ¦ * « </i><b>"..mutes.mute_sticker.."</b>\n"
text = text.."<i>* ¦ الجهات ¦ * « </i><b>"..mutes.mute_contact.."</b>\n"
text = text.."<i>* ¦ التوجيه ¦ * « </i><b>"..mutes.mute_forward.."</b>\n"
text = text.."<i>* ¦ المواقع ¦ * « </i><b>"..mutes.mute_location.."</b>\n"
text = text.."<i>* ¦ الملفات ¦ * « </i><b>"..mutes.mute_document.."</b>\n"
text = text.."<i>* ¦ الاشعارات ¦ * « </i><b>"..mutes.mute_tgservice.."</b>\n"
text = text.."<b>* ¦  •┈•✦•۪۫•৩﴾ ❊ ﴿৩•۪۫•✦•┈•  ¦ *</b>\n"
text = text.."<b>【 Dev 】 « </b> @iq_100k\n"
text = text.."<b>【 CH 】 « </b> @porgramer2017\n"

        return tdcli.sendMessage(chat, msg.id_, 1, text, 1, 'html')
end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "ايدي" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'ايدي المجموعة : '..msg.to.id..'\nايديك : '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "*لم يتم العثور على صورة شخصية..!*\n\n> ايدي المجموعة : `"..msg.to.id.."`\nايديك : `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ايدي"})
  end
if matches[2] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ايدي"})
      end
   end
if matches[1] == "تثبيت" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "* Pinned sucss ¦✔️*"
elseif lang then
return "تہٖٖم تہٖٖثبيہٖۧت ٱلہٖٖرسہٖٖاله بہٖۧنہٖۧجہٖۧآٰۧح 📍➰"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "* Pinned sucss ¦✔️*"
elseif lang then
return "تہٖٖم تہٖٖثبيہٖۧت ٱلہٖٖرسہٖٖاله بہٖۧنہٖۧجہٖۧآٰۧح 📍➰"
end
end
end
if matches[1] == 'الغاء تثبيت' and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "* unPinned sucss ¦✔️*"
elseif lang then
return "تہٖٖم الغاء تہٖٖثبيہٖۧت ٱلہٖٖرسہٖٖاله بہٖۧنہٖۧجہٖۧآٰۧح 📍➰"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "* unPinned sucss ¦✔️*"
elseif lang then
return "تہٖٖم الغاء تہٖٖثبيہٖۧت ٱلہٖٖرسہٖٖاله بہٖۧنہٖۧجہٖۧآٰۧح 📍➰"
end
end
end
if matches[1] == "تفعيل" then
return modadd(msg)
end
if matches[1] == "تعطيل" then
return modrem(msg)
end
if matches[1] == "رفع المدير" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="رفع المدير"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع المدير"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع المدير"})
      end
   end
if matches[1] == "تنزيل المدير" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل المدير"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل المدير"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل المدير"})
      end
   end
if matches[1] == "رفع ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="رفع ادمن"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع ادمن"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع ادمن"})
      end
   end
if matches[1] == "تنزيل ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل ادمن"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل ادمن"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل ادمن"})
      end
   end

if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الروابط" then
return lock_link(msg, data, target)
end
if matches[2] == "اليوزر" then
return lock_tag(msg, data, target)
end
if matches[2] == "الاشاره" then
return lock_mention(msg, data, target)
end
if matches[2] == "العربيه" then
return lock_arabic(msg, data, target)
end
if matches[2] == "التعديل" then
return lock_edit(msg, data, target)
end
if matches[2] == "الكلايش" then
return lock_spam(msg, data, target)
end
if matches[2] == "التكرار" then
return lock_flood(msg, data, target)
end
if matches[2] == "البوتات" then
return lock_bots(msg, data, target)
end
if matches[2] == "الماركداون" then
return lock_markdown(msg, data, target)
end
if matches[2] == "الويب" then
return lock_webpage(msg, data, target)
end
if matches[2] == "التثبيت" and is_owner(msg) then
return lock_pin(msg, data, target)
end
end

if matches[1] == "فتح" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الروابط" then
return unlock_link(msg, data, target)
end
if matches[2] == "اليوزر" then
return unlock_tag(msg, data, target)
end
if matches[2] == "الاشاره" then
return unlock_mention(msg, data, target)
end
if matches[2] == "العربيه" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "التعديل" then
return unlock_edit(msg, data, target)
end
if matches[2] == "الكلايش" then
return unlock_spam(msg, data, target)
end
if matches[2] == "التكرار" then
return unlock_flood(msg, data, target)
end
if matches[2] == "البوتات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "الماركداون" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "الويب" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "التثبيت" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
end
if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الكل" then
return mute_all(msg, data, target)
end
if matches[2] == "المتحركه" then
return mute_gif(msg, data, target)
end
if matches[2] == "الدردشه" then
return mute_text(msg ,data, target)
end
if matches[2] == "الصور" then
return mute_photo(msg ,data, target)
end
if matches[2] == "الفيديو" then
return mute_video(msg ,data, target)
end
if matches[2] == "الصوت" then
return mute_audio(msg ,data, target)
end
if matches[2] == "البصمات" then
return mute_voice(msg ,data, target)
end
if matches[2] == "الملصقات" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "الجهات" then
return mute_contact(msg ,data, target)
end
if matches[2] == "التوجيه" then
return mute_forward(msg ,data, target)
end
if matches[2] == "المواقع" then
return mute_location(msg ,data, target)
end
if matches[2] == "الملفات" then
return mute_document(msg ,data, target)
end
if matches[2] == "الاشعارات" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "الانلاين" then
return mute_inline(msg ,data, target)
end
if matches[2] == "بوتات الالعاب" then
return mute_game(msg ,data, target)
end
if matches[2] == "الكيبورد" then
return mute_keyboard(msg ,data, target)
end
end

if matches[1] == "فتح" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الكل" then
return unmute_all(msg, data, target)
end
if matches[2] == "المتحركه" then
return unmute_gif(msg, data, target)
end
if matches[2] == "الدردشه" then
return unmute_text(msg, data, target)
end
if matches[2] == "الصور" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "الفيديو" then
return unmute_video(msg ,data, target)
end
if matches[2] == "الصوت" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "البصمات" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "لملصقات" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "الجهات" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "التوجيه" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "المواقع" then
return unmute_location(msg ,data, target)
end
if matches[2] == "الملفات" then
return unmute_document(msg ,data, target)
end
if matches[2] == "الاشعارات" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "الانلاين" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "بوتات الالعاب" then
return unmute_game(msg ,data, target)
end
if matches[2] == "الكيبورد" then
return unmute_keyboard(msg ,data, target)
end
end
if matches[1] == "معلومات المجموعه" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*Group Info ¦💡*\n_Admin Number ¦💡_ *"..data.administrator_count_.."*\n*Member Number ¦💡* *"..data.member_count_.."*\n*Kicked Number ¦💡* *"..data.kicked_count_.."*\n*GB ID ¦💡* *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "_معلومات المجموعه ¦✔️_\n_عدد الادمنيه_ ¦‼️*"..data.administrator_count_.."*\n_عدد الاعضاء_ ¦‼️ *"..data.member_count_.."*\n_عدد المحضورين_ ¦‼️ *"..data.kicked_count_.."*\n_ايدي المجموعه_ ¦‼️ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'صنع رابط' and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Bot is not creator of GB❌*\n*set a new link for group on using* _/setlink_💡", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_البوت ليس منشئ للمجموعه ‼️  \nارسل لي ضع رابط ثم ارسل الرابط الذي تريده", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink seted ✔️*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "✔️ تم انشاء الرابط بنجاح", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if matches[1] == 'ضع رابط' and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '*Please send a link now 📍*'
    else 
         return ' ارسل لي الرابط الان 📍'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*new link seted ✔️*"
           else
           return "✔️ تم حفظ رابط المجموعه بنجاح"
		 	end
       end
		end
    if matches[1] == 'الرابط' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "_ 📍ارسل ضع رابط لانشاء رابط جديد_"
      end
      end
     if not lang then
       text = "<b>GB Link ¦💡</b>\n"..linkgp
     else
      text = "<b>رابط المجموعه ¦💡:</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if matches[1] == 'linkpv' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "_ 📍ارسل ضع رابط لانشاء رابط جديد_"
      end
      end
     if not lang then
     tdcli.sendMessage(user, "", 1, "<b>GB Link ¦💡"..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
      tdcli.sendMessage(user, "", 1, "<b>رابط المجموعه ¦💡 "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
      if not lang then
        return "*link sent to you now ✔️*"
       else
        return "✔️تم ارسال رابط المجموعه لك بنجاح"
        end
     end
  if matches[1] == "ضع قوانين" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules set ✔️*"
   else 
  return "✔️تم حفظ قوانين المجموعه بنجاح"
   end
  end
  if matches[1] == "القوانين" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "💡 *The Default Rules* !\n‼️ *No Flood*.\n❌ *No Spam*.\n"
    elseif lang then
       rules = "\n      ❗️¦_القوانين العامه للكروب  _¦❗️\n❌¦_ عدم ارسال الروابط_   \n💡¦_عدم تكرار الرسائل  _\n🎚¦عدم التفليش  \n🔞¦_عدم ارسال اي شي اباحي_ \n ▪️▪️▪️▪️▪️▪️▪️▪️▪️▪️\n ❗️¦_ نتمنى لكم اسعد الاوقات معنا_¦❗️"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "res" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if matches[1] == "whois" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'ضع تكرار' and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_Wrong number, range is_ *[1-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
    return "_✔️تم وضع عدد التكرار بنجاح :_ *[ "..matches[2].." ]*"
       end
		if matches[1]:lower() == 'مسح' and is_owner(msg) then
			if matches[2] == 'mods' then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "*no super admin here ❌*"
             else
                return "لا يوجد اداريين ❌  "
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "*all super admins demoted now ✔️*"
          else
            return "تم تنزيل جميع الاداريين بنجاح ✔️"
			end
         end
			if matches[2] == 'filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "*mute words list is empty* ‼️"
         else
					return "لا يوجد كلمات ممنوعه ‼️ "
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "*mute words list cleaned now ✔️*"
           else
				return "تم مسح قائمة الكلمات الممنوعه بنجاح ✔️"
           end
			end
			if matches[2] == 'القوانين' then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "*No rules ❌*"
             else
               return "‼️ لايوجد قوانين  هنا"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*group rules deleteing now ✔️*"
          else
            return "تم مسح القوانين بنجاح ✔️"
			end
       end
			if matches[2] == 'setwelcome' then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "*Welcome Message not set*"
             else
               return "لا يوجد رسالة ترحيب"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Welcome message* _has been cleaned_"
          else
            return "تم مسح الترحيب"
			end
       end
			if matches[2] == 'الوصف' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "_No_ *description* _available_"
            else
              return "❗️┋لايوجد وصف في هذه المجموعة"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "*Group description* _has been cleaned_"
           else
              return "❗️️┋تم مسح وصف المجموعة"
             end
		   	end
        end
		if matches[1]:lower() == 'مسح' and is_admin(msg) then
			if matches[2] == 'المدراء' then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "_No_ *owners* _in this group_"
            else
                return "💡️┋لابوجد مدراء في هذه المجموعة"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *owners* _has been demoted_"
           else
            return "💡️┋تم مسح قائمة المدراء"
          end
			end
     end
if matches[1] == "ضع اسم" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "ضع وصف" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "❗️️┋تم حفظ وصف المجموعة"
      end
  end
  if matches[1] == "الوصف" and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "❗️┋لايوجد وصف في هذه المجموعة"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['الوصف']
      end
    return about
  end
  if matches[1] == 'muteword' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'unmuteword' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == 'mutewordlist' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "الحمايه" then
return group_settings(msg, target)
end
if matches[1] == "الوسائط" then
return mutes(msg, target)
end
if matches[1] == "الادمنيه" then
return modlist(msg)
end
if matches[1] == "المدراء" and is_owner(msg) then
return ownerlist(msg)
end

if matches[1] == "اللغه" and is_owner(msg) then
   if matches[2] == "انكلش" then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "تہٖٖمہٖۧہ تْہٖۧحہٖۧويہٖٖلہٖۧہ ٱلہٖۧلہٖٖغہٖٖہﮪّﮧ ٱلہٖۧہ﴿💗﴾ـہٖۧہٖۧـﮯ *EN*"
  elseif matches[2] == "عربي" then
redis:set(hash, true)
return "تہٖٖمہٖۧہ تْہٖۧحہٖۧويہٖٖلہٖۧہ ٱلہٖۧلہٖٖغہٖٖہﮪّﮧ ٱلہٖۧہ﴿💗﴾ـہٖۧہٖۧـﮯ *AR*"
end
end

if matches[1] == "الاوامر" and is_mod(msg) then
if not lang then
text = [[
_❰ اوامر حمايه المجموعه🛡❱_

_✔️¦【قفل+الامر】➣ للقفل               ❌¦【قفل+الامر】➣ للفتح_

_💡¦ التعديل   /   ¦ الملصقات 🌞_
_💡¦ الانلاين   /   ¦ المواقع 🗿_
_💡¦ التثبيت   /   ¦ الويب 🌐_
_💡¦ الكلايش /   ¦ الماركداون📍_
_💡¦ البصمات /   ¦ التوجيه ↪️_
_💡¦ المتحركة /  ¦ الكتابة ✏️_
_💡¦ الصور       /   ¦ البوتات 🤖_
_💡¦ الفيديو    /   ¦ التكرار 👥_
_💡¦ الصوتيات /  ¦ الكيبورد 🌞 _
_💡¦ الروابط     /   ¦ الكل 🗿_
_💡¦ الجهات    /  ¦الملفات 📁_
_💡¦ النص        /  ¦ التاك  📍_
_💡¦ الاشعارات/ ¦ اليوزر  👥_
_💡¦ العربيه      / ¦ الاشاره 💡_
_💡¦ الدردشه   /_   
_💡¦ بوتات الالعاب 🃏_




_❰ اوامر المجموعه العامه🚸❱_

_🔱 ¦ رفع المدير ➖رفع مدير المجموعه_
_🔱 ¦ تنزيل المدير➖لتنزيل مدير المجموعه_

_🔱 ¦ رفع ادمن➖لرفع ادمن في المجموعه_
_🔱 ¦ تنزيل ادمن➖لتنزيل ادمن في المجموعه_

_🔱 ¦ حظر➖لحظر العضو_
_🔱 ¦ فتح الحظر➖لالغاء حضر العضو_

_🔱 ¦ كتم➖لكتم العضو_
_🔱 ¦ فتح الكتم➖لفتح الكتم_

_🔱 ¦ حظر عام➖لحظر العضة بند عام_
_🔱 ¦ فتح العام➖لفتح الحظر_

_🔱 ¦ مسح الكل بلرد➖لمسح رسائل العضو_

_🔱 ¦ انشاء مجموعة ¦ ضع اسم_📍
_🔱 ¦ ضع قوانين  ¦ ضع وصف_📍
_🔱 ¦ ضع صورة   ¦ ضع ترحيب_📍
_🔱 ¦ الوسائط     ¦ الحمايه_📍

_™ كول + كلمه _


_❰خاص ببروفايل البوت 👾❱_

_💡¦ اسم البوت +【اسم للبوت】_
_💡¦ معرف البوت+ 【معرف للبوت】💡¦ صوره البوت +【صوره للبوت】_


_تابع قناه البوت _💙✨ @porgramer2017]]

elseif lang then

text = [[
_❰ اوامر حمايه المجموعه🛡❱_

_✔️¦【قفل+الامر】➣ للقفل               ❌¦【قفل+الامر】➣ للفتح_

_💡¦ التعديل   /   ¦ الملصقات 🌞_
_💡¦ الانلاين   /   ¦ المواقع 🗿_
_💡¦ التثبيت   /   ¦ الويب 🌐_
_💡¦ الكلايش /   ¦ الماركداون📍_
_💡¦ البصمات /   ¦ التوجيه ↪️_
_💡¦ المتحركة /  ¦ الكتابة ✏️_
_💡¦ الصور       /   ¦ البوتات 🤖_
_💡¦ الفيديو    /   ¦ التكرار 👥_
_💡¦ الصوتيات /  ¦ الكيبورد 🌞 _
_💡¦ الروابط     /   ¦ الكل 🗿_
_💡¦ الجهات    /  ¦الملفات 📁_
_💡¦ النص        /  ¦ التاك  📍_
_💡¦ الاشعارات/ ¦ اليوزر  👥_
_💡¦ العربيه      / ¦ الاشاره 💡_
_💡¦ الدردشه   /_   
_💡¦ بوتات الالعاب 🃏_




_❰ اوامر المجموعه العامه🚸❱_

_🔱 ¦ رفع المدير ➖رفع مدير المجموعه_
_🔱 ¦ تنزيل المدير➖لتنزيل مدير المجموعه_

_🔱 ¦ رفع ادمن➖لرفع ادمن في المجموعه_
_🔱 ¦ تنزيل ادمن➖لتنزيل ادمن في المجموعه_

_🔱 ¦ حظر➖لحظر العضو_
_🔱 ¦ فتح الحظر➖لالغاء حضر العضو_

_🔱 ¦ كتم➖لكتم العضو_
_🔱 ¦ فتح الكتم➖لفتح الكتم_

_🔱 ¦ حظر عام➖لحظر العضة بند عام_
_🔱 ¦ فتح العام➖لفتح الحظر_

_🔱 ¦ مسح الكل بلرد➖لمسح رسائل العضو_

_🔱 ¦ انشاء مجموعة ¦ ضع اسم_📍
_🔱 ¦ ضع قوانين  ¦ ضع وصف_📍
_🔱 ¦ ضع صورة   ¦ ضع ترحيب_📍
_🔱 ¦ الوسائط     ¦ الحمايه_📍

_™ كول + كلمه _


_❰خاص ببروفايل البوت 👾❱_

_💡¦ اسم البوت +【اسم للبوت】_
_💡¦ معرف البوت+ 【معرف للبوت】💡¦ صوره البوت +【صوره للبوت】_


_تابع قناه البوت _💙✨ @porgramer2017]]
end
return text
end
--------------------- Welcome -----------------------
	if matches[1] == "الترحيب" and is_mod(msg) then
		if matches[2] == "تشغيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "_Group_ *welcome is already runing ‼️*"
       elseif lang then
				return "‼️ الترحيب مفعل بالفعل "
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "*groub welcome runing now ✔️*"
       elseif lang then
				return "✔️ تم تشغيل الترحيب "
          end
			end
		end
		
		if matches[2] == "تعطيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "_Group_ *welcome is already stoping ‼️*"
      elseif lang then
				return "‼️ الترحيب معطل مسبقا "
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "*groub welcome stoping now ✔️*"
      elseif lang then
				return "✔️ تم تعطيل الترحيب "
          end
			end
		end
	end
	if matches[1] == "ضع ترحيب" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
  return "_Welcome Msg Set sucss 📍_\n*"..matches[2].."*\n_لرؤيه القوانين اكتب القوانين_"
       else
		return "💾┋تم حفظ الترحيب : \n"..matches[2].."\n☺️| لأضهار القوانين اكتب القوانين"
        end
     end
	end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.to.id
   local user = msg.from.id
 local data = load_data(_config.moderation.data)
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*welcome huny* 💙✨"
    elseif lang then
     welcome = " نورت حياتي تابع قناتنا @porgramer2017 💙✨"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "💡 *The Default Rules* !\n‼️ *No Flood*.\n❌ *No Spam*.\n"
    elseif lang then
       rules = "\n      ❗️┋_قوانين المجموعة العامه _┋❗️\n🚸┋_ عدم ارسال الروابط_   \n💡┋_عدم تكرار الرسائل _\n🎚┋عدم تفليش الكروب \n🔞┋_عدم ارسال صور اباحية_ \n •••••••••••••••••••••••••••••••••••••\n ❗️┋_نتمنى لكم اسعد الاوقات في المجموعة_┋❗️"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{gprules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{user}", user_name)
		local welcome = welcome:gsub("{gpn}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
	-- return msg
 end
return {
patterns ={
"^(ايدي)$",
"^(ايدي) (.*)$",
"^(تثبيت)$",
"^(الغاء تثبيت)$",
"^(معلومات المجموعه)$",
"^[!/#](test)$",
"^(تفعيل)$",
"^(تعطيل)$",
"^(رفع المدير)$",
"^(رفع المدير) (.*)$",
"^(تنزيل المدير)$",
"^(تنزيل المدير) (.*)$",
"^(رفع ادمن)$",
"^(رفع ادمن) (.*)$",
"^(تنزيل ادمن)$",
"^(تنزيل ادمن) (.*)$",
"^(الادمنيه)$",
"^(المدراء)$",
"^(قفل) (.*)$",
"^(فتح) (.*)$",
"^(الحمايه)$",
"^(الوسائط)$",
"^(قفل) (.*)$",
"^(فتح) (.*)$",
"^(الرابط)$",
"^[!/#](linkpv)$",
"^(ضع رابط)$",
"^(صنع رابط)$",
"^(القوانين)$",
"^(ضع قوانين) (.*)$",
"^(الوصف)$",
"^(ضع وصف) (.*)$",
"^(ضع اسم) (.*)$",
"^(مسح) (.*)$",
"^(ضع تكرار) (%d+)$",
"^(res) (.*)$",
"^(whois) (%d+)$",
"^(الاوامر)$",
"^(اللغه) (.*)$",
"^[#!/](muteword) (.*)$",
"^[#!/](unmuteword) (.*)$",
"^[#!/](mutewordlist)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^(ضع ترحيب) (.*)$",
"^(الترحيب) (.*)$",
"^[#!/](name) (.*)$",


},
run=run,
pre_process = pre_process
}
--by aboskrop
--@iq_100k
--smile team


