%TEP estocástico V.2
%Daniel Ernesto Hernández Reyes
clc
clear all
%% Carga de datos del problema
%mpc=case3;
mpc=Garver;
Datos;

%%%Genera escenarios 

T=1;

for t=1:T
%Demandas
    Demanda=[];
    for i=1:Nbus
        d=mpc.scenario(mpc.scenario(:,2)==i,4+t-1);
        if dpico(i)~=0
            Demanda=[Demanda dpico(i).*d];
        else
            Demanda=[Demanda zeros(S,1)];
        end
    end
    Demanda=reshape(Demanda',[],1)


    %%%%%% corre el TEP 
    Pd=Demanda;

     %% Resolución del modelo MILP
    options=optimoptions('intlinprog');
    [Results,fval,exitflag,output] = intlinprog (FTEP,intcon,AineqTEP,...
        BineqTEP, AeqTEP, BeqTEP, LBTEP, UBTEP, options );
    
    %% Cambio de líneas invertidas
    for i=1:NLN
        if Results(S*(Ngen+NLE+NLN+Nbus)+i)==1
            mpc.branch(NLE+i,13)=0;
        end
    end

%% Presentación de resultados
    fprintf('Periodo T = %d\n',t)
    Generacion =Results(1:Ngen*S);
    k=0;
    for s=1:S
        fprintf('Generacion Escenario %d',s)
        Generacion(1+Ngen*k:Ngen+Ngen*k)
        k=k+1;
    end
    Flujos=Results(Ngen*S+1:S*(NLE+NLN)+Ngen*S);
    k=0;
    for s=1:S
        fprintf('Flujos Escenario %d',s)
        fprintf('\nLíneas existentes')
        Flujos(1+NLE*k:NLE+NLE*k)
        fprintf('Líneas nuevas')
        Flujos(NLE*S+1+NLN*k:NLE*S+NLN+NLN*k)
        k=k+1;
    end
    CostoTotal=fval
    CostoInversion=sum(Results(S*(Ngen+NLE+NLN+Nbus)+1:end).*mpc.branch(NLE+1:end,12))
    Invertir=[mpc.branch(NLE+1:end,1:2) Results(S*(Ngen+NLE+NLN+Nbus)+1:end)]
end