{ ... }:

{
	# Auto import all modules
	imports = builtins.filter 
		(f: f != ./default.nix)
		(builtins.map (e: ./${e}) (builtins.attrNames (builtins.readDir ./. )));

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
