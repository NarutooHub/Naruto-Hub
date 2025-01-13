shared.NarutoFunctions = nil

local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Vehicles = workspace:FindFirstChild("Vehicles")

LocalPlayer.CharacterAdded:Connect(function(newcharacter)
  
  Character = newcharacter
  
end)


-- Verifique se o jogador esta sentado em algum assento
function CheckPlayerSitting(seat, playername)
  
  if seat:IsA("Seat") then
    
    local SeatWeld = seat:FindFirstChild("SeatWeld")
    
    if SeatWeld then
      local Character = seatweld.Part1.Parent
      local Player = Players:GetPlayerFromCharacter(character)
      
      if Player.Name == playername then
        
        return true
        
      end
    end
  else
    
    return "Isto não é um assento"
    
  end
end

-- Verificar se você está no carro
function CheckYouInTheCar(callback)
  
  for _, Car in ipairs(Vehicles:GetChildren()) do
    
    local VehicleSeat = Car:FindFirstChild("VehicleSeat", true)
    
    if VehicleSeat and CheckPlayerSitting(VehicleSeat, LocalPlayer.Name) then
      
      if callback then
        
        callback(Car, VehicleSeat)
        
      end
      return true
    end
  end
  
  return "Você não está em um carro"
  
end

function shared.NarutoFunctions.CarSpeed(speed, method)
  
  CheckYouInTheCar(function(car, VehicleSeat)
    
    if method == "Speed" then
    
      local VehicleSeat = TopSpeed:FindFirstChild("TopSpeed")
      
      if VehicleSeat then
        
        VehicleSeat.Value = speed
        
      end
      
    elseif method == "Turbo" then
      
      local Turbo = VehicleSeat:FindFirstChild("Turbo")
      
      if Turbo then
        
        Turbo.Value = speed
        
      end
      
    end
  end)
end