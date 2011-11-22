#!/bin/sh -e

PROGRAM="mono --debug RatingPrediction.exe"

echo "MyMediaLite time-aware rating prediction test script"
echo "This will take about 3 minutes ..."

echo ""
echo "MovieLens 1M"
echo "------------"

DATA_DIR=../../../../../data/ml-1m
 
cd src/Programs/RatingPrediction/bin/Debug/
 

for method in BiasedMatrixFactorization UserItemBaseline TimeAwareBaseline TimeAwareBaselineWithFrequencies
do
       echo $PROGRAM --training-file=ratings.dat --chronological-split=2000-05-05 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --data-dir=$DATA_DIR --file-format=movielens_1m
            $PROGRAM --training-file=ratings.dat --chronological-split=2000-05-05 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --data-dir=$DATA_DIR --file-format=movielens_1m
done


for method in BiasedMatrixFactorization UserItemBaseline TimeAwareBaseline TimeAwareBaselineWithFrequencies
do
       echo $PROGRAM --training-file=ratings.dat --chronological-split=0.2 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --data-dir=$DATA_DIR --file-format=movielens_1m
            $PROGRAM --training-file=ratings.dat --chronological-split=0.2 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --data-dir=$DATA_DIR --file-format=movielens_1m
done

echo ""
echo "MovieLens 100K"
echo "--------------"

DATA_DIR=../../../../../data/ml-100k

for method in BiasedMatrixFactorization UserItemBaseline TimeAwareBaseline TimeAwareBaselineWithFrequencies
do
       echo $PROGRAM --training-file=u.data --chronological-split=1998-01-01 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --compute-fit --data-dir=$DATA_DIR
            $PROGRAM --training-file=u.data --chronological-split=1998-01-01 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --compute-fit --data-dir=$DATA_DIR
done


for method in BiasedMatrixFactorization UserItemBaseline TimeAwareBaseline TimeAwareBaselineWithFrequencies
do
       echo $PROGRAM --training-file=u.data --chronological-split=0.2 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --compute-fit --data-dir=$DATA_DIR
            $PROGRAM --training-file=u.data --chronological-split=0.2 --recommender=$method --find-iter=1 --max-iter=5 --recommender-options="num_iter=1" --compute-fit --data-dir=$DATA_DIR
done

cd ../../../../..
