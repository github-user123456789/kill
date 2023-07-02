--=| ISA BOOTLEG BOX
--=| @darkceius
-- this code stinky messy
-- i might rewrite this
-- free rar


--!nocheck
--!nolint DeprecatedApi
local owner: Player = owner

local tweenService = game:GetService("TweenService")
local connections = {}

local propertiesPlus = loadstring(game:GetService("HttpService"):GetAsync("https://dark.scriptlang.com/storage/scripts/propertyplus.lua"))()
local function randomizer(typ: any)
	local t = typeof(typ)
	if t == "number" then
		return math.random(-100, 100)
	end
	if t == "EnumItem" then
		local all = typ.EnumType
		local items = all:GetEnumItems()
		return items[math.random(1, #items)]
	end
	if t == "boolean" then
		return math.random(1,2) == 1
	end
	if t == "string" then
		return tostring(math.random())
	end
	if t == "Vector3" then
		return Vector3.new(randomizer(1),randomizer(1),randomizer(1))
	end
	if t == "CFrame" then
		return CFrame.new(randomizer(1),randomizer(1),randomizer(1))
	end
	if t == "Color3" then
		return Color3.fromRGB(math.random(0, 255),math.random(0, 255),math.random(0, 255))
	end
	if t == "BrickColor" then
		return BrickColor.random()
	end
end

local function jumble(part: BasePart)
	local allProperties = propertiesPlus.GetProperties(part.ClassName)
	for i,v in pairs(allProperties) do
		local real = part[v]
		if real ~= nil then
			local random = randomizer(real)
			if random then
				part[v] = random
			end
		end
	end
end

local function forceJumble(part: BasePart)
	local allProperties = propertiesPlus.GetProperties(part.ClassName)
	for i,v in pairs(allProperties) do
		local real = part[v]
		if real ~= nil then
			local random = randomizer(real)
			if random then
				part[v] = random
				table.insert(connections, part:GetPropertyChangedSignal(v):Connect(function()
					if part[v] ~= random then
						part[v] = random
					end
				end))
			end
		end
	end
end

local fakemesh = Instance.new("MeshPart")
local sto = game:GetService("TestService")
local infCF = CFrame.new(Vector3.new(1,1,1)*100000)
local modes = {
	[1] = {
		{"Joint Removal",
			function(part: BasePart)
				task.defer(pcall, part.BreakJoints, part)
			end
		},

		{"Joint Manipulation",
			function(part: BasePart)
				for i,v in pairs(part:GetDescendants()) do
					if v:IsA("Motor6D") or v:IsA("Weld") then
						v.C0 = infCF
					end
				end
			end
		},

		{"Joint Weaken",
			function(part: BasePart)
				for i,v in pairs(part:GetDescendants()) do
					if v:IsA("Motor6D") or v:IsA("Weld") then
						v.Enabled = false
					end
				end
			end
		},

		{"Texture Disarm",
			function(part: BasePart)
				for i,v in pairs(part:GetDescendants()) do
					if v:IsA("Texture") or v:IsA("Decal") then
						v.Texture = ""
					end
				end
			end
		},

		{"Name Manipulation",
			function(part: BasePart)
				part.Name = ""
			end
		},

		{"Forced Name Manipulation", function(v: BasePart)
			v.Name = ""
			table.insert(connections, v.Changed:Connect(function()
				if v.Name ~= "" then
					v.Name = ""
				end
			end))
		end, true},

		{"Full Name Manipulation",
			function(part: BasePart)
				part.Name = ""
				for i,v in pairs(part:GetDescendants()) do
					v.Name = ""
				end
			end
		},

		{"Forced Full Name Manipulation", function(v: BasePart)
			v.Name = ""
			table.insert(connections, v.Changed:Connect(function()
				if v.Name ~= "" then
					v.Name = ""
				end
			end))
			for i,v in pairs(v:GetDescendants()) do
				v.Name = ""
				table.insert(connections, v.Changed:Connect(function()
					if v.Name ~= "" then
						v.Name = ""
					end
				end))
			end
		end, true},

		{"Beheading",
			function(part: BasePart)
				if part.Name:find("Head") then
					pcall(game.Destroy, part)
				end
			end
		},
		
		{"Derender", function(v: BasePart)
			v.Parent = sto
		end, true},
		
		--{"Forced Derender", function(v: BasePart)
		--	v.Parent = sto
		--	table.insert(connections, v.Changed:Connect(function()
		--		if v.Parent ~= sto then
		--			v.Parent = sto
		--		end
		--	end))
		--end, true},
		
		{"Direct Elimination",
			function(part: BasePart)
				task.defer(pcall, game.Destroy, part)
			end
		},

		{"Inside Elimination",
			function(part: BasePart)
				task.defer(pcall, game.ClearAllChildren, part)
			end
		},

		{"Full Elimination",
			function(part: BasePart)
				task.defer(pcall, game.ClearAllChildren, part)
				task.defer(pcall, game.Destroy, part)
			end
		},

		{"Void Throw",
			function(part: BasePart)
				part.CFrame = infCF
			end,
		},

		{"Forced Void Throw", function(v: BasePart)
			v.CFrame = infCF
			table.insert(connections, v.Changed:Connect(function()
				if v.CFrame ~= infCF then
					v.CFrame = infCF
				end
			end))
		end, true},

		{"Improved Void Throw",
			function(part: BasePart)
				tweenService:Create(part, TweenInfo.new(0), {CFrame = infCF}):Play()
			end
		},
	},

	[2] = "1", -- amplified v1
	[3] = {
		{"Fake Degradation",
			function(part: BasePart)
				local v = Instance.new("ViewportFrame",workspace)
				part.Parent = v
				part.Parent = workspace
				v:Destroy()
			end
		},
		
		{"Forced Alternate Unreal Fake Degradation",
			function(part: BasePart)
				local viewport = workspace:FindFirstChildOfClass("ViewportFrame") or (function()
					local b = Instance.new("ViewportFrame")
					b.Parent = workspace
					return b
				end)()

				part.Parent = viewport
				table.insert(connections, part:GetPropertyChangedSignal("Parent"):Connect(function()
					if not part:IsDescendantOf(game) then
						return
					end
					
					if part.Parent ~= viewport then
						part.Parent = viewport
					end
				end))
			end,
		true
		},
		
		{"Mesh Degradation",
			function(part: BasePart)
				local mesh = Instance.new("SpecialMesh", part)
				mesh.Offset = Vector3.new(1,1,1)*math.huge

				for i,v: BasePart in pairs(part:GetDescendants()) do
					if v:IsA("BasePart") then
						local mesh = Instance.new("SpecialMesh", v)
						mesh.Offset = Vector3.new(1,1,1)*math.huge
					end
				end
			end
		},

		{"Mesh Degradation: Secondary",
			function(part: BasePart)
				local mesh = Instance.new("SpecialMesh")
				mesh.Offset = Vector3.new(1,1,1)*math.huge
				mesh.Parent = part

				for i,v: BasePart in pairs(part:GetDescendants()) do
					if v:IsA("BasePart") then
						local mesh = Instance.new("SpecialMesh")
						mesh.Offset = Vector3.new(1,1,1)*math.huge
						mesh.Parent = v
					end
				end
			end
		},

		{"Mesh Fake Degradation", function(v: BasePart)
			local function k(v: BasePart)
				local mesh = Instance.new("SpecialMesh")
				mesh.Offset = Vector3.new(1,1,1)*math.huge
				mesh.Parent = v
				table.insert(connections, mesh.Destroying:Once(function()
					k(v)
				end))
			end

			k(v)
			for i,v: BasePart in pairs(v:GetDescendants()) do
				if v:IsA("BasePart") then
					k(v)
				end
			end
		end, true},
		
		{"Mesh Tamper Degradation",
			function(part: BasePart)
				for i,v: SpecialMesh in pairs(part:GetDescendants()) do
					if v:IsA("SpecialMesh") then
						v.Offset = Vector3.new(1,1,1)*math.huge
					elseif v:IsA("MeshPart") then
						v.TextureID = ""
					end
				end
			end
		},

		{"Property Mesh ID Remover",
			function(part: BasePart)
				for i,v: SpecialMesh in pairs(part:GetDescendants()) do
					if v:IsA("SpecialMesh") then
						v.MeshId = ""
						
					end
				end
			end
		},
		
		-- oyu have to find a broken mesh
		{"Mesh ID Tamper Degradation",
			function(part: BasePart)
				if part:IsA("MeshPart") then
					part:ApplyMesh(fakemesh)
				end
				for i,v: MeshPart in pairs(part:GetDescendants()) do
					if v:IsA("MeshPart") then
						v:ApplyMesh(fakemesh)
					end
				end
			end
		},
	},
	
	[4] = "3",
	[5] = {
		{"Property Jumbler",
			function(part: BasePart)
				jumble(part)
				for i,v in pairs(part:GetDescendants()) do
					if v:IsA("BasePart") then
						jumble(v)
					end
				end
			end
		},
		
		-- this wil kil server
		--{"Forced Property Jumbler",
		--	function(part: BasePart)
		--		forceJumble(part)
		--		for i,v in pairs(part:GetDescendants()) do
		--			if v:IsA("BasePart") then
		--				forceJumble(v)
		--			end
		--		end
		--	end,
		--	true
		--},

		{"Esoteric Elimination",
			function(part: BasePart)
				part.Parent = nil
				for i,v in pairs(part:GetDescendants()) do
					v.Parent = nil
				end
				task.defer(pcall, game.ClearAllChildren, part)
				task.defer(pcall, game.Destroy, part)
			end
		},
	},
	[6] = "",
	[7] = "",
	[8] = {
		{"Death",
			function(part: BasePart)
				local mesh = Instance.new("SpecialMesh", part)
				mesh.Offset = Vector3.new(1,1,1)*math.huge

				for i,v in pairs(part:GetDescendants()) do
					if v:IsA("BasePart") then
						local mesh = Instance.new("SpecialMesh", v)
						mesh.Offset = Vector3.new(1,1,1)*math.huge
					end
					if v:IsA("SpecialMesh") then
						v.Offset = Vector3.new(1,1,1)*math.huge
					elseif v:IsA("MeshPart") then
						v.TextureID = ""
					end
				end

				task.defer(pcall, game.ClearAllChildren, part)
				task.defer(pcall, game.Destroy, part)
			end,
		},
	},

	[9] = {
		{"Infinite SoulAbyss Box", function(v: BasePart)
			table.insert(connections, v.Changed:Connect(function()
				if v.CFrame ~= infCF then
					v.CFrame = infCF
				end
			end))
			v.CFrame = infCF
			for i = 1, 5 do
				v.CFrame = infCF
			end
			if v:IsA("MeshPart") then
				v:ApplyMesh(fakemesh)
			end
			task.delay(0.05, pcall, game.Destroy, v)
		end, true},
	}
}

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {workspace:FindFirstChild("Base")}
local raycast = workspace:Raycast(Vector3.new(0, 90, 34), Vector3.new(0, -100, 0), params)

local isaPart=Instance.new("Part")
isaPart.BrickColor=BrickColor.new("Institutional white")
isaPart.CanCollide=false
isaPart.Material=Enum.Material.Neon
isaPart.Size=Vector3.new(1,1,1)*30
isaPart.Anchored = true
isaPart.Transparency=1
isaPart.CastShadow = false

local box = Instance.new("SelectionBox")
box.Adornee = isaPart
box.SurfaceTransparency = 1
box.Transparency = 0.5
box.LineThickness = 0.05
box.Transparency = 0
box.Color3 = Color3.new(0.262745, 0.262745, 0.262745)
box.Parent = isaPart

local status = Instance.new("BillboardGui")
status.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
status.Active = true
status.AlwaysOnTop = true
status.Size = UDim2.new(35, 0, 3, 0)
status.ClipsDescendants = true
status.StudsOffset = Vector3.new(0, 5, 0)

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Size = UDim2.new(1, 0, 0.3, 0)
frame.BackgroundTransparency = 0.5
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = status
frame.Visible = false

local subLabel = Instance.new("TextBox")
subLabel.ClearTextOnFocus = false
subLabel.TextEditable = false
subLabel.AnchorPoint = Vector2.new(0.5, 0.5)
subLabel.Size = UDim2.new(1, 0, 3, 0)
subLabel.BackgroundTransparency = 1
subLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
subLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
subLabel.FontSize = Enum.FontSize.Size14
subLabel.TextSize = 14
subLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
subLabel.TextWrapped = true
subLabel.Font = Enum.Font.Merriweather
subLabel.TextWrap = true
subLabel.TextScaled = true
subLabel.Parent = frame

local UIGradient = Instance.new("UIGradient")
UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.0125), NumberSequenceKeypoint.new(1, 1)})
UIGradient.Parent = frame

