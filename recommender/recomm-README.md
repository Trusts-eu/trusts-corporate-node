## TRUSTS Recommender System

The TRUSTS recommender system is based on [Know-Center’s ScaR framework](http://scar.know-center.tugraz.at/) – more information regarding the different recommendation use cases can be found in the following publication: https://dl.acm.org/doi/10.1145/3565011.3569055 - in case of questions or if you are interested in the recommender system, please contact Dieter Theiler (dtheiler@know-center.at) and/or Dominik Kowald (dkowald@know-center.at)

### Steps to use the recommender

Additionally to the usual TRUST node startup instructions, you need to do the following to use the recommender system:


1. Use the contact data above to get a license, and corresponding docker images
2. Set the locations of the images in the `docker-compose-recomm.yml` file.
3. Link the contents of this directory to the `node/` directory in the repository
4. Move to the `node/` directory and bring the node up with `docker compose -f docker-compose-recomm.yaml up`