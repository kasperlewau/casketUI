
  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local cfg = ns.cfg

  -----------------------------
  -- CHARSPECIFIC REWRITES
  -----------------------------

  local playername, _ = UnitName("player")
  local _, playerclass = UnitClass("player")

  if playername == "Solvexo" or playername == "Solvexx" or playername == "Wolowizard" or playername == "Loral" then
    cfg.hotkeys.show = false
    cfg.macroname.show = false
  end