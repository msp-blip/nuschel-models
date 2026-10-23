Sprachmodelle für Nuschel, als Ausweichquelle für Firmennetze, die die erste Quelle sperren. Die App prüft jede Datei mit der eingebauten SHA-256-Prüfsumme; eine veränderte Datei wird abgelehnt.

Speech and language models for Nuschel, a fallback source for company networks that block the first one. The app checks every file against its built-in SHA-256 and refuses any other file.

- `ggml-large-v3-turbo-q5_0.bin`: Whisper large-v3-turbo (OpenAI), ggml format by the whisper.cpp project, MIT License
- `ggml-small-q5_1.bin`: Whisper small (OpenAI), ggml format by the whisper.cpp project, MIT License
- `gemma-4-E2B-it-Q4_0.gguf` (in two parts, joined by the app): Gemma 4 E2B (Google), GGUF by ggml-org, Apache License 2.0

The files are unchanged copies of the sources listed in `models.json`.
- `parakeet-tdt-0.6b-v3-encoder.int8.onnx`: encoder of NVIDIA Parakeet TDT 0.6B v3 (CC-BY-4.0), int8 ONNX export by the sherpa-onnx project (Apache-2.0)
