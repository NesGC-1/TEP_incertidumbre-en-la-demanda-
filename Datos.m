%Datos generales del sistema:
Ngen=length(mpc.gen(:,1));
NLin=length(mpc.branch(:,1));
Nbus=length(mpc.bus(:,1));
Tipo_bus=mpc.bus(:,2);
Fbus=mpc.branch(:,1);
Tbus=mpc.branch(:,2);
dpico=mpc.bus(:,3); %Buses que tienen carga
MVAbase=mpc.baseMVA;

%Para las perdidas
RLine=diag(mpc.branch(:,3));   % Resistencia de lineas
XLine=diag(mpc.branch(:,4));   % Reactancia de lineas

B=inv(XLine);
G=inv(RLine);

%Nodo Slack:
Slack=find(Tipo_bus==3);

%Datos de los generadores:
PMax=mpc.gen(:,9);
PMin=mpc.gen(:,10);
Oferta=mpc.gencost(:,6);

%Datos de las líneas:
X=diag(mpc.branch(:,4));
Limite=mpc.branch(:,6);
Linea=[1:NLin]';

%Número de escenarios
S=mpc.NoScenarios;

%Peso de cada escenario (Probabilidad)
p=mpc.scenario(:,3);

%Matriz de generación en los buses:         
Busgen=mpc.gen(:,1);
Mgen=zeros(Nbus,Ngen);
for R=1:Nbus
    for i=1:Ngen
        if Busgen(i)==R
            Mgen(R,i)=1;
        end
    end
end
PGs=[]; %Escenarios de generación
    k=0;
    l=0;
    for s=1:S
        for i=1:size(Mgen,1)
            for j=1:size(Mgen,2)
                PGs(i+k,j+l)=Mgen(i,j);
            end
        end
        k=k+size(Mgen,1);
        l=l+size(Mgen,2);
    end

%Costo de generación en cada escenario
GenCs=[];
for i=1:S
    GenCs=[GenCs; p(i).*mpc.gencost(:,6)];
end

