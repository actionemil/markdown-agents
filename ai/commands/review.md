You are performing a critical architectural review of a document. No fluff. No preamble. No praise. Only genuine gaps, risks, and unresolved ambiguities.

Target file: $ARGUMENTS

## TRIGGER
- ONLY when the user explicitly invokes `/review <file>` as a slash command.
- DO NOT trigger on casual conversation mentions of "review", "feedback", "thoughts", "look at", or "what do you think".
- DO NOT trigger when discussing reviews already present in a document.
- DO NOT trigger when the user pastes review output from another agent for context.

## Hard Gates
- **Duplicate Guard**: Check if a `## Architectural Review` section already exists for today's date (`YYYY-MM-DD`). If it does, ABORT with: "Review already performed for today." Do NOT append duplicate sections.
- **Signal Threshold**: If fewer than 3 findings exist, state: "No further findings identified. Structural integrity is solid." Do NOT manufacture low-severity findings to fill the format.

## Steps

1. Read the target file completely.

2. Produce a review with this exact structure:

   **BLUF:** One sentence — is this doc ready to build from, or does it have blocking gaps?

   **Key findings:** Numbered list. Each finding:
   - Severity: **[High]**, **[Medium]**, or **[Low]**
   - Bold title
   - 2–4 sentences: what the gap/risk is, why it matters, what breaks if left unresolved

   Only include findings with real consequence. If a section is solid, skip it — do not explain why it is good.

3. Append the review to the file as a new section with this header format:
   `## Architectural Review (YYYY-MM-DD)`
   followed by the review content (BLUF + findings).
   Use today's actual date.

## Rules
- BLUF first, always.
- Findings are ordered by severity descending (High → Medium → Low).
- No "Overall Assessment" or "Conclusion" sections — findings speak for themselves.
- No suggested implementation order unless there is a sequencing dependency that is actually wrong in the doc.
- Do not restate what the doc says. State what it missed or got wrong.
- Append to the file without asking for confirmation. The user will revert if needed.
