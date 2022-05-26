# Alex Yates' Curriculum Vitae
PDF versions of my CV can be found in the /bin directory. There are two versions:
- EMEA (formatted for 'A4' paper)
- US (formatted for 'Letter' paper)

# Source files
My CV is produced in PowerPoint. Source files are in the /src directory. PowerPoint may sound like an odd choice. I chose it for the following reasons:
- Microsoft Word wasn't flexible enough.
- CV template/builder tools are great for ideas, but aren't flexible enough if you want to try anything more creative/original.
- I'm pretty familiar with PowerPoint and I don't want to learn a new tool for just one document.

## A note on how the git tree diagram was produced
I started by trying to design the git tree in PowerPoint but, frankly, my graphic design skills weren't up to it, and PowerPoint wasn't the right tool. I found it much easier to use a git client with a pretty graph UI out of the box and take a screenshot.

I produced the git tree in Git Kraken. I had to stitch a few screenshots together because the JSON config files that manage colour themes didn't allow me to set unique colours for Regate (red) and DLM Consultants (orange) without breaking the branch diagram. Also, I mistyped "Google" and editing history in git while maintaining branch structure is painful as hell. Much easier to simply re-screenshot.

I had planned to push the source code to GitHub too, so that you could click on the commits to see more details in the underlying files. I thought that might be cool, interactive, and relevant. However, git is specifically designed to make editing history painful, so correcting typos in older commits, without breaking the desired branch diagram is more trouble than it's worth. In the end I gave up on it... for now. Deadlines!

At some point I might come back to this and automate it such that I can write all the content in advance, edit to my hearts content, and then run a script to build a clean repo with the appropriate history/branch tree. That sounds like fun, but I don't have the time for that right now. Needless to say, the actual source code behind that git tree, for now, is a lot of "test", "deleteme", and "asdf".