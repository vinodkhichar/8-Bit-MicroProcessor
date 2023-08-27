#include <iostream>
#include <string>

using namespace std;
// typedef long long ll;
// ifstream read;
void hexatobcd(string s)
{
    if (s == "0")
        cout << "0000";
    else if (s == "1")
        cout << "0001";
    else if (s == "2")
        cout << "0010";
    else if (s == "3")
        cout << "0011";
    else if (s == "4")
        cout << "0100";
    else if (s == "5")
        cout << "0101";
    else if (s == "6")
        cout << "0110";
    else if (s == "7")
        cout << "0111";
    else if (s == "8")
        cout << "1000";
    else if (s == "9")
        cout << "1001";
    else if (s == "A")
        cout << "1010";
    else if (s == "B")
        cout << "1011";
    else if (s == "C")
        cout << "1100";
    else if (s == "D")
        cout << "1101";
    else if (s == "E")
        cout << "1110";
    else if (s == "F")
        cout << "1111";
}

void hexatobcdreg(string s)
{
    if (s == "0")
        cout << "00";
    else if (s == "1")
        cout << "01";
    else if (s == "2")
        cout << "10";
    else if (s == "3")
        cout << "11";
}

void alphabet(string reg)
{
    if (reg == "A")
        cout << "00";
    if (reg == "B")
        cout << "01";
    if (reg == "C")
        cout << "10";
    if (reg == "D")
        cout << "11";
}

