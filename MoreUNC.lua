-- Credits to SaladUNC and MoreUNC, respectively.
local objs = {}
local threadIdentities = {}
local httpserv = game:GetService("HttpService")
local function trackobj(obj)
    table.insert(objs, obj)
end
local function createobj(name)
    local obj = {name = name}
    trackobj(obj)
    return obj
end
local obj1 = createobj("obj1")
local obj2 = createobj("obj2")
getgenv().getgc = function()
    return objs
end
getgenv().isgameactive = function()
    return game and game:IsActive()
end
getgenv().http_request = function(url, method, headers, body)
    return getgenv().request({
        Url = url,
        Method = method,
        Headers = headers,
        Body = body
    })
end
local sha = loadstring(game:HttpGet("https://raw.githubusercontent.com/Insalad/libs/main/sha"))()
getgenv().setthreadidentity = function(identity)
    threadIdentities[coroutine.running()] = identity
end
getgenv().setidentity = setthreadidentity
getgenv().setthreadcontext = setidentity
getgenv().getthreadidentity = function()
    return threadIdentities[coroutine.running()] or 0
end
getgenv().getnilinstances = function(property)
    property = property or ""  
    local instances = {}
    for instance, properties in pairs(hiddenProperties) do
        if properties[property] == nil then
            table.insert(instances, instance)
        end
    end
    return instances
