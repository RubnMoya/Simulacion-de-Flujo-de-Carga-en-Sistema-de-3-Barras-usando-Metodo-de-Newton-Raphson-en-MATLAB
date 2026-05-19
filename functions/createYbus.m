function Ybus=createYbus(lineData)

n=max(max(lineData(:,1:2)));

Ybus=zeros(n,n);

for k=1:size(lineData,1)

from=lineData(k,1);

to=lineData(k,2);

R=lineData(k,3);

X=lineData(k,4);

Z=R+1i*X;

Y=1/Z;

Ybus(from,from)=Ybus(from,from)+Y;

Ybus(to,to)=Ybus(to,to)+Y;

Ybus(from,to)=Ybus(from,to)-Y;

Ybus(to,from)=Ybus(to,from)-Y;

end

end