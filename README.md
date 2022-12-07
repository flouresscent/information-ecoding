# Shannon-Fano information encoding algorithm

The Shannon-Fano algorithm is one of the first compression algorithms, which was first formulated by American scientists Claude Shannon and Robert Fano. This compression method has a great similarity with the Huffman algorithm, which appeared a few years later and is a logical continuation of the Shannon algorithm. The algorithm uses variable-length codes: a frequently occurring character is encoded by a shorter-length code, a rarely occurring character is encoded by a longer-length code. Shannon-Fano codes are prefixed, meaning no codeword is a prefix of any other. This property allows you to uniquely decode any sequence of code words.

## The main stages of coding
1. The symbols of the primary alphabet m1 are written out in descending order of probabilities.
2. The symbols of the resulting alphabet are divided into two parts, the total probabilities of the symbols of which are as close as possible to each other.
3. In the prefix code, the binary digit «0» is assigned to the first part of the alphabet, and «1» is assigned to the second part.
4. The resulting parts are recursively divided, and their parts are assigned the corresponding binary digits in the prefix code.

When the size of the half alphabet becomes zero or one, there is no further extension of the prefix code for the corresponding symbols of the primary alphabet, thus, the algorithm assigns prefix codes of different lengths to different symbols. There is ambiguity at the alphabet division step, since the difference of the total probabilities <i>P<sub>0</sub></i> - <i>P<sub>1</sub></i> may be the same for two variants of division (given that all characters of the primary alphabet have a probability greater than zero).

## What is implemented in the code
The Shannon-Fano encoding algorithm is implemented, as well as the decoding of the entered message. For information about the efficiency of the algorithm, data on the coincidence of encoded and decoded messages, the entropy of the original message, the average number of bits per character during encoding and the difference in the volumes of files in which the original message and the encoded message are recorded are output to the terminal.

``` matlab
  Enter a phrase: abracadabra
  [INFO] A file with the original message has been created
  [INFO] A file with a decoded message has been created
  [INFO] A file with a decoded message has been created

  [INFO] Matches of the original message and decoded 100%
  [INFO] The entropy of the message is 2.0404
  [INFO] The average number of bits per character in an encoded message is 2.9091
  [INFO] The difference in the amount of memory of the original message and the encoded one was 56 bits
```
