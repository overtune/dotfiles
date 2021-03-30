hs.hotkey.bind({"ctrl"}, "space", function()
    alacritty = hs.application.find('Alacritty')
    if alacritty then
      awin = alacritty:mainWindow()
    end
    if awin and alacritty and alacritty:isFrontmost() then
      alacritty:hide()
    else
      hs.application.launchOrFocus("/Applications/Alacritty.app")
      local alacritty = hs.application.find('Alacritty')
      alacritty.setFrontmost(alacritty)
      alacritty.activate(alacritty)
    end
  end
)