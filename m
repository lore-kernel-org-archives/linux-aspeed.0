Return-Path: <linux-aspeed+bounces-4240-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD3BCD98C7
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 00:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc0Kr5PVSz3bpt;
	Fri, 12 Jun 2026 10:11:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::433" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781167278;
	cv=pass; b=Bm+08tHaJbPuFP9TlQA8wYmZ+6to0Wd8AqeLmpufi/kEl75aJdz4YDfCya6yvXkP70ON842906Yo9ISRvQAqZVNujkNv3wiub9gY0l0VAmjUyeVrnTypAmr/l1wV0IFL1qIfbMtaCek4wbCniNBmol9aSgxQ9QEnEUSImxfcvWbjkSPnDUdAB207ij+Mn0by2cNKcxKI4M6JSwb46Ntz3safFE9bN2s+Fmjhw71MPkaHa9FIA3OIgsWeTpGem+8GD+Hkm9ddAxs/GXo7+6CZmxUJ+mmGuMqznRYttZ+MPhZ83CA8paijbMDnF63sqT362Sa+1VMvG5wnupZ2Ev4sgA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781167278; c=relaxed/relaxed;
	bh=JTPVC8sYyjTfHyV7EHjLW7I9an+WzGbbpL9DBfg5REw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMbC37UntLlUpMKlcX4lQI2mskuufQ3B+6bNnf+RQ6lMa+4AI1bNrDhz3fiEJ9eiT6fE3b3KlLWD6LFO2U8Hi5qgQ6VsVjc62AQS+YekdQyVdjNGvLfF4gg0vDPr7maddqdqbar1PHUG+HiAx3ImH3SnPTNIqThrAKIL+xFIVPLy9XyULqZajLBpEZuqtsJ4u/G7lulwrNBNb9M3I0NyFqDPgqtn0UCsIBoWQkF4GlzCtOcYY7PjW9qJ1/ZAXIXSR8hoXax1F4QOEUOpJfu1LviRCoCBxrefZ9MVof8+u/hAJ4joliWHwuCZC2xT0nuMcmflfCXcEdrA+AhFez6FFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=dOvOlJpf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=dOvOlJpf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbbhs2Vrbz2xLk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 18:41:16 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-4600cbb06deso356388f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 01:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167273; cv=none;
        d=google.com; s=arc-20240605;
        b=KKpoQJiLhnHBlemfVDINpzKv0uIziMcIZvnCwTXRd7hUHgmHFKfRmNeAGTj/Wif0vk
         ZWAv6eamGMxrDBP1c+3nLmNP5vYgf6HPCNpe/FJ2jEDrNhF3I6XtCkrhWK8eq6S5gmhS
         ie2a8J4laNnjYRNnmMXQwOMBQ4pD69xll+EWx/uX3sEohD7bhCfOksLGsROO0GokQq5d
         2vt+F7a96X86e05wOO+zOSJCRzH9y1regaXXqz3R1Ft1YxWyYVlH9z6UgkflCojdjQob
         glpU8oi/9dPdOfyK5+JFAoczOsUdd0bTukD+G6KG4CPN2dsflC4x6QE8UZsaEpp8Rkxh
         S7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JTPVC8sYyjTfHyV7EHjLW7I9an+WzGbbpL9DBfg5REw=;
        fh=YxncqvVUrYkxymAjBiIAoxEKQjIoPPWJ1LafHHSSzBM=;
        b=GnxPbcSa79JLRVORg8wLOIgATa/7LFtH5wRi1ad7MdIha2qRHxB6K/23lbRvMAJ/EQ
         uYSbGRhkFfCHo7NWfZ8vvdYU7L9g5R2K44Ber8QoWWiwRLXB1KCfZ3O4oA5W/BYaHvTD
         BlFrgoCBpVesQ8BHFb1TvyQgZNLoDd3XNVZzL4GAkJizOqehq/hGwOYAupoM5aZnCC4G
         cCG74CuUgyF5C/T/gnrPaB+/qPLoKSuxjmIDs/hHsCBxv870UbY+slZZXYvAw3CKXbRJ
         MNnBskcr4BhALlmB541eZV4kfOf5Yp73vSZbps6iFgraRw3KOnGsoEuYKYyinQMLKCG+
         83uA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781167273; x=1781772073; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTPVC8sYyjTfHyV7EHjLW7I9an+WzGbbpL9DBfg5REw=;
        b=dOvOlJpfHfo391jbV8LbhRY7dfhyDmna3VSf4sHaeCXE1NFsS8T6r9bHyebBZr3F14
         0fTl/FlJ8t9k1p+YuIprFKqrodY1mYgp6d/dNrtNVJP08LNTYbr9Kh0ykKpUAUHBRCbP
         VnbShzLXpxLY/9O2SjacO2S1MEYIBcofbQuCE19u1ykO1PP1x6mWFcxCUTkrLFiuJsF5
         VE71+x7oltFsKUQKJ13xVgScSVL9KhEEkAd82rJJeanCMolTMgy3O37QSgMZemEf5K8r
         IGe5qir0s7fV94CQ9SshQklaWSwmshCMwyF3U7ND+DWxkLJoc/nwV1CKXIwWh2FYRw/B
         v90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167273; x=1781772073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTPVC8sYyjTfHyV7EHjLW7I9an+WzGbbpL9DBfg5REw=;
        b=bYJmNWVczu7u/4hj2L3E+9sqgbMtRSr6fRd/MKKe57oRH8VyDXB2E1nR+Z4XoVwmYT
         ieT2Unk3cYQ5Okybf1B6b0JYS1c0/jNx4/L7vMlkrRp2TjLYBqknv4WyeN2RFS87ElU8
         rypIj0rVgF3l/GxwX7abJTTIrXmvigdwZyiBHyFohU3d1twDKk5sbpkS4bwtM1fwmmGw
         cjaznzrVyjJWDsAXzW0gCIuC+jzvX4YwsOLgN2EQL7ROORZhceebbhNQ06orRq1NFKW5
         AARmrQrWZEdujkipnKCiikMO+8Xt/aey5mUSKQQCPN4GM0KT65XavfWjDT58PvyZxCLO
         P4vw==
X-Forwarded-Encrypted: i=1; AFNElJ+diUUc5o3ZaRjgNk071hRgrtzCcbN0TKD8jVaFUQQguVrxOLLXpD95EsXx1RziDsPhD6H/tclr6WEWOHs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyROdFvkIBVpYFHBhgIBxOrVn1oV5IvEOH+zOR2cuUsWNbOP4Rh
	Z07z9f6IMM6Nm3T9TZhNZ/o96VwNm0hL6HG6kOFPA0PfAP11T85R94uEH3+lyRaVvvJjIMp/CO6
	tRgMF3zJMqsvMzNCykcuhTMnU6rLF3MCNbVpLHX1f0Q==
X-Gm-Gg: Acq92OHhUR43N5YRSNYDnhH/pOgd7Nt7RIJrNUR44nv2A7x7mBTLXH2Fkt1+DbB54nE
	AVHjNOyvd1y35fkNk/Z44mNZNlY2rSWKRohMAu9KaIZ1elZb0gCdOmxAX/jj5xZ5r2zSzsZgrx6
	Ik5TdJRyW9E9LUI+ZKqk5h23XuJxLp4VcNFhag7KGdCgVnrWEJkM7zX3fDtH0NzG8KuitbyB+IT
	cUqNggpl8m2TirqVN4kww5wnnwVAMvyevQxEvTiSfjwhcrCg+ocO8FoAwchG5kkv0BHP2EszBJb
	LNjQ6UEsW7w7KLQf7dN9vF5vasKGzNyhyOt6RggDwK8c6zPn7TpPxbtQVqUDDJm3o0ewHf3agDE
	K9VTo3L5GehMM5w==
