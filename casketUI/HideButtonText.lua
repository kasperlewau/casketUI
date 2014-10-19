for i=1, 12 do
        _G["ActionButton"..i.."Name"]:SetAlpha(0) -- main bar
        _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- bottom right bar
        _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- bottom left bar
        _G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- right bar
        _G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- left bar
end


for i=1, 12 do
        _G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- main bar
        _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- bottom right bar
        _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- bottom left bar
        _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- right bar
        _G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- left bar
end