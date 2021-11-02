From: Joel Stanley <joel@jms.id.au>
Date: Tue, 2 Nov 2021 03:28:57 +0000
Subject: [PATCH -next 4/4] ipmi: kcs_bmc_aspeed: add clock control logic
In-Reply-To: <HK0PR06MB3779F8E273396ED805EE5D81918B9@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <20211101233751.49222-5-jae.hyun.yoo@intel.com>
 <HK0PR06MB3779F8E273396ED805EE5D81918B9@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <CACPK8XesLdb+Cbi3ZYrOahRHbXQi3L=cQXax=RV2=PrjiPQBew@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2 Nov 2021 at 03:16, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Hi Jae,
>
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> >
> > From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >
> > If LPC KCS driver is registered ahead of lpc-ctrl module, LPC KCS block will be
> > enabled without heart beating of LCLK until lpc-ctrl enables the LCLK. This
> > issue causes improper handling on host interrupts when the host sends
> > interrupts in that time frame.
> > Then kernel eventually forcibly disables the interrupt with dumping stack and
> > printing a 'nobody cared this irq' message out.
> >
> > To prevent this issue, all LPC sub drivers should enable LCLK individually so this
> > patch adds clock control logic into the LPC KCS driver.
>
> Have all LPC sub drivers could result in entire LPC block down if any of them disables the clock (e.g. driver unload).
> The LPC devices such as SIO can be used before kernel booting, even without any BMC firmware.
> Thereby, we recommend to make LCLK critical or guarded by protected clock instead of having all LPC sub drivers hold the LCLK control.
>
> The previous discussion for your reference:
> https://lkml.org/lkml/2020/9/28/153

Please read the entire thread. The conclusion:

https://lore.kernel.org/all/CACPK8XdBmkhZ8mcSFmDAFV8k7Qj7ajBL8TVKfK8c+5aneUMHZw at mail.gmail.com/

That is, for the devices that have a driver loaded can enable the
clock. When they are unloaded, they will reduce the reference count
until the last driver is unloaded. eg:

https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk.c#L945

There was another fork to the thread, where we suggested that a
protected clocks binding could be added:

https://lore.kernel.org/all/160269577311.884498.8429245140509326318 at swboyd.mtv.corp.google.com/

If you wish to use this mechanism for eg. SIO clocks, then I encourage
Aspeed to submit a patch to do that.

Cheers,

Joel
