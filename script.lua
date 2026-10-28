-- BlockSpin Pro Hub - Ultimate Edition V12 (FULL All-In-One)
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local GUI_Parent = gethui and gethui() or CoreGui
if GUI_Parent:FindFirstChild("BlockSpinProV12") then GUI_Parent.BlockSpinProV12:Destroy() end

-- ==========================================
-- 1. بناء الواجهة (UI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = "BlockSpinProV12"; ScreenGui.Parent = GUI_Parent; ScreenGui.ResetOnSpawn = false
local FloatingIcon = Instance.new("TextButton"); FloatingIcon.Parent = ScreenGui; FloatingIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 22); FloatingIcon.Position = UDim2.new(0, 35, 0, 150); FloatingIcon.Size = UDim2.new(0, 54, 0, 54); FloatingIcon.Font = Enum.Font.SourceSansBold; FloatingIcon.Text = "🛡️"; FloatingIcon.TextColor3 = Color3.fromRGB(255, 69, 0); FloatingIcon.TextSize = 26
local IconCorner = Instance.new("UICorner"); IconCorner.CornerRadius = UDim.new(1, 0); IconCorner.Parent = FloatingIcon
local IconStroke = Instance.new("UIStroke"); IconStroke.Color = Color3.fromRGB(255, 69, 0); IconStroke.Thickness = 2.5; IconStroke.Parent = FloatingIcon

local MainFrame = Instance.new("Frame"); MainFrame.Name = "MainFrame"; MainFrame.Parent = ScreenGui; MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25); MainFrame.Position = UDim2.new(0.5, -210, 0.5, -220); MainFrame.Size = UDim2.new(0, 420, 0, 440); MainFrame.Visible = false
local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 16); MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke"); MainStroke.Color = Color3.fromRGB(255, 69, 0); MainStroke.Thickness = 2; MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame"); TopBar.Parent = MainFrame; TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 35); TopBar.Size = UDim2.new(1, 0, 0, 48)
local TopCorner = Instance.new("UICorner"); TopCorner.CornerRadius = UDim.new(0, 16); TopCorner.Parent = TopBar
local Title = Instance.new("TextLabel"); Title.Parent = TopBar; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 18, 0, 0); Title.Size = UDim2.new(0.7, 0, 1, 0); Title.Font = Enum.Font.SourceSansBold; Title.Text = "BLOCKSPIN | Pro Hub V12"; Title.TextColor3 = Color3.fromRGB(255, 69, 0); Title.TextSize = 16; Title.TextXAlignment = Enum.TextXAlignment.Left
local CloseXBtn = Instance.new("TextButton"); CloseXBtn.Parent = TopBar; CloseXBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50); CloseXBtn.Position = UDim2.new(1, -38, 0.5, -13); CloseXBtn.Size = UDim2.new(0, 26, 0, 26); CloseXBtn.Font = Enum.Font.SourceSansBold; CloseXBtn.Text = "X"; CloseXBtn.TextColor3 = Color3.fromRGB(255, 255, 255); CloseXBtn.TextSize = 13; CloseXBtn.AutoButtonColor = false
local XCorner = Instance.new("UICorner"); XCorner.CornerRadius = UDim.new(1, 0); XCorner.Parent = CloseXBtn

local TabsBar = Instance.new("Frame"); TabsBar.Parent = MainFrame; TabsBar.BackgroundTransparency = 1; TabsBar.Position = UDim2.new(0, 10, 0, 55); TabsBar.Size = UDim2.new(1, -20, 0, 35)
local TabsLayout = Instance.new("UIListLayout"); TabsLayout.Parent = TabsBar; TabsLayout.FillDirection = Enum.FillDirection.Horizontal; TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder; TabsLayout.Padding = UDim.new(0, 6)
local ContentContainer = Instance.new("Frame"); ContentContainer.Parent = MainFrame; ContentContainer.BackgroundTransparency = 1; ContentContainer.Position = UDim2.new(0, 10, 0, 95); ContentContainer.Size = UDim2.new(1, -20, 1, -105)

