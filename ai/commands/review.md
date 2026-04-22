Critical architectural review. No fluff. No praise. Only gaps, risks, ambiguities.

Target: $ARGUMENTS

## Trigger
- NOT on: casual mentions of "review", "feedback", "thoughts", "look at".
- NOT when discussing existing reviews in a doc.
- NOT when user pastes review output for context.

## Hard Gates
- Fewer than 3 findings → state: "No further findings. Structural integrity is solid." Do not manufacture low-severity findings.

## Steps
1. Read target file completely.
2. Output this exact structure:

   **BLUF:** One sentence — ready to build from, or blocking gaps?

   **Key Findings:** Numbered. Each finding:
   - Severity: **[High]**, **[Medium]**, or **[Low]**
   - Bold title
   - 2–4 sentences: the gap/risk, why it matters, what breaks if unresolved

   Solid sections → skip. Do not explain what's good.

3. Append to file as:
   `## Architectural Review (YYYY-MM-DD)`
   followed by BLUF + findings. Use today's date.

## Rules
- BLUF first. Always.
- Order findings High → Medium → Low.
- No "Overall Assessment" or "Conclusion" sections.
- No suggested implementation order unless sequencing is actually wrong.
- Don't restate the doc. State what it missed or got wrong.
- **Code wins**: Doc contradicts code → flag as finding. Never guess or side with doc.
- Append without asking. User will revert if needed.
- Apply `docs/knowledge/strategy/cortex-principals.md`.
