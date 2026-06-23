Return-Path: <linux-aspeed+bounces-4290-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8440CCDB479
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 23:54:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMP31JwYz2yRC;
	Wed, 24 Jun 2026 09:54:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::341"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782224978;
	cv=none; b=C7EFS7oDQNsBscCds90mob/w9Hsl8MUo0UE7oAXSrWh5loB8hjgwt417PGota0zbdRVxQ77PgOigBA4PZq53+NqEGscCb8hV3rPfzSf3XhOwPEFuoWOpNQCsWbO2iny2stg47SDunlrSq4PDb5UBB8a/o/dpTDyzWshp7hWfd0/zfBDx01tghltOBpQo2WtiR4A9HEsP7cWyD50jjcpgAN2GxEqEVpscO54AUf4tz0dwlZaI1tmPtqMY82MgVuJQOwUsewIE0MusmwQQK9c5Z37Y1OUSrjQGS8oanNba4dSWm0FFvCkqjwaZl6d4MWX5RsJnuC6+RxBeMf2jGA+NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782224978; c=relaxed/relaxed;
	bh=H10VUnmTOcSqsdtPCuQYnfKlpPMwS75wksj7BtxL1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QehR0G1M9Y2YAHyyB/Lxa5q5c+QBOF0cVgDOzr9SsN72kC8/AfJGK3In3MkibILbM1psG3wUQD+hE1A3MSMb0lQUD1aFmiVGEsyzyaxSXFApWMb32SOA3LWk1k8UVG9ZS6OzFsbkz70KnhBpuCQwGrQJ1y1LAoTlHZV0zOM8RpU0ZtOZzpzB07yEBoNhE9K4vT6PVrZ3iVtRn5a3Lzgpj4ZWRNneX1w185ihlbrROKJmcUeLmFjmUKGAX7JIV8fXk6+0NMigvapueMjYzur9Em/8EU+blBUIciMxl7lkaESM6PaRPMAM5a7k+plZoihOGKTipUxeXowj8s3+P1Ug2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Sm9Y9IMq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Sm9Y9IMq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6sD4xcyz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 00:29:35 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-4924593f45dso40672585e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Jun 2026 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224967; x=1782829767; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H10VUnmTOcSqsdtPCuQYnfKlpPMwS75wksj7BtxL1Y4=;
        b=Sm9Y9IMqxPq3s+VRvs5jncJGsBLuZf4hS8BzkkepXIqXG7R9FO6KT28sBepqZMCcKb
         tptjljVB/pNZVkj7Gnn+9Ho8o1wQVhMUPgYdKm6cy3/bLeFrtLPUYzujjDGFeLyTbSCd
         kLZZs1SAbNPBq+DMelZysAA4dy7R+NL4Tk54CGs6z+fa/yDtOJdgPfRVJIS416g6uCIZ
         LplND1Ij2qmu6jC/50GcVG4z4vta6y7/DRkPBu0JJ99cHy1AjIluZSCgRDPCwW6cglG+
         212Uoaj5eDEVWGURPkPbql7riAzKztFiASMszDu33xghyAotCgSpypCaT1uy2D9+RbKV
         1ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224967; x=1782829767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H10VUnmTOcSqsdtPCuQYnfKlpPMwS75wksj7BtxL1Y4=;
        b=fJlZTGZ1zPF7SghCBJjuAcbfaRyr5vxlfXMRNL8uta4k5Rp0SL/6hjfWqSydekGyDp
         rhncW/gk3qxWenV5gDsp61ggIQRCT2nhxAIPHNIDxJTB2+I7ZNnKl2NrPgwCTk5IRPxr
         efvKkyR5FzTLr9qpTEbp2Pykea8uDrxRMvoOVv+I7nAd6cidL1dKDb1UoS+DGMY5J1f+
         5UUqzT/LkzNSa6Xk3Vo83Espu4ZE/yZbjB7k+NCmN4W1fPApseCtlmBVBfAWTncHlbEV
         uZoOrf8JldvxS/D+hQecAq3wM9GI2v04CPaN8wCzhWaTnqjYfC1t8CTyNcCJn70aqtfc
         6ipQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Up8Pt8jqsO1afvuKHjCTo2vRGOgF6jMV/l1Bv6M9Y9sTkg2WT3AL5FW6OIi+xPwHIQutr3v3SsNKb9io=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFD0EUjeSsGyqpFyChkm6w69NCPnpuFUYXJSaMPL5kKKyV2qiZ
	m9s1Z/xvesi4/mMuGbJHiz8ZWa+E28Ov1nCCKbkFn1FZukR2BEyDL8zSbiGwsoifnRs=
