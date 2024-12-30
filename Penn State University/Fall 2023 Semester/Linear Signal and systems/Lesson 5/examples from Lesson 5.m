syms t s;
p=heaviside(t)-heaviside(t-1);
p=laplace(p);