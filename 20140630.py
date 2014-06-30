### Example code from 6/30/2014
### Download data at http://grouplens.org/datasets/movielens/


import pandas as pd
import matplotlib.pyplot as plt


# Navigate to the directory in which you saved the folder. Read in data:
unames = ['user_id', 'gender', 'age', 'occupation', 'zip']
users = pd.read_table('ml-1m/users.dat', sep='::', header=None,
                      names=unames)

rnames = ['user_id', 'movie_id', 'rating', 'timestamp']
ratings = pd.read_table('ml-1m/ratings.dat', sep='::', header=None,
                        names=rnames)

mnames = ['movie_id', 'title', 'genres']
movies = pd.read_table('ml-1m/movies.dat', sep='::', header=None,
                        names=mnames)
						
# Merge tables                    
data = pd.merge(pd.merge(ratings, users), movies)



### Do ratings for different genres vary by gender?

data['movietype'] = np.where(data.genres.str.contains('Comedy'), 'Comedy', 'Other')
data['movietype'] = np.where(data.genres.str.contains('Documentary'), 'Documentary', data['movietype'])
data['movietype'] = np.where(data.genres.str.contains('Thriller'), 'Thriller', data['movietype'])

mean_ratings = data.pivot_table('rating', index='movietype', columns='gender', aggfunc='mean')




### Do ratings vary over time?

import re

pattern = '[0-9]{4}'
data['year'] = data.title.str.findall(pattern)
data['year'] = data.year.str.join('')			# Converts from list to string

yearly_ratings = data.pivot_table('rating', index='year', columns='gender', aggfunc='mean')
yearly_ratings.plot()





