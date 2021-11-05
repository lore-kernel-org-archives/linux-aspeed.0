From: Oskar Senft <osk@google.com>
Date: Thu, 4 Nov 2021 23:28:43 -0400
Subject: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
In-Reply-To: <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com>
References: <20211105005955.107419-1-osk@google.com>
 <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
 <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com>
Message-ID: <CABoTLcTb5uGABwe9FG4haj1888NA4mdZqJFTeQcSotBnq1aZVg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

> I test the kernels independently of yocto; I recommend doing that with
> a cross compiler when submitting patches upstream. My flow looks like
> this:
> [...]
> A few notes:
>  - I use the cross compiler from my distro. Debian unstable has GCC
> 11.2.0, which is the same as openbmc. You can use the compiler from
> your openbmc build tree if you aren't able to install a modern
> compiler
I couldn't figure out how to use the compiler from the OpenBMC tree.
The biggest issue is that it has "openbmc" in its name and Linux build
was getting confused by it. I gave up on that approach and found how
to install the right cross compiler in our environment. That worked
well. Thanks for the hints!

>  - building with -s means warnings stand out
Excellent idea, thank you!

>  - if you're working on device trees and want to ensure your binary is
> being built each time, omit the -s and build the 'dtbs' target
Ack.

I'll send a PATCH v3 now.

Oskar.
