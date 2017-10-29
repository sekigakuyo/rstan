data {
  int N;
  int X[N];
  int Y[N];

  int N_new;
  int X_new[N_new];
}

parameters {
  real b[2];
  real<lower=0> sigma;
}

transformed parameters {
  real y_base[N];
  for(n in 1:N){
    y_base[n] = b[1] + b[2]*X[n];
  }
}

model {
  for(n in 1:N){
    Y[n] ~ normal(y_base[n] ,sigma);
  }
}

generated quantities {
  real y_base_new[N_new];
  real y_new[N_new];
  for(n in 1:N_new){
    y_base_new[n] = b[1] + b[2]*X_new[n];
    y_new[n] = normal_rng(y_base_new[n],sigma);
  }
}