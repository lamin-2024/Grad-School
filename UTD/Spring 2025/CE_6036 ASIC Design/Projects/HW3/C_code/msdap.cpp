#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>
#include <sstream>
#include <string>
#include <bitset>
using namespace std;

static void readIn(vector<uint16_t> &vector, string filePath) {
    ifstream stream(filePath);
    if (stream.is_open()) {
        string inLine;
        while (getline(stream, inLine)) {
            vector.push_back(stoi(inLine, 0, 16));
        }
        stream.close();
    }
    else {
        std::cerr << "Error opening file!" << std::endl;
    }
}

static void readIn(vector<uint8_t>& vector, string filePath) {
    ifstream stream(filePath);
    if (stream.is_open()) {
        string inLine;
        while (getline(stream, inLine)) {
            vector.push_back(stoi(inLine, 0, 16));
        }
        stream.close();
    }
    else {
        std::cerr << "Error opening file!" << std::endl;
    }
}

static void readIn(vector<int16_t>& vector, string filePath) {
    ifstream stream(filePath);
    if (stream.is_open()) {
        string inLine;
        while (getline(stream, inLine)) {
            vector.push_back(stoi(inLine, 0, 16));
        }
        stream.close();
    }
    else {
        std::cerr << "Error opening file!" << std::endl;
    }
}

int main(int argc, char* argv[]) {

    string coeffInFP = argv[1];
    string RjInFP = argv[2];
    string dataInFP = argv[3];
    string dataOutFP = argv[4];

    vector<uint16_t>coeff;
    vector<uint8_t>Rj;
    vector<int16_t>dataIn;
    vector<int64_t>dataOut;

    readIn(coeff, coeffInFP);
    readIn(Rj, RjInFP);
    readIn(dataIn, dataInFP);

    //DataIn
    for (int n = 0; n < dataIn.size(); ++n) {
        int64_t sum = 0;
        int64_t x2 = dataIn.at(n) << 16;
        int lastcoeff = 0;
        int offset = 0;
        //Rj Parse per DataIn
        for (int i = 0; i < Rj.size(); i++) {
            //Coeff Parse per RJ.
            uint8_t Rjcurr = Rj.at(i);
            sum = sum >> 1;
            //cout << "shi" << bitset<64>(sum).to_string() << endl;
            for (; lastcoeff < Rjcurr + offset; lastcoeff++) {
                uint16_t coeffCurr = coeff.at(lastcoeff);
                uint16_t N = coeffCurr & 0x00FF;
                int index = n - N;
                if ((index) >= 0 )
                {
                    if ((coeffCurr & 0x0100) == 0x0100) {
                        //int64_t subtract = static_cast<int64_t>(-x2);
                        int64_t subtract = -(dataIn.at(index) << 16);
                        //cout << "sub" << bitset<64>(subtract).to_string() << endl;
                        sum += subtract;
                    }
                    else if ((coeffCurr & 0x0100) == 0x0000) {
                        //int64_t add = x2;
                        int64_t add = (dataIn.at(index) << 16);
                        //cout << "add" << bitset<64>(add).to_string() << endl;
                        sum += add;
                    }
                }
            }
            //sum = sum >> 1;
            
            offset = lastcoeff;
        }
        sum = sum >> 1;
        dataOut.push_back(sum);
        //cout << bitset<64>(dataOut.back()).to_string() << endl;
    }

    //OUTPUTS
    for (int i = 0; i < dataOut.size(); i++)
    {
        dataOut.at(i) = dataOut.at(i) & 0xFFFFFFFFFF;
    }

    // Write output results in hexadecimal format
    std::ofstream output_file(dataOutFP);
    for (int n = 0; n < dataOut.size(); ++n) {
        stringstream stream;
        stream << hex << dataOut.at(n);
        //string result(stream.str());
        if (stream.str().length() != 10) {
            for (int i = stream.str().length(); i < 10; i++) {
                output_file << 0;
            }
        }

        string output = stream.str();

        for (int i = 0; i < output.length(); i++)
            output[i] = toupper(output[i]);

        output_file << output << std::endl; 
    }

    output_file.close();
    cout << "Convolution Successful" << endl;
}
