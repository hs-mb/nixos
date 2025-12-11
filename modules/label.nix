{ system, ... }:

{
	imports = [
		label
	];

	environment.systemPackages = [
		label.packages.${system}.textlabel
	];
}
