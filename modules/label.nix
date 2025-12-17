{ config, pkgs, lib, system, etikett, ... }:

let
	labelpkgs = etikett.packages.${system};
in
{
	options.label = {
		enable = lib.mkEnableOption "Enable the label module";
	};

	config = lib.mkIf config.label.enable {
		environment.systemPackages = [
			labelpkgs.textlabel
		];

		systemd.services.printserver = {
			enable = true;
			description = "Label printing server";
			serviceConfig = {
				ExecStart = "${labelpkgs.printserver}/bin/printserver -b \"${pkgs.cups}/bin/lpr\" zebra";
				Restart = "always";
			};
			wantedBy = [ "multi-user.target" ];
		};

		systemd.services.webprint = {
			enable = true;
			description = "Web printing server";
			serviceConfig = {
				ExecStart = "${labelpkgs.webprint}/bin/webprint ws://192.168.178.48:6245";
				Restart = "always";
			};
			wantedBy = [ "multi-user.target" ];
		};
	};
}
