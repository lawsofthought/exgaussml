library(rjags)

set.seed(1001)

N <- 5000 # Total number of trials
K <- 10   # Total number of subjects

v <- rnorm(N) # Predictor variable on each trial
subjects <- sample(1:K, N, replace=T) # Subjects on trials 1 ... N 

# Trial by trial standard deviation
sigma <- 1.0

# The population averages for the random slopes and intercepts.
alpha.mu.0  <- 1.0 
beta.mu.0  <- 2.25

alpha.tau.0  <- 0.2
beta.tau.0  <- 1.5

# Variances for random slopes and intercepts
beta.mu.sigma <- 1.0
alpha.mu.sigma <- 1.0
beta.tau.sigma <- 0.1
alpha.tau.sigma <- 0.25

# Random slopes and intercepts for the K subjects
# (for mu)
beta.mu <- rnorm(K, mean=beta.mu.0, sd=beta.mu.sigma)
alpha.mu <- rnorm(K, mean=alpha.mu.0, sd=alpha.mu.sigma)
# (for tau)
beta.tau <- rnorm(K, mean=beta.tau.0, sd=beta.tau.sigma)
alpha.tau <- rnorm(K, mean=alpha.tau.0, sd=alpha.tau.sigma)


# Generate the data
z <- rep(0, N)
for (i in seq(N)){
  
  mu <- alpha.mu[subjects[i]] + beta.mu[subjects[i]]*v[i]
  tau <- exp(alpha.tau[subjects[i]] + beta.tau[subjects[i]]*v[i])
  
  x <- rnorm(1, mean=mu, sd=sigma)
  y <- rexp(1, rate=tau)
  
  z[i] <- x + y
  
}

data <- list('N'=N,
             'K'=K,
             'z'=z,
             'v'=v,
             'subjects'=subjects)
             

M <- jags.model('exgaussml.jags',
                data = data,
                n.chains = 3)

n.iterations <- 10000

update(M, n.iterations)

S.1 <- coda.samples(M, 
                    variable.names = c('alpha.tau.0', 'beta.tau.0', 'alpha.mu.0', 'beta.mu.0'), 
                    n.iterations)

S.2 <- coda.samples(M, 
                    variable.names = c('alpha.tau.sigma', 'beta.tau.sigma', 'alpha.mu.sigma', 'beta.mu.sigma', 'sigma'), 
                    n.iterations)
