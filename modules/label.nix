{ config, lib, system, label, ... }:

let
	labelpkgs = label.packages.${system};
in
{
	options.label = {
		enable = lib.mkEnableOption "Enable the label module";
		printserver.port = lib.mkOption {
			type = lib.types.string;
			default = "8080";
			description = "Label printing server port";
		};
	};

	config = lib.mkIf config.label.enable {
		environment.systemPackages = [
			labelpkgs.textlabel
			labelpkgs.printserver
		];

		systemd.services.printserver = {
			enable = true;
			description = "Label printing server";
			serviceConfig = {
				ExecStart = "printserver zebra ${config.printserver.port}";
				Restart = "always";
			};
			wantedBy = [ "multi-user.target" ];
		};
	};
}
