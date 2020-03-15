close all;
clear all;
clc;

% ======== CASI NAZIONALI =========

url = 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json';
nazionale = jsondecode(urlread(url));


sizeNazionale = size(nazionale);
sizeNazionale = sizeNazionale(1);
for i = 1:sizeNazionale
    nazionale_data(i) = datetime(nazionale(i).data,'Format','dd/MM','InputFormat','yyyy-MM-dd HH:mm:ss');
end
nazionale_totcasi = vertcat(nazionale.totale_attualmente_positivi);
nazionale_nuoviPos = vertcat(nazionale.nuovi_attualmente_positivi);
nazionale_totOspedalizzati = vertcat(nazionale.totale_ospedalizzati);
nazionale_terapiaIntensiva = vertcat(nazionale.terapia_intensiva);
nazionale_dimessiGuariti = vertcat(nazionale.dimessi_guariti);
nazionale_deceduti = vertcat(nazionale.deceduti);

fig = figure;
hold on
plot (nazionale_data,nazionale_totcasi,'-o')
plot (nazionale_data, nazionale_totOspedalizzati,'-o')
plot (nazionale_data, nazionale_terapiaIntensiva,'-o')
plot (nazionale_data, nazionale_dimessiGuariti,'-o')
legend("Totale attualmente positivi","Totale Ospedalizzati","Terapia Intensiva","Dimessi guariti",'Location','northwest')
title ('Andamento integrale Nazionale')
%xlabel('Tempo [Giorni]') 
ylabel('Unità')
grid on
grid minor
hold off


fig1 = figure;

semilogy (nazionale_data, nazionale_totcasi,'-o')
hold on
semilogy (nazionale_data, nazionale_deceduti,'-o')
legend("Totale attualmente positivi","Deceduti",'Location','southeast')
title ('Log Integrale Nazionale')
xlabel('Tempo [Giorni]') 
ylabel('Unità')
grid on
grid minor
hold off

fig2 = figure;

plot (nazionale_data, nazionale_nuoviPos,'-o')
title ('Andamento giornaliero Nazionale')
xlabel('Tempo [Giorni]') 
ylabel('Unità')
grid on
grid minor

saveas(fig,'Nazionale.bmp');
pause (1)
saveas(fig1,'LogNazionale.bmp');
saveas(fig2,'GioNazionale.bmp');


% ======== CASI REGIONALI=========

regioni = ["Valle d'Aosta","Lombardia","Emilia Romagna","Veneto","Marche","Toscana","Abruzzo","Lazio","Campania","Puglia","Calabria","Sicilia","Sardegna"];
dim = size(regioni);
dim = dim(2);

url = 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json';
matrice = jsondecode(urlread(url));

for i = 1:dim
    close all;
    target = regioni (i);
    matrice = jsondecode(urlread(url));
    regione = matrice(strcmp({matrice.denominazione_regione}, target));
    
    sizeRegione = size(regione);
    sizeRegione = sizeRegione(1);
    for i = 1:sizeRegione
        regione_data(i) = datetime(regione(i).data,'Format','dd/MM','InputFormat','yyyy-MM-dd HH:mm:ss');
    end
    regione_totcasi = vertcat(regione.totale_casi);
    regione_nuoviPos = vertcat(regione.nuovi_attualmente_positivi);
    regione_totOspedalizzati = vertcat(regione.totale_ospedalizzati);
    regione_terapiaIntensiva = vertcat(regione.terapia_intensiva);
    regione_dimessiGuariti = vertcat(regione.dimessi_guariti);
    regione_deceduti = vertcat(regione.deceduti);
    
    fig1 = figure;
    subplot (2,1,1)
    plot (regione_data,regione_totcasi,'-o')
    title (sprintf('Andamento Integrale %s ', target))
    %xlabel('Tempo [Giorni]')
    ylabel('Unità')
    grid on
    grid minor
    
    subplot (2,1,2)
    plot (regione_data,regione_nuoviPos,'-o')
    title (sprintf('Andamento Giornaliero %s ', target))
    xlabel('Tempo [Giorni]')
    ylabel('Unità')
    grid on
    grid minor
    
    fig2 = figure;
    hold on
    plot (regione_data, regione_totOspedalizzati,'-o')
    plot (regione_data, regione_terapiaIntensiva,'-o')
    plot (regione_data, regione_dimessiGuariti,'-o')
    plot (regione_data, regione_deceduti,'-o')
    title (sprintf('Ospedalizzati %s ', target))
    xlabel('Tempo [Giorni]')
    ylabel('Unità')
    grid on
    grid minor
    legend("Totale Ospedalizzati","Terapia Intensiva","Dimessi guariti","Deceduti",'Location','northwest')
    hold off
    
    saveas(fig1,sprintf('%s.bmp', target));
    pause (1);
    saveas(fig2,sprintf('ospedalizzati%s.bmp', target));
end
