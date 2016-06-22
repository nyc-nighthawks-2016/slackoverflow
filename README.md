# slackoverflow
DBC Stack Overflow Project - Team (Erica Rufrano, Jeffrey Ng, Jonathan Andrew Philippou, &amp; Seth Goldman)

User Stories:




PROJECT LAYOUT:

DBC Sinatra Overflow
Learning Competencies

Given a specification, implement an HTTP application that generates appropriate responses to requests using Sinatra or Rails
Summary

Let's get our feet wet building a substantial Sinatra application from the ground up: a StackOverflow clone.

Feel free to take a few minutes and peruse StackOverflow to gather a good understanding of what you will be building. The goal is to focus on building a well-structured Sinatra application with a good mixture of front-end and back-end features. Focus on defining clear routes, creating clean templates, and enhancing your application by making AJAX calls.

Strategy

Before you dive to deeply into the code, be clear with your team on three things:

Set expectations for the project.
Decide on your MVP
Break your MVP down into deliverable features
Objectives

These instructions are left deliberately ambiguous, both to give you flexibility in your implementation and because clarifying ambiguous requirements is at least 30% of an engineer's job. At. Least.

Users should be able to post questions. Other users should be able to answer them. Users should be able to respond to both questions and answers. Like StackOverflow, the responses should just be a flat list.

The person who posted a question can declare one of the user-submitted answers "the best."

Users should be able to vote on questions, answers, and responses (both upvotes and downvotes) - only once.

Users cannot add a question, answer, or vote unless they're logged in, but they can view all of the above when logged out.

Stretch: Responses should be sorted chronologically, with oldest first. Answers should be sorted by "the best" first, followed by most highly-voted.

Stretch: Users should be able to see questions sorted three ways: highest-voted, most recent, and "trending."

Polymorphic Associations

Because there are multiple "votable" models — questions, answers, and responses — we have the opportunity to use polymorphic associations. Instead of having three vote-related tables like answer_votes, question_votes, etc. polymorphic associations enable you to have a single votes table with a type column that indicates what kind of thing was voted on. You may also want to consult Rich on Rails blog post on polymorphic associations.

Likewise, a Response can belong to either an Answer or a Question.

That is, instead of the "type" being encoded in the table name, it's encoded as a field in the table.

The decision to make use of Polymorphic Associations is up to your group. You are not required to dive into this new concept right now. It is 100% possible to simply have a answer_votes and question_votes table to store the different types of votes and a answer_responses and question_responses table to store the different types of responses.

AJAX

We need to practice our new AJAX skills. Your team should decide what specific pieces of functionality y'all want to AJAX. A good place to start is AJAXing the voting functionality.

For example, instead of refreshing the page when a user upvotes or downvotes, we just want to make a quick AJAX call to our server to send that info and update the vote count on our page.

Pro Developer Tips

You should track your work / user stories and their progress by means of an electronic tracking application Trello is a common one, Pivotal Tracker is another
Optional: Add a chat application. Many teams, especially those that work remotely, find it helpful to create a chat environment in either Slack, HipChat or some other technology. Integrate this with GitHub and CI and hygeinic git behavior, you can work as well separated by miles as you might while standing in the same room together.
Checkpoints

Your team should produce a repo inside of your cohort's organization in GitHub
Your first commit should be a README.md containing:
Your team name
Your team members' names
The user stories that define your MVP
You should practice "good" git workflow and commit often
You should not merge your own branches. A team member should review your code then merge it.
You should have multiple AJAX calls to enhance a user's experience
You will be demo-ing your MVP
Show us your app doing the essential functionalities listed above
