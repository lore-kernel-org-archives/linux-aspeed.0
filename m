From: Timothy Pearson <tpearson@raptorengineering.com>
Date: Thu, 2 May 2019 14:37:38 -0500 (CDT)
Subject: [PATCH 3/3] aspeed/pinctrl: Fix simultaneous DVO and serial
 outputs on AST2500 devices
In-Reply-To: <e2388fbc-e664-4338-a0f5-d34a3621c3fb@www.fastmail.com>
References: <236762130.3394112.1556751009128.JavaMail.zimbra@raptorengineeringinc.com>
 <128da9c8-d138-47b9-b323-b845bd93ca2f@www.fastmail.com>
 <1991472336.3446950.1556778801333.JavaMail.zimbra@raptorengineeringinc.com>
 <e2388fbc-e664-4338-a0f5-d34a3621c3fb@www.fastmail.com>
Message-ID: <1968156380.3538229.1556825858913.JavaMail.zimbra@raptorengineeringinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



----- Original Message -----
> From: "Andrew Jeffery" <andrew@aj.id.au>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-aspeed" <linux-aspeed@lists.ozlabs.org>, "Ryan Chen" <ryan_chen@aspeedtech.com>
> Sent: Thursday, May 2, 2019 1:40:39 AM
> Subject: Re: [PATCH 3/3] aspeed/pinctrl: Fix simultaneous DVO and serial outputs on AST2500 devices

> On Thu, 2 May 2019, at 16:03, Timothy Pearson wrote:
>> 
>> 
>> ----- Original Message -----
>> > From: "Andrew Jeffery" <andrew@aj.id.au>
>> > To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-aspeed"
>> > <linux-aspeed@lists.ozlabs.org>, "Ryan Chen"
>> > <ryan_chen@aspeedtech.com>
>> > Sent: Thursday, May 2, 2019 12:51:00 AM
>> > Subject: Re: [PATCH 3/3] aspeed/pinctrl: Fix simultaneous DVO and serial outputs
>> > on AST2500 devices
>> 
>> > On Thu, 2 May 2019, at 08:20, Timothy Pearson wrote:
>> >> There appears to be a significant error in the pinmux table starting on
>> >> page 127 of the AST2500 datasheet v1.6.  Specifically, the COND2 (DVO)
>> >> requirement is incorrectly applied to multiple digital video input (DVI)
>> >> muxed pins, and no DVI-specific condition is provided.  This results in
>> >> the serial devices incorrectly overriding the DVO pinmuxes and disabling
>> >> the DVO pins.
>> >> 
>> >> Create a new condition code (COND6) for DVI enable, and update the most
>> >> seriously affected pins to use the new condition code.
>> >> 
>> >> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
>> >> ---
>> >>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 17 +++++++++--------
>> >>  1 file changed, 9 insertions(+), 8 deletions(-)
>> >> 
>> >> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
>> >> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
>> >> index 6f357a11e89a..676f90d3c5f3 100644
>> >> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
>> >> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
>> >> @@ -29,6 +29,7 @@
>> >>  
>> >>  #define COND1		{ ASPEED_IP_SCU, SCU90, BIT(6), 0, 0 }
>> >>  #define COND2		{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 0, 0 }
>> >> +#define COND6		{ ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 0, 0 }
>> >>  
>> >>  /* LHCR0 is offset from the end of the H8S/2168-compatible registers */
>> >>  #define LHCR0		0x20
>> >> @@ -660,8 +661,8 @@ SSSF_PIN_DECL(T2, GPIOL0, NCTS1, SIG_DESC_SET(SCU84, 16));
>> >>  
>> >>  #define T1 89
>> >>  #define T1_DESC		SIG_DESC_SET(SCU84, 17)
>> >> -SIG_EXPR_LIST_DECL_SINGLE(VPIDE, VPI24, VPI_24_RSVD_DESC, T1_DESC, COND2);
>> >> -SIG_EXPR_LIST_DECL_SINGLE(NDCD1, NDCD1, T1_DESC, COND2);
>> >> +SIG_EXPR_LIST_DECL_SINGLE(VPIDE, VPI24, VPI_24_RSVD_DESC, T1_DESC, COND6);
>> >> +SIG_EXPR_LIST_DECL_SINGLE(NDCD1, NDCD1, T1_DESC, COND6);
>> > 
>> > I feel like you didn't test this patch, because VPI_24_RSVD_DESC (the DVI
>> > condition)
>> > requires SCU90[5]=0b1, but your introduction of COND6 requires SCU90[5:4]=0b00
>> > for
>> > the mux configuration to succeed. This can't work - bit 5 of SCU90 can not
>> > simultaneously take the values 1 and 0.
>> 
>> That's correct -- I don't have hardware that supports DVI available to
>> test with.
> 
> Okay. In that case I'm not prepared to ACK changes here, much less changes with
> that fail in this way. The current implementation at least follows what is
> dictated by
> the programming guide and is at least correct in theory.
> 
> As Ryan is not confident there are no negative side-effects to not following the
> configuration dictated by the programming guide, changes like this have a real
> up-hill battle on their hands.
> 
> Cheers,
> 
> Andrew

There is a negative effect right now in that enabling either UART will force disable the DVO pinmuxes.  While I agree the patch needs additional work, as it stands right now DVO will not function simultaneously with the UART without a patched kernel.

From where I stand I am fairly confident in a documentation error, however I do not have access to the hardware required to prove this.  Can someone at ASpeed look at the HDL and verify or correct the documentation?  We have already caught one documentation error relating to COND2 and DVO, and verified that one in hardware.

Thank you!
