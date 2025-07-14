# 4KB_Mem
A 4KB Memory controller, capable of storing 32bit information in 1024 address location
The Testbench is build using SV and SV methodology, it uses mailbox for communicating with different TB component
1. Does Read/Write operation based on the request
2. Respond to requested transaction, based on Ready,Valid handshake signals.
3. Verified multiple read/write transaction
