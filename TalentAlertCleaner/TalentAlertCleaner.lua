local CLEAN = {
  PlayerSpellsMicroButton = true,
}

local function IsCleanTarget(btn)
  if not btn or not btn.GetName then return false end
  local name = btn:GetName()
  return name and CLEAN[name] or false
end

local stopped = setmetatable({}, { __mode = "k" })

local function CleanAlert(btn)
  if not IsCleanTarget(btn) then return end

  if type(MainMenuMicroButton_HideAlert) == "function" then
    MainMenuMicroButton_HideAlert(btn)
  end

  if not stopped[btn] and type(MicroButtonPulseStop) == "function" then
    MicroButtonPulseStop(btn)
    stopped[btn] = true
  end
end

if type(hooksecurefunc) == "function" then
  if type(MainMenuMicroButton_ShowAlert) == "function" then
    hooksecurefunc("MainMenuMicroButton_ShowAlert", CleanAlert)
  end

  if type(MicroButtonPulse) == "function" then
    hooksecurefunc("MicroButtonPulse", function(btn)
      if IsCleanTarget(btn) then
        if type(MicroButtonPulseStop) == "function" then
          MicroButtonPulseStop(btn)
        end
        stopped[btn] = true
      end
    end)
  end
end