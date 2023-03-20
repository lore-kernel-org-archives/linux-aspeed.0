From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 20 Mar 2023 02:54:46 +0000
Subject: [PATCH v2 3/5] dmaengine: aspeed: Add AST2600 UART DMA driver
In-Reply-To: <20230318030113.2024-1-hdanton@sina.com>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230318030113.2024-1-hdanton@sina.com>
Message-ID: <KL1PR0601MB37815BD56FC3EEA2553432B191809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Hillf Danton <hdanton@sina.com>
> Sent: Saturday, March 18, 2023 11:01 AM
> 
> On 14 Mar 2023 10:18:15 +0800 Chia-Wei Wang
> <chiawei_wang@aspeedtech.com>
> > +static irqreturn_t ast2600_udma_isr(int irq, void *arg) {
> 
> [...]
> 
> > +	/* handle RX interrupt */
> > +	sts = readl(udma->regs + UDMA_RX_INT_STS);
> > +	for_each_set_bit(ch_bit, (unsigned long *)&sts, udma->n_ucs / 2) {
> > +		ch_id = (ch_bit << 1) + 1;
> > +		wptr = readl(udma->regs + UDMA_CH_WPTR(ch_id));
> > +
> > +		uc = &udma->ucs[ch_id];
> > +		ud = &uc->ud;
> > +		tx = &ud->tx;
> > +
> > +		uc->residue = (ud->size & ~UDMA_CH_CTRL_BUFSZ) - wptr;
> > +
> > +		/* handle non-4B-aligned case */
> > +		if (ud->addr & 0x3) {
> > +			p = phys_to_virt(dma_to_phys(uc->chan.device->dev,
> ud->addr));
> 
> This does not work if the dma address has no corresponding struct page.

Will add the error check for dma_to_phys to prevent further unexpected memory accesses.

Thanks,
Chiawei

> 
> > +			memcpy(p, uc->buf, wptr);
> > +		}
> > +
> > +		ast2600_udma_terminate(&uc->chan);
> > +
> > +		dma_cookie_complete(tx);
> > +		dma_descriptor_unmap(tx);
> > +		dmaengine_desc_get_callback_invoke(tx, NULL);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
