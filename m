From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 2 Nov 2021 03:15:52 +0000
Subject: [PATCH -next 4/4] ipmi: kcs_bmc_aspeed: add clock control logic
In-Reply-To: <20211101233751.49222-5-jae.hyun.yoo@intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <20211101233751.49222-5-jae.hyun.yoo@intel.com>
Message-ID: <HK0PR06MB3779F8E273396ED805EE5D81918B9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jae,

> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> 
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> If LPC KCS driver is registered ahead of lpc-ctrl module, LPC KCS block will be
> enabled without heart beating of LCLK until lpc-ctrl enables the LCLK. This
> issue causes improper handling on host interrupts when the host sends
> interrupts in that time frame.
> Then kernel eventually forcibly disables the interrupt with dumping stack and
> printing a 'nobody cared this irq' message out.
> 
> To prevent this issue, all LPC sub drivers should enable LCLK individually so this
> patch adds clock control logic into the LPC KCS driver.

Have all LPC sub drivers could result in entire LPC block down if any of them disables the clock (e.g. driver unload).
The LPC devices such as SIO can be used before kernel booting, even without any BMC firmware.
Thereby, we recommend to make LCLK critical or guarded by protected clock instead of having all LPC sub drivers hold the LCLK control.

The previous discussion for your reference:
https://lkml.org/lkml/2020/9/28/153

Regards,
Chiawei
