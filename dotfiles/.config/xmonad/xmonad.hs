----------------------------------------------------------------
--	Name:		      Cesar Leon
--	Type:		      Haskell Script
--	E-mail:		    leoncesaralejandro@gmail.com
--	Date:		      August, the 15th/ 2021
--	Description:	XMONAD CONFIGURATION FILE
----------------------------------------------------------------

----------------------------------------------------------------
-- 1. Imports
-- General modules used in the script
-- (THIS SECTION SHOULD BE AT THE BEGINNING OF THE SCRIPT)
----------------------------------------------------------------

import System.IO

import XMonad

import XMonad.Actions.RotSlaves
import XMonad.Actions.CycleWS

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers


import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.WindowArranger

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

----------------------------------------------------------------
-- 2. Variables
-- Defining variables used in various hooks and configs
----------------------------------------------------------------

myFont = "xft:"
myModMask = mod4Mask
myTerminal = "alacritty"
myBrowser = "brave-browser"
myIDE = "emacsclient -c -a 'emacs'"
myRecorder = "obs"
myVirtManager = "VirtualBox"
myBorderWidth = 2
myGap = 7
myNormColor = "#282c34"
myFocusColor = "#46d9ff"
myWorkspaces = [" term "," ide "," docs "," obs "," vbox "," video "," nitr "," web "," etc "]

-- Colors -------------------------------------------------------

blue = xmobarColor "#bd93f9" ""
grey = xmobarColor "#808080" ""
red = xmobarColor "#ff5555" ""
white = xmobarColor "#f8f8f2" ""
yellow = xmobarColor "#f1fa8c" ""

----------------------------------------------------------------
-- 3. Keybindings
-- Custom shortcuts to optimize time around xmonad methods.
-- Ordered alphabetically to ensure readability.
-- Keybindings should relate the key with the method.
----------------------------------------------------------------

myKeybindings = [
                -- Xmonad Key Shorcuts
                  ("M-q", spawn "xmonad --recompile")           -- Recompile XMonad
                , ("M-r", spawn "xmonad --restart")             -- Restart XMonad
                -- Dmenu utilities
                , ("M-d", spawn "dmenu_run -i -p \"Run: \"")    -- Open Dmenu
                -- Spawn Applications
                , ("M-t", spawn (myTerminal))                   -- Open Terminal
                , ("M-e", spawn (myIDE))                        -- Emacs Editor
                , ("M-o", spawn (myRecorder))                   -- OBS
                , ("M-v", spawn (myVirtManager))                -- Virtual Box
                -- Window Arrangement
                , ("M-<Tab>", rotSlavesDown)                    -- Rotate Windows
                , ("M-<Right>", nextWS)                         -- Move to next Workspace
                , ("M-<Left>", prevWS)                          -- Move to previous Workspace
                ]

----------------------------------------------------------------
-- 4. Hooks
-- Using hooks to distinguish from configs in main function.
-- This sections is for Hooks only, no Configs allowed
----------------------------------------------------------------

-- Open apps at startup hook
myStartupHook = do
    spawnOnce "lxsession &"
    spawnOnce "picom -f &"                      -- compositor with fade effect
    spawnOnce "nm-applet &"                     -- network manager applet
    spawnOnce "volumeicon &"                    -- alsamixer volume icon
    spawnOnce "/usr/bin/emacs --daemon &"       -- emacs daemon
    spawnOnce "nitrogen --restore &"            -- wallpaper

-- Layput of windows and xmobar
myBaseLayoutHook = avoidStruts $ Grid ||| tiled ||| Mirror tiled ||| Full
   where
      tiled          = Tall nmaster delta ratio
      nmaster        = 1
      ratio          = 1/2
      delta          = 3/100
      
mySpacing i    = spacingRaw        False
               ( Border i i i i )  True
               ( Border i i i i )  True
             
myLayoutHook   = mySpacing myGap
               $ myBaseLayoutHook

myLogHook bar  = dynamicLogWithPP  $ xmobarPP {
                 ppOutput          = hPutStrLn bar
               , ppSep             = white " || "
               , ppCurrent         = wrap (white "[") (white "]")
               , ppHidden          = white . wrap " " ""
               , ppHiddenNoWindows = grey . wrap " " ""
               , ppUrgent          = red . wrap (yellow "!") (yellow "!")
               , ppOrder           = \(ws:l:t) -> [ws,l]++t
               }

myManageHook   = composeAll [
              -- System Boxes
                 className    =? "confirm"            --> doFloat
               , className    =? "file_progress"      --> doFloat
               , className    =? "dialog"             --> doFloat
               , className    =? "download"           --> doFloat
               , className    =? "error"              --> doFloat
               , className    =? "notification"       --> doFloat
               , className    =? "splash"             --> doFloat
               , className    =? "toolbar"            --> doFloat
               -- Applications
               , className    =? "Emacs"              --> doShift (myWorkspaces !! 1)
               , className    =? "obs"                --> doShift (myWorkspaces !! 3)
               , className    =? "VirtualBox Manager" --> doShift (myWorkspaces !! 4)
               , className    =? "vlc"                --> doShift (myWorkspaces !! 5)
               , className    =? "Nitrogen"           --> doShift (myWorkspaces !! 6)
               , isFullscreen                         --> doFullFloat
               ]

----------------------------------------------------------------
-- 5. Configs
-- Personal configs using previously definded data
---------------------------------------------------------------

----------------------------------------------------------------
-- 6. Main function
-- Wrapping up the configuration, variables and all the other
-- stuff that is needed
----------------------------------------------------------------

main :: IO ()
main = do
  myBar <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc"
  xmonad . ewmh $ docks def { 
           borderWidth        = myBorderWidth
         , layoutHook         = myLayoutHook
         , logHook            = myLogHook myBar
         , manageHook         = myManageHook <+> manageDocks
         , modMask            = myModMask
         , startupHook        = myStartupHook
         , terminal           = myTerminal
         , workspaces         = myWorkspaces
         , normalBorderColor  = myNormColor
         , focusedBorderColor = myFocusColor
         } `additionalKeysP` myKeybindings