status.Adornee = isaPart
status.Parent = isaPart

if raycast then
	isaPart.Position=raycast.Position + Vector3.new(0, isaPart.Size.Y/2, 0)
else
	isaPart.Position=Vector3.new(0, 10, 30)
end
isaPart.Position += Vector3.new(0, 0.1, 0)
isaPart.Parent = script

local currentMode = 0
local currentSub = 0

local currentSubTable = nil

local amplified = false
local awakened = false
local running = false

local functions = {}

local runService = game:GetService("RunService")

local function clearConnections()
	for i,v in pairs(connections) do
		v:Disconnect()
	end
	connections = {}
end

local voiceSFX = Instance.new("Sound")
voiceSFX.Parent = isaPart
voiceSFX.Volume = 9

local modeVoices = {
	[1] = "rbxassetid://8765309012", -- genesis
	[2] = "rbxassetid://8765310014", -- 1
	[3] = "rbxassetid://8765310560", -- 2
	[4] = "rbxassetid://8765311234",  -- 3
	[5] = "rbxassetid://8765312042", -- 4
	[6] = "rbxassetid://8765312392", -- 5
	[7] = "rbxassetid://8765313042", -- 6
	[8] = "rbxassetid://8765313651", -- 7
	[9] = "rbxassetid://8765314189", -- 8
}

