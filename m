From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 8 Sep 2021 09:16:02 +0000
Subject: [PATCH v4 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <6593206c0bc90186f255c6ea86339576576f70dc.camel@codeconstruct.com.au>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
 <20210901033015.910-4-chiawei_wang@aspeedtech.com>
 <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
 <HK0PR06MB37792273A075533C2570002391CE9@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <513cb05f8d83d08a5c1e491dc0a9b6784195e7dd.camel@codeconstruct.com.au>
 <HK0PR06MB37799C48533B084CF864E49D91D29@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <6593206c0bc90186f255c6ea86339576576f70dc.camel@codeconstruct.com.au>
Message-ID: <HK0PR06MB377924CFCBFE9BD40E1C4A5D91D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Monday, September 6, 2021 11:17 AM
> 
> Hi Chiawei,
> 
> > > If that model doesn't fit though, that's OK, but I think we need
> > > some rationale there.
> >
> > After an internal discussion, we found that our eSPI VW device may not
> > fit into existing GPIO model.
> >
> > The reason is that GPIO direction changes through VW channel has no
> > interrupts triggered.
> > And the direction is controlled by the Host as aforementioned.
> 
> This piqued my curiosity, so I had a look through the 2500 datasheet. It appears
> that the host has full control of both the direction *and* hardware GPIO
> assignment though the platform-specific eSPI configuration register set.
> 
> So, with VW GPIOs in hardware mode (ESPICTRL[9] = 0, the default), the host
> has arbitrary control of all hardware GPIO lines (except for the GPIOAC bank, I
> guess?).
> 
> There's a huge security implication there - for example, GPIOs that assert
> physical presence can now be set by the host, possibly remotely - so I'd
> *strongly* recommend that we always get ESPICTRL[9] to 1, to set
> software-only mode.

Yes, there is security concern using HW mode.
Our designer is considering to remove the HW mode support in the next generation of Aspeed SoCs.
So far we haven't encountered a scenario demanding HW mode.

> 
> With than in mind, if we're disabling hardware mode - what does the direction
> control setting effect when we're in software mode (ESPICTRL[9] == 1)? Does it
> even matter?

Yes, the direction matters even in SW mode.
When the direction is 'master-to-slave' and the GPIO value is updated by the Host through PUT_VW, a VW interrupt is trigger to notify BMC.
For the 'slave-to-master' GPIO, a alert is generated to notify the Host to issue GET_VW for the GPIO value updated by the BMC by ESPI09C.

> 
> For example, what happens when the host goes a GET_VW cycle for a GPIO
> that is marked as 'master-to-slave' mode? Is the state of the GPIO in ESPI09C
> still reported?

The Host can only issue GET_VW when BMC update one of the 'slave-to-master' GPIO pins and have eSPI status VW_AVAIL set.
And the eSPI slave will not report the value of GPIO marked as 'master-to-slave'.

> 
> If that's the case, then we can just ignore the direction settings from
> ESPICFG800 completely, and have the BMC assign directions to standard
> gpiodevs as appropriate.

If the direction setting from the Host is ignored, the presented virtual GPIO does not reflect the correct state.
Plus that the direction change from the Host has no interrupt to notify BMC.
My concern is that if the gpiodevs way works partially, then it should not be adopted to avoid confusing users.

> 
> Separate from this: I'm also proposing that we represent the system event VWs
> as gpiodevs as well.
> 
> > A raw packet, primitive interface should have better flexibility to
> > manage MCTP packets over the OOB channel.
> 
> OK, let me phrase this differently: can the OOB channel be used for anything
> other than SMBus messaging? Is it useful to provide an interface that isn't a
> standard SMBus/i2c device?

Yes, the PCH spec. also defines two additional packet format for an eSPI slave to retrieve PCH Temperature Data and RTC time.
It should be trivial to prepare a byte buffer in that format and send it through the raw packet interface.
Aspeed also have demo APPs described in the header comment.

> 
> If you need custom uapi definitions for this driver, that might be okay, but it's
> going to be more work for you (to define an interface that can be supported
> long-term), rather than using standard infrastructure that already exists.

Thus I suggested that we can refer to the IPMI KCS BMC driver, which supports the selection of different user interfaces, RAW or IPMI.
If any other interface is needed afterward, the driver can be enhanced in that fashion.
While the eSPI raw packet TX/RX handling is preserved as the primitive operations.

If IOCTL is considered to be not user friendly or magic code polluting, file-based read/write on the miscdevice node is also an option.
