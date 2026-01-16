This is my personal modified implementation of Tiago Forte’s PARA system

## Overview

| Note type  | Description                                                                                                                                                                                                                                                                                                                                                                               | Properties: internal                   | Properties: relations         |     |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- | ----------------------------- | --- |
| Area group | Collections of areas based on Maslow’s hierarchy of needs                                                                                                                                                                                                                                                                                                                                 |                                        |                               |     |
| Area       | Ongoing aspects of life that require consistent attention and maintenance <br>- Areas are always “active”<br>- Areas don’t have a specific end goal or deadline                                                                                                                                                                                                                           |                                        |                               |     |
| Project    | Projects are goals with a fixed timeframe or deadline. They are short-term, temporary, and dynamic.<br>	- Projects are supported by tasks and/or habits. Some projects are primarily task-based (e.g. moving houses) while some are primarily habit-based (e.g. lose weight).<br>	- The project “miscellaneous” is a container for miscellaneous tasks that don’t fall under any project. | - Active status<br>- Goal / milestones | - Linked to one or more areas |     |
| Task       | Tasks are managed using the TaskNotes plugin as well as Obsidian bases                                                                                                                                                                                                                                                                                                                    |                                        | - Project                     |     |
| Habit      | Habit is a type of task. We can make it a subset of tasks with specific properties.                                                                                                                                                                                                                                                                                                       |                                        |                               |     |
| Resource   |                                                                                                                                                                                                                                                                                                                                                                                           |                                        |                               |     |

Open questions
- Should projects be linked to areas?
- Should tasks be linked to areas in addition to projects?
- What to do about miscellaneous tasks that don't belong to projects?

## Tasks + Resources
Current vs desired state

| Area                   | Note type        | Current solution                                                  | Ideal state                                                                      |
| ---------------------- | ---------------- | ----------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Personal               | Tasks            | Some in Todoist, some in Obsidian task notes                      | Two way sync: Todoist + Obsidian task notes                                      |
| Personal               | Docs - resources | Obsidian - multiple dirs                                          | Obsidian - unified resources dir                                                 |
| Personal               | Files            | Google Drive / Files                                              | TBD: Move to Obsidian repo attachments folder with links in project / area docs? |
| Coding projects        | Tasks            | Stored in project repos either as markdown files or github issues | Two way sync: Github issues + Obsidian task notes                                |
| Coding projects        | Docs - resources | Project repos - markdown files                                    | Two way sync via symlinks or other solution                                      |
| Collaborative projects | Tasks            | Todoist                                                           | Two way sync: Todoist + Obsidian task notes                                      |
| Collaborative projects | Docs - resources | Google docs                                                       | ?                                                                                |



## PARA Groups and Areas
Groups and areas are relatively constant

### Groups
- **Self-esteem & actualization**
    - **Areas:** Career; Learning & creativity
    - **Vision:** Self-actualization—realizing my potential through personal growth and peak experiences. Self-esteem—realizing self-worth, accomplishment, and respect.
- **Love & belonging**
    - **Areas:** Marriage & family; Community; Recreation
    - **Vision:** Nurture a sense of love, connection, and belonging; engage in activities that bring joy, inspiration, and a sense of unity.
- **Scaffolding**
    - **Areas:** Physical health; Mental health; Productivity; Wealth; Home
    - **Vision:** Maintain a solid foundation that ensures safety, security, and overall well-being.

### Areas
- **Self-esteem & actualization**
    - **Career** — Deliver impactful work, become a leader, and build strong relationships.
    - **Learning & creativity** — Pursue intellectual challenges, creative activities, and side projects.
- **Love & belonging**
    - **Marriage & family** — Nurture a loving marriage and family.
    - **Community** — Nurture relationships with friends and family.
    - **Recreation** — Engage in restorative leisure activities: arts, culture, travel, and nature.
- **Scaffolding**
    - **Physical health** — Maintain health metrics (BMI, blood glucose) through nutrition, exercise, and sleep.
    - **Mental health** — Build mental strength, resilience, calmness, and emotional regulation.
    - **Wealth** — Secure financial stability for short- and long-term goals.
    - **Home** — Maintain a comfortable and nurturing home environment.
    - **Productivity** — Maintain efficient systems to achieve life goals.


