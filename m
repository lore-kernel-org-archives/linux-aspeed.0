Return-Path: <linux-aspeed+bounces-4616-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4898EC56201
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 08:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFNc86XpPz2xqM;
	Wed, 05 Aug 2026 18:19:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785917960;
	cv=none; b=HNPHcxCm6ahODX9265VpPD6XMUAT4chD9diN0dkdAdEyUgs/BxU5AdQycNv3cBD0u/4bgGEUXJpkrtJucq32GAJvBIpSlvNjh/ygaC5le7mIp/EtmTMojPSEG4uDnfX4wqMxqpER2Kmbu/AT3/2aFrsiNvUh+zlycXXbKUUHai6W1NlF2N2mD4/9Yh67cUTC2P8GnBUlT/5eRLwX+mubyDfvowRLxWAcfVoJOPeBMkKHNkdhY3e4NaQl/8dh2tjFVAfyeLOFe0psQK231RVP5KcrezyYgL2Dao1153zyht8nghX0TWvA11kIwGHU1in55yEDPsqAwySqKuddR6vfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785917960; c=relaxed/relaxed;
	bh=PAmFeRSZbFo4XUxpmLajRJiEjxvL2omNRIxy6wYxlZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZJi4PgEZ13RjZWWnW2Beu/rmVMpeNxYzlJ7GIWUAyPFeUVmJgvrVWpjhH2NTf8wxx+S2uZVaftMcNb0mywRMxsJyTvqI4pF/6u237AlDunCw+9qlB7MSLsblOaZkZ40fF8oUafxbKdQtv0mMpTpw7zxjoJAi8VfpwnBin142/4D3je3Zoh9ccam+JKBq7V4719uXsRhPJ3wkLWE84v3q8BSnQouCAHX0PuD1usLso/wU2A1uoP5G+T/uSJfzKpB6oW4eGlEaKMLhdhoRmEHJ/b/TQ1jYtc5YwIaRhHmo6cniF7MZnsrYHIo4Qv02f1pXUpzIIFdLxSOca3jH9kwDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=WPeUluH+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=WPeUluH+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFNc60KBsz2xl5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 18:19:16 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-49548e01d02so3615865e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785917953; x=1786522753; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAmFeRSZbFo4XUxpmLajRJiEjxvL2omNRIxy6wYxlZk=;
        b=WPeUluH+4o2cb/5USWQXZJ5Wqd8FuF7Xba8EMmInBz+VRQPjFbOjBsz/6hhiiMkHPi
         qKykGIZsmXtCgZME7WrzLPs4aYNBHNFiZR/MJCjsSgIAfGoqBPZBAIhWVVU6h+IdxWGF
         hTQmQBrY3Ie4ygo6BQw7X0dleeFMVuQPJJD0KHlJ+85MhiPDpF7hWBo88gZFdd35lUK9
         34CWcHEp9CszpBzluIatdLRtioLtOOjvHDpt7UsQPlz8YV9vPJPIEIaKVfychRdihid4
         YF3hvlw8Tu4KCZnkWqmk0mYXuLiA5VNJV+fkLZ8a6eQUc+ua446XpJMk36kzyU2QpXOm
         3ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785917953; x=1786522753;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PAmFeRSZbFo4XUxpmLajRJiEjxvL2omNRIxy6wYxlZk=;
        b=TvM7Wyi2RUzMIFK5j1xk839JRiQUgN4zjf7CVgED565bkB3L+7ILJrAwnpPKKDSaXO
         ZobM47aLFFaApREIzj3OFzIm8J+Uc6DHioCfDhN0mGPvsRWII58FFuupJOqesbd6DVWq
         xTijir7O6Oj6KsT/djTxUEFlOtxXRiuUbr8P744AIu41wr6jqlGbZdIozjpHSdpGQMqZ
         myGScxVZCIq5F4D2YLbqMGTsEnB8JJlGFr8odO47m6BEPhU82Cx3kiTUVoNW82m36tf7
         JqBqF55ju9CikDYzblVG8XQE2E+tuV3WUMqXW9uKxL4IXLb0T8sD4AQFD/rl5HK0UV/n
         bEMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOtNtQQxHYy+uYZr9VEI/pT0bZ7YKac+xOvNZ0awBpAOP1wZFyBh8fdHW3gj763y0xL62KxnjzEwiEX5g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1MOMyuhttk8kC6kzQmKeLlhxIraeLzrGqlNNnZG3ow556r4b2
	U15C682142IgbyG9fnAwERKSHrYYcfFkPQr6b0KsYt0vNGQgg24gFT5h09Rek4Z8oIg=
