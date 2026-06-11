Return-Path: <linux-aspeed+bounces-4241-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B788CD98CC
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 00:11:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc0Kr61K6z3bqD;
	Fri, 12 Jun 2026 10:11:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781167254;
	cv=pass; b=YNRVM3YsTPl+EDjvk3F6HUd+hTv7UwL58VZwiagShOeSqedhdNevx/eUPagzCDm65FF9JlpDViADMroSk5UJXvUhekO37+hGD47zNWwDPmtEJHCf5mFdHdSGzREG+uJnrQdHvPTmmNa0pcsuHsHa5mRl1TmhLJ3K9s/Rt5jmejGb722+IAB3+rk2x8iUGe3KK5HUr8s6qLHi4xCU/eQrvdXLTkDoGMxjP5Ki4Yh8zwqx5J73hbnWY20Hkt5fJw2d2uKUmPGUnRWNcU4k9+YpqO7inrRJYdw4fiBqeKrj4RjD+kVs6nLp7f/YiRDyv4fQ09jCoNrDQyxt1Hu8qiQlUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781167254; c=relaxed/relaxed;
	bh=X2WPByO+G8FHiboiB1L4c6R/FhwALJaPpiaRhOBTGss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxMJ2XYxMG9l7nH3CwtgdmXwqDv6Q/ljQTefksznYAam+YLm6p1hxbKuvce8p/IdqXhpnlQIHHZG6ciAvpuansCr+FgaLfqU6f0anJoQUoe5E62ATj5cg//sYZe00UpCG78LR1cx5NomBPZbO4YaQgt4jX2iq2mZHRiAKCOE3eEmUOsGqDOWeIi6m+4G3HDnUL45tyRUHGSkWNyn1KxnND4OXOiYyI2UMr/dSJqvvLOedGo0vyC0kU6VBPa2EnYcOBgTWSaxm2nLRL7GDlxuTfn2SwTiizvmzu4T1uLH+ZvAVbLR/rrBJnIF0OHZsn+wYYv1qK7OWPbvGo3NsbzJMQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=a9kI/I4c; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=a9kI/I4c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbbhP0q1Zz2xLk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 18:40:52 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-46013161068so3878063f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 01:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167248; cv=none;
        d=google.com; s=arc-20240605;
        b=VqqsOhhr/dZRW5XSRgTx0o1pvC6Jz9EQIBFncTIfzmScuO23xnB1icnUFiKg5V1QNw
         daGqSDvFLTDdAv0euR2BWbme0lgQY/kIP7FEjw2FDFfjmbTLeBoe+iGvJ69eSVCfWpm1
         CTt55UxM1P3lDhGK7wNrjLHLiJQmnP7LaOfo+Q3XVBQUkbgvWRSPtdiGz2f2k66GWtKa
         SLr406kGMDh7kHZHQx9pkm/fmX8Y+cnXjFphIFzpHrdSMbe2mFDK1bbKrPWMbLE2S2AB
         ZhHhdFdp58cEUn1jT55dJCZbSA7SxslP9ocRLACQuogpGTCyCLJYL/jxN74Meaad8CU+
         H9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2WPByO+G8FHiboiB1L4c6R/FhwALJaPpiaRhOBTGss=;
        fh=eqLyKwFxQDnIK6S9YvZ0VsfFkyYtlLrcVpRBwpndWDs=;
        b=ePNl7yC8+HpGDcQpkbrIeCBBlhql9BC/BUMOb5lvOEEAz5MPdnmc5xMbh18JGSDqO6
         4XDp18e+7Co+R358dLKFTtSzfGxFY3y67Swn74AdGs4JhKvaSRJZ+8keRCQpk79MdJBB
         nq4rzLy+jJTFi9F0sXG68UlVjEZEw5J+lix5003LqFXd7UAsScwPH1dImFXqj1GR5MQT
         HbeR3CSa3IurFznXpzXTciY1sLSvGV6QjtrlhJ5sAzec+ZjB4n2GFUDkpIORdpA6xObE
         onAPeA9M0qD3KNiGcilD/mvfo05usoMyNUisY7DXaTCfkhcjGXM48GxI69GRm/1XpuwC
         bXuA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781167248; x=1781772048; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2WPByO+G8FHiboiB1L4c6R/FhwALJaPpiaRhOBTGss=;
        b=a9kI/I4c4MwQ8zrnCJEYXPfbEA3ow8SKmmWbXTXfvyEFThowL76ADm/WvXFxU4X9Cp
         FIEkowShtpYTqZoR56La2C/a0geVw0OJtvzcj60gGNMdkFW7FK0R9MSrtSRJtFrfkEnN
         wdJbDN53yX6wKFWYR8o3g32Zz5RbDIuqvcuSiEyJGvmFNFTxGuY7+cWnHCk1997gr6we
         SgyqZF73PxBdgdh+niJyh3WEKcJrxfirB9BxeLe6o4FPsder8CS9yC13QJZc+VEZbaMO
         8gIytRYF3duQEuCWR2J460nC+/ozj2ybm2f8oxjc1mfiE054FVR2wGDDK+CeHT55Ob5j
         Lhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167248; x=1781772048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X2WPByO+G8FHiboiB1L4c6R/FhwALJaPpiaRhOBTGss=;
        b=ChH70dOxgSWTL6GC63GjwnSNXLeQZ7762mo86M+gYg31fdn+q57mP/nmNckaDkBJma
         5/Pv122hklqvmIrdad0vikFMB0cAAmhdbMGiAUNbaPYxLWrHrqdb6ilQ1rhBGaZQSScZ
         vLxJbVOEhLZBG2bjbc76MiKu9EoJ3iCh06Qdn609KgnDq7N62dNSqg3iV5L6grICBb/3
         6vxu+mGzjgMGm6/bopLd9u1hqRqxTCoY9iRA6UKH6F/QTD8ISw2cuV2UZNj8eIL5jNhF
         WepkGTduyliB1KxJ9raq9kMme/er/9zRZ3mmKKxavA+LT95wdIbU8MBbD44fQZ3kh0cG
         zAVw==
