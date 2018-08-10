function distribution = powerlaw_distribution(alphax,gammax,l,L,shiftS)

phi1 = -L:l:L;

distribution = gammax^alphax./(abs(phi1-shiftS).^alphax+gammax^alphax);
distribution = distribution'/sum(distribution*l);

end