X-Gm-Gg: AR+sD12R/DhOxGNgLiAXofuXNGtr8PLkqnIBxgdyGhJWKpdd63+V5vu2JcsfmdF0ajs
	LjRS9C83IyKi0RegxjJ48KN6JwWbtWpXPnblS4+ulQVDyvI6OSjlIVO33MXHO6qZ2db5wmhztG9
	PlCiSbC298aTi+e92HLm0Bty0uipDWN7EKTmPk7SiJD0kd1qZbVpGkbFwzE+24Z8UIbwrg/Hr0X
	rWs2S6sdGmWiC2xXu3VZkJXRFO7QD9EN4u/cwWQDwpBkMMHjP9Qsw7fezq5rLMqBJ/yuP+3mgzK
	SkZI/j+5cJIRU1Gg78tFGKWbNDPzTmcCogHoEP27QWn70iZUIAtEB/sK6XnYcPY9AejEuLdIQkd
	MVYkfF9q7GfeO1EIoronpKNKYeO10szYEWxvAWzUOlJcrgrYhlruAg/d4X1lOx5agnzNYQhebdc
	jCWyzNGfkhbW8rNugFD2TPe0h1QjT/o17jVg0dlySFgrXs3YHbnz7lbcRy2PJ5/IX3Fn+Zex83T
	9rFhTZ/ffEgFS2XL5Y7wARmwT3EjJxP0FOc4gl6hpgF9BC6zVldnYdR70hJPHVvUEILZSZzp+nl
X-Received: by 2002:a05:600c:474a:b0:495:7888:281c with SMTP id 5b1f17b1804b1-4994e6d4a13mr49305745e9.0.1785917952680;
        Wed, 05 Aug 2026 01:19:12 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e0356d4sm74745695e9.10.2026.08.05.01.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:19:12 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: jammy_huang@aspeedtech.com,
	yc_hsieh@aspeedtech.com,
	openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 0/2 RESEND] soc: aspeed: ipmi: add KCS Channel 4 over PCIe
Date: Wed,  5 Aug 2026 10:18:59 +0200
Message-ID: <cover.1785135437.git.gregoire.layet@9elements.com>
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
Message-ID: <20260805081859.BMonsZNvpVpzv-lER5z3KXf-oQNpGJ8o5a-wTWoT4JQ@z>

The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
interface on channel 4. This is a fully KCS-compatible interface
that is exposed over PCIe.

Add pcie_kcs4 to existing LPC bus in aspeed-g6.dtsi.
Modify kcs_bmc_aspeed driver to detect the PCIe over LPC channel.

In the driver, this PCIe over LPC channel will be detected as Channel 5.
In the datasheet this is defined as Channel 4 over PCIe.

The Channel 4 name is still referenced in the offsets macros.

The host need a driver to activate the MSI interrupts with the PCIe BMC
Device.

Tests:
With the patch [1] adding PCIe BMC device for Virtual UART, the MSI
interrupts are correctly setups. The Host driver is build and side
loaded on the host. The ipmi_si driver on the host is loaded manually
with the KCS address given by hand. 'ipmitool mc info' is run to confirm
it's working.

Tested on : Asus IPMI Expansion Card, AST2600.
```
$ insmod aspeed-host-bmc-dev.ko
$ lspci -vvv -d 1a03:2402
02:01.0 Unassigned class [ff00]: ASPEED Technology, Inc. Device 2402
	Subsystem: ASPEED Technology, Inc. Device 2402
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 154
	IOMMU group: 12
	Region 0: Memory at 82080000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 82040000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=32/32 Maskable- 64bit+
		Address: 00000000fee00818  Data: 0000
	Kernel driver in use: aspeed-host-bmc-dev

$ modprobe ipmi_si type=kcs addrs=0x82040E88 regspacings=4 regsizes=1 regshifts=0

$ ipmitool mc info
Device ID                 : 32
Device Revision           : 1
Firmware Revision         : 26.04
IPMI Version              : 2.0
Manufacturer ID           : 2623
Manufacturer Name         : ASUSTek Computer Inc.
...
```

Changes since v2 [2]:
 - Put pcie_kcs4 node in ascending address order.
 - Add missing "case PCIE_LPC_ODR4" in aspeed_kcs_outb.

An RFC [3] is in discussion for implementing multiple LPC controller support
in kcs_bmc_aspeed. This would change the implementation of the pcie_lpc.
This series adds the pcie_kcs4 to have devices like the Asus IPMI Expansion Card
use it, before waiting to have full PCIe LPC support.

[1] https://lore.kernel.org/linux-aspeed/51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com/
[2] https://lore.kernel.org/linux-aspeed/cover.1784732161.git.gregoire.layet@9elements.com/
[3] https://lkml.org/lkml/2026/7/23/429

Grégoire Layet (2):
  ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe
  ARM: dts: aspeed-g6: add pcie-kcs4

 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  8 +++++
 drivers/char/ipmi/kcs_bmc_aspeed.c      | 41 +++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)


base-commit: 03f906d8f5541e8bb741035981304feceed5993d
--
2.54.0

