# Budget state: copy into working memory at task start

```
BUDGET
  window_limit : <model context size, e.g. 200k>
  soft_ceiling : <~55% of limit>   -> offload payloads to files, keep pointers
  hard_ceiling : <~78% of limit>   -> compact (write digest, reinitialize)
  keep_always  : goal | success criteria | active plan step | open decisions | pointers
  offload_first: raw tool output | finished steps | reference dumps | long logs
  status       : <ok | approaching-soft | approaching-hard>
```

Update `status` whenever you sense the window filling. Act at each ceiling per SKILL.md.