local modeBG = {
	[1] = "rbxassetid://13608974888",
	[3] = "rbxassetid://13609022752",
	[6] = "rbxassetid://13609042238",
	[9] = "rbxassetid://13609152933",
}

local function getNearestIndex(id)
	local nearestIndex = nil

	for index, _ in pairs(modeBG) do
		if index <= id and (nearestIndex == nil or index > nearestIndex) then
			nearestIndex = index
		end
	end

	return modeBG[nearestIndex]
end

local bg = voiceSFX:Clone()
bg.Volume = 4
bg.Parent = isaPart
bg.Looped = true
bg.SoundId = ""
bg:Play()

local attack = voiceSFX:Clone()
attack.Parent = isaPart
attack.SoundId = "rbxassetid://9060378036"

local function loadMode(id)
	currentMode = id
	frame.Visible = false
	local mode = modes[id]
	if typeof(mode) == "nil" then id = 1 mode = modes[id] end

	if typeof(mode) == "string" then
		local number = tonumber(mode)
		mode = modes[number]
		amplified = true
	else
		amplified = false
	end
	if id == 7 then
		awakened = true
		amplified = false
		mode = {table.unpack(modes[8]), table.unpack(modes[3])}
	elseif id == 8 then
		awakened = true
		amplified = true
		mode = {table.unpack(modes[1]), table.unpack(modes[3])}
	elseif id == 6 then
		awakened = true
		amplified = false
		mode = modes[1]
	elseif id == 9 then
		awakened = true
		amplified = true
	end
	functions = mode
	local mId = getNearestIndex(id)
	if mId ~= nil then
		if bg.SoundId ~= mId then
			bg.SoundId = mId
			if bg.SoundId == "rbxassetid://13609152933" then
				bg.PlaybackSpeed = 0.5
			else
				bg.PlaybackSpeed = 1
			end
			bg:Play()
		end
	end

	if modeVoices[id] then
		voiceSFX.SoundId = modeVoices[id]
		voiceSFX.TimePosition = 0.1
		voiceSFX:Play()
		repeat task.wait() until voiceSFX.TimeLength > 0
		task.wait(voiceSFX.TimeLength - 0.2)
	else
		voiceSFX:Stop()
	end
