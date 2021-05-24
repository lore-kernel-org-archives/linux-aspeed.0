From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 24 May 2021 10:06:00 +0930
Subject: [PATCH v3 00/16] ipmi: Allow raw access to KCS devices
In-Reply-To: <20210521173616.GK2921206@minyard.net>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210521173616.GK2921206@minyard.net>
Message-ID: <e0803983-a385-4972-9dcb-404b2006f674@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Corey,

On Sat, 22 May 2021, at 03:06, Corey Minyard wrote:
> On Mon, May 10, 2021 at 03:11:57PM +0930, Andrew Jeffery wrote:
> > Hello,
> > 
> > This is the 3rd spin of the series refactoring the keyboard-controller-style
> > device drivers in the IPMI subsystem.
> 
> This is a nice set of cleanups outside of just allowing raw access.
> I'll let you handle Zev's comments and a few of mine.

Thanks for taking the time to review the series. I'll address the 
comments from you both in v4.

> 
> I almost hate to ask this, but would there be value in allowing the BT
> driver to use this abstract interface? 

Hmm. Possibly, but it's not something I've looked at yet. If we did 
want to go down that path I don't think it would be too difficult, but 
I don't have a need to touch the BT side of it right now.

> Or maybe it would be just too
> hard to get a common abstraction, more work than it's worth.  It's
> surprising that more people don't want BT as it's vastly superior to
> KCS.  

For bulk data, certainly. However for the use-cases I have I'm using 
the KCS interface as a control channel that isn't data intensive. 
Interrupts, a small command set (256 values are more than enough) and a 
status byte are all I'm really after, so BT is more than I need.

Plus for the systems I'm working on we're still using BT for in-band 
IPMI while we transition to MCTP/PLDM. The current BT implementation is 
working fine for that :)

Cheers,

Andrew