local tabs = {}
local function createTabContent(name)
    local scrolling = Instance.new("ScrollingFrame"); scrolling.Name = name .. "Content"; scrolling.Parent = ContentContainer; scrolling.BackgroundTransparency = 1; scrolling.Size = UDim2.new(1, 0, 1, 0); scrolling.CanvasSize = UDim2.new(0, 0, 0, 0); scrolling.ScrollBarThickness = 4; scrolling.Visible = false
    local list = Instance.new("UIListLayout"); list.Parent = scrolling; list.HorizontalAlignment = Enum.HorizontalAlignment.Center; list.SortOrder = Enum.SortOrder.LayoutOrder; list.Padding = UDim.new(0, 8)
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() scrolling.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15) end)
    return scrolling
end

local function createTabButton(name, iconText)
    local btn = Instance.new("TextButton"); btn.Parent = TabsBar; btn.BackgroundColor3 = Color3.fromRGB(26, 26, 36); btn.Size = UDim2.new(0, 92, 1, 0); btn.Font = Enum.Font.SourceSansBold; btn.Text = iconText .. " " .. name; btn.TextColor3 = Color3.fromRGB(180, 180, 180); btn.TextSize = 13; btn.AutoButtonColor = false
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 8); corner.Parent = btn
    local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(45, 45, 60); stroke.Thickness = 1; stroke.Parent = btn
    local content = createTabContent(name)
    btn.Activated:Connect(function()
        for _, t in pairs(tabs) do t.content.Visible = false; t.btn.BackgroundColor3 = Color3.fromRGB(26, 26, 36); t.btn.TextColor3 = Color3.fromRGB(180, 180, 180); t.stroke.Color = Color3.fromRGB(45, 45, 60) end
        content.Visible = true; btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50); btn.TextColor3 = Color3.fromRGB(255, 69, 0); stroke.Color = Color3.fromRGB(255, 69, 0)
    end)
    tabs[name] = {btn = btn, content = content, stroke = stroke}
    return content
end

local combatTab = createTabButton("Combat", "🎯")
local visualsTab = createTabButton("Visuals", "👁️")
local utilityTab = createTabButton("Utility", "📦")
local autofarmTab = createTabButton("AutoFarm", "🤖")
tabs["Combat"].content.Visible = true; tabs["Combat"].btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50); tabs["Combat"].btn.TextColor3 = Color3.fromRGB(255, 69, 0); tabs["Combat"].stroke.Color = Color3.fromRGB(255, 69, 0)

local function createFeatureToggle(parentTab, name, desc, callback)
    local btn = Instance.new("TextButton"); btn.Parent = parentTab; btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32); btn.Size = UDim2.new(0.98, 0, 0, 48); btn.Text = ""; btn.AutoButtonColor = false
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 10); corner.Parent = btn
    local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(45, 45, 60); stroke.Thickness = 1.2; stroke.Parent = btn
    local nameLabel = Instance.new("TextLabel"); nameLabel.Parent = btn; nameLabel.BackgroundTransparency = 1; nameLabel.Position = UDim2.new(0, 14, 0, 8); nameLabel.Size = UDim2.new(0.7, 0, 0, 16); nameLabel.Font = Enum.Font.SourceSansBold; nameLabel.Text = name; nameLabel.TextColor3 = Color3.fromRGB(240, 240, 240); nameLabel.TextSize = 14; nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    local descLabel = Instance.new("TextLabel"); descLabel.Parent = btn; descLabel.BackgroundTransparency = 1; descLabel.Position = UDim2.new(0, 14, 0, 24); descLabel.Size = UDim2.new(0.7, 0, 0, 16); descLabel.Font = Enum.Font.SourceSans; descLabel.Text = desc; descLabel.TextColor3 = Color3.fromRGB(140, 140, 140); descLabel.TextSize = 11; descLabel.TextXAlignment = Enum.TextXAlignment.Left
    local statusBox = Instance.new("Frame"); statusBox.Parent = btn; statusBox.BackgroundColor3 = Color3.fromRGB(50, 50, 65); statusBox.Position = UDim2.new(1, -38, 0.5, -12); statusBox.Size = UDim2.new(0, 24, 0, 24)
    local boxCorner = Instance.new("UICorner"); boxCorner.CornerRadius = UDim.new(0, 6); boxCorner.Parent = statusBox
    local state = false
    btn.Activated:Connect(function()
        state = not state
        if state then statusBox.BackgroundColor3 = Color3.fromRGB(255, 69, 0); stroke.Color = Color3.fromRGB(255, 69, 0) else statusBox.BackgroundColor3 = Color3.fromRGB(50, 50, 65); stroke.Color = Color3.fromRGB(45, 45, 60) end
        callback(state)
    end)
    return btn