X-Forwarded-Encrypted: i=1; AFNElJ84we9t+ao2p9p75VeM59+FqEkRy7Y3p0NuvOtcVaBlnK/r89jp5wQqYAYS+Y+yameWdbOClmAFbhOztQ4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkIEens0k6LHhMnnM3rJGCzvOvz0voZIGDPAydO6yC8NlxByDm
	zXY8i6puiTrTAVx50K1JwAPJjmkn4euKGv9rsZmU3CODu9CKYz4vn+2x2AGNskThEoi9Vda9Qbz
	rlxDbs8O8WmyxcUZQ4zf9RlHRZ8+Az/L9zQFrCji97w==
X-Gm-Gg: Acq92OFUuRDMriYnbaV5E+fUGVaBWk37cDhwpL5LHaNrmCaryF95Xd5pX28Pbt+MZAp
	T7kWx7pEobIHV1SNa+P9KnDYRrFV4H59scsZKO3IyMbVkaIcthwTrP1zYCqdyTzWgvNpPh567Dj
	BbzqF17DbcD638zJ2X3foBX0/PuOkRZw8q1c4By9dAWLxlOh5I6zqYmQ9790vkE8Ob/b/e2DekQ
	jZA7bSUwlDrbRUnK4VPFL/rS8MyJE+0x17qNUU5jlSbiId75QBsie6PFG4TztFJWaxa4pDytzBV
	EXdylSbgUYc2TDmfhHgqB9lDy3P4J0SBVYaZwKi8HfcWlBXq6hEvSvnToxCCnos2YjVUBDGCrs3
	kQdI=
X-Received: by 2002:a05:6000:4383:b0:45e:b99d:dad with SMTP id
 ffacd0b85a97d-460677e5777mr2632363f8f.38.1781167247796; Thu, 11 Jun 2026
 01:40:47 -0700 (PDT)
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
 <af322e76d34ad504e0bdec470293a017b489cfd7.1780929570.git.gregoire.layet@9elements.com>
 <4839c31f666b612799a795bb47c884901fd2a903.camel@codeconstruct.com.au>
In-Reply-To: <4839c31f666b612799a795bb47c884901fd2a903.camel@codeconstruct.com.au>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 11 Jun 2026 10:40:35 +0200
X-Gm-Features: AVVi8CeBOWu4EGURBiKGSA-XqC1fjOjUEZ-adK5473sjjF-Cuy_g9HUqema9G8E
Message-ID: <CAFi2wKYzUDY5Gis9GaHdqeYdv-orHB+gWfLXkJBgbxfbnRgorA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: aspeed: add BMC-side PCIe BMC device driver
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

