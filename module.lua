shared.NarutoFunctions = {}

local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Vehicles = workspace:FindFirstChild("Vehicles")

LocalPlayer.CharacterAdded:Connect(function(newcharacter)
    Character = newcharacter
end)

-- Verifique se o jogador está sentado em algum assento
function CheckPlayerSitting(seat, playername)
  if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
    local SeatWeld = seat:FindFirstChild("SeatWeld")
    if SeatWeld and SeatWeld.Part1 then
      local PlayerCharacter = SeatWeld.Part1.Parent
      local Player = Players:GetPlayerFromCharacter(PlayerCharacter)
      if Player and playername == Player.Name then
        return true
      end
    end
  end
  return false
end

-- Verificar se você está no carro
function CheckYouInTheCar(callback)
  for _, Car in ipairs(Vehicles:GetChildren()) do
    local VehicleSeat = Car:FindFirstChild("VehicleSeat", true)
    if VehicleSeat and CheckPlayerSitting(VehicleSeat, LocalPlayer.Name) then
      if callback then
        callback(Car, VehicleSeat)
      end
      warn("Encontrei")
      return true
    end
  end
  return false
end

function shared.NarutoFunctions.CarSpeed(speed, method)

  CheckYouInTheCar(function(car, VehicleSeat)

    warn(car)

    if method == "Speed" then
      local TopSpeed = VehicleSeat:FindFirstChild("TopSpeed")
      if TopSpeed then
        TopSpeed.Value = speed
      end
    elseif method == "Turbo" then
      local Turbo = VehicleSeat:FindFirstChild("Turbo")
      if Turbo then
        Turbo.Value = speed
      end
    end
  end)
end