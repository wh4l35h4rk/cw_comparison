# cw_comparison
скрипты к нпк.

чтобы работало, нужно, чтобы:
- PLOT_COMPARISON.m лежал в одной директории с RAMs;
- всё остальное лежало в её субдиректории (напр. project).

в субдиректории project также должны быть:
- файл, из которого будет делаться батиметрия;
- субсубдиректория с сэмплами гидрологии;
- файлы bottom.txt и MainRAMS.txt - для RAMs.

## как этим пользоваться?

+ создаём структуру проекта (см. выше);
+ в prepare_for_RAMS.m выбираем файл, для которого будем строить TL;
+ запускаем prepare_for_RAMS.m, получаем батиметрию и папку гидрологии для выбранного файла;
+ из директории с RAMs запускаем PLOT_COMPARISON.M;

  