end
getgenv().customprint = function(text: string, properties: table, imageId: rbxasset)
    print(text)
    task.wait(.025)
    local msg = game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI:WaitForChild("MainView").ClientLog[tostring(#game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren())-1].msg
    for i, x in pairs(properties) do
        msg[i] = x
    end
    if imageId then
         msg.Parent.image.Image = imageId 
    end
end
getgenv().getdevice = function()
    local inputsrv = game:GetService("UserInputService")
    if inputsrv:GetPlatform() == Enum.Platform.Windows then
        return 'Windows'
    elseif inputsrv:GetPlatform() == Enum.Platform.OSX then
        return 'macOS'
    elseif inputsrv:GetPlatform() == Enum.Platform.IOS then
        return 'iOS'
    elseif inputsrv:GetPlatform() == Enum.Platform.UWP then
        return 'Windows (Microsoft Store)'
    elseif inputsrv:GetPlatform() == Enum.Platform.Android then
        return 'Android'
    else 
        return 'Unknown'
    end
end
getgenv().runanimation = function(animationId, player)
    local plr = player or getplayer()
    local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. tostring(animationId)
        humanoid:LoadAnimation(animation):Play()
    end
end
getgenv().getping = function(suffix: boolean)
    local rawping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local pingstr = rawping:sub(1,#rawping-7)
    local pingnum = tonumber(pingstr)
    local ping = tostring(math.round(pingnum))
    return not suffix and ping or ping.." ms"
end
getgenv().getfps = function(suffix: boolean)
    local rawfps = game:GetService("Stats").Workspace.Heartbeat:GetValue()
    local fpsnum = tonumber(rawfps)
    local fps = tostring(math.round(fpsnum))
    return not suffix and fps or fps.." fps"
end
getgenv().getplayers = function()
    local players = {}
    for _, x in pairs(game:GetService("Players"):GetPlayers()) do
        players[x.Name] = x
    end
    players["LocalPlayer"] = game:GetService("Players").LocalPlayer
    return players
end
getgenv().getplayer = function(name: string)
    return not name and getplayers()["LocalPlayer"] or getplayers()[name]
end
getgenv().getaffiliateid = function()
  return "salad-aff0"
end
getgenv().getlocalplayer = function()
    return getplayer()
end
getgenv().firesignal = function(button, event)
    if button and event and button[event] then
        local connections = getconnections(button[event])
        for _, connection in pairs(connections) do
            connection:Fire()
        end
    end
end
getgenv().firetouchtransmitter = firetouchinterest
getgenv().getplatform = getdevice
getgenv().getos = getdevice
getgenv().playanimation = runanimation
getgenv().cache = {}
getgenv().cachedshit = {}
getgenv().cache.invalidate = function(part)
    if part then
        part:Destroy()
        cachedshit[part] = nil
    end
end
getgenv().cache.iscached = function(part)
    if not part then
        return false
    end

    return cachedshit[part] ~= nil
end
getgenv().cache.replace = function(oldpart, newpart)
    if cachedshit[oldpart] then
        cachedshit[oldpart] = nil
    end
    cachedshit[newpart] = true
end
game.DescendantAdded:Connect(function(descendant)
    cachedshit[descendant] = true
end)
game.DescendantRemoving:Connect(function(descendant)
    cachedshit[descendant] = nil
end)
local table = table.clone(table)
local debug = table.clone(debug)
local bit32 = table.clone(bit32)
local bit = bit32
local os = table.clone(os)
local math = table.clone(math)
local utf8 = table.clone(utf8)
local string = table.clone(string)
local task = table.clone(task)
local game = game
local oldGame = game
local Version = '1.1.6'
local Data = game:GetService("TeleportService"):GetLocalPlayerTeleportData()
local TeleportData
if Data and Data.MOREUNCSCRIPTQUEUE then
 TeleportData = Data.MOREUNCSCRIPTQUEUE
end
if TeleportData then
 local func = loadstring(TeleportData)
 local s, e = pcall(func)
 if not s then task.spawn(error, e) end
end
print = print
warn = warn
error = error
pcall = pcall
printidentity = printidentity
ipairs = ipairs
pairs = pairs
tostring = tostring
tonumber = tonumber
setmetatable = setmetatable
rawget = rawget
rawset = rawset
getmetatable = getmetatable
type = type
version = version
local HttpService = game:GetService('HttpService');
local Log = game:GetService('LogService');
local API_Dump_Url = "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/Mini-API-Dump.json"
local API_Dump = game:HttpGet(API_Dump_Url)
local Hidden = {}
for _, API_Class in pairs(HttpService:JSONDecode(API_Dump).Classes) do
    for _, Member in pairs(API_Class.Members) do
        if Member.MemberType == "Property" then
            local PropertyName = Member.Name

            local MemberTags = Member.Tags

            local Special

            if MemberTags then
                Special = table.find(MemberTags, "NotScriptable")
            end
            if Special then
                table.insert(Hidden, PropertyName)
            end
        end
    end
end
local vim = Instance.new("VirtualInputManager");
function QueueGetIdentity()
  printidentity()
  task.wait(.1)
  local messages = Log:GetLogHistory()
  local message;
  if not messages[#messages].message:match("Current identity is") then
   for i = #messages, 1, -1 do
    if messages[i].message:match("Current identity is %d") then
     message = messages[i].message
     break
    end
   end
  else
   message = messages[#messages].message:match('Current identity is %d'):gsub("Current identity is ", '')
  end
  Identity = tonumber(message)
end
local Queue = {}
Queue.__index = Queue
function Queue.new()
    local self = setmetatable({}, Queue)
    self.elements = {}
    return self
end
function Queue:Queue(element)
    table.insert(self.elements, element)
end
function Queue:Update()
    if #self.elements == 0 then
        return nil
    end
    return table.remove(self.elements, 1)
end
function Queue:IsEmpty()
    return #self.elements == 0
end
function Queue:Current()
    return self.elements
end
local ClipboardQueue = Queue.new()
local ConsoleQueue = Queue.new()
local getgenv = getgenv or getfenv(2)
getgenv().getgenv = getgenv
local Sandbox = loadstring(game:HttpGet("https://pastebin.com/raw/a0cuADU4"))()
funcs.dumpstring = funcs.string.dump
funcs.compareinstances = function(a, b)
 if not clonerefs[a] then
  return a == b
 else
  if table.find(clonerefs[a], b) then return true end
 end
 return false
end
funcs.cache.iscached = function(thing)
 return cache[thing] ~= 'REMOVE' and thing:IsDescendantOf(game) or false
end
funcs.cache.invalidate = function(thing)
 cache[thing] = 'REMOVE'
 thing.Parent = nil
end
funcs.cache.replace = function(a, b)
 if cache[a] then
  cache[a] = b
 end
 local n, p = a.Name, a.Parent
 b.Parent = p
 b.Name = n
 a.Parent = nil
end
funcs.deepclone = function(a)
 local Result = {}
 for i, v in pairs(a) do
  if type(v) == 'table' then
    Result[i] = funcs.deepclone(v)
  end
  Result[i] = v
 end
 return Result
end
funcs.base64.encode = function(data)
    local letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return letters:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
funcs.base64.decode = function(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
        end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0)
        end
        return string.char(c)
    end))
end
funcs.syn.write_clipboard = funcs.setclipboard
funcs.toclipboard = funcs.setclipboard
funcs.writeclipboard = funcs.setclipboard
funcs.setrbxclipboard = funcs.setclipboard
funcs.getrenderproperty = function(thing, prop)
 return thing[prop]
end
funcs.setrenderproperty = function(thing, prop, val)
 local success, err = pcall(function()
  thing[prop] = val
 end)
 if not success and err then warn(err) end
end
funcs.syn.protect_gui = function(gui)
 names[gui] = {name=gui.Name,parent=gui.Parent}
 protecteduis[gui] = gui
 gui.Name = funcs.crypt.random(64)
 gui.Parent = gethui()
end
funcs.syn.unprotect_gui = function(gui)
 if names[gui] then gui.Name = names[gui].name gui.Parent = names[gui].parent end protecteduis[gui] = nil
end
funcs.syn.protectgui = funcs.syn.protect_gui
funcs.syn.unprotectgui = funcs.syn.unprotect_gui
funcs.syn.secure_call = function(func)
 return pcall(func)
end
funcs.httppost = function(url, body, contenttype)
 return game:HttpPostAsync(url, body, contenttype)
end
funcs.request = function(args)
 local Body = nil
 local Timeout = 0
 local function callback(success, body)
  Body = body
  Body['Success'] = success
 end
 HttpService:RequestInternal(args):Start(callback)
 while not Body and Timeout < 10 do
  task.wait(.1)
  Timeout = Timeout + .1
 end
 return Body
end
funcs.mouse1click = function(x, y)
 x = x or 0
 y = y or 0
 vim:SendMouseButtonEvent(x, y, 0, true, game, false)
 task.wait()
 vim:SendMouseButtonEvent(x, y, 0, false, game, false)
end
funcs.mouse2click = function(x, y)
 x = x or 0
 y = y or 0
 vim:SendMouseButtonEvent(x, y, 1, true, game, false)
 task.wait()
 vim:SendMouseButtonEvent(x, y, 1, false, game, false)
end
funcs.mouse1press = function(x, y)
 x = x or 0
 y = y or 0
 vim:SendMouseButtonEvent(x, y, 0, true, game, false)
end
funcs.mouse1release = function(x, y)
 x = x or 0
 y = y or 0
 vim:SendMouseButtonEvent(x, y, 0, false, game, false)
end
funcs.mouse2press = function(x, y)
 x = x or 0
 y = y or 0
 vim:SendMouseButtonEvent(x, y, 1, true, game, false)
end
funcs.mouse2release = function(x, y)
 x = x or 0
 y = y or 0
 vim:SendMouseButtonEvent(x, y, 1, false, game, false)
end
funcs.mousescroll = function(x, y, a)
 x = x or 0
 y = y or 0
 a = a and true or false
 vim:SendMouseWheelEvent(x, y, a, game)
end
funcs.keyclick = function(key)
 if typeof(key) == 'number' then
 if not keys[key] then return error("Key "..tostring(key) .. ' not found!') end
 vim:SendKeyEvent(true, keys[key], false, game)
 task.wait()
 vim:SendKeyEvent(false, keys[key], false, game)
 elseif typeof(Key) == 'EnumItem' then
  vim:SendKeyEvent(true, key, false, game)
  task.wait()
  vim:SendKeyEvent(false, key, false, game)
 end
end
funcs.keypress = function(key)
 if typeof(key) == 'number' then
 if not keys[key] then return error("Key "..tostring(key) .. ' not found!') end
 vim:SendKeyEvent(true, keys[key], false, game)
 elseif typeof(Key) == 'EnumItem' then
  vim:SendKeyEvent(true, key, false, game)
 end
end
funcs.keyrelease = function(key)
 if typeof(key) == 'number' then
 if not keys[key] then return error("Key "..tostring(key) .. ' not found!') end
 vim:SendKeyEvent(false, keys[key], false, game)
 elseif typeof(Key) == 'EnumItem' then
  vim:SendKeyEvent(false, key, false, game)
 end
end
funcs.newlclosure = function(fnc)
 return function(...) return fnc(...) end
end
funcs.clonefunction = funcs.newlclosure
funcs.is_executor_closure = funcs.isexecutorclosure
funcs.isourclosure = funcs.isexecutorclosure
funcs.isexecclosure = funcs.isexecutorclosure
funcs.checkclosure = funcs.isourclosure
local files = {}
local function startswith(a, b)
 return a:sub(1, #b) == b
end
local function endswith(hello, lo) 
    return hello:sub(#hello - #lo + 1, #hello) == lo
end
funcs.writefile = function(path, content)
 local Path = path:split('/')
 local CurrentPath = {}
 for i = 1, #Path do
  local a = Path[i]
  CurrentPath[i] = a
  if not files[a] and i ~= #Path then
   files[table.concat(CurrentPath, '/')] = {}
   files[table.concat(CurrentPath, '/') .. '/'] = files[table.concat(CurrentPath, '/')]
  elseif i == #Path then
   files[table.concat(CurrentPath, '/')] = tostring(content)
  end
 end
end
funcs.isfolder = function(path)
 return type(files[path]) == 'table'
end
funcs.http.request = funcs.request
funcs.syn.crypt = funcs.crypt
funcs.syn.crypto = funcs.crypt
funcs.syn_backup = funcs.syn
funcs.http_request = getgenv().request or funcs.request
funcs.getmodules = function()
 local a = {};for i, v in pairs(game:GetDescendants()) do if v:IsA("ModuleScript") then table.insert(a, v) end end return a
end
funcs.setsimulationradius = function(Distance, MaxDistance)
 local LocalPlayer = game:GetService("Players").LocalPlayer
 assert(type(Distance)=='number','Invalid arguement #1 to \'setsimulationradius\', Number expected got ' .. type(Distance))
 LocalPlayer.SimulationRadius = type(Distance) == 'number' and Distance or LocalPlayer.SimulationRadius
 if MaxDistance then
  assert(type(MaxDistance)=='number','Invalid arguement #2 to \'setsimulationradius\', Number expected got ' .. type(MaxDistance))
  LocalPlayer.MaxSimulationDistance = MaxDistance
 end
end
funcs.getnilinstances = function()
 return Instances
end
funcs.iswriteable = function(tbl)
 return not table.isfrozen(tbl)
end
funcs.makewriteable = function(tbl)
 return funcs.setreadonly(tbl, false)
end
funcs.firetouchinterest = function(toTouch, TouchWith, on)
 if on == 0 then return end
 if toTouch.ClassName == 'TouchTransmitter' then
   local function get()
    local classes = {'BasePart', 'Part', 'MeshPart'}
    for _, v in pairs(classes) do
    if toTouch:FindFirstAncestorOfClass(v) then
     return toTouch:FindFirstAncestorOfClass(v)
    end
   end
  end
  toTouch = get()
 end
 local cf = toTouch.CFrame
 local anc = toTouch.CanCollide
 toTouch.CanCollide = false
 toTouch.CFrame = TouchWith.CFrame
 task.wait()
 toTouch.CFrame = cf
 toTouch.CanCollide = anc
end
funcs.getthreadidentity = funcs.getthreadcontext
funcs.getidentity = funcs.getthreadcontext
funcs.queue_on_teleport = function(scripttoexec)
 local newTPService = {
  __index = function(self, key)
   if key == 'Teleport' then
    return function(gameId, player, teleportData, loadScreen)
      teleportData = {teleportData, MOREUNCSCRIPTQUEUE=scripttoexec}
      return oldGame:GetService("TeleportService"):Teleport(gameId, player, teleportData, loadScreen)
    end
   end
  end
 }
 local gameMeta = {
  __index = function(self, key)
    if key == 'GetService' then
     return function(name)
      if name == 'TeleportService' then return newTPService end
     end
    elseif key == 'TeleportService' then return newTPService end
    return game[key]
  end,
  __metatable = 'The metatable is protected'
 }
 getgenv().game = setmetatable({}, gameMeta)
end
funcs.queueonteleport = funcs.queue_on_teleport
local Count = 0
local Total = 0
local funcs2 = {}
for i, _ in pairs(funcs) do
 table.insert(funcs2, i)
end
table.sort(funcs2, function(a, b)
 return string.byte(a:lower())<string.byte(b:lower())
end)
for i, v in pairs(funcs2) do
 if not getgenv()[i] then
  Total = Total + 1
 end
end
for _, i in pairs(funcs2) do
 local v = funcs[i]
 local Result = SafeOverride(i, v)
 if Result == 2 then Count = Count + 1 end
 local str = Result == 1 and ('[⛔] %s already exists.'):format(i) or Result == 2 and ("[✅] Added %s%s to the global environment. (%d/%d)"):format(i, type(v)=='function' and '()' or '', Count, Total) or Result ~= 1 and Result ~= 2 and ("[⛔] Unknown result for %s."):format(i)
end
funcs.getthreadcontext = function()
	if coroutine.isyieldable(coroutine.running()) then
		QueueGetIdentity()
		task.wait(.1)
		return tonumber(Identity)
	else
		if Identity == -1 then
			task.spawn(QueueGetIdentity)
			return 1
		else
			return tonumber(Identity)
		end
	end
end
