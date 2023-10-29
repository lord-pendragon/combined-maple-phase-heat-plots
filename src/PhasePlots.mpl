PhasePlots := module()
option package;

export  Stereographic, Planar, Pseudosphere, PoincareDisc, Beltrami, Klein, Modular, PoincareDiscUltra, Pseudoplane, BeltramiUltra, KleinUltra, Dini, PoincareDynamic, PoincareUltraDynamic, PseudosphereNaive, ComputeMotion, PoincarePlanar, PoincarePlanarUltra;
local S2P, `Pi/2`, `1*Pi`, `2*Pi`, PhasePlots, T, SphX, SphY, SphZ, Sph2Pln, Pol2Sph, arg;

$include "Support.mpl"
$include "Stereographic.mpl"
$include "Planar.mpl"
$include "Pseudosphere.mpl"
$include "PoincareDisc.mpl"
$include "Beltrami.mpl"
$include "Klein.mpl"
$include "Modular.mpl"
$include "PoincareDiscUltra.mpl"
$include "Pseudoplane.mpl"
$include "BeltramiUltra.mpl"
$include "KleinUltra.mpl"
$include "Dini.mpl"
$include "PoincareDynamic.mpl"
$include "PoincareUltraDynamic.mpl"
$include "PseudosphereNaive.mpl"
$include "ComputeMotion.mpl"
$include "PoincarePlanar.mpl"
$include "PoincarePlanarUltra.mpl"
$include "CombinedPhasePlots.mpl"

end module: