module ready_ff(set,reset,rdyq);
input set,reset;
output rdyq;
reg rdyq;

always@(negedge set,negedge reset)
begin
if(~reset)
rdyq= 1'b0;
else
if(~set)
rdyq=1'b1;
end