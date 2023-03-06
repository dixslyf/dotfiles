{ hyprland-nvidia
, makeWrapper
, ...
}:
hyprland-nvidia.overrideAttrs (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [ makeWrapper ];
  postInstall = oldAttrs.postInstall or ''
    wrapProgram $out/bin/Hyprland \
      --set LIBVA_DRIVER_NAME nvidia \
      --set CLUTTER_BACKEND wayland \
      --set XDG_SESSION_TYPE wayland \
      --set QT_WAYLAND_DISABLE_WINDOWDECORATION 1 \
      --set MOZ_ENABLE_WAYLAND 1 \
      --set GBM_BACKEND nvidia-drm \
      --set __GLX_VENDOR_LIBRARY_NAME nvidia \
      --set WLR_NO_HARDWARE_CURSORS 1 \
      --set WLR_BACKEND vulkan \
      --set QT_QPA_PLATFORM wayland \
      --set GDK_BACKEND "wayland,x11" \
      --set _JAVA_AWT_WM_NONREPARENTING 1 \
      --set NIXOS_OZONE_WL 1
  '';
})
