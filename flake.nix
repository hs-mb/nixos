{
	description = "NixOS configuration";

	inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

		label = {
			url = "github:hs-mb/label";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations =
			let
				system = "x86_64-linux";
				pkgs = import nixpkgs { inherit system; };
			in
			{
				labeltc = nixpkgs.lib.nixosSystem {
					inherit system pkgs;
					modules = [
						./hosts/labeltc
					];
					specialArgs = {
						inherit system;
					};
				};
			};
	};
}
