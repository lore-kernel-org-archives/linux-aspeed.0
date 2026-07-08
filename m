Return-Path: <linux-aspeed+bounces-4442-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FD9C43458
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ9C1Dzbz3054;
	Thu, 09 Jul 2026 09:31:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525109;
	cv=none; b=TvsgFZiP0IcEq+ZsAO9IQhH0Sh6NXX/VCN1cFLgoWAi0aauCqa93mc9DoR3K5p3lWEDF8e9qk9j+rsEFs/IGiMg+ssr1+3t/GA7nVke7cs9nFWZwY+9NBv3uEm19VNWwy+Is5HZwHRvG23qwNvM816+cNqwiqLdws8VLDDNvd7CTYbb1OVWwus+YuZDIxZed3UKf60wZOY8xBpDR90p4cshMqkARwshymRjRu2YHE5iKbXxKGfqlgO+sutbH5iqoAFuQ55xLvTBubqwA7+19XbqO3cxmT4mzXmnRjd8Ouo5s3Zhia0HJSuSaIT3+1WYWFVDnQhIJFoRFhM7+XDKZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525109; c=relaxed/relaxed;
	bh=6E2M/OW82zq935Lg7IK8OFbhLBXo8GmRMpNDGq8g+oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tw+nDkz5k3el4F1Fz6Fv/T3ZrjmW2mbJ0jIfFSTPv+BycCZJSHtQhpfLFVpG4xU9JNAN7KbBKv0UJ36bDJUnBxALZt97Klap4cw1scJk5KPhBvHraW23SAGK9GcMnRZ1pnmhgNHUsNtWiyKUIlGygdQU2h+wJYsOEz09wciPvKGtw9ZUvC9Riovm/nSFHj746+UYwCjqRrKiOTe1MB3j0fDzpq8S9AhJJsQhqqTvc335U7CYozmLfyWdvXYQ93BHjTVGby06j/AzV5hNGtPMV96GGZ0isky1yLnZTVCjw+jdc4WciJQVZqQeNTxX825VoR0i+r2sGj1PDZtVKqk1BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QYYNLh/w; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::2; helo=mail-wr2-x02.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QYYNLh/w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:30::2; helo=mail-wr2-x02.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x02.google.com (mail-wr2-x02.google.com [IPv6:2a00:1450:4864:30::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMgl0mtHz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:26 +1000 (AEST)
Received: by mail-wr2-x02.google.com with SMTP id ffacd0b85a97d-47528970fbdso353136f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525103; x=1784129903; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6E2M/OW82zq935Lg7IK8OFbhLBXo8GmRMpNDGq8g+oA=;
        b=QYYNLh/wRTPUwU40pfYRXFxoBczlIx1xPsZrO2ZGFvyqKMmLnXiqwSTOTOnxOSwCWW
         CZOGZbEiS5Pj8c+4kwFZF62gXRr1QrrO73OB7T86/Pm9Vb0JSICIgwlnqHb0I0IIX882
         Rw2XmMR8HFj9pIHcburxtnIFP8u0UaX+C8YXRsVUQqYqv3DMwKLwnRBnLKpISA+lCxA7
         8ygrJjGjQnBWu4y6KlILVghRRPH0so+JmTZ1U/QHLF4JzmE/syYSrnKE/30yUBFLX3O+
         jARNEgcC2mMnPBOD9kSPZr7a3eqO9kLvGYEkvIGRDVrQ93CBDUVj+/PZYUJZ35slRszJ
         e4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525103; x=1784129903;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6E2M/OW82zq935Lg7IK8OFbhLBXo8GmRMpNDGq8g+oA=;
        b=ZSvxbOJM5Uwl8k8GKBkJjxnx9nVAoydVJKf7YduHCDLsy1HN7riympfXuXFJ9scHso
         RSH35l+7PgP687d5Q9Za7G67NFzrrkvmHN6TS++XchD1WoEcF2Rt+tw7CJjRsHGGekSk
         kLqAcsgS4VVddW36B7lkd9QgVz/FHUnDa82fkjlrBOlSZgk9cGHJNxViMJ5ZKl0lT5s4
         rQaDz0rlagW3++DWYv9xzip7kP0kFBlCpbZnBS+izmKjruPJoIas/80Jg+MZI+c8qXXn
         XqglBNlkZClqVoWOiAR9+e+9SZPfjTt9GbCscA3Q1ZcCFNCNR0qzhWAUawRyFIY8l3ho
         APFg==
X-Forwarded-Encrypted: i=1; AHgh+RoxHmYm0OqVR407yeuoUsmq47/XkoUINJHLcMHxpSmJbnYwsdlX/ZcnplbUwHKYl033aq2GNMsPM3+L0JY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUlNIYJ5CJEDusPKdoWeFzXlPBfr4/oORM7rzjo6wHUa8hMuhM
	Bt2sqWo+KK2wzpVpMCGOXBdRCJf+WqZKsOqc2NXY6Vwdm+YyHfSpbLeSXkO0PXCJ6uQ=
X-Gm-Gg: AfdE7ckgVoUfS3rc46rgAajSt3FrUt61laNYWLjeWnW2nZTPiEoyYmHjkCsxbIqjZiy
	ZlRV6OPOKy6bd0AhHEGKBLszyk9cmnRtv1jPf8q+DOmogOgn5Qz/YSyMoXEKVJC5bPZBaHaasRS
	SqjCos102Hpfczs8NXNaBJQYBn2ajR7g2S+FqmD0RHWkC5eozK3rvSQZqysC9+Fbxar5l70IKH0
	lrRP8sKvbWra2fKPgaqw2tsQEcEssI6nZxcYD05enamqQgcl//VemHPFoUByWsmKlSr6OnDnEnE
	rhf8813p2L7DHeCbMcDmqShb4RdLZreEMee4qVYYjFKR4zFp51Z+tWj15lDFmY9JEftOHsgr9wL
	w2vHXAynudvGzVkvmfmKvwBI/e7Xlzy+Y+xzlfArA43FScV/LECNBvEKcnyek1FxyHu/5zSj7Ne
	grRpf4ghoJrO4789JmXSWitjokgGITlA9+4ak8l4HYyw48yj/CbstI8wTMUVcDM9W60FFMwY9Tc
	/jiwwGf6/bMxVvwTXggg/X6rRO+
X-Received: by 2002:a05:6000:1ac5:b0:45e:f302:95b with SMTP id ffacd0b85a97d-47df078ba55mr3258189f8f.37.1783525103272;
        Wed, 08 Jul 2026 08:38:23 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:22 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 0/7] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Wed,  8 Jul 2026 15:35:52 +0000
Message-ID: <cover.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a v4 for upstreaming the VUART over PCIe BMC device driver.
The initial driver is from the ASPEED kernel SDK (master-v6.18) [1].

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The virtual UART is an 8250-compatible register set.
On the AST2600, two VUARTs can be exposed over PCI via the PCI BMC device.

The host cannot access the BMC's memory. Only the exposed features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality for a communication between
the host and the BMC. More information can be found here [2].

The v3 and this v4 mainly modifies the BMC driver and focuses on VUART.
The BMC driver is now incorporated into the '8250_aspeed_vuart' driver.
A specific flag can be set to indicate that the VUART should be used
over PCI. Several changes have been made to the 8250 device tree binding
and the 'aspeed-g6.dtsi'.

This v4 serves as a resend of the v3 while applying Krzysztof's review.

Changes since v3 [3]:
- Add the aspeed,ast2600-vuart compatible entry to the '8250' DT binding
- Add the aspeed,ast2600-vuart compatible property in 'aspeed-g6.dtsi'
- Add the aspeed,vuart-over-pci boolean property to the '8250' DT binding,
  only for the aspeed,ast2600-vuart
- Add the syscon phandle property required for aspeed,vuart-over-pci.
- Add the aspeed,vuart-over-pci flag and syscon phandle to the vuart3 and vuart4
- Cleanup the VUART over PCI code in the '8250_aspeed_vuart' driver.
- Further cleanup of the host side driver.

The host-side driver is still in /soc/aspeed/, as it is very specific to
this SoC for me. I didn't receive any feedback on where to put this
driver. I can, of course, change this to the relevant location.

It's important to consider that the host driver will do multiple
functions. The AST2600 also supports LPC over PCI, with a specific KCS
channel (KCS4). This driver should also be used to enable the IPMI
automatically via this KCS channel. The UART and the IPMI will depend on
the same PCI resource (BAR1), so this must be configured in one driver.

As with v3, VUART data flow and MSI interrupts have been verified
working on the test hardware.

Tested on:
BMC:
- Asus IPMI Kommando Card R1.01, AST2600 A3.
- OpenBMC
Host:
- Linux kernel v7.0.0

This series only supports AST2600; the AST2700 is not supported.

Same as v3, I would like to know whether I should add the 'lpc-io-reg' and
'lpc-interrupt' values to the vuart3 and vuart4 nodes directly in the
'aspeed-g6.dtsi'. The host driver is not capable of finding the vuart
address on its own, so they are hardcoded to 0x3f8 and 0x2f8. It will
not work with other addresses, so perhaps they should be in the .dtsi to
ensure the correct configuration for the 2 vuart over PCI.

For the interrupt number, my test is working with interrupt = 0
for vuart3 and interrupt = 1 for vuart4. I don't fully understand how
the silicon routes MSI numbers to the VUART but the following
combination is working :
       | host MSI idx | BMC lpc-interrupts |
VUART3 |      16      |       0            |
VUART4 |      17      |       1            |

The original ASPEED driver used MSI index 15 for the VUART4.
I tested every lpc-interrupts on the BMC from 0 to 15, but none of them
worked with the host MSI index set to 15.

For me, the silicon only routes the MSI index 16 to VUART3 and 17 to
VUART4, and the lpc-interrupt needs to match the 4 least significant bits.
I might be wrong on this explanation but the data path is working with
those numbers. There is no explanation for any of this in the datasheet.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com/
[3]: https://lore.kernel.org/linux-aspeed/cover.1782224059.git.gregoire.layet@9elements.com/

Grégoire Layet (7):
  dt-bindings: serial: 8250: aspeed: add compatible string for ast2600
  dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
  serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
  serial: 8250_aspeed_vuart: add VUART over PCI
  soc: aspeed: add host-side PCIe BMC device driver
  ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
  ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 .../devicetree/bindings/serial/8250.yaml      |  46 ++++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  12 +-
 drivers/soc/aspeed/Kconfig                    |  15 ++
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c      | 174 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  87 +++++++++
 6 files changed, 323 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c


base-commit: 564edaca14861ba9e58d4e646d272c677296d285
--
2.54.0

