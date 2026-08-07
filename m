Return-Path: <linux-aspeed+bounces-4651-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9622AC5AC7C
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:37:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcw16dQcz3c1g;
	Fri, 07 Aug 2026 18:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091841;
	cv=none; b=gq4mWDUE2SqIQflI4JymPLJV8GSMyGEbecAWieusylhmt08qjPklEWkPPuy/mn2k2N5mJZp+pLS5Zuep5Rv+YX2p+Znxl0yVu7zY094ANoMUp9+TOgp6jbbh1+lnKODlxdVQ2KF0kDIyUyT4DDh7dzKxXsGqGM+OZJ+p0DncftchjGaPTz5CKiVb0+SbWLSSK4S3qTAYFZQNdPnUC6W1MH2/wodOA1+CRrUUQQApcjGYgAmZ9TZSNy1NSEENCgrEWoW/jCihj5DFx66xRG0vtIpiseJhvqHdSGDNnh3+GK8JvdsxoXse+mV0sbH17bE7M7N9xtwIuGR0arKobvwSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091841; c=relaxed/relaxed;
	bh=7xmdghfSgadBkY6GVQoxPAoUuT5sReEQgJK7Tv/QlXE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=O8Ku/IltqI0EAbHecbVoetFM2GtNddxCy4nuMPHjfOSbZ4j0JoskOWOhrNlo1L4IMxXfv5HseuWbTrbOP/19KMvfuYEtcQCxUAnOucdGWl4DLajY0lMrrE6tZrhOI1RIS9SBDKm714eHDk4loFi1EQHOQU6Xh/F/QIImBqWVxWrzgJtu3Nm7FQe1lYwlGuT4K1j72CmCXh6vfVuOY/HoLFPWINEo3o6Kdq7pejou5dVzjOM7tQSkIS0tDboeG1PRGxhMOSR6u72l8QSmrN11BZQzSz42lisHx5fxqOg1SBM8cJyHXd7LWEXGwb7HGGKmTmzPZWTFo6uaqYNBoS344g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=euGbADoD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=euGbADoD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcw02F0hz3c1S
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:37:20 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4994c49f588so17722875e9.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091837; x=1786696637; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7xmdghfSgadBkY6GVQoxPAoUuT5sReEQgJK7Tv/QlXE=;
        b=euGbADoDUBdixf8ucY1+8PXg/M/ZZUXrnEc0T+DBw7Cv10L0IPJMo9hhHH9ts2+OQs
         j0K9v7jyxr3WroGkAFCnN1V66e3LGW+LC1M/ooNAJacbG7B4LsSZJP8iG2jgDakzHjqv
         Xq7LDdZIJsvpqeutWqhQUNG8NUhQ++VzocAIfo1kkxSQ0mj03mbyAYelOzXbscVAOmwE
         5kgMePfPPT0x0K3UfdhyEbYmD8qHQEdCkjONZhcjH+tpfzWwBqhmi+87kqlWS0z9BSZu
         BOs3i7cEKLJIhLeQVNyEf1nkDGXJ8Mjz4Dm7yscrrVP6sVHVOuQ+gwBeiO6b+y0QOskM
         ktUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091837; x=1786696637;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xmdghfSgadBkY6GVQoxPAoUuT5sReEQgJK7Tv/QlXE=;
        b=hKhkRLwF/QtO3wi7DEvFbcU/AZAc4kvR8tjCX3gU3aVtSHGBc7DB+fZRG5g9z1MVIm
         fMfdP3vmry4Y/8x639TkcVG+kshToUHkcT/XitjXLi29O5diAljBhheaJlnQvZFKAO31
         jjTnXw36gV3xsdtlg6oVhk/lqfB29Y5zje6AsN3/zXk2aza9nF2yGguiwHq6Azao+sx5
         hqPLRMbWTr2Ypz4EzNDJRDidwXT40LfoHm6F0A6wwwwUm6i5Oue8ynBUt49PslZNL1/h
         GmTd3XxCBh8XhySrWSflxLmTuG9WYo01qNBUyxbbgQ6CbRqiW5JJGi1aJKzabFLNkM5T
         JqGA==
