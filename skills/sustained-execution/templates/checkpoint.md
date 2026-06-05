# Checkpoint entry: checkpoint-<NNN>: <timestamp>

> A checkpoint is a context-budgeting digest, saved, with its pointer recorded in the
> ledger's CHECKPOINTS section. Reuse templates from context-budgeting/templates/digest.md.

```
checkpoint_id : checkpoint-<NNN>
reason        : <hard-ceiling | phase-boundary | pre-one-way-step | pre-risky-op>
digest_file   : notes/digest-<NNN>.md
plan_position : step <#> active
verified_last : <last result that passed verifying-reasoning>
resume_from   : <NEXT ACTION at checkpoint time>
```

After writing: reinitialize context, reload GOAL + ledger + digest, go to resume_from.