end

local silentEnabled, aimbotEnabled, espEnabled, autoLootEnabled = false, false, false, false
local autoChefEnabled, autoJanitorEnabled, autoGasEnabled, autoAtmEnabled = false, false, false, false

createFeatureToggle(combatTab, "Silent Aim", "تصويب صامت ذكي", function(enabled) silentEnabled = enabled end)
createFeatureToggle(combatTab, "Aimbot", "قفل الأيم", function(enabled) aimbotEnabled = enabled end)
createFeatureToggle(visualsTab, "Players ESP", "تلوين اللاعبين", function(enabled) espEnabled = enabled end)
createFeatureToggle(utilityTab, "Auto Loot", "التقاط الغنائم", function(enabled) autoLootEnabled = enabled end)
createFeatureToggle(autofarmTab, "Auto Chef Job", "الطباخ/الكاشير (المطعم)", function(enabled) autoChefEnabled = enabled end)
createFeatureToggle(autofarmTab, "Auto Janitor Job", "المساح الآلي", function(enabled) autoJanitorEnabled = enabled end)
createFeatureToggle(autofarmTab, "Auto Stocker (Boxes)", "رص الرفوف (الصناديق)", function(enabled) autoGasEnabled = enabled end)
createFeatureToggle(autofarmTab, "Auto ATM Hack", "تهكير الصرافات (ديناميكي)", function(enabled) autoAtmEnabled = enabled end)

-- ==========================================
-- 2. أكواد القتال (Combat)
-- ==========================================
local silentFovCircle = Drawing.new("Circle"); silentFovCircle.Visible = false; silentFovCircle.Radius = 100; silentFovCircle.Color = Color3.fromRGB(255, 69, 0); silentFovCircle.Thickness = 1.5; silentFovCircle.Transparency = 0.7
local aimbotFovCircle = Drawing.new("Circle"); aimbotFovCircle.Visible = false; aimbotFovCircle.Radius = 100; aimbotFovCircle.Color = Color3.fromRGB(0, 191, 255); aimbotFovCircle.Thickness = 1.5; aimbotFovCircle.Transparency = 0.7

local currentLockedTarget = nil; local cachedSilentTarget = nil
local function getClosestSilentTarget() local closest = nil; local shortest = 100; local mouse = UserInputService:GetMouseLocation(); for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then local part = math.random(1, 10) <= 3 and p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart"); if part then local pos, onScreen = Camera:WorldToViewportPoint(part.Position); if onScreen then local dist = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude; if dist < shortest then shortest = dist; closest = part end end end end end return closest end
local function getClosestAimbotTarget() local camCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2); if currentLockedTarget and currentLockedTarget.Parent and currentLockedTarget.Parent:FindFirstChild("Humanoid") and currentLockedTarget.Parent.Humanoid.Health > 0 then local pos, onScreen = Camera:WorldToViewportPoint(currentLockedTarget.Position); if onScreen and (Vector2.new(pos.X, pos.Y) - camCenter).Magnitude <= 100 * 1.3 then return currentLockedTarget end end local closest = nil; local shortest = 100; for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then local part = p.Character:FindFirstChild("HumanoidRootPart"); if part then local pos, onScreen = Camera:WorldToViewportPoint(part.Position); if onScreen then local dist = (Vector2.new(pos.X, pos.Y) - camCenter).Magnitude; if dist < shortest then shortest = dist; closest = part end end end end end currentLockedTarget = closest; return currentLockedTarget end

local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...) local method = getnamecallmethod(); if silentEnabled and not checkcaller() and (method == "Raycast" or method == "FindPartOnRay") and self == Workspace then if cachedSilentTarget and cachedSilentTarget.Parent then local args = {...}; pcall(function() if method == "Raycast" and typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then args[2] = (cachedSilentTarget.Position - args[1]).Unit * args[2].Magnitude elseif method == "FindPartOnRay" and typeof(args[1]) == "Ray" then args[1] = Ray.new(args[1].Origin, (cachedSilentTarget.Position - args[1].Origin).Unit * args[1].Direction.Magnitude) end end); return oldNamecall(self, unpack(args)) end end return oldNamecall(self, ...) end)

