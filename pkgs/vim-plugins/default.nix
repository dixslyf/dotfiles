{
  inputs,
  vimUtils,
}: {
  catppuccin-nvim = vimUtils.buildVimPlugin {
    pname = "catppuccin-nvim";
    version = inputs.catppuccin-nvim.lastModifiedDate;
    src = inputs.catppuccin-nvim;
    meta.homepage = "https://github.com/catppuccin/nvim";
  };

  feline-nvim = vimUtils.buildVimPlugin {
    pname = "feline-nvim";
    version = inputs.feline-nvim.lastModifiedDate;
    src = inputs.feline-nvim;
    meta.homepage = "https://github.com/feline-nvim/feline.nvim";
  };

  nvim-web-devicons = vimUtils.buildVimPlugin {
    pname = "nvim-web-devicons";
    version = inputs.nvim-web-devicons.lastModifiedDate;
    src = inputs.nvim-web-devicons;
    meta.homepage = "https://github.com/kyazdani42/nvim-web-devicons";
  };
}
