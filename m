From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 13 Feb 2023 04:18:16 +0000
Subject: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <34e3729f-9266-3606-9f11-33222f50e753@molgen.mpg.de>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-4-chiawei_wang@aspeedtech.com>
 <34e3729f-9266-3606-9f11-33222f50e753@molgen.mpg.de>
Message-ID: <KL1PR0601MB3781ABE9B28372C88E62946491DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Friday, February 10, 2023 6:35 PM
> 
> Dear Chia-Wei,
> 
> 
> Thank you for your patch.
> 
> Am 10.02.23 um 08:26 schrieb Chia-Wei Wang:
> > Add the driver for Aspeed UART/VUART devices, which are 16550A
> > compatible. It is an wrapper to cover the generic 16550A operation
> 
> a wrapper
> 
> > while exetending DMA feature for the devices.
> 
> extending
> 
> Is this for all ASPEED devices or only current ones?

There is major design change of UDMA.
Therefore, this patch is for AST2600 only.

> 
> How did you test this? What is the maximum transfer speed?

Yes.
I can't remember the precise data. The experiment was done like 2 years ago.
But it should be above 2MB/s

> 
> There are other serial drivers also supporting DMA, and those seem to use
> DMAengine?
> 
>      $ git grep dmaengine drivers/tty/serial/8250/
> 

Yes.
The UDMA design is dedicated to, and tightly coupled with each UART/VUART devices.
And UDMA does not support common DMA control such as suspend/resume.

We found certain discussions in the old mailing list saying that if a DMA controller is not fully fit into the DMAEngine subsystem,
placing the implementation in the soc folder might be an option.

Regards,
Chiawei
