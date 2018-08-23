function p = stblpdf_nor(alpha1,beta1,gamma1,delta1,l,L)
    
    x = -L:l:L;
    p = stblpdf(x,alpha1,beta1,gamma1,delta1);
    p = p'/sum(p*l);
    
end