X-Received: by 2002:a05:6000:46cd:b0:460:602f:85a6 with SMTP id
 ffacd0b85a97d-46067d76da0mr1633808f8f.0.1781167273598; Thu, 11 Jun 2026
 01:41:13 -0700 (PDT)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1780929570.git.gregoire.layet@9elements.com>
 <13d18d25f53e0a084a8c17219804b305d4667c6b.1780929570.git.gregoire.layet@9elements.com>
 <66df26f7ec827a0f48cd44c454bfd36968ca4dd0.camel@codeconstruct.com.au>
In-Reply-To: <66df26f7ec827a0f48cd44c454bfd36968ca4dd0.camel@codeconstruct.com.au>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 11 Jun 2026 10:41:02 +0200
X-Gm-Features: AVVi8CcKzYMP3f0b_avZn05_OrjMV_vz5NO3fLD-LF4m21UoudA5bOxe5V3JhCA
Message-ID: <CAFi2wKba=x5JUBdAkwaVf57s0zCwD3ChXV2-g=7=sv-A2ABzMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: aspeed: add host-side PCIe BMC device driver
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

> Again, I'd rather we avoid drivers/soc/aspeed.

If creating a new specific driver is the right move, where should it go if
not in drivers/soc/aspeed ?
But again, considering all you remarks, maybe this driver is unnecessary.

As initially the driver was doing all the PCI BMC device functionality
provided by ASPEED (shared memory, VUART, message queue and doorbell),
it made sense to have everything in a driver for this specific case.

However for a TTY-only driver, that might be excessive.
When I trimmed down the driver, I didn't consider whether the driver itself
was still necessary.
I think adding a new driver is not the right solution for this.

From my research, the ASPEED PCIe device could be added to the 8250_pci dri=
ver.
The ASPEED PCIe device has a specific device ID and Vendor ID.

What do you think about this?


Thanks,
Gr=C3=A9goire

On Wed, 10 Jun 2026 at 14:51, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2026-06-08 at 14:51 +0000, Gr=C3=A9goire Layet wrote:
> > Taken from ASPEED 6.18 Kernel SDK
> >
> > Add support for VUART over PCIe between BMC and host.
> > This add host side driver.
> >
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> > Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> > Tested-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> > ---
> >  drivers/soc/aspeed/Kconfig               |   8 +
> >  drivers/soc/aspeed/Makefile              |   1 +
> >  drivers/soc/aspeed/aspeed-host-bmc-dev.c | 249 +++++++++++++++++++++++
>
> Again, I'd rather we avoid drivers/soc/aspeed.
>
> >  3 files changed, 258 insertions(+)
> >  create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c
> >
> > diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> > index 3e1fcf3c3268..5deefb64e8c7 100644
> > --- a/drivers/soc/aspeed/Kconfig
> > +++ b/drivers/soc/aspeed/Kconfig
> > @@ -11,6 +11,14 @@ config ASPEED_BMC_DEV
> >         Enable support for the ASPEED AST2600 BMC Device.
> >         This exposes the PCIe-to-LPC bridge of the BMC to the host over=
 PCIe.
