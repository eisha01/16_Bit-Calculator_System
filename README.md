# 16_Bit-Calculator_System
Our program is implemented using Emulator emu8086. The program is designed in Assembly language.
# Theory:
We have designed a program that simulates the operation of a 16-bit calculator system. It can
take up to 4-digits as input and display an answer with a maximum of four digits as we have
used 16-bit registers in our code. Our calculator performs the following unsigned mathematical
operations:
 Addition (+): It takes two numbers as input, stores them in a register, and produces
their sum after applying the “add” operation on them.
 Subtraction (-): It takes two numbers as input, stores them in a register, and produces
their difference after applying the “sub” operation on them.
 Multiplication (*): It takes two numbers as input and produces their product by
multiplying num2 with num1 stored in a register using the “imul” operation.
 Division (/): It takes two numbers as input and produces their quotient by dividing
num2 with num1 stored in a register using the “idiv” operation.
 Power Function (^): It takes two numbers as input; the first number is the base, and the
second number is the exponent, and then it multiplies the exponent with the base in a
loop.
 Factorial Function (!): It takes a single number as input which you store into the
counter register, decrements it, and multiply it using the loop until the counter is not
equal to zero.
 Modulus Function (%): It takes two numbers as inputs, stores them in a register,
divides them using the “div” operation, and displays its remainder, which is the mod.

# Implementation:
Our program is implemented using Emulator emu8086. The program is designed in Assembly
language. It is assembled, emulated, and run on emu8086. We have designed a separate
subroutine for each operation.
The program is divided into several modules, and each module is designed as a separate
subroutine where the complete calculator program will have distinct subroutines for every
single operation, subroutines for inputting and outputting the data, and subroutines to set flags
in our data for checking if the number is not too big or to check the signs of the values or to
wait for the user to press any key to stop the program and return control to the operating
system and so on.
Our program is implemented using Emulator emu8086. The program is designed in Assembly
language. It is assembled, emulated, and run on emu8086. We have designed a separate
subroutine for each operation.
The program is divided into several modules, and each module is designed as a separate
subroutine where the complete calculator program will have distinct subroutines for every
single operation, subroutines for inputting and outputting the data, and subroutines to set flags
in our data for checking if the number is not too big or to check the signs of the values or to
wait for the user to press any key to stop the program and return control to the operating
system and so on.
