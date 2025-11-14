{
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkOption types;
    in
    {
      planet.default-terminal = {
        startCommand = mkOption {
          type = with types; nullOr str;
          default = null;
          description = ''
            The command to execute to open the preferred terminal.
            Ensure that the command handles arguments passed to it using "$@" or similar.
          '';
        };
        startInDirectoryCommand = mkOption {
          type = with types; nullOr str;
          default = null;
          description = ''
            Like `planet.default-terminal.startCommand`, but this command starts the terminal in the directory passed as an argument.
          '';
        };
      };
    };
}
