% Get the shifted likelihood

function likelihood = get_shifted_likelihood(l,L,likelihood,shift)

shift = int32(shift);
likelihood = likelihood(3*L/l+1-shift/l:5*L/l+1-shift/l);
likelihood = likelihood/sum(likelihood*l);

end