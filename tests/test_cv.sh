!/bin/bash -e

PROGRAM="bin/rating_prediction"
DATA_DIR=data/ml-100k
LANG=C

K=3
U=50

echo "MyMediaLite cross-validation test script."
echo "This will take about 1 minutes ..."

echo
echo "rating predictors"
echo "-----------------"

echo $PROGRAM --training-file=u.data --cross-validation=$K --recommender=GlobalAverage --data-dir=$DATA_DIR --random-seed=1
     $PROGRAM --training-file=u.data --cross-validation=$K --recommender=GlobalAverage --data-dir=$DATA_DIR --random-seed=1

echo $PROGRAM --training-file=u.data --cross-validation=$K --recommender=MatrixFactorization --data-dir=$DATA_DIR --random-seed=1
     $PROGRAM --training-file=u.data --cross-validation=$K --recommender=MatrixFactorization --data-dir=$DATA_DIR --random-seed=1


echo
echo "item recommenders"
echo "-----------------"

PROGRAM="bin/item_recommendation"

echo $PROGRAM --training-file=u.data --cross-validation=$K --recommender=MostPopular --data-dir=$DATA_DIR --random-seed=1 > log1
     $PROGRAM --training-file=u.data --cross-validation=$K --recommender=MostPopular --data-dir=$DATA_DIR --random-seed=1 > log1

echo $PROGRAM --training-file=u.data --cross-validation=$K --recommender=WRMF --data-dir=$DATA_DIR --random-seed=1 > log2
     $PROGRAM --training-file=u.data --cross-validation=$K --recommender=WRMF --data-dir=$DATA_DIR --random-seed=1 > log2

grep "test data" log1 > log1.grep
grep "test data" log2 > log2.grep

diff log1.grep log2.grep

rm log1 log2 log1.grep log2.grep

echo $PROGRAM --training-file=u.data --cross-validation=$K --recommender=MostPopular --data-dir=$DATA_DIR --random-seed=1 --num-test-users=$U > log1
     $PROGRAM --training-file=u.data --cross-validation=$K --recommender=MostPopular --data-dir=$DATA_DIR --random-seed=1 --num-test-users=$U > log1

echo $PROGRAM --training-file=u.data --cross-validation=$K --recommender=WRMF --data-dir=$DATA_DIR --random-seed=1 --num-test-users=$U > log2
     $PROGRAM --training-file=u.data --cross-validation=$K --recommender=WRMF --data-dir=$DATA_DIR --random-seed=1 --num-test-users=$U > log2

grep "$U users" log1 > log1.grep
grep "$U users" log2 > log2.grep

diff log1.grep log2.grep

rm log1 log2 log1.grep log2.grep

