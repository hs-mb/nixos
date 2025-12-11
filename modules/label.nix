{ config, lib, system, label, ... }:

{
	options.label = {
		enable = lib.mkEnableOption "Enable the label module";
	};

	config = lib.mkIf config.label.enable {
		environment.systemPackages = [
			label.packages.${system}.textlabel
		];
	};
}