> It's probably best to use ASPEED's SDK as a source of inspiration for
> fixing obscure bugs, but not send drivers directly extracted from it.

I would like to discuss the different options then.

If we decide to continue on the current path, I'll modify the code accordin=
g
to your remarks.

> We should avoid adding more drivers in drivers/soc/aspeed where we can.
> Is this really necessary?

This driver (for the BMC side) only enables some configuration on the SCU t=
o
make MSI interrupts work. It is a very specific configuration, which is why=
 I
thought it was OK as a separate driver.

Fundamentally, the BMC side driver is not necessary. During my testing,
I successfully made data flow in both directions without the BMC side drive=
r,
but this was using polling mode (IRQ =3D 0), it's not ideal.


It is also possible to put the SCU initialisation on the
8250_aspeed_vuart driver
directly. This could be activated with a specific flag added to VUART nodes
('pcie2vuart' for example) on the DeviceTree.

Putting this configuration in the VUART driver directly would make the setu=
p
on the devicetree easier and more understandable. Because in this series, t=
he
bmc side driver needs a bmc_device node to be loaded. But the bmc_dev node
doesn't hold any meaningful information.
If we decide to take this approach, I think we should also add the
differentiation for the ast2600 compatibility. Currently, the aspeed-g6.dts=
i
uses the "aspeed,ast2500-vuart" compatibility entry for the four VUARTs.

What do you think about this solution ?


Thanks,
Gr=C3=A9goire


On Wed, 10 Jun 2026 at 14:33, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hello Gr=C3=A9goire,
>
> On Mon, 2026-06-08 at 14:51 +0000, Gr=C3=A9goire Layet wrote:
> > Taken from ASPEED 6.18 Kernel SDK
>
> It's probably best to use ASPEED's SDK as a source of inspiration for
> fixing obscure bugs, but not send drivers directly extracted from it.
>
> >
> > Add support for VUART over PCIe between BMC and host.
> > This add BMC side driver.
> >
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> > Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> > Tested-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> > ---
> >  drivers/soc/aspeed/Kconfig          |   7 ++
> >  drivers/soc/aspeed/Makefile         |   1 +
> >  drivers/soc/aspeed/aspeed-bmc-dev.c | 187 ++++++++++++++++++++++++++++
>
> We should avoid adding more drivers in drivers/soc/aspeed where we can.
>
> Is this really necessary?
>
> >  3 files changed, 195 insertions(+)
> >  create mode 100644 drivers/soc/aspeed/aspeed-bmc-dev.c
> >
> > diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> > index f579ee0b5afa..3e1fcf3c3268 100644
> > --- a/drivers/soc/aspeed/Kconfig
> > +++ b/drivers/soc/aspeed/Kconfig
> > @@ -4,6 +4,13 @@ if ARCH_ASPEED || COMPILE_TEST
> >
> >  menu "ASPEED SoC drivers"
> >
> > +config ASPEED_BMC_DEV
> > +     tristate "ASPEED BMC Device"
> > +     default n
> > +     help
> > +       Enable support for the ASPEED AST2600 BMC Device.
> > +       This exposes the PCIe-to-LPC bridge of the BMC to the host over=
 PCIe.
