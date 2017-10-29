data {
  int N1;
  int N2;
  real Y1[N1];
  real Y2[N2];  
}

parameters {
  real mu[2];
  real<lower=0> sigma;
}

model {

  for(n in 1:N1){
    Y1[n] ~ normal(mu[1],sigma);
  }
  for(n in 1:N2){
    Y2[n] ~ normal(mu[2],sigma);
  }

}