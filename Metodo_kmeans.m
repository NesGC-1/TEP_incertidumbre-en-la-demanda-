%Este programa agrupa los datos por medio del método de kmeans
clc
clear all
rng('default')

%Carga de datos
datos=xlsread('2016-hourly-loads.xls','SOUTH','D2:AA367');
numDatos=numel(datos); %Número total de datos
%Gráfica anual
figure(1)
plot(reshape(datos',1,[]))
title('Curva de demanda anual')
xlabel('Horas')
ylabel('Potencia [W]')

%Gráficas diarias
figure(2)
plot(datos')
title('Curvas de demandas diarias')
xlabel('Horas')
ylabel('Potencia [W]')

%Normalización de la demanda
pico=max(datos(:)) %Demanda pico o máxima
datosN=(1/pico).*datos; %Datos normalizados
figure(3)
plot(datosN')
title('Curvas de demandas normalizadas')
xlabel('Horas')
ylabel('Potencia unitaria')

%Normalización del tiempo (periodos)
% NumPeriodos=size(datos,2);
% p=(1/NumPeriodos):(1/NumPeriodos):(NumPeriodos/NumPeriodos);

%Implementación de kmeans
%Para 5 escenarios
k1=2; %5
[idx1,C1,sumd1]=kmeans(datosN,k1,'Replicates',5,'Display','final');
figure(4)
plot(C1')
title('Método k-means, k=5')
xlabel('Horas')
ylabel('Potencia unitaria')
numDatosxCluster1=zeros(k1,1);
for i=1:size(idx1,1)
    for j=1:k1
        if idx1(i)==j
            numDatosxCluster1(j)=numDatosxCluster1(j)+1;
        end
    end
end
w1=numDatosxCluster1/size(datos,1); %Peso de cada escenario

% %Para 10 escenarios
% k2=10
% [idx2,C2,sumd2]=kmeans(datosN,k2,'Replicates',5,'Display','final');
% figure(5)
% plot(C2')
% title('Método k-means, k=10')
% xlabel('Horas')
% ylabel('Potencia unitaria')
% numDatosxCluster2=zeros(k2,1);
% for i=1:size(idx2,1)
%     for j=1:k2
%         if idx2(i)==j
%             numDatosxCluster2(j)=numDatosxCluster2(j)+1;
%         end
%     end
% end
% w2=numDatosxCluster2/size(datos,1); %Peso de cada escenario
% 
% %Para 50 escenarios
% k3=50
% [idx3,C3,sumd3]=kmeans(datosN,k3,'Replicates',5,'Display','final');
% figure(6)
% plot(C3')
% title('Método k-means, k=50')
% xlabel('Horas')
% ylabel('Potencia unitaria')
% numDatosxCluster3=zeros(k3,1);
% for i=1:size(idx3,1)
%     for j=1:k3
%         if idx3(i)==j
%             numDatosxCluster3(j)=numDatosxCluster3(j)+1;
%         end
%     end
% end
% w3=numDatosxCluster3/size(datos,1); %Peso de cada escenario
% 
% %Para 100 escenarios
% k4=100
% [idx4,C4,sumd4]=kmeans(datosN,k4,'Replicates',5,'Display','final');
% figure(7)
% plot(C4')
% title('Método k-means, k=100')
% xlabel('Horas')
% ylabel('Potencia unitaria')
% numDatosxCluster4=zeros(k4,1);
% for i=1:size(idx4,1)
%     for j=1:k4
%         if idx4(i)==j
%             numDatosxCluster4(j)=numDatosxCluster4(j)+1;
%         end
%     end
% end
% w4=numDatosxCluster4/size(datos,1); %Peso de cada escenario