From: Corey Minyard <minyard@acm.org>
Date: Wed, 5 Oct 2022 18:54:59 -0500
Subject: [PATCH] ipmi: kcs: Poll OBF briefly to reduce OBE latency
In-Reply-To: <08c20621-e75d-4a72-82e6-b1980304e20a@app.fastmail.com>
References: <20220812144741.240315-1-andrew@aj.id.au>
 <08c20621-e75d-4a72-82e6-b1980304e20a@app.fastmail.com>
Message-ID: <Yz4ZU8Ron/b9GV6p@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 06, 2022 at 09:42:57AM +1030, Andrew Jeffery wrote:
> Hi Corey,
> 
> On Sat, 13 Aug 2022, at 00:17, Andrew Jeffery wrote:
> > The ASPEED KCS devices don't provide a BMC-side interrupt for the host
> > reading the output data register (ODR). The act of the host reading ODR
> > clears the output buffer full (OBF) flag in the status register (STR),
> > informing the BMC it can transmit a subsequent byte.
> >
> > On the BMC side the KCS client must enable the OBE event *and* perform a
> > subsequent read of STR anyway to avoid races - the polling provides a
> > window for the host to read ODR if data was freshly written while
> > minimising BMC-side latency.
> 
> Just wondering whether you're happy to pick this one up? I haven't seen 
> it hit the IPMI tree yet.

Sorry.  It's in my tree for 6.2 right now.

I can't push it up to for-next until 6.1-rc1 comes out.

-corey

> 
> Cheers,
> 
> Andrew
