tool = Instance.new("Tool",game.Players.LocalPlayer.Backpack)
tool.Name = "Fight"
handle = Instance.new("Part",tool)
handle.Name="Handle"
handle.Transparency=1
handle.Size=Vector3.new(.2,.2,.2)
anim = Instance.new'Animation'
anim.AnimationId = 'rbxassetid://218401948'

tool.Equipped:connect(function(mouse)
  
  ply = tool.Parent
  anim = ply.Humanoid:LoadAnimation(anim)
  local rarm = ply:findFirstChild("Right Arm")
  local larm = ply:findFirstChild("Left Arm")
  local deb = false
  pressedalready = false
  touched = function(part)
    
    local hum = part.Parent:findFirstChild("Humanoid")
    if hum and deb ~= true then
      deb = true
      wait(0.8)
      game.ReplicatedStorage.meleeEvent:FireServer(game.Players[hum.Parent.Name])
      deb = false
    end
  end

  mouse.Button1Down:connect(function()
    
    if pressedalready == false then
      ply.Humanoid.WalkSpeed = 14
      pressedalready = true
      if rarm and larm then
        rt = rarm.Touched:connect(touched)
        lt = larm.Touched:connect(touched)
      end
      anim:Play()
    else
      if pressedalready == true then
        ply.Humanoid.WalkSpeed = 16
        pressedalready = false
        anim:Stop()
        rt:disconnect()
        lt:disconnect()
      end
    end
  end
)
end
)
tool.Unequipped:connect(function()
  
  anim:Stop()
  ply.Humanoid.WalkSpeed = 16
  if pressedalready == true then
    rt:disconnect()
    lt:disconnect()
  end
end
)
