pathDir=$(pwd)
echo $pathDir
baseDir=$(basename $pathDir)
echo $baseDir
ourPath=${pathDir%"$baseDir"}
echo $ourPath

