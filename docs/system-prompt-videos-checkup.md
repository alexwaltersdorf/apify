# System Prompt — Vídeos 30s | Campanha Check-up Total Quality

Prompt-mestre para geração dos vídeos cinematográficos da campanha (Meta Ads, 9:16).
Modelo: **Seedance 2.0** (multi-shot, consistência de personagem por referência, som ambiente nativo).
Cada vídeo de 30s = 2 gerações de 15s (2 cenas cada) + concatenação.

---

## SYSTEM PROMPT (base comum a todas as cenas)

> Cinematic healthcare commercial, vertical 9:16, shot on 35mm lens, shallow depth of field,
> photorealistic, high production value. Natural soft lighting evolving from neutral morning tones
> to warm golden hour across the narrative. Teal-and-warm color grade. Smooth professional camera
> movement only (slow dolly-in, rack focus, steadicam follow, crane up). Realistic Brazilian
> middle-class settings. **No text, no captions, no logos, no on-screen graphics. No dialogue.**
> Subtle ambient sound only. Emotional register: understated, warm, hopeful — never dramatic,
> never fearful, never clinical-cold. The final scene must always deliver the emotional reward:
> the feeling of well-being, lightness and quiet satisfaction of someone who took care of their
> health — quality of life as the payoff.

**Regras fixas (compliance CFM 2.336/2023):**
- NUNCA mostrar procedimento, agulha, coleta ou exame em andamento — apenas chegada, recepção e cumprimento.
- NUNCA expressão de dor, medo ou preocupação grave — apenas reflexão leve que se resolve em alívio.
- Sem texto na tela (identificação da clínica e CTA ficam na legenda do anúncio e no perfil).

**Arco narrativo obrigatório (4 cenas × ~7,5s): Rotina → Decisão → Cuidado → Recompensa.**
A "recompensa" é sempre a cena final: golden hour, respiração profunda, sorriso contido,
movimento de câmera ascendente (crane/jib up) + lens flare suave — a gramática visual de
satisfação e dever cumprido.

---

## VÍDEO A — "Quando foi seu último check-up?" (dor leve → recompensa)

**Protagonista:** "Carlos", homem brasileiro de 55 anos, cabelo grisalho, barba aparada,
camisa azul-clara casual (referência de personagem gerada previamente).

| Cena | Duração | Prompt | Câmera |
|---|---|---|---|
| 1 — Rotina | 8s | Early morning, soft neutral light. Carlos stands by the kitchen window holding a coffee cup, steam rising. He pauses mid-sip, gaze drifting to the distance — a quiet moment of reflection, subtle and contained. Muted cool-neutral morning palette. Ambient: distant birds, soft kitchen hum. | pushIn (dolly-in lento) |
| 2 — Decisão | 7s | Carlos sits at the kitchen table, picks up his phone, types a short message. A gentle relieved half-smile forms as he sets the phone down. Morning light warming slightly through the window. Close on hands, rack focus up to his face. Ambient: soft phone tap, message swoosh. | focusChange |
| 3 — Cuidado | 7s | Bright modern medical clinic reception, white and soft-green tones, natural daylight. Carlos walks in; a smiling receptionist welcomes him; a doctor in a white coat greets him with a warm handshake in the corridor. Clean, calm, human atmosphere. No procedures shown. Ambient: soft clinic murmur. | leftWalking (steadicam) |
| 4 — Recompensa | 8s | Golden hour at a Brazilian beach promenade. Carlos walks slowly with his wife, both relaxed, he takes a deep breath of sea air, closes his eyes for a second, smiles with quiet satisfaction. Warm golden palette, gentle sea breeze in hair, soft lens flare. Camera rises slowly revealing the coastline. Ambient: waves, breeze, distant gulls. | craneUp + lensFlare |

## VÍDEO B — "Uma manhã." (processo/benefício → recompensa)

**Protagonista:** "Helena", mulher brasileira de 50 anos, cabelo castanho na altura dos ombros,
blusa bege elegante-casual (referência de personagem gerada previamente).

| Cena | Duração | Prompt | Câmera |
|---|---|---|---|
| 1 — Rotina | 7s | Morning home office. Helena reviews a full paper agenda, coffee beside her, morning light through blinds. She glances at her watch, a beat of "when do I fit myself in?" — light, not distressed. Neutral palette. Ambient: page turn, clock tick. | pushIn |
| 2 — Decisão/Chegada | 8s | Helena arrives at a bright modern clinic exactly on time; automatic doors open; the receptionist greets her by a warm smile and gestures her right in — no queue, no waiting. She visibly relaxes her shoulders. Light warming. Ambient: doors, friendly murmur. | rightWalking (steadicam) |
| 3 — Cuidado | 7s | Elegant montage feel: Helena in a calm consultation room in friendly conversation with a female doctor (only talking, smiling, doctor gesturing to a tablet); a warm handshake; Helena walking down the bright corridor checking her watch with a pleased expression — still morning. No procedures shown. Ambient: soft voices. | focusChange |
| 4 — Recompensa | 8s | Same day, golden late-afternoon light. Helena walks barefoot on the sand at Caraguatatuba beach, sandals in hand, wind in her hair, deep satisfied breath, serene smile — the afternoon is hers. Warm golden palette, soft lens flare, camera orbits gently then rises. Ambient: waves, breeze. | orbitRight → craneUp |

---

## Pós-produção ("recursos de After Effects")

Os modelos generativos não produzem motion graphics vetoriais; o acabamento AE é aplicado depois:
1. **End card (28–30s):** logo Total Quality + identificação obrigatória (clínica + registro CRM-SP,
   diretor técnico + CRM) animados com fade/scale suave — únicos elementos gráficos do vídeo.
2. **Color match** entre os clipes concatenados (curva única teal-warm).
3. **Trilha:** cama musical warm/uplifting discreta (biblioteca licenciada), crescendo na cena 4.
4. **Transições:** cortes secos entre cenas 1→2→3; cena 3→4 com dissolve de 12 frames (a "passagem
   para a recompensa").

## Especificações de entrega

- Formato: 9:16 vertical (Reels/Stories/Feed), 720p (upscale para 1080p disponível via Magnific)
- Duração: 30s (4 cenas: 8+7+7+8)
- Sem legendas, sem texto gerado, sem narração — som ambiente nativo apenas
- Custo por vídeo: ~4.200 créditos Magnific (2 gerações de 15s no Seedance 2.0 Mini 720p)
