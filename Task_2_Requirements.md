# Task II — Analysis Requirements Formalization

In *World of Tanks*, there are launched seasons of Battle Pass with a duration of around 3 months each ([Battle Pass description on the WoT Portal](https://worldoftanks.eu)).  
The Producer came to you as a Data Analyst and requested to provide the responsible team with monitoring of the Battle Pass health metrics to understand the current state of activity after release and, if necessary, make prompt decisions in the *World of Tanks* project. Please, complete the following:
- Formulate 10 questions that you would ask the Producer to better understand the in-game activity that is being launched.
- Suggest at least 10 metrics that you would suggest to the Producer to monitor the event status.

---

## Questions to Ask Before Launching a Battle Pass Event

1. **What is the main goal of this Battle Pass?**  
   To define the key KPIs and metrics — whether the goal is to drive engagement, retention, monetization, or reactivation of lapsed players.

2. **Which player segments are the primary focus for this event?**  
   To determine how to group users in dashboards and monitoring — for example, new vs. returning, paying vs. non-paying.

3. **What types of rewards and motivations are included in the Battle Pass? What monetization mechanics are involved?**  
   Rewards and monetization mechanics strongly influence player behavior. Understanding this helps us identify key decision points for players.

4. **What kind of player feedback do we plan to collect?**  
   To evaluate user sentiment and reactions to the event. Also helps define how feedback will be processed and used for further iterations.

5. **Do we have target numbers for active player participation in the event?**  
   Clear KPIs allow us to measure the "health" of the event and compare its performance against past versions.

6. **What in-event milestones are considered key to successful progression?**  
   To track player drop-offs or frustration points and intervene if needed.

7. **How can players participate in the Battle Pass?**  
   To understand entry barriers and identify potential UX or onboarding issues.

8. **Are there any external factors that may influence player activity (e.g., holidays, competitor updates)?**  
   To avoid false conclusions when analyzing player behavior during the event period.

9. **What are the main hypotheses we want to test with this Battle Pass?**  
   To identify whether we can run A/B tests or apply alternative methods to validate assumptions around new mechanics, monetization, or content.

10. **How long will the event run, and what are the key phases (e.g., launch, mid-season, finale)?**  
    To structure the monitoring accordingly. Player behavior and metrics often vary by phase.

---

## Key Metrics to Track

1. **DAU / MAU** — Daily and Monthly Active Users during the Battle Pass period
2. **Purchase Conversion Rate** — Free-to-paid and Battle Pass Premium conversions
3. **ARPU / ARPPU** — Average Revenue Per User / Paying User
4. **Retention Rates** — D1, D7, D30 retention after event start
5. **Activity and Progress by Segment** — e.g., new vs. returning players, payers vs. non-payers (quests completed, level progression funnels)
6. **Participation Rate** — % of active players engaging with the event
7. **Server Load and Peak Concurrent Users** during the Battle Pass
8. **Number of Bugs / Issues Reported** during the event period
9. **NPS** — Net Promoter Score
10. **Churn Rate by Phase** — Drop-offs during launch, mid-event, and finale