X-Forwarded-Encrypted: i=1; AHgh+RoBXUlX6HVRJ0XBEfpezkJgBSz+7faXRyh2I54vAzZ/WmaMoVpbeIhhrHWYGe5StpKUGj0HbCXDbrYtTP8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvpY+K9UddEtfqIWpIGg+J13CVyMW/SJuLjVkrjKzCze8hOzqo
	6DEI51cp2IMChV5nMjsHv6+rDp9uvrlD4HUaddghTVHm+nMcEsQEmBsUh7SbQMPgj44=
X-Gm-Gg: AR+sD109QndscUZc0IrahMg8L7TdjqDUFnLWx8T7Izu7ZDsxqy9ZqEllVcmEYiGjaw3
	al94v+cXE4wJh1lNZHnxXI8rCz2Pd1URzMconsNw6ZSwVy1xuaymkKQ5lUw5eDaIiDfAVlR3gqY
	v+F8xjMKpnk/R1/pRD42TukOWbG6QLUzu3dk01OR53bC9BE27LYvd1VxOukWTI3n6seizb7I1Vl
	+/SzILeVPy0K9RR+Y9XgUEwJ4+LQRVB89SYx4FcLAmJImlfx5apPICJKiggh4EFBJp9DrAny/DO
	2nKDdeZGVAmQpuVdTWLQ+Lt+MWG0R2clgB4L627f3Kk6wk8bTmRwZDZdKiNGbIOhx0WvhOYIKyW
	pyHOmYolyJSxtNe5TDRf+ZBWwzIyFl4CHRX+t+e9UatVfRftu90RsO5n/naayyql3+uDUia4tJO
	fucHz373eOl4DOJ3JDY7kevwVj9iw6xqZUPmeVP3Kqgb9BotjnIBt56nZ00lIbWZxv4GvwBX4tr
	Z49WOd45w==
X-Received: by 2002:a05:600c:42d4:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49959fddc5emr56438565e9.1.1786091836967;
        Fri, 07 Aug 2026 01:37:16 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:16 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 4/6] soc: mfd: add ASPEED AST2600 PCIe BMC device
 driver
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <51db5e5bb5bf44dd5ab893b8d547291f04e1d3c7.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <51db5e5bb5bf44dd5ab893b8d547291f04e1d3c7.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182923.193353.7287772568467157519.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=5887;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=5Wtm4+fC2TDCkZjPl5iY3esbeKwy0U6HWjzwFQYdxgM=;
 b=BYG8RuH2of4Gbb/wv8dafAtCnP3l9bAcx9jDlUpTUBOYFB1rnN5jJmZOKiXGTGs9fny/HkoHX
 tn9LiVn8tDnCAFLsuoN9DwifuoFqneYc0Efq2nsAEZ61Cjw8cXEYapH
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Add support for UART over PCIe between ASPEED
> AST2600 BMC and host.
> This is the host-side driver.
> 
> Based on ASPEED 6.18 Kernel SDK and trimmed down
> and changed to MFD driver.

This doesn't seem to be aligned (72/75 chars per line).

