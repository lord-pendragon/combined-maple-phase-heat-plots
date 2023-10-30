PhasePlots := module()
option package;

export  Stereographic, Planar, Pseudosphere, PoincareDisc, Beltrami, Klein, Modular, PoincareDiscUltra, Pseudoplane, BeltramiUltra, KleinUltra, Dini, PoincareDynamic, PoincareUltraDynamic, PseudosphereNaive, ComputeMotion, PoincarePlanar, PoincarePlanarUltra, Heatplot, Heatplotreverse, Keyplot, Keyplotreverse;
local S2P, `Pi/2`, `1*Pi`, `2*Pi`, PhasePlots, T, SphX, SphY, SphZ, Sph2Pln, Pol2Sph, arg, Heatplots;

export  

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
$include "Heatplot.mpl"
$include "Heatplotreverse.mpl"
$include "Keyplot.mpl"
$include "Keyplotreverse.mpl"

end module: