data {
  int N;
  int X[N];
  int Y[N];
}

parameters {
  real b[2];
  real<lower=0> sigma;
}

model {
  for(n in 1:N){
    Y[n] ~ normal(b[1] + b[2]*X[n] ,sigma);
  }
}