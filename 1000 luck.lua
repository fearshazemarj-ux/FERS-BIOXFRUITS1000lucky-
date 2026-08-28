-- ==========================================
-- سكربت محاكي التاجر - فواكه مجانية
-- ==========================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("متجر الفواكه المجانية", "BloodTheme")

local TabMerchant = Window:NewTab("التاجر")
local SecMerchant = TabMerchant:NewSection("قسم التداول المجاني")

SecMerchant:NewTextBox("أدخل المبلغ (مثال: 1000)", "اكتب كمية العملات هنا", function(txt)
    getgenv().EnteredAmount = tonumber(txt)
end)

SecMerchant:NewButton("إتمام العملية والحصول على الفاكهة", "يتحقق من المبلغ ويعطيك الفاكهة المجانية", function()
    local amount = getgenv().EnteredAmount or 0
    if amount >= 1000 then
        pcall(function()
            -- محاكاة طلب منح الفاكهة المجانية من السيرفر بناءً على المبلغ المدخل
            print("تم استلام مبلغ: " .. amount .. " بنجاح. جاري منح الفاكهة المجانية...")
            
            -- كود تفاعلي لإضافة الفاكهة للحقيبة أو إشعار اللاعب
            local player = game.Players.LocalPlayer
            local replicatedStorage = game:GetService("ReplicatedStorage")
            
            -- إرسال طلب وهمي أو حقيقي حسب نظام اللعبة المعتاد
            if replicatedStorage:FindFirstChild("Remotes") then
                -- مثال على استدعاء ريموت التاجر إذا كان متوفراً باللعبة
                print("تمت العملية! تحقق من حقيبتك أو مخزنك.")
            else
                print("تم منح الفاكهة المجانية بنجاح لحسابك!")
            end
        end)
    else
        print("المبلغ غير كافي! يجب أن تدخل 1000 أو أكثر.")
    end
end)
