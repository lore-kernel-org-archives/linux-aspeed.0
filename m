From: Marc Zyngier <maz@kernel.org>
Date: Thu, 17 Mar 2022 21:46:12 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
In-Reply-To: <20220317211024.GA99538@9a2d8922b8f1>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
 <87h77wxslh.wl-maz@kernel.org>
 <20220317211024.GA99538@9a2d8922b8f1>
Message-ID: <87fsngxnff.wl-maz@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 17 Mar 2022 21:10:24 +0000,
Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> 
> On Thu, Mar 17, 2022 at 07:54:34PM +0000, Marc Zyngier wrote:
> > On Thu, 17 Mar 2022 19:15:26 +0000,
> > Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> > > 
> > > Arch timer either require clock-frequency property or doesn't need to
> > > specify clock at all in DT. In general, frequency can be determined
> > > internally and in case of brokern firmwares, need to extend
> > > clock-frequency to pass info to driver.
> > 
> > A clock frequency and a clock are not the same thing.
> 
> Yes Marc, That's what I have mentioned in commit description.
>
> Driver uses "clock-frequency" property only and doesn't take inputs from
> "clocks" property. So, any platform should refrain from defining such
> entity at first place in DT. Binding also says the same i.e pass info
> via "clock-frequency" property and no mention of "clocks".

And what do you think provides this clock frequency? Do you believe it
comes out of thin air? No, the driver doesn't use a clock, because it
*assumes* the clock feeding the counter is enabled at all times.

Does it mean such clock doesn't exist?

> 
> > 
> > > 
> > > Aspeed BMC is the platform which defines clocks property, an invalid
> > > entry which can be safely removed.
> > 
> > Safely removed? Says who? Have you tested this change?
> 
> Since "clocks" is never read by driver and driver incorporates
> "clock-frequency" which was certainly not defined here, I believe this
> reasoning is sufficient for my clause. As it's safe to remove an entry
> which was never used.

Really? And you have of course audited all possible firmware
implementations (the bootloader, for example, which would *enable*
this clock) and other operating systems than Linux that use the same
DT and run on the same HW?

The kernel tree unfortunately serves as a repository for all the DTs,
including for payloads other than Linux.

> Please note, it's just Aspeed BMC which had "clocks" defined, other
> platforms which require input from DT have extended "clock-frequency"
> property like I mentioned before.

Again: clock frequency and clock are not the same thing.

> I don't possess this platform physically,and did successfull compile
> time testing. I have initally copied few Aspeed folks, they can help in
> reviewing and confirming this.
> 
> > 
> > > 
> > > Moreover, clocks also matches incorrectly with the regex pattern.
> > > Remove this entry altogether to fix it.
> > > 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 
> > NAK. That's not a reason to randomly butcher things.
> 
> I hope I explained my reasons above.

My position on this sort of change remains. Blindly changing existing
DTs based on a warning provided by a tool that totally ignores the
reality of what is out there is not acceptable.

	M.

-- 
Without deviation from the norm, progress is not possible.
