
-- [[ Services ]] --
local PathfindingService = game:GetService("PathfindingService");
local TweenService = game:GetService("TweenService")
local ServerStorage = game:GetService("ServerStorage")

-- [[ Variables ]] --

local Robot1 = script.Parent;
local Robot1Folder = workspace.R1Folder;
local path = PathfindingService:CreatePath();

-- [[ Functions ]] --
local function pathFollow(destination)
	local success, errorMessage = pcall(function()
        path:ComputeAsync(Robot1.Position, destination);
    end);
	if success and path.Status == Enum.PathStatus.Success then
		local Nodes = path:GetWaypoints();
		for i, v in pairs(Nodes) do
			local node = Instance.new("Part");
			node.Parent = workspace;
			--for faster computing, it is better to separate instance.new and properties
			node.Size = Vector3.new(.5,.5,.5);
			node.Position = v.Position;
			node.Anchored = true;
			node.CanCollide = false;
			node.Transparency = .2;
			node.BrickColor = BrickColor.new("Really red");
		end;
	end
end;




-- [[ Detection ]] --
for _, p in pairs(Robot1Folder:GetChildren()) do
	pathFollow(p.Position);
	local destination = p;
	local Info = TweenInfo.new(2, Enum.EasingStyle.Sine);
	local PropertyDictionary = {
		["Position"] = destination.Position;
	};
	local Tween = TweenService:Create(Robot1, Info, PropertyDictionary);
	Tween:Play();
	wait(3);
	destination:Destroy();
	Robot1.ConesStored.Value += 1;
end;

wait();

if not workspace.R1Folder:FindFirstChild("R1Part5") then
	local destination = workspace.Bases:FindFirstChild("R1Part")
	local Info = TweenInfo.new(2, Enum.EasingStyle.Sine)
	local PropertyDictionary = {
		["Position"] = destination.Position;
	}
	local Tween = TweenService:Create(Robot1, Info, PropertyDictionary);
	Tween:Play();
	for val = 1, 5, 1 do
		wait(2);
		local newCone = ServerStorage:FindFirstChild("Clone"):Clone();
		newCone.Parent = workspace;
		newCone.BrickColor = BrickColor.new("Really red");
		newCone.Position = Vector3.new(destination.Position.X, destination.Position.Y + val  , destination.Position.Z);
	end;
end;


