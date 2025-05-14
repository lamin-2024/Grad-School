/*****************************************************
EEDG 6306 HW2
Caleb Perez (cxp180012)
Lamin Jammeh (dal852207)
2/10/2025
*******************************************************/



#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>
#include <sstream>
#include <string>
using namespace std;

#define N 255 // FIR filter order
//#define DATA_SIZE 1000 // Number of input samples

// Function to perform power-of-two multiplication using shifts
int64_t shift_multiply(int16_t data, int32_t coeff) {
    uint16_t sign_part = (coeff >> 16) & 0xFFFF; // Extract sign part
    uint16_t shift_part = coeff & 0xFFFF;// Extract power-of-two shift part
    int64_t newData = data;
    newData = newData << 16;
    int64_t total = 0;

    for (int i = 0; i < 16; i++) {
        uint16_t sign_part_shift = sign_part >> (i);
        uint16_t shift_part_shift = shift_part >> (i);
        uint64_t negativeData = -1 * data;
        negativeData = negativeData << 16;

        if ((shift_part_shift & 1) == 1)
        {
            if ((sign_part_shift & 1) == 0) {
                total += newData;
                total = total >> 1;
            }
            else if ((sign_part_shift & 1) == 1){
                total += negativeData;
                total = total >> 1;
            }
        }
        else if ((shift_part_shift & 1) == 0) {
            total = total >> 1;
        }

    }

    return (total);
}

int main(int argc, char* argv[]) {
    string coeffInString = argv[1];
    string dataOutString = argv[3];

    //%%%%%%%%%%%%%%%%%%%%% DATA IN PARSING AND STORAGE %%%%%%%%%%%%%%%//
    ifstream dataIn(argv[2]);
    string dataInLine;
    vector<string> dataString;

    ifstream coeffIn(argv[1]);
    string coeffInLine;
    vector<string>signBitsString;
    vector<string>coeffString;
    vector<string>POTdigitsString;
    vector<int>signBits;
    vector<int>POTdigits;
    vector<int>coefficient;
    vector<int16_t>data;


    //Read in data.in//////////////////////////////////////////////////
    if (dataIn.is_open()) {
        while (getline(dataIn, dataInLine)) {
            dataString.push_back(dataInLine);
            cout << dataString.back() << endl;
        }
        dataIn.close();
    }
    else {
        std::cerr << "Error opening file!" << std::endl;
    }
    //////////////////////////////////////////////////////////////////

    //Read coeff.in///////////////////////////////////////////////////
    if (coeffIn.is_open()) {
        while (getline(coeffIn, coeffInLine)) {
            coeffString.push_back(coeffInLine);
            cout << coeffString.back() << endl;
        }
        coeffIn.close();
    }
    else {
        std::cerr << "Error opening file!" << std::endl;
    }
    /////////////////////////////////////////////////////////////////
    //%%%%%%%%%%%%% END DATA IN PARSING AND STORAGE %%%%%%%%%%%%%%%//

    ////////////////Convert Hex Strings to int///////////////////////
    for (int i = 0; i < coeffString.size(); i++) {
        coefficient.push_back(stoul(coeffString.at(i), 0, 16));
    }

    for (int i = 0; i < dataString.size(); i++) {
        data.push_back(stoi(dataString.at(i), 0, 16));
    }
    ////////////////////////////////////////////////////////////////

    vector<int64_t>dataOut(data.size(), 0);

    // Perform FIR filtering using only addition, subtraction, and shifts
    for (int n = 0; n < data.size(); ++n) {
        int64_t sum = 0;
        for (int k = 0; k <= N; ++k) {
            if (n - k >= 0) {
                sum += shift_multiply(data.at(n - k), coefficient.at(k));
            }
        }
        dataOut.at(n) = sum;
    }

    for (int i = 0; i < dataOut.size(); i++)
    {
        dataOut.at(i) = dataOut.at(i) & 0xFFFFFFFFFF;
    }
    
  // Write output results in hexadecimal format
  std::ofstream output_file(dataOutString);
  for (int n = 0; n < data.size(); ++n) {
      stringstream stream;
      stream << hex << dataOut.at(n);
      //string result(stream.str());
      if (stream.str().length() != 10) {
          for (int i = stream.str().length(); i < 10; i++) {
              output_file << 0;
          }
      }
      output_file << stream.str() << std::endl;
  }

  output_file.close();

    std::cout << "FIR filtering complete. Results saved to output.txt" << std::endl;
    return 0;
}