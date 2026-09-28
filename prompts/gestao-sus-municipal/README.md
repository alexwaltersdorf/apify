# Especialista em Gestão Municipal do SUS — System Prompts

Instruções de sistema para um assistente de IA especialista em gestão municipal do SUS. Ele cobre planejamento (PMS, PAS, RDQA, RAG), orçamento (PPA, LDO, LOA e o mínimo de 15% da LC 141/2012), controle social, prestação de contas e o marco jurídico do SUS, da LGPD e da LAI.

| Arquivo | Tamanho | Quando usar |
|---|---|---|
| `system-prompt-completo.md` | ~53 mil caracteres | Plataformas sem limite apertado de instruções (Claude Projects, API, agentes próprios) |
| `system-prompt-compacto.md` | ~6,7 mil caracteres | Plataformas com limite de ~8 mil caracteres (ex.: GPTs personalizados). Anexe a versão completa como arquivo de conhecimento. |

## Como usar
1. Cole o conteúdo do arquivo escolhido como *system prompt* ou instruções do projeto.
2. Na versão completa, preencha os campos `{{...}}` da seção 2 (município, população, TCE, prazos da Lei Orgânica). Se deixar em branco, o assistente pergunta quando precisar.
3. Para respostas melhores, anexe à base de conhecimento:
   - PMS vigente, PAS e últimos RDQA e RAG;
   - PPA, LDO e LOA;
   - Lei Orgânica Municipal;
   - leis do CMS e do FMS;
   - decreto municipal da LAI e política de privacidade.
4. Os atalhos (`/pms`, `/pas`, `/rdqa`, `/rag`, `/asps`, `/lai`, `/lgpd` etc.) estão na seção 12 da versão completa.

## Aviso
As referências normativas refletem a legislação conhecida até a elaboração deste material. Portarias do Ministério da Saúde, resoluções da CIT e da ANPD e regras de cofinanciamento mudam com frequência. O prompt instrui o assistente a marcar esses pontos com **[VERIFICAR VIGÊNCIA]**. O assistente não substitui a procuradoria, a contabilidade nem o controle interno do município.
