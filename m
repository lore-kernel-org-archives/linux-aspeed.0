From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 23 Feb 2023 01:56:00 +0000
Subject: [PATCH v5 1/4] crypto: aspeed: Add ACRY RSA driver
In-Reply-To: <CAMuHMdVS_JF0+5CyNM6ivxqRLKkMte9=Xw5E-fc-OTHibwc5vw@mail.gmail.com>
References: <20230104013436.203427-1-neal_liu@aspeedtech.com>
 <20230104013436.203427-2-neal_liu@aspeedtech.com>
 <CAMuHMdVS_JF0+5CyNM6ivxqRLKkMte9=Xw5E-fc-OTHibwc5vw@mail.gmail.com>
Message-ID: <TY2PR06MB3213D7FEB7D3FF472419419E80AB9@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Hi Neal,
> 
> On Wed, Jan 4, 2023 at 2:37 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
> > ACRY Engine is designed to accelerate the throughput of ECDSA/RSA
> > signature and verification.
> >
> > This patch aims to add ACRY RSA engine driver for hardware
> > acceleration.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> 
> Thanks for your patch, which is now commit 2f1cf4e50c956f88 ("crypto:
> aspeed - Add ACRY RSA driver").
> 
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/aspeed-acry.c
> 
> > +static int aspeed_acry_probe(struct platform_device *pdev) {
> > +       struct aspeed_acry_dev *acry_dev;
> > +       struct device *dev = &pdev->dev;
> > +       struct resource *res;
> > +       int rc;
> > +
> > +       acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
> > +                               GFP_KERNEL);
> > +       if (!acry_dev)
> > +               return -ENOMEM;
> > +
> > +       acry_dev->dev = dev;
> > +
> > +       platform_set_drvdata(pdev, acry_dev);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       acry_dev->regs = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(acry_dev->regs))
> > +               return PTR_ERR(acry_dev->regs);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +       acry_dev->acry_sram = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(acry_dev->acry_sram))
> > +               return PTR_ERR(acry_dev->acry_sram);
> > +
> > +       /* Get irq number and register it */
> > +       acry_dev->irq = platform_get_irq(pdev, 0);
> > +       if (acry_dev->irq < 0)
> > +               return -ENXIO;
> > +
> > +       rc = devm_request_irq(dev, acry_dev->irq, aspeed_acry_irq, 0,
> > +                             dev_name(dev), acry_dev);
> > +       if (rc) {
> > +               dev_err(dev, "Failed to request irq.\n");
> > +               return rc;
> > +       }
> > +
> > +       acry_dev->clk = devm_clk_get_enabled(dev, NULL);
> > +       if (IS_ERR(acry_dev->clk)) {
> > +               dev_err(dev, "Failed to get acry clk\n");
> > +               return PTR_ERR(acry_dev->clk);
> > +       }
> > +
> > +       acry_dev->ahbc =
> syscon_regmap_lookup_by_phandle(dev->of_node,
> > +
> "aspeed,ahbc");
> > +       if (IS_ERR(acry_dev->ahbc)) {
> > +               dev_err(dev, "Failed to get AHBC regmap\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* Initialize crypto hardware engine structure for RSA */
> > +       acry_dev->crypt_engine_rsa = crypto_engine_alloc_init(dev, true);
> > +       if (!acry_dev->crypt_engine_rsa) {
> > +               rc = -ENOMEM;
> > +               goto clk_exit;
> > +       }
> > +
> > +       rc = crypto_engine_start(acry_dev->crypt_engine_rsa);
> > +       if (rc)
> > +               goto err_engine_rsa_start;
> > +
> > +       tasklet_init(&acry_dev->done_task, aspeed_acry_done_task,
> > +                    (unsigned long)acry_dev);
> > +
> > +       /* Set Data Memory to AHB(CPU) Access Mode */
> > +       ast_acry_write(acry_dev, ACRY_CMD_DMEM_AHB,
> > + ASPEED_ACRY_DMA_CMD);
> > +
> > +       /* Initialize ACRY SRAM index */
> > +       aspeed_acry_sram_mapping(acry_dev);
> > +
> > +       acry_dev->buf_addr = dmam_alloc_coherent(dev,
> ASPEED_ACRY_BUFF_SIZE,
> > +
> &acry_dev->buf_dma_addr,
> > +                                                GFP_KERNEL);
> > +       memzero_explicit(acry_dev->buf_addr,
> ASPEED_ACRY_BUFF_SIZE);
> 
> When compile-testing with CONFIG_HAS_DMA=n:
> 
>     error: argument 1 null where non-null expected [-Werror=nonnull]
> 
> The call to dmam_alloc_coherent() lacks error handling, as the returned
> address may be NULL.

Thanks for your reminding. I'll add error handling for this.

> Moreover, is it safe to allocate this buffer only after the call to
> crypto_engine_start()? I.e. could acry_dev->buf_addr be accessed before,
> causing a NULL pointer dereference?
> Is there any other initialization that should be done earlier?

This does not seem to be any problem since acry_dev->buf_addr only be accessed when HW has task to do.
And the HW has task to do only after the algorithm be registered, which is after acry_dev->buf_addr initialization.

> > +
> > +       aspeed_acry_register(acry_dev);
> > +
> > +       dev_info(dev, "Aspeed ACRY Accelerator successfully
> > + registered\n");
> > +
> > +       return 0;
> > +
> > +err_engine_rsa_start:
> > +       crypto_engine_exit(acry_dev->crypt_engine_rsa);
> > +clk_exit:
> > +       clk_disable_unprepare(acry_dev->clk);
> > +
> > +       return rc;
> > +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
