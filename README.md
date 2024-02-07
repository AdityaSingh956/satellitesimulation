# Satellite Simulation

Thr orbits of numerous satellites were simulated using MATLAB. The difference between the trajectory of each satellite was because of its initial position and velocity, stored in the text file **satellite_data.txt**. 

From Newton's second law, the orbital motion of the satellites can be described via the following differential equations:

$` \frac{∂U}{∂t} = -GM_e \frac{X}{(X^2+Y^2+Z^2)^{3/2}} - \frac{C_d ρ_a A_s}{2m}U \sqrt{U^2+V^2+W^2} `$
$` \frac{∂V}{∂t} = -GM_e \frac{Y}{(X^2+Y^2+Z^2)^{3/2}} - \frac{C_d ρ_a A_s}{2m}V \sqrt{U^2+V^2+W^2} `$
$` \frac{∂W}{∂t} = -GM_e \frac{Z}{(X^2+Y^2+Z^2)^{3/2}} - \frac{C_d ρ_a A_s}{2m}W \sqrt{U^2+V^2+W^2} `$

where t is time (seconds); X, Y, and Z are position (meters) of the satellites relative to the center of the Earth; U, V, and W are the velocity components (meters/second) in the x, y, and z directions. I am assuming earth to be stationary.

Using the Euler-Cromer method I transformed the above equations into algebraic form and used them to create **satellite.m**. I read the information using **read_input.m** and finally created a simulation of the satellite trajectories on a model of the Earth using a 3d-graph.
