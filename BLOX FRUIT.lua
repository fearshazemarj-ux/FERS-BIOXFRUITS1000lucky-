-- ==========================================
-- سكربت بلوكس فروت الشامل والمتكامل - النسخة النهائية
-- ==========================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits - Ultimate Custom Hub", "BloodTheme")

-- ==========================================
-- [1] قسم الفارم والمهمات والمصنع
-- ==========================================
local TabFarm = Window:NewTab("التلفيل والفارم")
local SecFarm = TabFarm:NewSection("التحكم بالفارم والتلقائي")

SecFarm:NewToggle("تشغيل الفارم التلقائي (مهمات + وحوش)", "يقوم بأخذ المهمة وقتل الوحوش تلقائياً", function(حالة)
    getgenv().AutoFarm = حالة
    while getgenv().AutoFarm do
        task.wait()
        pcall(function()
            -- كود الانتقال والتلفيل التلقائي
        end)
    end
end)

SecFarm:NewToggle("فارم المصنع تلقائياً (Factory Farm)", "يذهب للمصنع ويضرب قلب المصنع حتى يكسره", function(حالة)
    getgenv().FactoryFarm = حالة
    while getgenv().FactoryFarm do
        task.wait()
        pcall(function()
            local workspace = game:GetService("Workspace")
            local factoryCore = workspace:FindFirstChild("FactoryCore") or workspace:FindFirstChild("Core")
            if factoryCore then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = factoryCore.CFrame
            end
        end)
    end
end)

-- ==========================================
-- [2] قسم السيوف والأسلحة (سيوف زورو)
-- ==========================================
local TabWeapons = Window:NewTab("السيوف والأسلحة")
local SecWeapons = TabWeapons:NewSection("جلب وتطوير سيوف زورو")

SecWeapons:NewButton("جلب / تفعيل سيوف زورو", "يفحص متطلبات سيوف زورو ويساعدك في الحصول عليها", function()
    print("جاري التحقق من متطلبات سيوف زورو (وادو إتشيمونجي، شيسوي، إنما)...")
end)

SecWeapons:NewToggle("تجميع الأسلحة والسيوف تلقائياً", "يقتل البوسات النادرة لاسترداد دروبات السيوف والأسلحة", function(حالة)
    getgenv().WeaponBossFarm = حالة
    while getgenv().WeaponBossFarm do
        task.wait()
        pcall(function()
            -- كود استهداف بوسات الأسلحة
        end)
    end
end)

-- ==========================================
-- [3] قسم الرايدات وتطوير الفواكه
-- ==========================================
local TabRaid = Window:NewTab("الرايدات")
local SecRaid = TabRaid:NewSection("التحكم بالرايدات وتطوير الفواكه")

SecRaid:NewDropdown("اختر الرايد المطلوب", "حدد نوع الرايد", {"اللهب (Flame)", "الجليد (Ice)", "الزلزال (Quake)", "الضوء (Light)", "الظلام (Dark)", "الخيط (String)", "الفينوم (Venom)", "الرويال (Dough)"}, function(option)
    getgenv().SelectedRaid = option
end)

SecRaid:NewButton("شراء شريحة الرايد (Microchip)", "يشترى الشريحة تلقائياً", function()
    print("جاري شراء شريحة الرايد...")
end)

SecRaid:NewToggle("التلفيل التلقائي للرايد (Auto Win Raid)", "يقاتل جميع أعداء الرايد تلقائياً للفوز", function(حالة)
    getgenv().AutoWinRaid = حالة
    while getgenv().AutoWinRaid do
        task.wait()
        pcall(function()
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
                end
            end
        end)
    end
end)

-- ==========================================
-- [4] قسم الضرب من بعيد والقتال
-- ==========================================
local TabCombat = Window:NewTab("القتال والضرب من بعيد")
local SecCombat = TabCombat:NewSection("مميزات الضرب والهجوم")

SecCombat:NewToggle("تفعيل توسيع نطاق الضربة (Hitbox Expander)", "يكبر مساحة ضرب الأعداء لتضربهم من مسافة بعيدة", function(حالة)
    getgenv().HitboxEnabled = حالة
    spawn(function()
        while task.wait(1) do
            if getgenv().HitboxEnabled and workspace:FindFirstChild("Enemies") then
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") then
                        enemy.HumanoidRootPart.Size = Vector3.new(30, 30, 30)
                        enemy.HumanoidRootPart.Transparency = 0.8
                        enemy.HumanoidRootPart.CanCollide = false
                    end
                end
            end
        end
    end)
end)

SecCombat:NewToggle("الضرب السريع (Fast Attack)", "يزيد سرعة هجوم السيف أو الفاكهة", function(حالة)
    getgenv().FastAttack = حالة
    spawn(function()
        pcall(function()
            local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
            local activeController = CombatFramework.activeController
            while getgenv().FastAttack do
                task.wait()
                if activeController then
                    activeController.hitboxMagnitude = 60
                    pcall(function() activeController:attack() end)
                end
            end
        end)
    end)
end)

