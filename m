From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 25 Nov 2019 10:31:13 +1030
Subject: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
In-Reply-To: <a600a526-2f11-4a37-b4f3-8f53c533db02@www.fastmail.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>
 <a600a526-2f11-4a37-b4f3-8f53c533db02@www.fastmail.com>
Message-ID: <e4d49ccb-8b83-4c85-9be1-48d77c0000e2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> > +static int aspeed_xdma_remove(struct platform_device *pdev)
> > +{
> > +	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
> > +
> > +	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
> > +		      XDMA_CMDQ_SIZE);
> 
> You've used devm_gen_pool_create(), so no need to explicitly free it.

Sorry, disregard that, brain-fart.

Andrew