> > +
> >  config ASPEED_LPC_CTRL
> >       tristate "ASPEED LPC firmware cycle control"
> >       select REGMAP
> > diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> > index b35d74592964..fab0d247df66 100644
> > --- a/drivers/soc/aspeed/Makefile
> > +++ b/drivers/soc/aspeed/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_ASPEED_BMC_DEV)         +=3D aspeed-bmc-dev.o
> >  obj-$(CONFIG_ASPEED_LPC_CTRL)                +=3D aspeed-lpc-ctrl.o
> >  obj-$(CONFIG_ASPEED_LPC_SNOOP)               +=3D aspeed-lpc-snoop.o
> >  obj-$(CONFIG_ASPEED_UART_ROUTING)    +=3D aspeed-uart-routing.o
> > diff --git a/drivers/soc/aspeed/aspeed-bmc-dev.c b/drivers/soc/aspeed/a=
speed-bmc-dev.c
> > new file mode 100644
> > index 000000000000..7a204b543c97
> > --- /dev/null
> > +++ b/drivers/soc/aspeed/aspeed-bmc-dev.c
> > @@ -0,0 +1,187 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright (C) ASPEED Technology Inc.
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <linux/regmap.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#define SCU_TRIGGER_MSI
> > +
> > +/* AST2600 SCU */
> > +#define ASPEED_SCU04                 0x04
> > +#define AST2600A3_SCU04                              0x05030303
> > +#define ASPEED_SCUC20                        0xC20
> > +#define ASPEED_SCUC24                        0xC24
>
> These could all use properly descriptive names.
>
> Pinctrl is an exception because of how the documentation is structured.
>
> > +#define MSI_ROUTING_MASK                     GENMASK(11, 10)
> > +#define PCIDEV1_INTX_MSI_HOST2BMC_EN         BIT(18)
> > +#define MSI_ROUTING_PCIe2LPC_PCIDEV0         (0x1 << 10)
> > +#define MSI_ROUTING_PCIe2LPC_PCIDEV1         (0x2 << 10)
> > +
> > +#define ASPEED_SCU_PCIE_CONF_CTRL    0xC20
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN                     BIT(8)
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN_MMIO                BIT(9)
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN_MSI                 BIT(11)
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN_IRQ                 BIT(13)
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN_DMA                 BIT(14)
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN_E2L                 BIT(15)
> > +#define  SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE BIT(21)
> > +
> > +#define ASPEED_SCU_BMC_DEV_CLASS     0xC68
> > +
> > +
> > +struct aspeed_platform {
> > +     int (*init)(struct platform_device *pdev);
> > +};
> > +
> > +struct aspeed_bmc_device {
> > +     struct device *dev;
> > +     int id;
> > +     void __iomem *reg_base;
> > +
> > +     int pcie2lpc;
> > +     int irq;
> > +
> > +     const struct aspeed_platform *platform;
> > +
> > +     struct regmap *scu;
> > +     int pcie_irq;
> > +};
> > +
> > +
> > +static int aspeed_ast2600_init(struct platform_device *pdev)
> > +{
> > +     struct aspeed_bmc_device *bmc_device =3D platform_get_drvdata(pde=
v);
> > +     struct device *dev =3D &pdev->dev;
> > +     u32 pcie_config_ctl =3D SCU_PCIE_CONF_BMC_DEV_EN_IRQ |
> > +                           SCU_PCIE_CONF_BMC_DEV_EN_MMIO | SCU_PCIE_CO=
NF_BMC_DEV_EN;
> > +     u32 scu_id;
> > +
> > +     bmc_device->scu =3D syscon_regmap_lookup_by_phandle(dev->of_node,=
 "aspeed,scu");
>
> We should rather look at auxbus for the SCU.
>
> > +     if (IS_ERR(bmc_device->scu)) {
> > +             dev_err(&pdev->dev, "failed to find SCU regmap\n");
> > +             return PTR_ERR(bmc_device->scu);
> > +     }
> > +
> > +     if (bmc_device->pcie2lpc)
> > +             pcie_config_ctl |=3D SCU_PCIE_CONF_BMC_DEV_EN_E2L |
> > +                                SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE;
> > +
> > +     regmap_update_bits(bmc_device->scu, ASPEED_SCU_PCIE_CONF_CTRL,
> > +                        pcie_config_ctl, pcie_config_ctl);
> > +
> > +     /* update class code to others as it is a MFD device */
> > +     regmap_write(bmc_device->scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff00000=
0);
> > +
> > +#ifdef SCU_TRIGGER_MSI
>
> I don't see that this needs to be a CPP test. This could be a C test.
> The construct would be optimised because of the constant and we'd get
> compile time coverage of both sides without additional configuration.
>
> Have you tested both sides?
>
> > +     //SCUC24[17]: Enable PCI device 1 INTx/MSI from SCU560[15]. Will =
be added in next version
> > +     regmap_update_bits(bmc_device->scu, ASPEED_SCUC20, BIT(11) | BIT(=
14), BIT(11) | BIT(14));
>
> These bits need descriptive macros.
>
> > +
> > +     regmap_read(bmc_device->scu, ASPEED_SCU04, &scu_id);
> > +     if (scu_id =3D=3D AST2600A3_SCU04)
> > +             regmap_update_bits(bmc_device->scu, ASPEED_SCUC24,
> > +                                PCIDEV1_INTX_MSI_HOST2BMC_EN | MSI_ROU=
TING_MASK,
> > +                                PCIDEV1_INTX_MSI_HOST2BMC_EN | MSI_ROU=
TING_PCIe2LPC_PCIDEV1);
> > +     else
> > +             regmap_update_bits(bmc_device->scu, ASPEED_SCUC24,
> > +                                BIT(17) | BIT(14) | BIT(11), BIT(17) |=
 BIT(14) | BIT(11));
>
> As do these
>
> > +#else
> > +     //SCUC24[18]: Enable PCI device 1 INTx/MSI from Host-to-BMC contr=
oller.
> > +     regmap_update_bits(bmc_device->scu, 0xc24, BIT(18) | BIT(14), BIT=
(18) | BIT(14));
>
> And these.
>
> > +#endif
> > +
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static struct aspeed_platform ast2600_plaform =3D {
> > +     .init =3D aspeed_ast2600_init
> > +};
> > +
> > +
> > +static const struct of_device_id aspeed_bmc_device_of_matches[] =3D {
> > +     { .compatible =3D "aspeed,ast2600-bmc-device", .data =3D &ast2600=
_plaform },
>
> This compatible isn't documented in this series and isn't present in
> linux-next at a87737435cfa ("Add linux-next specific files for
> 20260608"). You'll need to address that if it's reasonable to continue
> down this path. I expect you'll want to avoid it, and define any
> necessary properties on the SCU node rather than add further children.
>
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, aspeed_bmc_device_of_matches);
> > +
> > +static int aspeed_bmc_device_probe(struct platform_device *pdev)
> > +{
> > +     struct aspeed_bmc_device *bmc_device;
> > +     struct device *dev =3D &pdev->dev;
>
> This shortcut is defined but inconsistently used.
>
> > +     const void *md =3D of_device_get_match_data(dev);
>
> I think we can do without this, see below.
>
> > +     int ret =3D 0;
> > +
> > +     if (!md)
> > +             return -ENODEV;
> > +
> > +     bmc_device =3D devm_kzalloc(&pdev->dev, sizeof(struct aspeed_bmc_=
device), GFP_KERNEL);
> > +     if (!bmc_device)
> > +             return -ENOMEM;
> > +     dev_set_drvdata(dev, bmc_device);
> > +
> > +     bmc_device->platform =3D md;
> > +
> > +     bmc_device->id =3D of_alias_get_id(dev->of_node, "bmcdev");
> > +     if (bmc_device->id < 0)
> > +             bmc_device->id =3D 0;
> > +
> > +     bmc_device->dev =3D dev;
> > +     bmc_device->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(bmc_device->reg_base))
> > +             return PTR_ERR(bmc_device->reg_base);
> > +
> > +     bmc_device->irq =3D platform_get_irq(pdev, 0);
>
> This seems unnecessary.
>
> > +     if (bmc_device->irq < 0) {
> > +             dev_err(&pdev->dev, "platform get of irq[=3D%d] failed!\n=
", bmc_device->irq);
> > +             return bmc_device->irq;
> > +     }
> > +
> > +     if (of_property_read_bool(dev->of_node, "pcie2lpc"))
>
> This property isn't documented.
>
> > +             bmc_device->pcie2lpc =3D 1;
> > +
> > +     ret =3D bmc_device->platform->init(pdev);
>
> The driver only supports one SoC, this indirection seems unnecessary
> right now. We can add that later when there's a need to differentiate.
> I'd rather you call the setup function directly for now.
>
> > +     if (ret) {
> > +             dev_err(dev, "Initialize bmc device failed\n");
> > +             goto out;
> > +     }
> > +
> > +     dev_info(dev, "aspeed bmc device: driver successfully loaded.\n")=
;
> > +
> > +     return 0;
> > +
> > +out:
> > +     dev_warn(dev, "aspeed bmc device: driver init failed (ret=3D%d)!\=
n", ret);
> > +     return ret;
> > +}
> > +
> > +static void aspeed_bmc_device_remove(struct platform_device *pdev)
> > +{
> > +     struct aspeed_bmc_device *bmc_device =3D platform_get_drvdata(pde=
v);
> > +
> > +     devm_free_irq(&pdev->dev, bmc_device->irq, bmc_device);
> > +     devm_kfree(&pdev->dev, bmc_device);
>
> These are unnecessary due to cleanup of devres on release.
>
> Andrew

