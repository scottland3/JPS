function hunter_mm(self)
   -- Marksmanship Hunter by Chiffon with additions by Scribe
   -- Change this to your Aimed Shot binding --
   local clickMF = "/click ActionButton3"
   ------------------------------------------
   local up = UnitPower
   local r = RunMacroText;
   local spell = nil
   local raf_ready,raf_timeleft,_ = GetSpellCooldown("Rapid Fire");
   local chim_ready,chim_timeleft,_ = GetSpellCooldown("Chimera Shot");

	-- Interupting, Borrowed directly from feral cat
	if jps.Interrupts and jps.should_kick("target") and cd("Silencing Shot") == 0 then
		print("Silencing Target")
		return "Silencing Shot"
	end

   if jps.PetHeal and not ub("pet","Mend Pet") and UnitHealth("pet")/UnitHealthMax("pet") <= 0.9 then
      spell = "Mend Pet"
   elseif GetUnitSpeed("player") == 0 and not ub("player", "Aspect of the Hawk") then
      spell = "Aspect of the Hawk"
   elseif jps.MultiTarget and up("player") > 40 then
      spell = "Multi-Shot"
   elseif UnitHealth("target")/UnitHealthMax("target") <= 0.2 and cd("Kill Shot") == 0 then
      spell = "Kill Shot"
   elseif not jps.MultiTarget and not UnitDebuff("target", "Serpent Sting",nil,"PLAYER") and up("player") > 25 and UnitHealth("target") > 50000 then 
      spell = "Serpent Sting"
   elseif cd("Chimera Shot") <= 0.4 and up("player") >= 44 then
      spell = "Chimera Shot"
   elseif jps.UseCDs and cd("Rapid Fire") == 0 and not ub("player","rapid fire") then
      spell = "Rapid Fire"
   elseif jps.UseCDs and jps.Lifeblood and cd("Lifeblood") == 0 and not ub("player","Lifeblood") then
	  spell = "Lifeblood"
   elseif jps.UseCDs and cd("Rapid Fire") > 0 and (raf_timeleft-(GetTime()-raf_ready)>=120) and not ub("player","rapid fire") and cd("readiness") == 0 then
      spell = "Readiness"
   elseif GetUnitSpeed("player") == 0 and UnitHealth("target")/UnitHealthMax("target") > 0.8 and up("player") > 50 and (chim_timeleft-(GetTime()-chim_ready)>=3)then
	  -- Aimed Shot
      r(clickMF)
   elseif up("player") > 64 then
      spell = "Arcane Shot"
   elseif ub("player", "Fire!") then 
	  -- Instant Aimed Shot
      r(clickMF)
   elseif GetUnitSpeed("player") > 0 and not ub("player", "Aspect of the Fox") then
      spell = "Aspect of the Fox"
   else
      spell = "Steady Shot" 
   end


   return spell
end