RunService.RenderStepped:Connect(function() 
    local camCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    silentFovCircle.Position = camCenter; aimbotFovCircle.Position = camCenter
    if silentEnabled then cachedSilentTarget = getClosestSilentTarget() else cachedSilentTarget = nil end
    if aimbotEnabled then pcall(function() local targetPart = getClosestAimbotTarget(); if targetPart then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPart.Position), 0.35) else currentLockedTarget = nil end end) end 
end)

-- ==========================================
-- 3. نظام ESP
-- ==========================================
local activeHighlights = {}
RunService.RenderStepped:Connect(function()
    if espEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("BlockSpinHighlight") then
                local hl = Instance.new("Highlight"); hl.Name = "BlockSpinHighlight"; hl.Adornee = p.Character; hl.FillColor = Color3.fromRGB(255, 69, 0); hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.FillTransparency = 0.4; hl.Parent = p.Character; table.insert(activeHighlights, hl)
            end
        end
    else
        for _, hl in ipairs(activeHighlights) do if hl then hl:Destroy() end end; activeHighlights = {}
    end
end)

-- ==========================================
-- 4. نظام الأوتو لوت (Auto Loot)
-- ==========================================
local activeDrops = {}; local collectedParts = {}
Workspace.DescendantAdded:Connect(function(obj) if obj:IsA("BasePart") then task.delay(0.1, function() if obj and obj.Parent and obj:FindFirstChild("TouchInterest") then activeDrops[obj] = true end end) end end)
Workspace.DescendantRemoving:Connect(function(obj) if activeDrops[obj] then activeDrops[obj] = nil; collectedParts[obj] = nil end end)
task.spawn(function() for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then activeDrops[obj] = true end end end)

local function collectLoot()
    local char = LocalPlayer.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    for obj, _ in pairs(activeDrops) do
        if obj and obj.Parent and obj:FindFirstChild("TouchInterest") then
            local pName = obj.Parent.Name:lower(); local oName = obj.Name:lower()
            if not (pName:find("shop") or pName:find("pawn") or pName:find("sell") or pName:find("market") or pName:find("npc") or pName:find("trade") or pName:find("register") or oName:find("shop") or oName:find("pawn") or oName:find("sell") or oName:find("market") or oName:find("npc") or oName:find("trade") or oName:find("register")) then
                local distance = (hrp.Position - obj.Position).Magnitude
                if distance <= 8 and not collectedParts[obj] then
                    collectedParts[obj] = true; pcall(function() firetouchinterest(hrp, obj, 0); task.wait(); firetouchinterest(hrp, obj, 1) end); task.delay(2, function() collectedParts[obj] = nil end)
                end
            end
        else activeDrops[obj] = nil end
    end
end
task.spawn(function() while task.wait(0.4) do if autoLootEnabled then pcall(collectLoot) end end end)

-- ==========================================
-- 5. محرك الفارم الشامل (AutoFarm Engine)
-- ==========================================
local function moveTo(targetPos)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") or not char:FindFirstChild("HumanoidRootPart") then return false end
    local startTime = tick()
    while tick() - startTime < 20 do
        local dist = (char.HumanoidRootPart.Position - targetPos).Magnitude
        if dist < 7 then return true end
        char.Humanoid:MoveTo(targetPos); task.wait(0.2)
    end
    return false
end

local function findPromptNearPos(pos, radius)
    local params = OverlapParams.new(); params.FilterDescendantsInstances = {LocalPlayer.Character}; params.FilterType = Enum.RaycastFilterType.Exclude
    for _, part in pairs(Workspace:GetPartBoundsInRadius(pos, radius or 12, params)) do local prompt = part:FindFirstChildOfClass("ProximityPrompt"); if prompt then return prompt end end
    return nil
end

local boxLocations = { Vector3.new(149.11, 254.37, 212.75), Vector3.new(114.41, 236.27, 209.85), Vector3.new(102.41, 236.27, 209.75), Vector3.new(115.81, 236.27, 197.75) }
local chefLocation = Vector3.new(111.36, 256.15, -275.70) 

