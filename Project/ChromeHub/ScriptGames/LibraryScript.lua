--[[
  ChromaHub — LibraryScript.lua
  WindUI wrapper + utility functions
  Diload oleh setiap game script via loadstring
  by HaZcK
--]]

-- ============================
-- SERVICES
-- ============================
local TweenService  = game:GetService("TweenService")
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local LocalPlayer   = Players.LocalPlayer

-- ============================
-- LOAD WINDUI
-- ============================
local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/WindUI.lua"
))()

if not WindUI then
    warn("[ChromaHub] Gagal load WindUI!")
    return
end

-- ============================
-- CHROMAHUB LIBRARY
-- ============================
local ChromaLib = {}

-- --------------------------------
-- Window creator
-- Param:
--   config.Title     (string)   judul window
--   config.SubTitle  (string)   subtitle / nama game
--   config.Size      (UDim2)    ukuran window, optional
--   config.Acrylic   (bool)     blur background, optional
-- --------------------------------
function ChromaLib.CreateWindow(config)
    config = config or {}

    WindUI:SetConfiguration({
        Title       = config.Title    or "ChromaHub",
        SubTitle    = config.SubTitle or "Script Hub",
        TabWidth    = config.TabWidth or 160,
        Size        = config.Size     or UDim2.fromOffset(580, 460),
        Acrylic     = config.Acrylic  ~= nil and config.Acrylic or true,
        Theme       = config.Theme    or "Dark",
        Logo        = config.Logo     or "",
    })

    local Window = WindUI:CreateWindow()
    return Window
end

-- --------------------------------
-- Notifikasi
-- ntype: "info" | "success" | "warning" | "error"
-- --------------------------------
function ChromaLib.Notify(title, content, duration, ntype)
    local iconMap = {
        info    = "info",
        success = "check-circle",
        warning = "alert-triangle",
        error   = "x-circle",
    }
    WindUI:Notify({
        Title    = title   or "ChromaHub",
        Content  = content or "",
        Duration = duration or 3,
        Icon     = iconMap[ntype] or "bell",
    })
end

-- --------------------------------
-- Dialog konfirmasi
-- callback(bool) dipanggil setelah user pilih
-- --------------------------------
function ChromaLib.Confirm(title, message, callback)
    WindUI:Dialog({
        Title   = title   or "Konfirmasi",
        Content = message or "Yakin?",
        Buttons = {
            {
                Title    = "Ya",
                Callback = function()
                    if callback then callback(true) end
                end
            },
            {
                Title    = "Tidak",
                Callback = function()
                    if callback then callback(false) end
                end
            },
        }
    })
end

-- --------------------------------
-- Toggle loop utility
-- Berguna buat auto-farm, esp, dll
-- Usage:
--   local stop = ChromaLib.Loop(0.1, function() ... end)
--   stop() -- untuk hentikan loop
-- --------------------------------
function ChromaLib.Loop(interval, fn)
    local running = true
    task.spawn(function()
        while running do
            pcall(fn)
            task.wait(interval)
        end
    end)
    return function() running = false end
end

-- --------------------------------
-- Safe teleport karakter
-- --------------------------------
function ChromaLib.TeleportTo(position)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- --------------------------------
-- Get humanoid dari karakter local
-- --------------------------------
function ChromaLib.GetHumanoid()
    local char = LocalPlayer.Character
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

-- --------------------------------
-- Anti AFK built-in
-- --------------------------------
function ChromaLib.AntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- --------------------------------
-- No Clip toggle
-- --------------------------------
local _noclipActive = false
local _noclipConn   = nil

function ChromaLib.SetNoclip(state)
    _noclipActive = state
    if state and not _noclipConn then
        _noclipConn = RunService.Stepped:Connect(function()
            if not _noclipActive then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    elseif not state and _noclipConn then
        _noclipConn:Disconnect()
        _noclipConn = nil
    end
end

-- --------------------------------
-- Inf Jump toggle
-- --------------------------------
local _infJumpConn = nil

function ChromaLib.SetInfJump(state)
    if state and not _infJumpConn then
        _infJumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
            local hum = ChromaLib.GetHumanoid()
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    elseif not state and _infJumpConn then
        _infJumpConn:Disconnect()
        _infJumpConn = nil
    end
end

-- ============================
-- SIMPAN KE GLOBAL ENV
-- ============================
getgenv().ChromaLib = ChromaLib
getgenv().WindUI    = WindUI

print("[ChromaHub] LibraryScript loaded ✓")
