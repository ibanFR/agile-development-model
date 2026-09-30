# Agentic AI in the Software Development Model

This page explains how agentic AI fits into the Software Development Model, and why. It does not tell you how to set up an agent. It gives you a way to think about what agents change and what they leave alone.

A note on how to read it. Some statements come from studies or named practitioners. Others are interpretation: the research suggests them, but nobody has tested them on a whole team. The text marks the difference.

## The short version

An agent is a tool inside the components of the model. It is not a new participant, and it does not replace a focus area.

The research points to one pattern. Agents are good at turning an agreed decision into an artefact. They are weak at reaching the decision. The model has the same split built in. Relationships between components, such as "formulate" and "automate", are mostly transformations. Relationships from a person into a component, such as "presents rules and examples", are mostly decisions.

So the collaboration between the Domain Expert and the Software Engineer stays. The Domain Expert gains leverage and load. The Software Engineer spends less time implementing and more time specifying and verifying. The central tension is speed against shared understanding.

## Why the agent is not a third person

The model has two people. The Domain Expert owns the product vision and brings domain knowledge. The Software Engineer delivers software in small, high-quality steps. The [glossary](../../CONTEXT.md) defines terms by purpose, not by tooling.

An agent does not hold domain knowledge. The research found that agents fill gaps with plausible assumptions ([Böckeler](https://martinfowler.com/articles/pushing-ai-autonomy.html)). Fowler and Joshi make a related point. The domain model and its vocabulary emerge where the functional domain meets the solution domain, so domain experts cannot work in isolation ([Conversation: LLMs and Building Abstractions](https://martinfowler.com/articles/convo-llm-abstractions.html)).

That fits the model. The Software Engineer "obtains domain knowledge" from the Product Brief and "identifies functional gaps or inconsistencies" in the Specification Workshop. Both edges assume a person who can ask a question and hear the answer. An agent can draft text. It cannot stand in for that exchange.

## The five focus areas, in the model's flow

The model flows from Align and Understand, through BDD and DDD, into XP, and on to Lean Product Development. The same pattern shows up in each.

### Align and Understand

The Domain Expert "presents Product Feature" to the Product Brief. Domain Discovery "creates" the Product Backlog.

Agents can draft user stories quickly. Two offline studies found that the stories read well, but they were less diverse and less independent than stories written by people. They also met acceptance criteria less often ([Quattrocchi and others](https://arxiv.org/abs/2507.15157); [Sakib and others](https://arxiv.org/html/2603.28163)).

Independence matters here. A Product Backlog is useful because its items are small and can be ordered on their own. The research suggests that agents speed up the writing of items but not the judgement that makes them good. That reading is interpretation. The studies did not involve a live team.

A second effect follows from cheap building. Marty Cagan writes that AI prototyping makes it easy to build many prototypes a week, and that "product sense" is now the hard part ([Build to Learn vs Build to Earn](https://www.svpg.com/build-to-learn-vs-build-to-earn/)). Practitioners at QCon London 2026 reported teams running short of well-qualified work. Both are practitioner accounts, not controlled studies.

The model does not say how a Domain Expert should use agents. The research suggests a useful distinction. An agent can build a throw-away prototype to learn during Domain Discovery. Production work still goes through the rest of the model. The Product Brief matters more, because it frames and constrains what anyone, human or agent, is asked to build.

A conversation is also not a document. The "spread domain knowledge" edge describes knowledge moving between people. An agent that turns a brief into a story map spreads text. It does not spread understanding.

### BDD

The Domain Expert "presents rules and examples" in the Specification Workshop. The workshop leads to Features ("formulate"). Features lead to Acceptance Tests ("automate"), which "guides code implementation" in Pair Programming.

The formulation and automation steps suit agents. In three separate studies, generated Gherkin was mostly relevant and clear. It also contained omissions and hallucinations, and the authors called it draft material that needs human review ([Hassani and others](https://arxiv.org/html/2508.20744v2); [Ferreira and others](https://arxiv.org/abs/2504.07244)). In one industrial case, only 60% of generated test cases were usable as they came.

Nobody measured the discovery conversation itself. No study was found of Example Mapping with an LLM in the room. This is a real gap.

What we do have is the stated intent of BDD. Aslak Hellesøy, who created Cucumber, argued that it is not a testing tool. It "was born out of the frustration with ambiguous requirements and misunderstandings" between the people who order software and those who deliver it ([The world's most misunderstood collaboration tool](https://cucumber.io/blog/collaboration/the-worlds-most-misunderstood-collaboration-tool/)). He wrote this in 2014, before agents.

The link "creates shared understanding" is where this matters. If an agent writes the Features without the workshop, the Acceptance Tests can pass while the shared understanding is gone. The research suggests treating generated scenarios as input to the workshop, such as candidate examples to discuss, and not as its replacement. That is an inference from BDD's intent and from studies on comprehension. No study tested it on BDD teams.

Acceptance Tests have a second role. Tests given up front improve the code that models generate. Agents also exploit tests they are allowed to edit. The research on this comes from the earlier [XP research](../research/xp/agentic-development-in-xp-comprehensive-research.md). The suggestion is that Acceptance Tests are where the Domain Expert's intent reaches the agent, so the agent should not rewrite them.

Spec-driven development is a nearby idea. Thoughtworks places it in "Assess" and warns of lengthy specification files that are hard to review ([Technology Radar](https://www.thoughtworks.com/radar/techniques/spec-driven-development)). BDD specifications are small: a rule, a few examples, and a test that fails when behaviour is wrong. No study compares the two approaches directly.

### DDD

The Domain Expert "validates and categorizes subdomains". The Software Engineer "identifies strategically significant parts of the domain". Strategic Architecture leads by "collaborative modelling" to Software Design, then by "apply tactical patterns" to Code the Domain Model.

In an industrial case study, an LLM did well on the first three steps of DDD: ubiquitous language, a simulated Event Storming and bounded contexts. The errors then built up, and the later artefacts for aggregates and architecture were impractical. The authors describe the LLM as a sparring partner ([Eisenreich and others](https://arxiv.org/abs/2603.26244)). A benchmark of domain modelling found that relationships were the weakest part, with much left out. That benchmark is known only from its abstract, so this page does not rely on its numbers.

Two experiments shed light on the people side. One found that domain knowledge matters more than modelling skill when refining an LLM's model ([Silva Mercado and others](https://link.springer.com/article/10.1007/s10270-026-01414-5)). The other found that novices adopted about two-thirds of the incorrect classes in an LLM's first draft ([Bragilovski and others](https://link.springer.com/article/10.1007/s10664-026-10831-5)).

There is a limit to state plainly. These studies used students and university participants. They did not use professional Domain Experts. The results may not transfer.

With that caveat, the research suggests a reason why the model calls DDD "a creative collaboration of domain experts and software engineers". An agent's draft changes the Domain Expert's job from producing a model to correcting one. Correcting needs domain knowledge that only the Domain Expert holds. Drafts also anchor people, so one reading is that a draft works better as a check after the people have modelled than as a starting point. That ordering is interpretation, not a tested practice.

DDD authorities offer positions here, not findings. Eric Evans said that a trained language model is a bounded context ([InfoQ report](https://www.infoq.com/news/2024/03/Evans-ddd-experiment-llm/)). Michael Plöd framed DDD as part of the answer to AI and posed open questions, such as whether context maps need rethinking ([talk abstract](https://www.innoq.com/en/talks/2026/05/ai-domain-driven-design/)). Treat these as open questions.

The glossary in this repository shows one way the idea plays out. It writes the ubiquitous language down. For an agent, it also becomes context.

### XP

The chain runs from Pair Programming, through "write just enough code" to Test-Driven Development, through "push code to version control" to Continuous Integration. From there "deliver product increment" reaches Short Iterations.

This is the focus area where agents write the most code, and it is also the control loop that keeps the output shippable. The [XP research](../research/xp/agentic-development-in-xp-comprehensive-research.md) covers it in depth. Its direction is that agents fit inside XP's feedback loops and do not replace them. Humans own the failing test. Continuous Integration, not the agent's own report, says whether the build is green. A pair or ensemble working with an agent keeps the knowledge sharing that an agent alone does not.

The DORA research associates AI adoption with more throughput and also with less stable delivery. Small batches are named as an amplifier of the benefit. This is why the model's habit of small steps matters more with agents, not less.

There is an open question too. No controlled study of a whole XP team using agents exists.

### Lean Product Development

Short Iterations "visualize progress on" Informative Workspaces, "updates" the Knowledge Base and "gathers" Customer Feedback. The Domain Expert "validates product increments".

**Flow.** In a field study of an enterprise mandate to double output, merged pull requests per person more than doubled. Review load per reviewer roughly doubled as well, and automated review overtook human review. The limiting factor moved from writing code to reviewing it and to supplying well-formed work. The research suggests that short iterations and small Product Increments matter more, not less. That argument is interpretation. No study examined iteration length with agents.

**Visibility.** A controlled trial found experienced developers 19% slower with AI while they believed they were about 20% faster ([METR](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)). If perceived speed is unreliable, the choice of what an Informative Workspace shows becomes important. A board that shows only throughput can look healthy while stability and complexity get worse.

**Knowledge.** Agent instruction files are a new kind of team knowledge. A large empirical study found that they change like configuration code, through frequent small additions ([Chatlatanagulchai and others](https://arxiv.org/abs/2511.12884)). Another found that they do not generally raise task success, though agents follow them. They help most for team-specific practices, not for overviews of the repository ([Gloaguen and others](https://arxiv.org/abs/2602.11988)). That matches the purpose of a Knowledge Base, which holds what only the team knows.

**Feedback.** Agents can sort and summarise Customer Feedback at moderate accuracy. Interpreting it is still a person's work. The workspace file draws no link from Customer Feedback back to Align and Understand. This is an observation about the diagram and not a suggestion. The research notes only that a faster feedback loop stays fast if a person closes it.

## Tensions that run across the model

### Speed against shared understanding

This is the central tension. Thoughtworks calls the growing gap between a system and the team's understanding of it "cognitive debt" ([Technology Radar](https://www.thoughtworks.com/radar/techniques/codebase-cognitive-debt)). Studies of skill formation find that delegating work to AI reduces understanding of the result. Agents make the gap open faster.

The model offers two kinds of component in response. The collaborative ones are Domain Discovery, the Specification Workshop, collaborative modelling and Pair Programming. They are where shared understanding is made. The automated ones are Acceptance Tests, Test-Driven Development and Continuous Integration. They keep output honest.

The research suggests a reading of this. The collaborative components act as a brake that keeps agent speed in line with what the team understands. The automated components act as a harness. This reading is interpretation.

Prompts are not reproducible. Fowler describes an LLM as a non-deterministic abstraction, so storing a prompt does not guarantee the same result ([LLMs bring new nature of abstraction](https://martinfowler.com/articles/2025-nature-abstraction.html)). The lasting artefacts are the ones the model already names: the Product Brief, Features, Acceptance Tests, design documents, code and tests, and the Knowledge Base.

### Where the effort moves

Roles shift and do not disappear. The Domain Expert gains leverage, because building is cheap and product judgement steers it. The Domain Expert also gains load. Validation and well-formed work become the bottleneck. The practitioner evidence for the load is consistent, but no study measured it.

The Software Engineer moves toward specifying and verifying. Dave Farley has said the role shifts toward defining the problem in greater detail, and that verification becomes the bottleneck. Two vision papers take related positions: specifications as the contract between humans and agents ([Diaz and others](https://arxiv.org/abs/2609.00252)), and a "whole of process" view of agentic software engineering ([Hoda](https://arxiv.org/abs/2510.19692)). These are positions and open questions. The first calls itself a first step, not a validated theory.

### What stays and what changes

| Focus area | What stays | What changes |
|---|---|---|
| Align and Understand | The Domain Expert owns the vision. Discovery is a conversation. | Drafting is cheap. Judgement and a supply of small items become the constraint. |
| BDD | The workshop, with examples agreed by people. | Formulation and automation can be drafted by agents and reviewed by people. |
| DDD | Collaborative modelling and validation of subdomains. | Early drafts are cheap. Later design decisions compound errors. |
| XP | Pairing, TDD and CI as feedback loops. | The agent drives. Humans own the failing test. |
| Lean | Small increments, visible progress, team knowledge. | The constraint moves to review. The Knowledge Base gains instruction files. |

All of this table is interpretation.

## Limits of the evidence

- Most studies cover one activity, such as generating stories or Gherkin. None covers a product team using agents across the whole model.
- Many studies use students, offline datasets, or the authors' own researchers as raters.
- No study was found of Example Mapping or Event Storming with agents in a live team.
- The claim that the Domain Expert becomes a bottleneck rests on practitioner reports.
- Customer Feedback evidence covers classifying text, not changing what a team decides.
- The vision papers and the DDD authorities' talks pose questions. They do not report results.
- This page maps the evidence onto the model. That mapping is interpretation, and it does not propose changes to the model.

## Further reading

- [Research: Agentic AI in the Software Development Model](../research/agentic-ai-in-the-software-development-model-for-explanation-doc.md) holds the findings, confidence ratings and full citations behind this page.
- [Research: Agentic development in XP](../research/xp/agentic-development-in-xp-comprehensive-research.md) covers pairing, test-driven development, continuous integration, small batches and cognitive debt in depth.
- The [glossary](../../CONTEXT.md) defines the terms used here.
