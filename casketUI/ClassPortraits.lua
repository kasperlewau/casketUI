UFP = "UnitFramePortrait_Update"
UICC = "Interface\\TargetingFrame\\UI-Classes-Circles"
CIT = CLASS_ICON_TCOORDS
hooksecurefunc(UFP,function(self) if self.portrait then local t = CIT[select(2,UnitClass(self.unit))] if t then self.portrait:SetTexture(UICC) self.portrait:SetTexCoord(unpack(t)) end end end)