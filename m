Return-Path: <linux-aspeed+bounces-4575-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74677C531D0
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 07:30:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7qxV4wS4z2yhD;
	Mon, 27 Jul 2026 17:30:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785137406;
	cv=none; b=YCu7PlQj3hPJiWue5vyMrtmQ0/JjUEL+JyOMhdUtKY1SiA7IuIIFVQ/AfHXa3bA5n1Xion/1JzC7JDBZXjVyN+qUVsRnCY3xsIeIDSxM8/yILostA+GS/Khvm5sM+GcBPS1gYXMRUTAFedo2glQjWcTk1AL1n3tkH7wzLSwcqN+AbVcHUBBaer5CWJkYUYdgcisuOElGwJJXKjb25QtTUPjllSi64uGB/rb7oVcDayogYHLjnhQW8NfOrqrCppSzd+y2EoeKplFWS2jqmf9o1mlgU1sXOq6hs0EZZxcAXAtqTVJDaeQoYcM1SjvrinKlqRtnoG50rYrOX9wzZPbe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785137406; c=relaxed/relaxed;
	bh=PAmFeRSZbFo4XUxpmLajRJiEjxvL2omNRIxy6wYxlZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jMn9t5qjK5G26DJ7DpILnIEBUca4Oft/RX+McEJ5Y3++WZMmH0V/Hks4OyhT3B4ZYo40PewO701MhzX5EIkoHLqkmILRfFHtIT8k4JfOSMHVdBVieDWIAQVRfvvgBIopEYMVgVOwMdAdq2Q5jPSHaxGZokki6nqb9POhTC+GjX70aBa/5L+SOax21MWwrHzARusTTafYtGuqCTzP95xsUgnxmwv3AQAY3SlSz14eidOC3kbUwLZ24/xm0d7n1VT1jK1otDYfTJhgP1vrQr4sAi61p7ILSrvd8ir7HyaFKobZ6jGMKBkx8H/vOWMIX1yaZ+n45yGntwnfZWBt/L8gWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KMQ4Cf6S; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KMQ4Cf6S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7qxS61zjz2yRl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 17:30:03 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so15364035e9.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785137400; x=1785742200; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAmFeRSZbFo4XUxpmLajRJiEjxvL2omNRIxy6wYxlZk=;
        b=KMQ4Cf6SYbE53NvAc+V9Lc//baR7R3UnU7zTdkIZeuc3MtH219nqaIuCfZyyxlECG4
         7yNmwo/sVEFf/07H4Emn2zx6RW+AZ9TYbhxswCqx5VVH0gOYn1lq7F4wLB6kHyxvx53F
         0CEEEj3uEnMg4XBos2hcGMREuAss/+acvWy0y2deZU6XKPqOunsRhX+XriT7K12ekqJd
         QaZpO72hLuJWNBVQur7lpmEH9ViEjC2q/zd10+pAgis2rlJcu4GzCkrZvlKIuhw5HpNu
         Bfddjdn4We9vu4r1g/xGvsDjFJIrvq4aBEiUOmGPLt7O2/dabkmb8BuvEPHUR+8uV8v8
         KOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137400; x=1785742200;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PAmFeRSZbFo4XUxpmLajRJiEjxvL2omNRIxy6wYxlZk=;
        b=TEvuS5yISuQFGRu4huZ8IxmNiTkDIZrQyuWXDVlznYwQ3w+xpD2vOLfV7zLVF4Dhbe
         KZN7QYSGz3yAhD0daHVGNR5nWM8KrVyxtWGSdSq8aN+P7tbc9dmXZxJZ9dg2Xmf62lvR
         mlmglG881Gwp+tOIoBkHzNQJF7GYB1gUmqT7Aqq7KmbN6/CmZAZFulYzvNDaF55dFeL6
         f/59LcMxhZRtF+UiyQB8pthBa/GiUJdNSGK6Y1FTwLWpt+x//tgEwrMHtF7u5Y/iY1Ba
         sNnFYjdW0Yh/mjTOhM3fq2AgRY4Fj1vadDYIunFewPFEEwW9K059xbf9pANw5K5keoCY
         g63w==
X-Forwarded-Encrypted: i=1; AHgh+RoPa/XoHmHZqHJn8KUEAaiQoWnZ6Mhu9qUqhhg8kp/OKBC1drQsjPQ8qIHMKEjppXZv69m9JPgCNoilibE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2w2Si15pGJ2+HEXocWIds0rAHGb0+YlygGmJCPTj85bo5SCDa
	FfnD/+ixhJohJBPinv+T7q71cts7nO1lMsZxJ+QMbKZDX05ZzRywtccSXAJ3CfJkcx4=
X-Gm-Gg: AR+sD1375yz7XDmAH1ynqtQBxWuGjackwzK/iFUOeCHohQdWx+VRgs7vIg/O2BYeHhN
	WTJG/ykp+y06x8Jik54xyi/na14yfuTXTz9EE/FD0F/IP5nBpKiKOi/t4Dsu+DedR4AwHTHAnkN
	0oWce7tEfEahF4fnA34wZEeuHKI8CGsbbJIN1msY+/8ngU76jwwkXLeJO2XRAhj3f62HpgTHrD3
	/iQV6stNLKJORlmJ02UeMiDTZ34dzO0P1sBDinHUQzogNUUNf+LlhX8e4gge2X4zX617O4pUKN3
	EqMJcmIWd8lSQfNGoDLia0GhqhlqRppu2uQrhCbdVila0XHpSSjdWJYECJ0aDAy1tAx2T5Iz39y
	sHoTqNm3+5ekKawOSAgCiQUKqkdPjnFGAHghGjLh7QE+Htm/ScOlTI4PH7ywOJZhCFxisbAO0bk
	bdlB9zAwAqbGcB37SuokD8/vp3OuOmUHUvjn9qPt45v6UPgBIS7/lI+YxYiB3eZp1FTBpD5TDfZ
	qPhIxgmxLNXav9ie6claRBRUs54
X-Received: by 2002:a05:600c:45d5:b0:495:4cb6:71cc with SMTP id 5b1f17b1804b1-496b570fc0cmr84095365e9.5.1785137399785;
        Mon, 27 Jul 2026 00:29:59 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee4504sm201823685e9.6.2026.07.27.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:29:59 -0700 (PDT)
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
Subject: [PATCH v3 0/2] ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe
Date: Mon, 27 Jul 2026 09:27:39 +0200
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

