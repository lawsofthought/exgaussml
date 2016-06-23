Multilevel Ex-Gaussian Model for Response Times
################################################

This is a minimal example, using artificial data, of how to model human response times using a multilevel `ExGaussian`_ regression model. It is implemented in `Jags`_ and `R`_ and uses the `gamlss`_ and `rjags`_ packages. For details about how to see up `R`_ to use `Jags`_, see a `guide`_ I wrote for a `workshop`_ that I teach that requires  `R`_ to use `Jags`_. 

Details
-------------

An `ExGaussian`_ probability distribution with parameters :math:`\mu`,
:math:`\sigma^2`, and :math:`\tau`:, is a `convolution`_ of a `Gaussian`_ (or
Normal) distribution with mean and variance parameters :math:`\mu`,
:math:`\sigma^2` respectively, and an exponential distribution with rate
parameter :math:`\tau`. More simply, if :math:`x` is normally distributed
random variable, with parameters :math:`\mu`, :math:`\sigma^2`,  and :math:`y`
is an exponentially distributed with parameters :math:`\tau`, then 

.. math::
        
        z = x + y 

is an  `ExGaussian`_ random variable with parameters  :math:`\mu`,
:math:`\sigma^2` and  :math:`\tau`.

The `ExGaussian`_ distribution has been used a model of human reaction times,
see [Hea1991]_. As such, it could be used to replace the Normal probability
distribution that is the standard assumption of linear regresion models.  What
follows is a description of how to do this in a multilevel regression model,
where the slope and intercepts for some predictor vary randomly across subjects
in an experiment. Also, both :math:`\mu` and :math:`\tau` vary as (linear or
transformed linear) functions of the predictor. 

In detail, let us assume that our observed data are

.. math:: 

        (z_i, v_i, s_i)

for :math:`i \in 1 \ldots n`, where :math:`z_i` is the observed response time
on trial :math:`i`, :math:`v_i` is the value of the predictor variable on trial
:math:`i`, and :math:`s_i \in 1 \ldots K` is the identity of the subject on
trial :math:`i`.

The main details of this model are as follows:

.. math::

        z_i &\sim \mathrm{dexgauss}(\mu_i, \tau_i, \sigma^2) \\
        \mu_i &= \alpha_{0[s_i]} + \beta_{0[s_i]} v_i, \\
        \log(\tau_i) &= \alpha_{1[s_i]} + \beta_{1[s_i]} v_i, 

where, for :math:`k \in 1 \ldots K`, each of :math:`\alpha_{0k}`,  :math:`\beta_{0k}`,  :math:`\alpha_{1k}`,  :math:`\beta{1k}` are normally distributed random variables. These are random slopes and intercepts for each subject.


.. _`ExGaussian`: https://en.wikipedia.org/wiki/Exponentially_modified_Gaussian_distribution
.. _`convolution`: https://en.wikipedia.org/wiki/Convolution
.. _`Gaussian`: https://en.wikipedia.org/wiki/Normal_distribution
.. _`exponential`: https://en.wikipedia.org/wiki/Exponential_distribution
.. _`Jags`: http://mcmc-jags.sourceforge.net/
.. _`R`: https://www.r-project.org/
.. _`retimes`: https://cran.r-project.org/web/packages/retimes/index.html
.. _`rjags`: https://cran.r-project.org/web/packages/rjags/index.html
.. _`gamlss`: http://artax.karlin.mff.cuni.cz/r-help/library/gamlss.dist/html/exGAUS.html
.. _`guide`: http://www.priorexposure.org.uk/software
.. _`workshop`: http://www.priorexposure.org.uk/

.. [Hea1991]  Analysis of response time distributions: An example using the Stroop task. Heathcote, Andrew; Popiel, Stephen J.; Mewhort, D. J. Psychological Bulletin, Vol 109(2), Mar 1991, 340-347.
