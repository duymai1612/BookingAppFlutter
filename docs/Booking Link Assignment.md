Create an interactive booking page prototype in Flutter based on the provided design file.  

The page must allow users to select a duration, date, time, and timezone.  Users must be able to confirm or cancel a booking.  

No backend connection is needed; dummy data is sufficient.  

**Acceptance Criteria**  

**1\. Layout**  

• Build the page exactly like the design.  

• Structure into three vertical sections:  

◦ Left: Duration  

◦ Middle: Date Picker  

◦ Right: Time Slots  

• Page must display correctly on different desktop screen sizes.  

• Mobile responsiveness is **out of scope**.  

**2\. Interaction**  

**Duration selection**  

• 15, 30, 60 minutes options.  

• Only one selection possible.  

• Highlight selected option.  

• Show related description text.  

**Date picker**  

• Default to current month and today’s date.  

• Allow navigation to other months using arrows, limited to 3 months in the future.  • Clicking a day selects it (only one day selectable).  

**Time slot picker**  

• Dummy time slots displayed for each day.  

• Selecting a time slot highlights it.   
• Only one time slot selectable at a time.  

• Time slots should be scrollable vertically if they overflow.  

**Confirmation area**  

• Only appears after selecting a time slot.  

• Displays:  

◦ Meeting duration  

◦ Event title  

◦ Date and time  

• "Confirm" button (green) confirms booking.  

• "Cancel" button (grey) clears the selected time slot.  

**Timezone selection**  

• Display timezone at the bottom of the page.  

• Default to the user’s timezone.  

• Allow users to manually change the timezone from a dropdown.  

• Dummy timeslots can remain static; no need to update times based on timezone.  

**3\. Header**  

• Above the duration block, show a **Participants** section.  

• Display the first names of the meeting organizer and participant as placeholders.  • Add a static placeholder for “Add Participants”.  

**Technical Requirements**  

• **Flutter only** (no React, no web libraries).  

• Follow best Flutter practices: structured code, state management, clear folder structure.  • Dummy data for:  

◦ Duration options  

◦ Available dates   
◦ Available time slots  

◦ Participants  

• Simple .Net back-end for proof of concept is fine  

**Styling**  

• Match fonts, button radius, colors, and highlights exactly to the provided design.  • Light hover effects on clickable elements (optional, nice-to-have).  

**Notes**  

• Language \= English.  

• URL format can stay generic for now (no need to implement /username/uuid).  

✅ **Deliverable**  

• A single Flutter project  

• Organized code structure with comments  

• Visual result must match the provided design closely  

• Submit a GitHub link 