local discoveredAtms = {}; local scannedAtmPositions = {}; local currentAtmIndex = 1
local function scanForNewAtms()
    local char = LocalPlayer.Character; if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local params = OverlapParams.new(); params.FilterDescendantsInstances = {char}; params.FilterType = Enum.RaycastFilterType.Exclude
    for _, part in pairs(Workspace:GetPartBoundsInRadius(char.HumanoidRootPart.Position, 500, params)) do
        local prompt = part:FindFirstChildOfClass("ProximityPrompt")
        if prompt then
            local searchStr = (part.Name .. " " .. prompt.ActionText):lower()
            if searchStr:find("atm") or searchStr:find("hack") then
                local isNew = true
                for _, existingPos in pairs(scannedAtmPositions) do if (part.Position - existingPos).Magnitude < 10 then isNew = false; break end end
                if isNew then table.insert(scannedAtmPositions, part.Position); table.insert(discoveredAtms, {prompt = prompt, part = part}) end
            end
        end
    end
end

local isFarmingAtm, isFarmingBox, isCooking, isCleaning = false, false, false, false; local boxIndex = 1

task.spawn(function()
    while task.wait(1) do
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then continue end

        if autoAtmEnabled and not isFarmingAtm then
            isFarmingAtm = true
            task.spawn(function()
                if #discoveredAtms == 0 then scanForNewAtms() end
                if #discoveredAtms > 0 then
                    local target = discoveredAtms[currentAtmIndex]
                    if target and target.part and target.part.Parent then
                        if moveTo(target.part.Position) then target.prompt:InputHoldBegin(); task.wait(target.prompt.HoldDuration + 0.2); target.prompt:InputHoldEnd(); task.wait(2) end
                    end
                    currentAtmIndex = currentAtmIndex + 1
                    if currentAtmIndex > #discoveredAtms then currentAtmIndex = 1; moveTo(Vector3.new(math.random(-1000, 1000), 250, math.random(-1000, 1000))); scanForNewAtms() end
                end
                isFarmingAtm = false
            end)
        end

        if autoGasEnabled and not isFarmingBox then
            isFarmingBox = true
            task.spawn(function()
                local targetPos = boxLocations[boxIndex]
                if moveTo(targetPos) then local prompt = findPromptNearPos(targetPos, 12); if prompt then prompt:InputHoldBegin(); task.wait(prompt.HoldDuration + 0.2); prompt:InputHoldEnd(); task.wait(2) end end
                boxIndex = boxIndex + 1; if boxIndex > #boxLocations then boxIndex = 1 end; isFarmingBox = false
            end)
        end

        if autoChefEnabled and not isCooking then
            isCooking = true
            task.spawn(function()
                if moveTo(chefLocation) then local prompt = findPromptNearPos(chefLocation, 15); if prompt then prompt:InputHoldBegin(); task.wait(prompt.HoldDuration + 0.2); prompt:InputHoldEnd(); task.wait(3) end end
                isCooking = false
            end)
        end

        if autoJanitorEnabled and not isCleaning then
            local puddles = {}
            local params = OverlapParams.new(); params.FilterDescendantsInstances = {char}; params.FilterType = Enum.RaycastFilterType.Exclude
            for _, part in pairs(Workspace:GetPartBoundsInRadius(char.HumanoidRootPart.Position, 100, params)) do if part:IsA("BasePart") and (part.Name:lower():find("puddle") or part.Name:lower():find("spill") or part.Name:lower():find("water")) then table.insert(puddles, part) end end
            if #puddles > 0 then isCleaning = true; task.spawn(function() if moveTo(puddles[1].Position) then task.wait(3) end; isCleaning = false end)
            else
                local params2 = OverlapParams.new(); params2.FilterDescendantsInstances = {char}; params2.FilterType = Enum.RaycastFilterType.Exclude
                for _, part in pairs(Workspace:GetPartBoundsInRadius(char.HumanoidRootPart.Position, 50, params2)) do
                    local prompt = part:FindFirstChildOfClass("ProximityPrompt")
                    if prompt and (prompt.ActionText:lower():find("apply") or part.Name:lower():find("apply")) then
                        isCleaning = true; task.spawn(function() if moveTo(part.Position) then prompt:InputHoldBegin(); task.wait(prompt.HoldDuration); prompt:InputHoldEnd() end; isCleaning = false end); break
                    end
                end
            end
        end
    end
end)

-- تحريك الأيقونة
local dragging, dragStart, startPos
FloatingIcon.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = FloatingIcon.Position end end)
UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; FloatingIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
local function toggleMenu() MainFrame.Visible = not MainFrame.Visible end
FloatingIcon.Activated:Connect(toggleMenu)
CloseXBtn.Activated:Connect(toggleMenu)

print("BlockSpin Pro Hub V12 - FULL Edition Loaded Successfully!")
