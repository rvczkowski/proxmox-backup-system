# Proxmox Backup System

Prosty skrypt automatycznego tworzenia backupów wirtualnych maszyn i ich przywracania.

## Changelog

- Dodano funkcję i ograniczono ilość kodu
- Dodano automatyczne generowanie do tablic identyfikatorów wirtualnych maszyn
- Dodano plik config.sh z statycznymi zmiennymi oraz innymi opcjami
- Przekształcono backup.sh oraz restore.sh
- Zmieniono formę weryfikowania działania serwera na polecenie qm status

## backup.sh

Pętla for z dynamicznie generowanymi do tablicy identyfikatorami

Proces działania:
- Przejście do katalogu kopii zapasowych
- Usunięcie poprzedniej kopii zapasowej
- Przekazanie informacji o inicjalizacji procesu
- Proces tworzenia
- Weryfikacja po stworzeniu
- - Jeśli pozytywna: Przekazywana informacja o pomyślnym zakończeniu
- - Jeśli negatywna: Przekazywana informacja o negatywnym zakończeniu

Informacja idzie poleceniem curl webhookiem na określonym komunikatorze 


## restore.sh

Pętla for z dynamicznie generowanymi do tablicy identyfikatorami

Proces działania:
- Polecenie qm status id_serwera sprawdzające status działania serwera
- - Jeśli pozytywny - zakończenie procesu
- - Jeśli negatywny - przywracanie kopii zapasowej

Proces przywracania kopii zapasowej:

- Przejście do katalogu kopii zapasowych
- Wywołanie polecenia przywracania kopii zapasowej na id z dodatkową cyfrą 1 w porównaniu do maszyny produkcyjnej
- Wyłączenie maszyny produkcyjnej
- Włączenie maszyny kopii zapasowej
- Weryfikacja po zakończeniu procesu przywracania
- - Jeśli pozytywna: Przekazywana informacja o awarii i aktywacji maszyny zapasowej
- - Jeśli negatywna: Przekazywana informacja o awarii i niepowodzeniu aktywacji maszyny

Informacja idzie poleceniem curl webhookiem na określonym komunikatorze 

## Autorzy

- [@rvczkowski](https://github.com/rvczkowski)

