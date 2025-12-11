{ config, pkgs, lib, system, label, ... }:

let
	labelpkgs = label.packages.${system};
in
{
	options.label = {
		enable = lib.mkEnableOption "Enable the label module";
		printserver.addr = lib.mkOption {
			type = lib.types.str;
			default = "0.0.0.0:8080";
			description = "Label printing server address";
		};
	};

	config = lib.mkIf config.label.enable {
		environment.systemPackages = [
			labelpkgs.textlabel
		];

		systemd.services.printserver = {
			enable = true;
			description = "Label printing server";
			serviceConfig = {
				ExecStart = "${labelpkgs.printserver}/bin/printserver -b \"${pkgs.cups}/bin/lpr\" zebra ${config.label.printserver.addr}";
				Restart = "always";
			};
			wantedBy = [ "multi-user.target" ];
		};
	};
}
