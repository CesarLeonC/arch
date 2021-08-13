------------------------------------------
-- 1.- Imports
------------------------------------------

import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.Grid
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

myModMask     = mod4Mask
myTerminal    = "alacritty"
myBorderWidth = 2
myLayoutHook  = grid ||| tiled ||| Mirror tiled ||| Full
   where
      grid    = Grid
      tiled   = Tall nmaster delta ratio
      nmaster = 1
      ratio   = 1/2
      delta   = 3/100

myConfig      = def
   {
   modMask        = myModMask,
   terminal       = myTerminal,
   layoutHook     = myLayoutHook
   }

main :: IO ()
main = xmonad . ewmh =<< xmobar myConfig