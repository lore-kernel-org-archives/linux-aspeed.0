From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 21 Oct 2019 14:16:29 +0200
Subject: AST2600 i2c irq issue
In-Reply-To: <8c62b118777c44d1bf8e1a3c32175644@TWMBX02.aspeed.com>
References: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
 <f9fecc04-2a9a-4cbd-a1ff-ffb680b0fec2@linux.vnet.ibm.com>
 <dbb8635e-a95a-3951-cd65-3428adc461ec@linux.intel.com>
 <8c62b118777c44d1bf8e1a3c32175644@TWMBX02.aspeed.com>
Message-ID: <20191021121629.GE1145@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


>          spin_lock(&bus->lock);
>          irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +       if (!irq_received)
> +               return IRQ_NONE;
> +
>          /* Ack all interrupts except for Rx done */
>          writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
>                 bus->base + ASPEED_I2C_INTR_STS_REG);
> 
> 
> I think it's a right fix for the issue. At least, we need to prevent
> any driver state corruption. The state machine would run correctly if
> we filtering the garbage interrupt out.

Just unlock the spinlock before you return...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191021/eeb5c44a/attachment.sig>
