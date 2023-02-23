% Graphical Method
clc;
clear;
C=[3 2]
A=[2 4;3 5 ]
b=[8;15]
X1=[0:1:max(b)]
X21=(b(1)-A(1,1)*X1)/A(1,2)
X22=(b(2)-A(2,1)*X1)/A(2,2)

X21=max(0,X21)
X22=max(0,X22)

plot(X1,X21,'r',X1,X22,'g')
xlabel('X1')
ylabel('X2')
legend('Constraint1','Constraint2')
hold on

CX1=find(X1==0)
C1=find(X21==0)
C2=find(X22==0)

line1=[X1([CX1,C1]);X21([CX1,C1])]'
line2=[X1([CX1,C2]);X22([CX1,C2])]'

uniq=unique([line1;line2],'rows')

pt=[ ]
for i=1:size(A,1)
    A1=A(i,:)
    B1=b(i,:)
    for j=i+1:size(A,1)
        A2=A(j,:)
        B2=b(j,:)
        A4=[A1;A2]
        B4=[B1;B2]
        X=A4\B4
        pt=[pt   X]
    end 
end 
pt=pt'
alpts=[uniq ; pt]
points=unique(alpts,'rows')

plot(points(:,1),points(:,2),'o')
hold on

for i=1:size(points,1)
    const1(i)=A(1,1)*points(i,1)+A(1,2)*points(i,2)-b(1)
    const2(i)=A(2,1)*points(i,1)+A(2,2)*points(i,2)-b(2)
end
S1=find(const1<0)
S2=find(const2<0)
S=unique([S1,S2])


points(S,:)=[]
S3=find(points(:,1)<0)
S4=find(points(:,2)<0)
S=unique([S3,S4])

points(S,:)=[]
values=points*C'
table=[points ,values]
[obj,index]=max(values)
x1=points(index,1)
x2=points(index,2)
obj
fprintf('Maximum value of Objective function is at (%d,%d) = %d',x1,x2,obj) 
[obj,index]=min(values)
x1=points(index,1)
x2=points(index,2)
obj
fprintf('Minimum value of Objective function is at (%d,%d) = %d',x1,x2,obj)
