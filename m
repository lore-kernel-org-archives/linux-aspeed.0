From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 3 Nov 2021 01:55:41 +0000
Subject: [PATCH -next 4/4] ipmi: kcs_bmc_aspeed: add clock control logic
In-Reply-To: <edaeb540-aa31-d143-4320-cb2a73f0070f@linux.intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <20211101233751.49222-5-jae.hyun.yoo@intel.com>
 <HK0PR06MB3779F8E273396ED805EE5D81918B9@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8XesLdb+Cbi3ZYrOahRHbXQi3L=cQXax=RV2=PrjiPQBew@mail.gmail.com>
 <edaeb540-aa31-d143-4320-cb2a73f0070f@linux.intel.com>
Message-ID: <HK0PR06MB377977167B4AD45BF9775349918C9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Sent: Wednesday, November 3, 2021 12:36 AM
> 
> On 11/1/2021 8:28 PM, Joel Stanley wrote:
> > On Tue, 2 Nov 2021 at 03:16, ChiaWei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >>
> >> Hi Jae,
> >>
> >>> From: linux-arm-kernel
> >>> <linux-arm-kernel-bounces@lists.infradead.org> On
> >>>
> >>> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >>>
> >>> If LPC KCS driver is registered ahead of lpc-ctrl module, LPC KCS
> >>> block will be enabled without heart beating of LCLK until lpc-ctrl
> >>> enables the LCLK. This issue causes improper handling on host
> >>> interrupts when the host sends interrupts in that time frame.
> >>> Then kernel eventually forcibly disables the interrupt with dumping
> >>> stack and printing a 'nobody cared this irq' message out.
> >>>
> >>> To prevent this issue, all LPC sub drivers should enable LCLK
> >>> individually so this patch adds clock control logic into the LPC KCS driver.
> >>
> >> Have all LPC sub drivers could result in entire LPC block down if any of them
> disables the clock (e.g. driver unload).
> >> The LPC devices such as SIO can be used before kernel booting, even
> without any BMC firmware.
> >> Thereby, we recommend to make LCLK critical or guarded by protected
> clock instead of having all LPC sub drivers hold the LCLK control.
> >>
> >> The previous discussion for your reference:
> >> https://lkml.org/lkml/2020/9/28/153
> >
> > Please read the entire thread. The conclusion:
> >
> >
> https://lore.kernel.org/all/CACPK8XdBmkhZ8mcSFmDAFV8k7Qj7ajBL8TVKfK8c
> +
> > 5aneUMHZw at mail.gmail.com/
> >
> > That is, for the devices that have a driver loaded can enable the
> > clock. When they are unloaded, they will reduce the reference count
> > until the last driver is unloaded. eg:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk.c#L945
> >
> > There was another fork to the thread, where we suggested that a
> > protected clocks binding could be added:
> >
> >
> https://lore.kernel.org/all/160269577311.884498.8429245140509326318 at sw
> > boyd.mtv.corp.google.com/
> >
> > If you wish to use this mechanism for eg. SIO clocks, then I encourage
> > Aspeed to submit a patch to do that.
> 
> We are revisiting the aged discussion. Thanks for bringing it back.
> 
> I agree with Joel that a clock should be enabled only on systems that need the
> clock actually so it should be configurable by a device driver or through device
> tree setting,?not by the static setting in clk-ast2600.c code. So that's the
> reason why I stopped upstreaming below change for making BCLK as a critical
> clock.
> 
> https://www.spinics.net/lists/linux-clk/msg44836.html
> 
> Instead, I submitted these two changes to make it configurable through device
> tree setting.
> 
> https://lists.ozlabs.org/pipermail/linux-aspeed/2020-January/003394.html
> https://lists.ozlabs.org/pipermail/linux-aspeed/2020-January/003339.html
> 
> But these were not accepted too.
> 
> And recently, Samuel introduced a better and more generic way.
> 
> https://lore.kernel.org/all/20200903040015.5627-2-samuel at sholland.org/
> 
> But it's not accepted?yet either.
> 
> 
> Chiawei,
> 
> Please refine the mechanism and submit a change to make SIO clocks
> configurable through device tree setting. I believe?that we can keep this patch
> series even with the change, or it can be modified and adjusted if needed after
> the SIO clocks fix is accepted.

Thanks for your feedback and the information shared.
We will keep tracking these changes and construct a compatible patch for the SIO clocks.

Regards,
Chiawei
