# TextBook

[微型计算机原理与接口技术（第5版） 周荷琴、冯焕清编著](https://baike.baidu.com/item/%E5%BE%AE%E5%9E%8B%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%8E%9F%E7%90%86%E4%B8%8E%E6%8E%A5%E5%8F%A3%E6%8A%80%E6%9C%AF%EF%BC%88%E7%AC%AC5%E7%89%88%EF%BC%89/13237881)

# How to run these codes

1. Create a virtual Dos environment using [DOSBox](https://www.dosbox.com/). You can find  [DOSBox tutorial](https://www.dosbox.com/wiki/Basic_Setup_and_Installation_of_DosBox) here 
2. Use TASM to compile and execute your codes. Download [TASM](http://trimtab.ca/2010/tech/tasm-5-intel-8086-turbo-assembler-download/) here.

# Eight queens puzzle

`queen.asm` contains assembly version solution.

`queen.cpp` contains cpp version solution.

The algorithm used to solve this problem in two version are completely identical. Basically, the algorithm simplifies the puzzle from 2 dimension to 1 dimension. Then DFS (Deep First Search) algorithm is implemented to iterate through all possible solutions.

# 感想

汇编真的是有点意思啊，勤学多练，越写越熟。