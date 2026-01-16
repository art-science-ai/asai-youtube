---
aliases:
- Outlook webcal calendar sync
---

- Meta outlook calendar publish
	- https://outlook.office365.com/owa/calendar/a3aa1e5a19e942d884226931659b5ddf@meta.com/1036a0e049ee4b959237a6fb7cb718ef2968587449237826819/calendar.ics
		- Outlook > Settings > Publish a calendar
	- https://outlook.office365.com/owa/calendar/a3aa1e5a19e942d884226931659b5ddf@meta.com/00d5d848d67b4dfb89c8bb60e93116658788616713736613722/S-1-8-588929841-1055636683-2520604268-2886053264/reachcalendar.ics
		- Found in google calendar import
- Google calendar
	- Public: https://calendar.google.com/calendar/ical/nikhil.maddirala%40gmail.com/public/basic.ics
	- Secret: https://calendar.google.com/calendar/ical/nikhil.maddirala%40gmail.com/private-a24f722e2cd73ddffd9d081407613cc8/basic.ics
- Import webcal ical to pesronal Google cal / Outlook
	- Adds as subscribed calendar, not main calendar
	- Sync is infrequent - once every 12 hrs or so
- To add to primary calendar, I need to do it via API:
	- Zapier webhooks
	- Google Apps script - for google calendar - e.g. nikhil.maddirala@gmail.com
	- Azure app - for outlook calendar - e.g. nikhil.maddirala@outlook.com
- Meta personal calendar sync Azure app
	- Display name: nm-calendar-sync
	- Application (client) ID: e5ef9486-d448-4546-83dd-be8b75b18c6b
	- Object ID: 7e9da39d-c2e5-41c0-89a1-69ad3a90354f
	- Directory (tenant) ID: e652e587-8648-4e1a-9c2b-c7a303d9a588
	- nm-calendar-sync-secret
		- Value: M7i8Q~K3Mz8YoJahDxHIE7VNiY4wg8ZIUPAiXcBE
		- Secret ID: 880123b3-db03-4dc9-8cc7-c797254147a7
- Tools
	- [gcalcli](https://github.com/insanum/gcalcli)
	- **[OutlookGoogleCalendarSync](https://github.com/phw198/OutlookGoogleCalendarSync)**
	- **[GAS-ICS-Sync](https://github.com/derekantrican/GAS-ICS-Sync)**
		- Syncs ics to subscribed google cal with frequent refresh
- 


| Calendar                                  | Purpose                    | Events                                                                            | Events imported from |     |
| ----------------------------------------- | -------------------------- | --------------------------------------------------------------------------------- | -------------------- | --- |
| Outlook - Meta - nikhilmaddirala@meta.com | Scheduling work events     | Native events<br><br>Synced events from Google Calendar                           |                      |     |
| Outlook - nikhil.maddirala@outlook.com    |                            | Synced events from Meta calendar (incl. synced events from Google calendar)       |                      |     |
| Google - nikhil.maddirala@gmail.com       | Scheduling personal events | Native events<br><br>Synced events from Meta calendar (except synced from Google) |                      |     |