> >
> > +config ASPEED_HOST_BMC_DEV
> > +     tristate "ASPEED Host BMC Device"
> > +     depends on PCI
> > +     depends on SERIAL_8250
> > +     help
> > +       Enable support for the ASPEED AST2600 BMC Device on the Host.
> > +       This configure the PCIe and setup two 8250 compatible VUART por=
ts.
> > +
> >  config ASPEED_LPC_CTRL
> >       tristate "ASPEED LPC firmware cycle control"
> >       select REGMAP
> > diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> > index fab0d247df66..3fd3f6d8d36e 100644
> > --- a/drivers/soc/aspeed/Makefile
> > +++ b/drivers/soc/aspeed/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_ASPEED_BMC_DEV)         +=3D aspeed-bmc-dev.o
> > +obj-$(CONFIG_ASPEED_HOST_BMC_DEV)    +=3D aspeed-host-bmc-dev.o
> >  obj-$(CONFIG_ASPEED_LPC_CTRL)                +=3D aspeed-lpc-ctrl.o
> >  obj-$(CONFIG_ASPEED_LPC_SNOOP)               +=3D aspeed-lpc-snoop.o
> >  obj-$(CONFIG_ASPEED_UART_ROUTING)    +=3D aspeed-uart-routing.o
> > diff --git a/drivers/soc/aspeed/aspeed-host-bmc-dev.c b/drivers/soc/asp=
eed/aspeed-host-bmc-dev.c
> > new file mode 100644
> > index 000000000000..7cb52a770fb6
> > --- /dev/null
> > +++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
> > @@ -0,0 +1,249 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright (C) ASPEED Technology Inc.
> > +
> > +#include <linux/init.h>
> > +#include <linux/version.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/pci.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/serial_8250.h>
> > +
> > +static DEFINE_IDA(bmc_device_ida);
> > +
> > +#define VUART_MAX_PARMS      2
>
> Given the one supported piece of hardware we could avoid the associated
> loops and rather extract loop bodies to functions and call the function
> twice.
>
> > +#define MAX_MSI_NUM          8
> > +#define BMC_MULTI_MSI        32
> > +
> > +#define DRIVER_NAME "aspeed-host-bmc-dev"
> > +
> > +enum aspeed_platform_id {
> > +     ASPEED,
> > +};
> > +
> > +enum msi_index {
> > +     VUART0_MSI,
> > +     VUART1_MSI,
> > +};
> > +
> > +/* Match msi_index */
> > +static int ast2600_msi_idx_table[MAX_MSI_NUM] =3D { 16, 15 };
> > +
> > +struct aspeed_platform {
> > +     int (*setup)(struct pci_dev *pdev);
> > +};
> > +
> > +struct aspeed_pci_bmc_dev {
> > +     struct device *dev;
> > +     struct aspeed_platform *platform;
> > +     kernel_ulong_t driver_data;
> > +     int id;
> > +
> > +     unsigned long message_bar_base;
> > +     unsigned long message_bar_size;
> > +     void __iomem *msg_bar_reg;
> > +
> > +     struct uart_8250_port uart[VUART_MAX_PARMS];
> > +     int uart_line[VUART_MAX_PARMS];
> > +
> > +     /* Interrupt
> > +      * The index of array is using to enum msi_index
> > +      */
> > +     int *msi_idx_table;
> > +};
> > +
> > +static void aspeed_pci_setup_irq_resource(struct pci_dev *pdev)
> > +{
> > +     struct aspeed_pci_bmc_dev *pci_bmc_dev =3D pci_get_drvdata(pdev);
> > +
> > +     /* Assign static msi index table by platform */
> > +     pci_bmc_dev->msi_idx_table =3D ast2600_msi_idx_table;
> > +
> > +     if (pci_alloc_irq_vectors(pdev, 1, BMC_MULTI_MSI, PCI_IRQ_INTX | =
PCI_IRQ_MSI) <=3D 1)
> > +             /* Set all msi index to the first vector */
> > +             memset(pci_bmc_dev->msi_idx_table, 0, sizeof(int) * MAX_M=
SI_NUM);
> > +}
> > +
> > +static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev)
> > +{
> > +     struct aspeed_pci_bmc_dev *pci_bmc_dev =3D pci_get_drvdata(pdev);
> > +     struct device *dev =3D &pdev->dev;
> > +     u16 vuart_ioport;
> > +     int ret, i;
> > +
> > +     for (i =3D 0; i < VUART_MAX_PARMS; i++) {
> > +             /* Assign the line to non-exist device */
> > +             pci_bmc_dev->uart_line[i] =3D -ENOENT;
> > +             vuart_ioport =3D 0x3F8 - (i * 0x100);
> > +             pci_bmc_dev->uart[i].port.flags =3D UPF_SKIP_TEST | UPF_B=
OOT_AUTOCONF | UPF_SHARE_IRQ;
> > +             pci_bmc_dev->uart[i].port.uartclk =3D 115200 * 16;
> > +             pci_bmc_dev->uart[i].port.irq =3D
> > +                     pci_irq_vector(pdev, pci_bmc_dev->msi_idx_table[V=
UART0_MSI + i]);
> > +             pci_bmc_dev->uart[i].port.dev =3D dev;
> > +             pci_bmc_dev->uart[i].port.iotype =3D UPIO_MEM32;
> > +             pci_bmc_dev->uart[i].port.iobase =3D 0;
> > +             pci_bmc_dev->uart[i].port.mapbase =3D
> > +                     pci_bmc_dev->message_bar_base + (vuart_ioport << =
2);
> > +             pci_bmc_dev->uart[i].port.membase =3D 0;
> > +             pci_bmc_dev->uart[i].port.type =3D PORT_16550A;
> > +             pci_bmc_dev->uart[i].port.flags |=3D (UPF_IOREMAP | UPF_F=
IXED_PORT | UPF_FIXED_TYPE);
> > +             pci_bmc_dev->uart[i].port.regshift =3D 2;
> > +             ret =3D serial8250_register_8250_port(&pci_bmc_dev->uart[=
i]);
> > +             if (ret < 0) {
> > +                     dev_err_probe(dev, ret, "Can't setup PCIe VUART\n=
");
> > +                     return ret;
> > +             }
> > +             pci_bmc_dev->uart_line[i] =3D ret;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void aspeed_pci_host_bmc_device_release_vuart(struct pci_dev *p=
dev)
> > +{
> > +     struct aspeed_pci_bmc_dev *pci_bmc_dev =3D pci_get_drvdata(pdev);
> > +     int i;
> > +
> > +     for (i =3D 0; i < VUART_MAX_PARMS; i++) {
> > +             if (pci_bmc_dev->uart_line[i] >=3D 0)
> > +                     serial8250_unregister_port(pci_bmc_dev->uart_line=
[i]);
> > +     }
> > +}
> > +
> > +static int aspeed_pci_host_setup(struct pci_dev *pdev)
> > +{
> > +     struct aspeed_pci_bmc_dev *pci_bmc_dev =3D pci_get_drvdata(pdev);
> > +     int rc =3D 0;
> > +
> > +     /* Get Message BAR */
> > +     pci_bmc_dev->message_bar_base =3D pci_resource_start(pdev, 1);
> > +     pci_bmc_dev->message_bar_size =3D pci_resource_len(pdev, 1);
> > +     pci_bmc_dev->msg_bar_reg =3D pci_ioremap_bar(pdev, 1);
> > +     if (!pci_bmc_dev->msg_bar_reg)
> > +             return -ENOMEM;
> > +
> > +     if (pdev->revision < 0x27) {
> > +             /* AST2600 ERRTA40: dummy read */
>
> Can you please rather document what problem this is actually solving.
>
> > +             (void)__raw_readl((void __iomem *)pci_bmc_dev->msg_bar_re=
g);
> > +     } else {
> > +             /* AST2700 not supported */
> > +             pr_err("AST2700 detected but not supported");
>
> This logs an error but rc =3D 0 on return. Perhaps drop the log message
> and return an appropriate error code?
>
> > +             goto out_free0;
> > +     }
> > +
> > +     rc =3D aspeed_pci_bmc_device_setup_vuart(pdev);
> > +     if (rc) {
> > +             pr_err("Cannot setup Virtual UART");
> > +             goto out_free0;
> > +     }
> > +
> > +     return 0;
> > +
> > +out_free0:
> > +     pci_iounmap(pdev, pci_bmc_dev->msg_bar_reg);
> > +
> > +     return rc;
> > +}
> > +
> > +static struct aspeed_platform aspeed_pcie_host[] =3D {
> > +     { .setup =3D aspeed_pci_host_setup },
> > +     { 0 }
> > +};
> > +
> > +static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
> > +{
> > +     struct aspeed_pci_bmc_dev *pci_bmc_dev;
> > +     int rc =3D 0;
> > +
> > +     pr_info("ASPEED BMC PCI ID %04x:%04x, IRQ=3D%u\n", pdev->vendor, =
pdev->device, pdev->irq);
>
> I think we could do without this.
>
> > +
> > +     pci_bmc_dev =3D devm_kzalloc(&pdev->dev, sizeof(*pci_bmc_dev), GF=
P_KERNEL);
> > +     if (!pci_bmc_dev)
> > +             return -ENOMEM;
> > +
> > +     /* Get platform id */
> > +     pci_bmc_dev->driver_data =3D ent->driver_data;
> > +     pci_bmc_dev->platform =3D &aspeed_pcie_host[ent->driver_data];
> > +
> > +     pci_bmc_dev->id =3D ida_alloc(&bmc_device_ida, GFP_KERNEL);
>
> This seems unnecessary.
>
> > +     if (pci_bmc_dev->id < 0)
> > +             return pci_bmc_dev->id;
> > +
> > +     rc =3D pci_enable_device(pdev);
> > +     if (rc) {
> > +             dev_err(&pdev->dev, "pci_enable_device() returned error %=
d\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     pci_set_master(pdev);
> > +     pci_set_drvdata(pdev, pci_bmc_dev);
> > +
> > +     /* Prepare IRQ resource */
> > +     aspeed_pci_setup_irq_resource(pdev);
> > +
> > +     /* Setup BMC PCI device */
> > +     rc =3D pci_bmc_dev->platform->setup(pdev);
>
> As with patch 1 this indirection seems unnecessary.
>
> > +     if (rc) {
> > +             dev_err(&pdev->dev, "ASPEED PCIe Host device returned err=
or %d\n", rc);
> > +             pci_free_irq_vectors(pdev);
> > +             pci_disable_device(pdev);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void aspeed_pci_host_bmc_device_remove(struct pci_dev *pdev)
> > +{
> > +     struct aspeed_pci_bmc_dev *pci_bmc_dev =3D pci_get_drvdata(pdev);
> > +
> > +     if (pci_bmc_dev->driver_data =3D=3D ASPEED)
>
> This condition seems unnecessary as the value shouldn't be anything
> else.
>
> > +             aspeed_pci_host_bmc_device_release_vuart(pdev);
> > +
> > +     ida_free(&bmc_device_ida, pci_bmc_dev->id);
> > +
> > +     pci_iounmap(pdev, pci_bmc_dev->msg_bar_reg);
> > +
> > +     pci_free_irq_vectors(pdev);
> > +     pci_disable_device(pdev);
> > +}
> > +
> > +/**
> > + * This table holds the list of (VendorID,DeviceID) supported by this =
driver
> > + *
> > + */
>
> I think that's self-evident and prefer the comment be removed.
>
> > +static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] =3D {
> > +     /* ASPEED BMC Device */
> > +     { PCI_DEVICE(0x1A03, 0x2402), .class =3D 0xFF0000, .class_mask =
=3D 0xFFFF00,
> > +       .driver_data =3D ASPEED },
> > +     {
> > +             0,
> > +     }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(pci, aspeed_host_bmc_dev_pci_ids);
> > +
> > +static struct pci_driver aspeed_host_bmc_dev_driver =3D {
> > +     .name           =3D DRIVER_NAME,
> > +     .id_table       =3D aspeed_host_bmc_dev_pci_ids,
> > +     .probe          =3D aspeed_pci_host_bmc_device_probe,
> > +     .remove         =3D aspeed_pci_host_bmc_device_remove,
> > +};
> > +
> > +static int __init aspeed_host_bmc_device_init(void)
> > +{
> > +     return pci_register_driver(&aspeed_host_bmc_dev_driver);
> > +}
> > +
> > +static void aspeed_host_bmc_device_exit(void)
> > +{
> > +     /* unregister pci driver */
> > +     pci_unregister_driver(&aspeed_host_bmc_dev_driver);
> > +}
> > +
> > +late_initcall(aspeed_host_bmc_device_init);
> > +module_exit(aspeed_host_bmc_device_exit);
>
> module_driver() could be used here.
>
> > +
> > +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> > +MODULE_DESCRIPTION("ASPEED Host BMC DEVICE Driver");
> > +MODULE_LICENSE("GPL");

