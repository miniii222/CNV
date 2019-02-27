# CNV
cnv data 분석

### cyto band 기준으로 데이터 나누기 : [code](https://github.com/miniii222/CNV/blob/master/cyto.R)
- 변수를 800여개로 줄임

### TCGA 데이터 모델링: [code](https://github.com/miniii222/CNV/blob/master/TCGA_model.ipynb)
- 논문처럼 accuracy 90%정도로 예측

### 오줌 데이터 모델링: [code](https://github.com/miniii222/CNV/blob/master/model1.ipynb)
- accuracy : 50%미만

### TCGA 데이터로 오줌 데이터 predict: [code](https://github.com/miniii222/CNV/blob/master/TCGA_model.ipynb)
- train data에서는 잘 예측하지만, test data에서는 약 30%정도로 예측

### pattern plot: [code](https://github.com/miniii222/CNV/blob/master/Pattern_plot.ipynb)
- 오줌 데이터 pattern은 잘 보이지 않음.
- 값들이 튀는 것이 

### binary model
- 방광암이 그나마 잘 예측되므로
- 방광암 : 1 / 나머지 : 0 -> modeling
- 방광암 : 1 / normal : 0 -> modeling


## 다음에 할 것
- pattern 살펴볼 것
- report 작성
