From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 03 Nov 2021 08:44:15 +1030
Subject: [PATCH -next 2/4] ipmi: bt: add clock control logic
In-Reply-To: <20211101233751.49222-3-jae.hyun.yoo@intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <20211101233751.49222-3-jae.hyun.yoo@intel.com>
Message-ID: <602c4784-9ef2-405f-95ef-d75e56d4505e@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 2 Nov 2021, at 10:07, jae.hyun.yoo at intel.com wrote:
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>
> If LPC BT driver is registered ahead of lpc-ctrl module, LPC BT
> hardware block will be enabled without heart beating of LCLK until
> lpc-ctrl enables the LCLK. This issue causes improper handling on
> host interrupts when the host sends interrupts in that time frame.
> Then kernel eventually forcibly disables the interrupt with
> dumping stack and printing a 'nobody cared this irq' message out.
>
> To prevent this issue, all LPC sub drivers should enable LCLK
> individually so this patch adds clock control logic into the LPC
> BT driver.
>
> Fixes: 54f9c4d0778b ("ipmi: add an Aspeed BT IPMI BMC driver")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
