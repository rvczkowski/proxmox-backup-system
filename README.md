
# Proxmox Backup System

Prosty skrypt automatycznego tworzenia backupów wirtualnych maszyn i ich przywracania.

## backup.sh

Pętla while z statycznie określonymi identyfikatorami w zmiennej, która usuwa poprzednią kopię zapasową

Proces działania:
- Przejście do katalogu kopii zapasowych
- Usunięcie poprzedniej kopii zapasowej
- Przekazanie informacji o rozpoczęciu procesu
- Proces tworzenia
- Weryfikacja po stworzeniu
- - Jeśli pozytywna: Przekazywana informacja o pomyślnym zakończeniu
- - Jeśli negatywna: Przekazywana informacja o negatywnym zakończeniu

Informacja idzie poleceniem curl webhookiem na kanale Discord 


## restoring.sh

Pętla while z statycznie określonymi identyfikatorami w zmiennej

Proces działania:
- Polecenie ping sprawdzające połączenie
- - Jeśli pozytywny - zakończenie procesu
- - Jeśli negatywny - przywracanie kopii zapasowej

Proces przywracania kopii zapasowej:

- Przejście do katalogu kopii zapasowych
- Wywołanie polecenia przywracania kopii zapasowej na id o 100 większe od maszyny produkcyjnej
- Wyłączenie maszyny produkcyjnej
- Włączenie maszyny kopii zapasowej
- Weryfikacja po zakończeniu procesu przywracania
- - Jeśli pozytywna: Przekazywana informacja o awarii i aktywacji maszyny zapasowej
- - Jeśli negatywna: Przekazywana informacja o awarii i niepowodzeniu aktywacji maszyny

Informacja idzie poleceniem curl webhookiem na kanale Discord 

## Autorzy

- [@rvczkowski](https://github.com/rvczkowski)