> 
> The AST2600 has two 8250-compatible register set usable over PCIe.
> These act as two UARTs. As there is only a FIFO internally between both
> ends, they are called Virtual UARTs. This patch adds both VUARTs as
> plat_serial8250_port. This is the core driver in charge of setting up
> MSI interrupts. It doesn't bind the whole PCIe resource to allow each
> sub-driver to bind the needed addresses.
> 
> This is not added as a PCI 8250 UART device, but as a MFD driver, as this
> host driver can be expanded upon for IPMI over KCS. It can also be used
> in the future for custom BMC<->host communication with shared memory and
> doorbell.
> 
> This host module should be the entry point for setting up all features
> related to an AST2600 present on the PCI bus.
> 
> Notes on the implementation:
> The host can't detect the VUART addresses, so they are forced to
> 0x3f8 and 0x2f8, as in the initial ASPEED driver.
> 
> The MSI vector index of VUART2 has been changed from 15 to 17.
> The index 15 used in the initial driver was not working.
> 
> Tested:
> Data path in both direction is tested on both VUARTs.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15011f5752a9..33a0351819e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4011,6 +4011,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/crypto/aspeed,*
>  F:	drivers/crypto/aspeed/
>  
> +ASPEED PCI BMC DEVICE DRIVER
> +M:	Grégoire Layet <git@gregoirelayet.com>
> +M:	Tan Siewert <tan.siewert@9elements.com>
> +S:	Maintained
> +F:	drivers/mfd/aspeed-pci-core.c
> +
>  ASPEED PECI CONTROLLER
>  M:	Iwona Winiarska <iwona.winiarska@intel.com>
>  L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 763ce6a34782..dd780f72d169 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2573,5 +2573,17 @@ config MFD_MAX7360
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_ASPEED_PCI_BMC_DEVICE
> +	tristate "ASPEED BMC PCIe device"
> +	depends on PCI
> +	select MFD_CORE
> +	help
> +	  Host-side driver for the ASPEED AST2600 BMC PCIe device found on
> +	  BMC expansion cards. Exposes two 8250-compatible VUART
> +	  ports.
> +
> +	  If unsure, say N. Choose M here if this machine has an
> +	  AST2600-based BMC expansion card on its PCIe bus.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index dd4bb7e77c33..a364b1b5936b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -303,3 +303,5 @@ obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>  obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
>  
>  obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
> +
> +obj-$(CONFIG_MFD_ASPEED_PCI_BMC_DEVICE)	+= aspeed-pci-core.o
> diff --git a/drivers/mfd/aspeed-pci-core.c b/drivers/mfd/aspeed-pci-core.c
> new file mode 100644
> index 000000000000..ad6732133ec5
> --- /dev/null
> +++ b/drivers/mfd/aspeed-pci-core.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (C) ASPEED Technology Inc.
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/pci.h>
> +#include <linux/serial_8250.h>
> +#include <linux/mfd/core.h>
> +
> +#define ASPEED_BMC_MULTI_MSI		32
> +#define ASPEED_BMC_PCI_DEVICE_ID	0x2402
> +#define ASPEED_BMC_REVISION_AST2700	0x27
> +#define ASPEED_BMC_VUART		2
> +
> +#define DRIVER_NAME "ast2600-pci-core"
> +
> +static const unsigned int vuart_msi_index[ASPEED_BMC_VUART] = { 16, 17 };
> +static const u16 vuart_port_addr[ASPEED_BMC_VUART] = { 0x3f8, 0x2f8 };
> +
> +struct aspeed_pci_bmc_dev {
> +	struct plat_serial8250_port uart[ASPEED_BMC_VUART + 1];
> +	struct mfd_cell cell;
> +};
> +
> +static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev,
> +					     struct aspeed_pci_bmc_dev *pci_bmc_dev)
> +{
> +	resource_size_t bar = pci_resource_start(pdev, 1);
> +	struct plat_serial8250_port *port;
> +	u16 vuart_ioport;
> +	unsigned int i;
> +
> +	for (i = 0; i < ASPEED_BMC_VUART; i++) {
> +		port = &pci_bmc_dev->uart[i];
> +
> +		/* ASPEED BMC device shift addresses by 2 to the left */
> +		vuart_ioport = vuart_port_addr[i] << 2;
> +
> +		port->mapbase = bar + vuart_ioport;
> +		port->uartclk = 115200 * 16;
> +		port->irq = pci_irq_vector(pdev, vuart_msi_index[i]);
> +		port->iotype = UPIO_MEM32;
> +		port->type = PORT_16550A;
> +		port->flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
> +		port->regshift = 2;
> +	}
> +
> +	pci_bmc_dev->cell = (struct mfd_cell) {
> +		.name		= "serial8250",
> +		.platform_data	= pci_bmc_dev->uart,
> +		.pdata_size	= sizeof(pci_bmc_dev->uart),
> +	};

In the commit message you're describing that the MFD driver will be used for
setting up MSI interrupts:
> It doesn't bind the whole PCIe resource to allow each sub-driver to bind the
> needed addresses.

But you're adding the UART devices here which now means that the core driver is
doing more than MSI interrupt init.

Suggestion from my side would be to have an array of `mfd_cell` where you define
which devices are part of the MFD, and your VUART lives in another driver.
See `ls2k-bmc-core` for example.

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