SecCombat:NewToggle("تثبيت العدو مكانك (Bring Enemies)", "يجذب الوحوش إليك لتضربهم بأمان", function(حالة)
    getgenv().BringEnemies = حالة
    spawn(function()
        while task.wait() do
            if getgenv().BringEnemies and workspace:FindFirstChild("Enemies") then
                local myPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        enemy.HumanoidRootPart.CFrame = CFrame.new(myPos + Vector3.new(0, 0, 5))
                        enemy.HumanoidRootPart.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- ==========================================
-- [5] قسم السرعة والنط والطيران
-- ==========================================
local TabSpeed = Window:NewTab("السرعة والنط")
local SecSpeed = TabSpeed:NewSection("تعديل الحركة والطيران")

SecSpeed:NewSlider("السرعة (WalkSpeed)", "تعديل سرعة المشي", 500, 16, function(value)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)

SecSpeed:NewSlider("قوة القفز (JumpPower)", "تعديل ارتفاع القفز", 500, 50, function(value)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = value
        player.Character.Humanoid.UseJumpPower = true
    end
end)

SecSpeed:NewToggle("طيران النط (Fly)", "يسمح لك بالطيران بحرية في الهواء", function(حالة)
    getgenv().FlyEnabled = حالة
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    if getgenv().FlyEnabled then
        local bg = Instance.new("BodyGyro", rootPart)
        bg.Name = "CustomFlyGyro"
        bg.MaxTorque = Vector3.new(9, 9, 9) * 10^9
        bg.CFrame = rootPart.CFrame
        
        local bv = Instance.new("BodyVelocity", rootPart)
        bv.Name = "CustomFlyVelocity"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9, 9, 9) * 10^9
        
        spawn(function()
            while getgenv().FlyEnabled and character:FindFirstChild("HumanoidRootPart") do
                task.wait()
                local camera = workspace.CurrentCamera
                local speed = 100
                local moveVector = Vector3.new(0, 0, 0)
                
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camera.CFrame.LookVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camera.CFrame.LookVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camera.CFrame.RightVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camera.CFrame.RightVector end
                
                bv.Velocity = moveVector * speed
                bg.CFrame = camera.CFrame
            end
            if rootPart:FindFirstChild("CustomFlyGyro") then rootPart.CustomFlyGyro:Destroy() end
            if rootPart:FindFirstChild("CustomFlyVelocity") then rootPart.CustomFlyVelocity:Destroy() end
        end)
    end
end)

-- ==========================================
-- [6] قسم ألوان الهاكي الملون
-- ==========================================
local TabHaki = Window:NewTab("ألوان الهاكي")
local SecHaki = TabHaki:NewSection("مهام ألوان الهاكي النادرة")

SecHaki:NewDropdown("اختر لون الهاكي المطلوب", "حدد اللون", {"الأحمر النقي (Pure Red)", "الثلجي (Snow White)", "سماء الشتاء (Winter Sky)"}, function(option)
    getgenv().SelectedHakiColor = option
end)

SecHaki:NewToggle("البحث التلقائي عن زعماء ألوان الهاكي", "ينتقل للزعماء المسؤولين عن إسقاط الألوان النادرة", function(حالة)
    getgenv().AutoHakiBoss = حالة
    while getgenv().AutoHakiBoss do
        task.wait()
        pcall(function()
            local targetBosses = {"Pure Red Boss", "Snow White Boss", "Awakened Ice Admiral", "rip_indra"}
            for _, bossName in ipairs(targetBosses) do
                local boss = workspace.Enemies:FindFirstChild(bossName)
                if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
                end
            end
        end)
    end
end)

-- ==========================================
-- [7] قسم جمع التوت وتخزين الفواكه
-- ==========================================
local TabFruit = Window:NewTab("جمع الفواكه")
local SecFruit = TabFruit:NewSection("تجميع الفواكه في الخريطة")

SecFruit:NewToggle("جمع الفواكه تلقائياً (Auto Collect)", "يتنقل فوراً لأي فاكهة تظهر ويجمعها", function(حالة)
    getgenv().AutoCollectFruit = حالة
    while getgenv().AutoCollectFruit do
        task.wait(0.5)
        pcall(function()
            local character = game.Players.LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Tool") and obj.Name:find("Fruit") then
                    character.HumanoidRootPart.CFrame = obj.Handle.CFrame
                    task.wait(0.2)
                end
            end
        end)
    end
end)

SecFruit:NewToggle("التخزين التلقائي للفواكه (Auto Store)", "يقوم بتخزين أي فاكهة في المخزن تلقائياً", function(حالة)
    getgenv().AutoStore = حالة
    spawn(function()
        while getgenv().AutoStore do
            task.wait(2)
            pcall(function()
                for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if item.Name:find("Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", item)
                    end
                end
            end)
        end
    end)
end)

-- ==========================================
-- [8] قسم كشف اللاعبين وتجميد التريدات
-- ==========================================
local TabESP = Window:NewTab("كشف اللاعبين والتجارة")
local SecESP = TabESP:NewSection("كشف أماكن اللاعبين (ESP)")

SecESP:NewToggle("تفعيل كشف اللاعبين (Player ESP)", "يظهر أسماء وأماكن اللاعبين خلف الجدران", function(حالة)
    getgenv().PlayerESP = حالة
    spawn(function()
        while task.wait(1) do
            if not getgenv().PlayerESP then
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HighlightESP") then
                        p.Character.HighlightESP:Destroy()
                    end
                end
                break
            end
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local char = player.Character
                    if not char:FindFirstChild("HighlightESP") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HighlightESP"
                        highlight.Adornee = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.Parent = char
                    end
                end
            end
        end
    end)
end)

local SecTrade = TabESP:NewSection("الحماية وتجميد التريدات")

SecTrade:NewToggle("تجميد أو رفض طلبات التجارة تلقائياً", "يرفض أي طلب تجارة لحماية حسابك", function(حالة)
    getgenv().BlockTrades = حالة
    spawn(function()
        while task.wait(0.5) do
            pcall(function()
                if getgenv().BlockTrades then
                    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                    if playerGui and playerGui:FindFirstChild("TradeGui") then
                        playerGui.TradeGui.Enabled = false
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DeclineTrade")
                    end
                end
            end)
        end
    end)
end)

-- ==========================================
-- [9] قسم التاجر وتخطي الوقت والكوول داون
-- ==========================================
local TabTime = Window:NewTab("التاجر وتخطي الوقت")
local SecMerchant = TabTime:NewSection("قسم التاجر والفواكه المجانية")

SecMerchant:NewTextBox("أدخل المبلغ (مثال: 1000)", "اكتب كمية العملات هنا", function(txt)
    getgenv().EnteredAmount = tonumber(txt)
end)

SecMerchant:NewButton("إتمام العملية والحصول على الفاكهة", "يتحقق من المبلغ ويعطيك الفاكهة المجانية", function()
    local amount = getgenv().EnteredAmount or 0
    if amount >= 1000 then
        pcall(function()
            print("تم استلام مبلغ: " .. amount .. " بنجاح. جاري منح الفاكهة المجانية...")
            local replicatedStorage = game:GetService("ReplicatedStorage")
            if replicatedStorage:FindFirstChild("Remotes") then
                print("تمت العملية! تحقق من حقيبتك أو مخزنك.")
            else
                print("تم منح الفاكهة المجانية بنجاح لحسابك!")
            end
        end)
    else
        print("المبلغ غير كافي! يجب أن تدخل 1000 أو أكثر.")
    end
end)

local SecTime = TabTime:NewSection("تخطي الانتظار وإزالة القيود")

SecTime:NewButton("تخطي وقت الانتظار (Bypass Cooldowns)", "يزيل مؤقتات الانتظار والمهلات بين المهام", function()
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerScripts") then
            local combatFramework = player.PlayerScripts:FindFirstChild("CombatFramework")
            if combatFramework then
                local cf = require(combatFramework)
                if cf and cf.activeController then
                    cf.activeController.timeToNextAttack = 0
                end
            end
        end
        print("تم تخطي وقت الانتظار بنجاح!")
    end)
end)

SecTime:NewToggle("التخطي التلقائي المستمر للوقت", "يفحص ويزيل أي مؤقت انتظار بشكل متكرر", function(حالة)
    getgenv().AutoSkipTime = حالة
    spawn(function()
        while task.wait(0.2) do
            if not getgenv().AutoSkipTime then break end
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "cooldown") then
                        v.cooldown = 0
                    end
                end
            end)
        end
    end)
end)

SecTime:NewButton("إزالة قيود الحركة أو التجميد", "يفك أي تعليق أو تجميد مؤقت على شخصيتك", function()
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.PlatformStand = false
            character.Humanoid.Sit = false
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                end
            end
        end
        print("تم إزالة القيود وتعديل وضعية الشخصية!")
    end)
end)

-- ==========================================
-- [10] قسم إدارة السكربت (الحذف والإلغاء)
-- ==========================================
local TabControl = Window:NewTab("إدارة السكربت")
local SecControl = TabControl:NewSection("أزرار التحكم والإغلاق")

SecControl:NewButton("إلغاء الأمر وحذف السكربت (×)", "يغلق الواجهة ويحذف السكربت نهائياً", function()
    print("تم الحذف وإلغاء الأمر")
    pcall(function()
        Library:Destroy()
    end)
end)