end

local function render()
	local txt = `{currentSubTable[1]}`
	if currentSubTable[1] ~= "Infinite SoulAbyss Box" then
		txt = `{awakened and "Awakened " or ""}{amplified and "Amplified " or ""}` .. txt
	end
	
	frame.Visible = true
	subLabel.Text = txt
	attack:Play()
	return txt
end

local function loadSub(count)
	local sub = functions[count]

	if count == 0 then
		loadMode(currentMode-1)
		loadSub(#functions)
		return
	end
	if sub == nil then
		loadMode(currentMode+1)
		loadSub(1)
		return
	end

	currentSub = count
	currentSubTable = sub

	clearConnections()

	if currentSubTable[1] == "End" then
		frame.Visible = false
	else
		isaPart.Transparency = 0
		tweenService:Create(isaPart, TweenInfo.new(.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Transparency = 1}):Play()
		task.wait(0.08)
		render()
		task.wait(0.2)
	end
end

local did = {}

local function handleSub(v)

	if currentSubTable then
		if v:IsDescendantOf(isaPart) or v == isaPart then
			return
		end
		if not currentSubTable[3] then
			pcall(currentSubTable[2], v)
		else
			if did[v] == nil then
				did[v] = true
				pcall(currentSubTable[2], v)
			end
		end
	end
end

local function handleSubs(children)
	if currentSubTable then
		for i,v in pairs(children) do
			if v:IsA("BasePart") then
				handleSub(v)
			end
		end
	end
end

local function kill()
	if not running then return end
	handleSubs(workspace:GetPartsInPart(isaPart))
end

isaPart.DescendantAdded:Connect(function(v)
	if v:IsA("BasePart") then
		task.defer(pcall, game.Destroy, v)
	end
end)

local before = voiceSFX:Clone()
before.Parent = isaPart
before.SoundId = "rbxassetid://9060399229"

local function startup()
	loadMode(1)
	running = true
	loadSub(1)

	task.spawn(function()
		while task.wait(2) do
			if currentSubTable[1] == "Infinite SoulAbyss Box" then
				continue
			end
			did = {}
			running = false

			do
				local n = functions[currentSub+1]
				if (n ~= nil)  and (n[1] ~= "End") then
					before:Play()
					task.wait(.25)--task.wait(1)
				end
			end

			loadSub(currentSub+1)
			running = true

			if currentSubTable[1] == "End" then
				running = false
				bg:Stop()
				voiceSFX:Stop()
				running = false
				break
			end
		end
	end)
end

task.spawn(function()
	while true do
		kill()
		task.wait()
	end
end)

runService.Heartbeat:Connect(function()
	kill()
end)

local task_defer = task.defer

-- this is shn but optimized
local function amplify(f, ...)
	task_defer(
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer, task_defer,
		f, ...
	)
end

local postSimulation = Instance.new("BindableEvent")
local superLoop = Instance.new("BindableEvent")
runService.PostSimulation:Connect(function()
	postSimulation:Fire()
	
end)

postSimulation.Event:Connect(function()
	if amplified then
		amplify(kill)
	end
end)

for i,v in ipairs({runService.Heartbeat, runService.Stepped, runService.PreRender, postSimulation.Event, runService.PreSimulation}) do
	v:Connect(function()
		superLoop:Fire()
	end)
end

superLoop.Event:Connect(function()
	if awakened then
		--amplify(kill)
		kill()
	end
end)

if owner then
	owner.Chatted:Connect(function(msg)
		if string.sub(msg, 1, 3) == "/e " then
			msg = string.sub(msg, 4)
		end
		if string.sub(msg, 1, 3) == "!m " then
			local i = tonumber(string.sub(msg, 4))
			if i then
				running = false
				amplified = false
				awakened = false
				loadMode(i)
				loadSub(1)
				running = true
			end
		end
	end)
end

print("@darkceius ISA BOOTLEG BOX")
print("!m <number> (to change modes)")
startup()
