From: Andrew Jeffery <andrew@aj.id.au>
Date: Sun, 05 Apr 2020 16:27:35 +0930
Subject: [PATCH v7 0/5] soc: aspeed: Add XDMA engine driver
In-Reply-To: <d1fe0157-8a4b-f0f5-f0e4-443d6f4e3e4a@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
 <8ca08ea0-2f3e-4b44-a595-bfe96ca02b3f@www.fastmail.com>
 <d1fe0157-8a4b-f0f5-f0e4-443d6f4e3e4a@linux.ibm.com>
Message-ID: <73c7b292-fa99-4809-a0fa-b3605f35aff4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 4 Apr 2020, at 01:22, Eddie James wrote:
> 
> On 4/2/20 7:32 PM, Andrew Jeffery wrote:
> >
> > On Fri, 3 Apr 2020, at 06:19, Eddie James wrote:
> >> This series adds a driver to control the Aspeed XDMA engine embedded in the
> >> AST2500 and AST2600. The XDMA engine performs automatic DMA operations
> >> over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.
> >>
> >> Changes since v6:
> >>   - See individual patches
> > v7 is not an evolution on v6 - v7 contains a bunch of bugs that v6 fixed (at least
> > wrt locking). How did you generate this series?
> 
> 
> My goodness, I could have sworn that was v6. I took the series that was 
> merged in the openbmc kernel. Must have gotten mixed up. -_-

No worries, hopefully v8 is in the right state :)

> 
> 
> >
> > Also my name is misspelled in each of the Reviewed-by: tags which makes me
> > think that something has gone quite wrong with the posting of v7, and I'm
> > concerned that this was based on e.g. v5 but with my tags against v6 applied.
> 
> 
> Well thats because I added them manually since they had "disappeared" or 
> so I thought from v6 during the application to openbmc... guess that 
> should have been a warning sign

It certainly was for me!

Cheers,

Andrew