int main()
{
    // read.open("C:\newfolder\tb.txt");

    freopen("input.txt", "r", stdin);
    freopen("tb_processor.v", "w+", stdout);

    
        cout << "`timescale 1ns/1ps\n";       
        cout << "module tb_cpu;\n"  ;
        cout << "reg clk,reset, ins_write, ins_read, mem_read_tb;\n";
        cout << "reg[7:0] machine_code, mem_write_data_tb;\n";
        cout << "reg[3:0] access_addr_tb;\n";
        cout << "wire[7:0] alu_result, flag, instruction_out, pc, mem_read_data;\n";
        cout << "wire[31:0] register;\n";
        cout << "integer i;\n";
        cout << "\n";
        cout << "  CPU C(.clk(clk), .reset(reset), .alu_result(alu_result), .flag(flag), .instruction_write_data(machine_code),\n";
        cout << "         .instruction(instruction_out), .pc(pc), .ins_write(ins_write), .ins_read(ins_read), .register(register),\n";
        cout << "         .mem_write_data_tb(mem_write_data_tb), .access_addr_tb(access_addr_tb),\n";
        cout << "         .mem_read_data(mem_read_data), .mem_read_tb(mem_read_tb));\n";
        cout << "initial     \n";
        cout << " begin\n";
        cout << "  $dumpfile(\"dump.vcd\");    \n";
        cout << "  $dumpvars(1,tb_cpu);   \n";
        cout << "end                      \n";
        cout << "\n";
        cout << "initial   \n";
        cout << " begin\n";
        cout << "  clk = 0; ins_write=1; access_addr_tb = 4'H0; mem_write_data_tb = 8'H00;\n";
        cout << "forever\n";
        cout << "    begin\n";
        cout << "     #1 clk = 0;\n";
        cout << "     #1 clk = 1;\n";
        cout << "    end\n";
        cout << " end  \n";
        cout << "\n";
        cout << "\n";
        cout << "initial \n";
        cout << "begin \n";
        cout << "    #1\n";

    string s;
    while (getline(cin, s))
    {
        if(s[0] == '#'){
            cout<<"\t#2 access_addr_tb = 4'H"<<s[1]<<";";
            cout<<" mem_write_data_tb = 8'H"<<s.substr(3,2)<<";"<<endl;
            continue;
        }

        // string s;
        // getline(cin, s);
        // cout << s << endl;
        cout << "\t";
        string opcode;
        for (int i = 0; i < s.size(); i++)
        {
            if (s[i] == ' ')
                break;
            else
                opcode += s[i];
        }
        // operand(opcode);
        cout << "#2 machine_code = 8'b";
        if (opcode == "LD")
        {
            cout << "0000";
            string al = s.substr(3, 1);
            hexatobcd(al);
            // cout << endl;
        }

        else if (opcode == "ST")
        {
            cout << "0001";
            string al = s.substr(3, 1);
            hexatobcd(al);
            // cout << endl;
        }

        else if (opcode == "MR")
        {
            cout << "0011";
            alphabet(s.substr(3, 1));
            alphabet(s.substr(5, 1));
            // cout << endl;
        }

        else if (opcode == "MI")
        {
            cout << "0010";
            string pb = s.substr(3, 1);
            alphabet(pb);
            string al = s.substr(5, 1);
            hexatobcdreg(al);
            // cout << endl;
        }

        else if (opcode == "SUM")
        {
            cout << "0100";
            alphabet(s.substr(4, 1));
            alphabet(s.substr(6, 1));
            // cout << endl;
        }

        else if (opcode == "SMI")
        {
            cout << "1100";
            string pb = s.substr(4, 1);
            alphabet(pb);
            string al = s.substr(6, 1);
            hexatobcdreg(al);
            // cout << endl;
        }

        else if (opcode == "SB")
        {
            cout << "0101";
            alphabet(s.substr(3, 1));
            alphabet(s.substr(5, 1));
            // cout << endl;
        }

        else if (opcode == "SBI")
        {
            cout << "1101";
            string pb = s.substr(4, 1);
            alphabet(pb);
            string al = s.substr(6, 1);
            hexatobcdreg(al);
            // cout << endl;
        }

        else if (opcode == "CM")
        {
            cout << "0111";
            alphabet(s.substr(3, 1));
            alphabet(s.substr(5, 1));
            // cout << endl;
        }

        else if (opcode == "CMI")
        {
            cout << "1111";
            string pb = s.substr(4, 1);
            alphabet(pb);
            string al = s.substr(6, 1);
            hexatobcdreg(al);
            // cout << endl;
        }
        else if (opcode == "ANR")
        {
            cout << "0110";
            alphabet(s.substr(4, 1));
            alphabet(s.substr(6, 1));
            // cout << endl;
        }

        else if (opcode == "ANI")
        {
            cout << "1110";
            string pb = s.substr(4, 1);
            alphabet(pb);
            string al = s.substr(6, 1);
            hexatobcdreg(al);
            // cout << endl;
        }

        else if (opcode == "ORR")
        {
            cout << "1000";
            alphabet(s.substr(4, 1));
            alphabet(s.substr(6, 1));
            // cout << endl;
        }

        else if (opcode == "ORI")
        {
            cout << "1001";
            string pb = s.substr(4, 1);
            alphabet(pb);
            string al = s.substr(6, 1);
            hexatobcdreg(al);
            // cout << endl;
        }

        else if (opcode == "XRR")
        {
            cout << "1010";
            alphabet(s.substr(4, 1));
            alphabet(s.substr(6, 1));
            // cout << endl;
        }

        else if (opcode == "XRI")
        {
            cout << "1011";
            string pb = s.substr(4, 1);
            alphabet(pb);
            string al = s.substr(6, 1);
            hexatobcdreg(al);
            
        }

        cout << ";" << endl;

    }
    cout << "    #2\n";
    cout << "    #2 ins_write = 0; ins_read = 1; reset = 1;\n";
    cout << "    #0.1 reset = 0; \n";
    cout << "end\n";
    cout << "\n";
    cout << "initial \n";
    cout << " begin   \n";
    cout << "   $monitor($time,\" %b %b %b  A=%b, B=%b, C=%b, D=%b, Flag=%d\", pc, instruction_out, alu_result,\n";
    cout << "   register[7:0], register[15:8], register[23:16], register[31:24], flag\n";
    cout << "   );\n";
    cout << " end\n";
    cout << "  \n";
    cout << " initial begin #51 reset = 1; mem_read_tb = 1; access_addr_tb = 4'H0;\n";
    cout << " for(i=0; i<18; i=i+1) begin\n";
    cout << "  $display(\"\t%d \t%H\",access_addr_tb, mem_read_data);\n";
    cout << "  #2 access_addr_tb <= access_addr_tb + 1; \n";
    cout << "  end\n";
    cout << " end\n";

    cout << " initial #90 $finish;\n";
    cout << "endmodule\n";
}