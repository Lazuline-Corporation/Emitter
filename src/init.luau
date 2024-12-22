--[=[
    @name Emitter
]=]
local Emitter = {}

-- Functions
function Emitter:Emit(instance: Instance)
	for _, descendant in instance:GetDescendants() do
		if not descendant:HasTag("NoEmit") then
			if descendant:IsA("ParticleEmitter") then
				task.spawn(function()
					local emitCount = descendant:GetAttribute("EmitCount")
					local emitDelay = descendant:GetAttribute("EmitDelay")
					local emitDuration = descendant:GetAttribute("EmitDuration")

					if type(emitDelay) == "number" then
						task.wait(emitDelay)
					end

					if type(emitCount) == "number" then
						descendant:Emit(emitCount)
					end

					if type(emitDuration) == "number" then
						descendant.Enabled = true

						task.delay(emitDuration, function()
							descendant.Enabled = false
						end)
					end
				end)
			elseif descendant:IsA("Sound") then
				task.spawn(function()
					local emitDelay = descendant:GetAttribute("Delay")

					if type(emitDelay) == "number" then
						task.wait(emitDelay)
					end

					descendant:Play()
				end)
			end
		end
	end
end

return Emitter
