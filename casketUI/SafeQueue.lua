SafeQueueDB = SafeQueueDB or { announce = "self", enabled = true, minimap = "on" }
local queueTime
local queue = 0
local button2 = StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].button2
local remaining = 0

local function SafeQueue_Print(msg)
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99SafeQueue|r: " .. msg)
end

local function SafeQueue_PrintTimeWaited()
        if SafeQueueDB.announce == "off" then return end
        local secs, str, mins = floor(GetTime() - queueTime), "Queue popped "
        if secs < 1 then
                str = str .. "instantly!"
        else
                str = str .. "after "
                if secs >= 60 then
                        mins = floor(secs/60)
                        str = str .. mins .. "m "
                        secs = secs%60
                end
                if secs%60 ~= 0 then
                        str = str .. secs .. "s"
                end
        end
        if SafeQueueDB.announce == "self" then
                SafeQueue_Print(str)
        elseif SafeQueueDB.announce == "raid" then
                if UnitInRaid("player") then
                        SendChatMessage(str, "RAID")
                else
                        SendChatMessage(str, "PARTY")
                end
        elseif SafeQueueDB.announce == "party" then
                SendChatMessage(str, "PARTY")
        end
end
local function SafeQueue_Timer()
        local secs = GetBattlefieldPortExpiration(queue)
        if secs > 0 and SafeQueueDB.enabled == true then
                local p = StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY")
                if p then
                        local color
                        if remaining ~= secs then
                                remaining = secs
                                if secs > 20 then
                                        color = "f20ff20"
                                elseif secs > 10 then
                                        color = "fffff00"
                                else
                                        color = "fff0000"
                                end
                                _G[p .. "Text"]:SetText(string.gsub(
                                        _G[p .. "Text"]:GetText(), 
                                        ".+ to enter",
                                        "You have |cf"..color.. SecondsToTime(secs) .. "|r to enter"))
                        end
                end
        end     
end

local function SafeQueue_Update()
        local queued
        for i=1, GetMaxBattlefieldID() do
                local status, _, _, registeredMatch = GetBattlefieldStatus(i)
                if registeredMatch == 1 then
                        if status == "queued" then
                                queued = true
                                if not queueTime then queueTime = GetTime() end
                        elseif status == "confirm" then
                                if queueTime then
                                        SafeQueue_PrintTimeWaited()
                                        queueTime = nil
                                        remaining = 0
                                        queue = i
                                end                                     
                        end
                        break
                end
        end
        if not queued and queueTime then queueTime = nil end
end

local function SafeQueue_Enable()
        frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
        StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].button2 = nil
        StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].hideOnEscape = false
end

local function SafeQueue_Disable()
        frame:UnregisterEvent("UPDATE_BATTLEFIELD_STATUS")
        StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].button2 = button2
        StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].hideOnEscape = true
end

local function SafeQueue_Command(msg)
        msg = msg or ""
        local cmd, arg = string.split(" ", msg, 2)
        cmd = string.lower(cmd or "")
        arg = string.lower(arg or "")
        if cmd == "enable" then
                if SafeQueueDB.enabled == false then
                        SafeQueue_Enable()
                        SafeQueueDB.enabled = true      
                end
                SafeQueue_Print("|cff00ff00Enabled|r")
        elseif cmd == "disable" then
                if SafeQueueDB.enabled == true then
                        SafeQueue_Disable()
                        SafeQueueDB.enabled = false
                end
                SafeQueue_Print("|cffff0000Disabled|r")
        elseif cmd == "announce" then
                if arg == "off" or arg == "self" or arg == "party" or arg == "raid" then
                        SafeQueueDB.announce = arg
                        SafeQueue_Print("Announce set to " .. arg)
                else
                        SafeQueue_Print("Announce set to " .. SafeQueueDB.announce)
                        SafeQueue_Print("Announce types are \"off\", \"self\", \"party\", and \"raid\"")
                end
        else
                local status
                if SafeQueueDB.enabled == true then status = "|cff00ff00Enabled|r" else status = "|cffff0000Disabled|r" end
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99SafeQueue v1.7|r")
                SafeQueue_Print(status)
                SafeQueue_Print("/sq enable")
                SafeQueue_Print("/sq disable")
                SafeQueue_Print("/sq announce : " .. SafeQueueDB.announce)
                SafeQueue_Print("/sq safeleave : " .. SafeQueueDB.minimap)
        end
end

frame = CreateFrame("Frame", nil, UIParent)
frame:SetScript("OnEvent", SafeQueue_Update)
frame:SetScript("OnUpdate", SafeQueue_Timer)
if SafeQueueDB.enabled == true then SafeQueue_Enable() end

SlashCmdList["SafeQueue"] = SafeQueue_Command
SLASH_SafeQueue1 = "/safequeue"
SLASH_SafeQueue2 = "/sq"