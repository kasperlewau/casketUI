local fontName = "FONTS\\MORPHEUS.ttf"
local fontHeight = 22
local fFlags = ""

local function FS_SetFont()
        DAMAGE_TEXT_FONT = fontName
        NUM_COMBAT_TEXT_LINES = 20;
        COMBAT_TEXT_SCROLLSPEED = 1.0;
        COMBAT_TEXT_FADEOUT_TIME = 1.0;
        COMBAT_TEXT_HEIGHT = 18;
        COMBAT_TEXT_CRIT_MAXHEIGHT = 2.0;
        COMBAT_TEXT_CRIT_MINHEIGHT = 1.2;
        COMBAT_TEXT_CRIT_SCALE_TIME = 0.7;
        COMBAT_TEXT_CRIT_SHRINKTIME = 0.2;
        COMBAT_TEXT_TO_ANIMATE = {};
        COMBAT_TEXT_STAGGER_RANGE = 20;
        COMBAT_TEXT_SPACING = 7;
        COMBAT_TEXT_MAX_OFFSET = 130;
        COMBAT_TEXT_LOW_HEALTH_THRESHOLD = 0.2;
        COMBAT_TEXT_LOW_MANA_THRESHOLD = 0.2;
        COMBAT_TEXT_LOCATIONS = {};
    local fName, fHeight, fFlags = CombatTextFont:GetFont()
    CombatTextFont:SetFont(fontName, fontHeight, fFlags)
end
FS_SetFont()