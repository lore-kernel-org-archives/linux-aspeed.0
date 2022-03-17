From: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Date: Fri, 18 Mar 2022 02:40:24 +0530
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
In-Reply-To: <87h77wxslh.wl-maz@kernel.org>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
 <87h77wxslh.wl-maz@kernel.org>
Message-ID: <20220317211024.GA99538@9a2d8922b8f1>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 17, 2022 at 07:54:34PM +0000, Marc Zyngier wrote:
> On Thu, 17 Mar 2022 19:15:26 +0000,
> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> > 
> > Arch timer either require clock-frequency property or doesn't need to
> > specify clock at all in DT. In general, frequency can be determined
> > internally and in case of brokern firmwares, need to extend
> > clock-frequency to pass info to driver.
> 
> A clock frequency and a clock are not the same thing.

Yes Marc, That's what I have mentioned in commit description.

Driver uses "clock-frequency" property only and doesn't take inputs from
"clocks" property. So, any platform should refrain from defining such
entity at first place in DT. Binding also says the same i.e pass info
via "clock-frequency" property and no mention of "clocks".

> 
> > 
> > Aspeed BMC is the platform which defines clocks property, an invalid
> > entry which can be safely removed.
> 
> Safely removed? Says who? Have you tested this change?

Since "clocks" is never read by driver and driver incorporates
"clock-frequency" which was certainly not defined here, I believe this
reasoning is sufficient for my clause. As it's safe to remove an entry
which was never used.

Please note, it's just Aspeed BMC which had "clocks" defined, other
platforms which require input from DT have extended "clock-frequency"
property like I mentioned before.

I don't possess this platform physically,and did successfull compile
time testing. I have initally copied few Aspeed folks, they can help in
reviewing and confirming this.

> 
> > 
> > Moreover, clocks also matches incorrectly with the regex pattern.
> > Remove this entry altogether to fix it.
> > 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> NAK. That's not a reason to randomly butcher things.

I hope I explained my reasons above.

- Kuldeep
