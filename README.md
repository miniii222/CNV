# CNV
cnv data 분석
## 분석 목표
- CNV 데이터를 이용하여 다양한 모델로 암을 분류하여 보자.
- TCGA데이터를 이용하여 분석한 논문을 참고하여, 새로운 데이터(소변 데이터)에 적용시켜 보자.

## Domain 공부
#### CNV란 ?
- Copy Number Variation. 구조변이의 한 종류.
- 유전체의 특정 영역이 2개 이상으로 복사되거난 삭제되는 현상.
- 각 개체마다 다른 변이를 갖는다.
- 사람에 따라 어떤 영역 혹은 유전자가 두개, 세개의 복사가 있을 수 있고, 없을 수도 있다.

#### 암세포와 CNV
- 우리의 목표인 암세포 분류와 연관시켜 보자.
- copy-number는 암세포의 증식에 관여한다.
- copy-number가 많아지면, 암세포의 발현이 증가하거나, 암억제 유전자를 삭제하는 역할을 한다.
- 또한, 암의 종류에 따라 그 패턴이 상이하다.
- 따라서, cnv데이터를 이용하여 암을 분류할 수 있다는 것이 알려져 있다.


## 분석
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
#### only urine -> accuracy 70%정도 : [code](https://github.com/miniii222/CNV/blob/master/binary_modeling_urine.ipynb)
#### using TCGA fit urine : [code](https://github.com/miniii222/CNV/blob/master/binary_modeling_using_TCGA.ipynb)
- 방광암 : 1 / normal : 0 -> modeling
  - stacking(randomforest, svm, logist regression) 까지 써서 나온 결과
  ![](https://github.com/miniii222/CNV/blob/master/%EC%BA%A1%EC%B2%981.JPG '1')


## 다음에 할 것
- pattern 살펴볼 것
- report 작성
