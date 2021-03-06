close all;
clear all;
clc;

% ======== CASI NAZIONALI =========

url = 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json';
nazionale = jsondecode(urlread(url));


sizeNazionale = size(nazionale);
sizeNazionale = sizeNazionale(1);
for i = 1:sizeNazionale
    nazionale_data(i) = datetime(nazionale(i).data,'Format','dd/MM','InputFormat','yyyy-MM-dd''T''HH:mm:ss');
end
nazionale_totcasi = vertcat(nazionale.totale_positivi);
nazionale_nuoviPos = vertcat(nazionale.variazione_totale_positivi);
nazionale_totOspedalizzati = vertcat(nazionale.totale_ospedalizzati);
nazionale_terapiaIntensiva = vertcat(nazionale.terapia_intensiva);
nazionale_dimessiGuariti = vertcat(nazionale.dimessi_guariti);
nazionale_deceduti = vertcat(nazionale.deceduti);

fig = figure;
hold on;
plot (nazionale_data,nazionale_totcasi,'-o');
plot (nazionale_data, nazionale_deceduti,'-o');
plot (nazionale_data, nazionale_totOspedalizzati,'-o');
plot (nazionale_data, nazionale_terapiaIntensiva,'-o');
plot (nazionale_data, nazionale_dimessiGuariti,'-o');
legend(sprintf("Totale attualmente positivi (%i)",nazionale_totcasi(end)),sprintf("Deceduti (%i)",nazionale_deceduti(end)),sprintf("Totale Ospedalizzati (%i)",nazionale_totOspedalizzati(end)),sprintf("Terapia Intensiva (%i)",nazionale_terapiaIntensiva(end)),sprintf("Dimessi guariti (%i)",nazionale_dimessiGuariti(end)),'Location','northwest');
title ("Andamento integrale Nazionale");
xlabel('Tempo [Giorni]'); 
ylabel('Unità');
grid on;
grid minor;
hold off;


fig1 = figure;
hold on;
set(gca,'yscale','log');
semilogy (nazionale_data, nazionale_totcasi,'-o');
semilogy (nazionale_data, nazionale_deceduti,'-o');
semilogy (nazionale_data, nazionale_totOspedalizzati,'-o');
semilogy (nazionale_data, nazionale_terapiaIntensiva,'-o');
semilogy (nazionale_data, nazionale_dimessiGuariti,'-o');
legend(sprintf("Totale attualmente positivi (%i)",nazionale_totcasi(end)),sprintf("Deceduti (%i)",nazionale_deceduti(end)),sprintf("Totale Ospedalizzati (%i)",nazionale_totOspedalizzati(end)),sprintf("Terapia Intensiva (%i)",nazionale_terapiaIntensiva(end)),sprintf("Dimessi guariti (%i)",nazionale_dimessiGuariti(end)),'Location','southeast');
title ('Log Integrale Nazionale');
xlabel('Tempo [Giorni]');
ylabel('Unità');
grid on;
grid minor;
hold off;

fig2 = figure;

plot (nazionale_data, nazionale_nuoviPos,'-o');
title (sprintf('Andamento giornaliero Nazionale (%+i)', nazionale_nuoviPos(end)));
xlabel('Tempo [Giorni]');
ylabel('Unità');
legend("Totale nuovi positivi",'Location','northwest');
grid on;
grid minor;

saveas(fig,'./Grafici/Nazionale.png');
pause (1);
saveas(fig1,'./Grafici/LogNazionale.png');
saveas(fig2,'./Grafici/GioNazionale.png');


% ======== CASI REGIONALI=========

regioni = ["Valle d'Aosta","Piemonte","Liguria","Lombardia","Veneto","Friuli Venezia Giulia","Emilia-Romagna","Marche","Toscana","Umbria","Abruzzo","Molise","Lazio","Campania","Basilicata","Puglia","Calabria","Sicilia","Sardegna"];
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
        regione_data(i) = datetime(regione(i).data,'Format','dd/MM','InputFormat','yyyy-MM-dd''T''HH:mm:ss');
    end
    regione_totcasi = vertcat(regione.totale_positivi);
    regione_nuoviPos = vertcat(regione.nuovi_positivi);
    regione_totOspedalizzati = vertcat(regione.totale_ospedalizzati);
    regione_terapiaIntensiva = vertcat(regione.terapia_intensiva);
    regione_dimessiGuariti = vertcat(regione.dimessi_guariti);
    regione_deceduti = vertcat(regione.deceduti);
    
    fig1 = figure;
    subplot (2,1,1);
    hold on;
    plot (regione_data,regione_totcasi,'-o');
    plot (regione_data,regione_deceduti,'-o');
    title (sprintf('Andamento Integrale %s (%i)', target, regione_totcasi(end)));
    %xlabel('Tempo [Giorni]');
    ylabel('Unità');
    legend(sprintf("Totale attualmente positivi (%i)",regione_totcasi(end)),sprintf("Deceduti (%i)",regione_deceduti(end)),'Location','northwest');
    grid on;
    grid minor;
    
    subplot (2,1,2);
    plot (regione_data,regione_nuoviPos,'-o');
    title (sprintf('Andamento Giornaliero %s (%+i)', target, regione_nuoviPos(end)));
    xlabel('Tempo [Giorni]');
    ylabel('Unità');
    legend("Totale nuovi positivi",'Location','northwest');
    grid on;
    grid minor;
    
    fig2 = figure;
    hold on;
    plot (regione_data, regione_totOspedalizzati,'-o');
    plot (regione_data, regione_deceduti,'-o');
    plot (regione_data, regione_terapiaIntensiva,'-o');
    plot (regione_data, regione_dimessiGuariti,'-o');
    title (sprintf('Ospedalizzati %s %i (%+i) ', target, regione_totOspedalizzati(end), (regione_totOspedalizzati(end) - regione_totOspedalizzati(end-1))));
    xlabel('Tempo [Giorni]');
    ylabel('Unità');
    grid on;
    grid minor;
    legend(sprintf("Totale Ospedalizzati (%i)",regione_totOspedalizzati(end)),sprintf("Deceduti (%i)",regione_deceduti(end)),sprintf("Terapia Intensiva (%i)",regione_terapiaIntensiva(end)),sprintf("Dimessi guariti (%i)",regione_dimessiGuariti(end)),'Location','northwest');
    hold off;
    
     saveas(fig1,sprintf('./Grafici/%s.png', target));
     pause (1);
     saveas(fig2,sprintf('./Grafici/ospedalizzati%s.png', target));
end
