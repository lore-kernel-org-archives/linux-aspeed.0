From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 8 Sep 2021 10:18:35 +0000
Subject: [PATCH v2 0/3] arm: aspeed: Add UART routing support
In-Reply-To: <20210908094248.GZ23326@home.paul.comp>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
 <20210908094248.GZ23326@home.paul.comp>
Message-ID: <HK0PR06MB3779180F75DB8BD872F8A78391D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Paul,

> From: Paul Fertser <fercerpav@gmail.com>
> Sent: Wednesday, September 8, 2021 5:43 PM
> 
> Hello,
> 
> On Thu, Sep 02, 2021 at 10:18:13AM +0800, Chia-Wei Wang wrote:
> > Add UART routing driver and the device tree nodes.
> 
> Thank you for working on exposing this functionality in upstreamable way,
> that's so much better than all the register-level hacks in U-Boot and similar
> approaches!
> 
> 
> One (somewhat) related question that I hope you do not mind answering:
> is there anything special regarding the routing or other configuration that
> needs to be done for VUART to work with IRQs?

No. The routing control has no relation to VUART.

> 
> The reason I ask is that I have tried hard (and I know several other developers
> who have too) to use VUART functionality but somehow as soon as Linux was
> booting on host and starting to use the IRQ-based
> 16550 driver the communication was halted both ways. Basically, the BMC
> firmware was enabling VUART in DTS, then setting LPC address to
> 0x3F8 and LPC IRQ to 4 and reading/writing using the corresponding
> /dev/ttyS* node. The datasheet is not clearly telling what other actions need to
> be performed for this to work. Not using VUART and instead routing UART1
> lines with exactly the same pinctrl/pinmux worked just fine. One detail is that
> with VUART the host wasn't seeing new interrupts but when they were
> simulated by exporting the LPC interrupt pin via /sys/class/gpio and toggling it
> manually the data was getting through.
> 
> Does UART1 need some explicit disabling for VUART IRQs to work? It looks like
> setting LPC address and IRQ number in VUART is enough to override the
> register part but probably not for the interrupt?

You may need to confirm that the Host does not enable the SIO SUART1 device.
This will conflict with VUART as both SUART and VAURT are competing for the port address 0x3f8 and SIRQ 4.

> 
> --
> Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
> mailto:fercerpav at gmail.com
