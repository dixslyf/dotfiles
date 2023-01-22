{
  inputs,
  discord,
  ...
}: (discord.overrideAttrs (old: {
  src = inputs.discord;
}))