X-Gm-Gg: AfdE7cnZnytO50uQy6Vox2doCZllickDlj0okA2U3xCI6mkfy29Bp1dSODZdZpxhIuJ
	LaOOAxAWpd5+2BmVvSR16PGLmcTe+AH8m1C4jSyKVGcwOW/q0c3CZijvcjqLVBYyZbRkF7zUzoj
	qG2N/kH8niRBP9Resl6Cqpw6XtKo7a8l74mnxkiMdYAa7hpISHB3pYtnnAcZ5PnljqaYMWHkcgv
	JgCT7Y1Xp52HbkJhK/ZMNZufw0fYWlql/S2OpONM1nkYZWOk/PkynTY6TtqnFrPjsxbd3WtpvXl
	FWqsu+1OXziR//7uawxVkIhR84TrJQorc/8A1wb+xsKWhzpn5JoOs+8evd4kOPrK6/rTDMNJRSH
	bw6F2DYpCdIRwA6JTMuJx8HC613Mq1852N23ZxgjpKgWm2wwyfivJyVc5fNg7SZgq1kq6cyzTt4
	RrEkOcKMiOKPmUDkBJ3rWzsHoX2ti5bOoxPuCPiOQwHGGy0smiFk4bHviEY4b3I/+HEp64oAIsu
	KxpKMNmU98BmCA+8GIXgSJM5ELW
X-Received: by 2002:a05:600c:8b2c:b0:490:ba0a:1178 with SMTP id 5b1f17b1804b1-4925b3b1732mr44333735e9.28.1782224967252;
        Tue, 23 Jun 2026 07:29:27 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:26 -0700 (PDT)
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
Subject: [PATCH v3 0/7] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Tue, 23 Jun 2026 14:25:38 +0000
Message-ID: <cover.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780929570.git.gregoire.layet@9elements.com>
References: <cover.1780929570.git.gregoire.layet@9elements.com>
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

This is a v3 for upstreaming the VUART over PCIe BMC device driver.
The initial driver is from the ASPEED kernel SDK (master-v6.18) [1].

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The host cannot access the BMC's memory. Only the enabled features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality also exist for a communication between
the host and the BMC. More information can be found here [2].

This v3 mainly modifies the BMC driver and focuses on VUART.
The BMC driver is now incorporated into the '8250_aspeed_vuart' driver.
A specific flag can be set to indicate that the VUART should be used
over PCI. Several changes have been made to the 8250 device tree binding
and the 'aspeed-g6.dtsi'.

Changes since v2 [3]:
- Add the aspeed,ast2600-vuart compatible entry to the '8250' DT binding
- Add the aspeed,ast2600-vuart compatible property in 'aspeed-g6.dtsi'
- Add the aspeed,vuart-over-pci boolean property to the '8250' DT binding,
  only for the aspeed,ast2600-vuart
- Add the aspeed,vuart-over-pci flag to the vuart3 and vuart4 
- Add the aspeed,ast2600-vuart compatible property to the 
  '8250_aspeed_vuart' driver
- Add the VUART over PCI code to the '8250_aspeed_vuart' driver
- The v2 review of the host-side BMC driver has been applied.

The host-side driver is still in /soc/aspeed/, as it is very specific to
this SoC for me. I didn't receive any feedback on where to put this
driver. I can, of course, change this to the relevant location.

It's important to consider that the host driver will do multiple
functions. The AST2600 also supports LPC over PCI, with a specific KCS
channel (KCS4). This driver should also be used to enable the IPMI
automatically via this KCS channel. The UART and the IPMI will depend on
the same PCI resource (BAR1), so this must be configured in one driver.

As with v2, VUART data flow and MSI interrupts have been verified 
working on the test hardware.

Tested on:
BMC:
- Asus IPMI Kommando Card R1.01, AST2600 A3.
- OpenBMC
Host:
- Linux kernel v7.0.0

This v3 only supports AST2600; the AST2700 is not supported by this series.

I would like to know whether I should add the 'lpc-io-reg' and
'lpc-interrupt' values to the vuart3 and vuart4 nodes directly in the
'aspeed-g6.dtsi'. The host driver is not capable of finding the vuart
address on his own, so they are hardcoded to 0x3f8 and 0x2f8. It will
not work with other adresses, so perhaps they should be in the .dtsi to
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
[3]: https://lore.kernel.org/linux-aspeed/cover.1780929570.git.gregoire.layet@9elements.com/

Grégoire Layet (7):
  dt-bindings: serial: 8250: aspeed: add compatible string for ast2600
  dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
  serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
  serial: 8250_aspeed_vuart: add VUART over PCI
  soc: aspeed: add host-side PCIe BMC device driver
  ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
  ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 .../devicetree/bindings/serial/8250.yaml      |  35 +++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  10 +-
 drivers/soc/aspeed/Kconfig                    |   8 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c      | 183 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  87 +++++++++
 6 files changed, 312 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.54.0


