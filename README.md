# nuschel-models

Öffentliche Ablage der Sprachmodelle für die Diktier-App Nuschel. Hier liegen nur Modelldateien und das Skript,
das sie prüft und hochlädt; der Code der App liegt nicht hier.

- `models.json`: Quelle, Größe und SHA-256 jedes Modells (dieselben Werte, die die App eingebaut hat)
- `mirror.sh`: lädt jedes Modell von seiner Quelle, prüft die SHA-256, lädt es in das Release `models-v1` hoch
  (über 1,9 GB in Teilen) und prüft die öffentliche Kopie noch einmal
- Lizenzen und Herkunft: siehe `NOTICE.md`
