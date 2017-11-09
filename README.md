# SR-LTA
==========

The released code for paper " Bottom-up saliency detection with sparse representation of learnt texture atoms" ([link](http://www.sciencedirect.com/science/article/pii/S0031320316301078)) in PR2016, from Lai Jiang, Mai Xu in Beihang University(2016). 

## Abstract
To predict visual attention, this paper proposes a saliency detection method by exploring a novel low level feature on sparse representation of learnt texture atoms (SR-LTA). The learnt texture atoms are encoded in salient and non-salient dictionaries. For salient dictionary, a novel formulation is proposed to learn salient texture atoms from image patches attracting extensive attention. Then, online salient dictionary learning (OSDL) algorithm is provided to solve the proposed formulation. Similarly, the non-salient dictionary can be learnt from image patches without any attention. A new pixel-wise feature, namely SR-LTA, is yielded based on the difference of sparse representation errors regarding the learnt salient and non-salient dictionaries. Finally, image saliency can be predicted via linear combination of the proposed SR-LTA feature and conventional features, i.e., luminance and contrast. For the linear combination, the weights corresponding to different feature channels are determined by least square estimation on the training data. The experimental results show that our method outperforms several state-of-the-art  methods for bottom-up saliency detection.

![](/figs/fig1.png)

## Publication
Our work is published in [PR2016](http://www.sciencedirect.com/science/article/pii/S0031320316301078)), one can cite with the Bibtex code:  

```
@article{xu2016bottom,
  title={Bottom-up saliency detection with sparse representation of learnt texture atoms},
  author={Xu, Mai and Jiang, Lai and Ye, Zhaoting and Wang, Zulin},
  journal={Pattern Recognition},
  volume={60},
  pages={348--360},
  year={2016},
  publisher={Elsevier}
}
```

## Models
SR-LTA feature and framework.

![framework](/figs/framework.png "framework")

## Software
Matlab 2012 (or later)

## Usage
    1.	Add the whole directory into Matlab path setting.
    2.	Run ./spams-matlab/compile.m  and  ./spams-matlab/start_spams.m
    3.	Run main.m for saliency detection
    
## Visual Results
A toy example.
![](/figs/example.png)

## Contact
IF any question, please contact jianglai.china@aliyun.com / jianglai.china@buaa.edu.cn.


