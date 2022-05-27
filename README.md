# Alex Yates' Curriculum Vitae
PDF versions of my CV can be found in the /bin directory. There are two versions:
- EMEA (formatted for 'A4' paper)
- US (formatted for 'Letter' paper)

## Source files
My CV is produced in PowerPoint. Source files are in the /src directory. PowerPoint may sound like an odd choice. I chose it for the following reasons:
- Microsoft Word wasn't flexible enough.
- CV template/builder tools are great for ideas, but aren't flexible enough if you want to try anything more creative/original.
- I'm familiar with PowerPoint and I don't want to learn a new tool for just one document.

## A note on how the git tree diagram was produced
The git tree is a screenshot from GitKraken. In my first draft I created my own diagram, but it was ugly. Git Kraken is pretty out of the box.

Actually, it's a couple of screenshots stitched together. It was necessary to take one screenshot with tier one branches set to red (for Redgate), and another with tier 1 set to orange (for DLM). Apparently there are limits to GitKraken UI theme configurability.

Since it's a nightmare to update history, especially while maintaining the intended branch structure, it proved awful to produce the diagram manually. It took ages and a single typo caused huge frustration. Early on I was resorting to copying, cropping and patching over typos. Yuk!

With this in mind, I wrote a script to recreate the repo manually. All the code and raw content is in ./git-tree-builder. You can recreate the repo on your own machine by opening a PowerShell window and running:

    > git clone https://github.com/Alex-Yates/curriculum-vitae.git
    > cd curriculum-vitae
    > cd git-tree-builder
    > .\build-repo.ps1

By default this builds the repo in the directory "C:/deleteme/CV_GitTree". If you would like to build the repo somewhere else:

    > .\build-repo.ps1 -path "C:/somewhere/else"

This might feel like over-engineering. It cost me a few hours to troubleshoot a few things. In particular:

- IO bottlenecks getting everything out of sync and screwing up the commit order and branch diagrams.
- Git sending it's output to stderr by default, causing phantom errors.

However, as I proof-read, redrafterd and refined this document, it was very useful to be able to tweak the content in a simple JSON file, and respawn the repo from scratch in a few seconds. Also, it was a pretty fun little learning project. :-)