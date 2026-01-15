Return-Path: <linux-aspeed+bounces-3352-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5759D4662F
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 23:11:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsdzG2cdPz2yFY;
	Fri, 16 Jan 2026 10:11:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768455096;
	cv=none; b=LVuf1bG6Ml2T/iyT/9cbEEmSylXphsHugDCBN5CmG9bcnkYFuxPe2L+qKwW6Z8+lttIOX4ChoB9KoWoencjqHEblzt+CyJYT1OJDxqcyGXTA/J4mK08q1kq5vtQ+Sl+ZiJyqiFi+R1ySE2hLzaUVjE+Ni8vqzCi0Js1CKr1WcBQvgVN1B00YgaTjAYZk/xL2lwkMe8WnLaA9lZLXVc3Hly7/OReONhzn0q4EtqYI8DDo9cwfv0YIJdCW35TbDdo55tcuveIjTiPqOgoGERTQVtHNXweF8fKbcQtL2l844Bx19BlFx6M1y7a0h4JAiQg1SCUt71LwCjLZ1mgUgXC3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768455096; c=relaxed/relaxed;
	bh=AzrY2zyUlFdBwp56KpRsHxbj2guX634diWbsvb3BOuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aclt4Hjv8vR6muGo4fDpz2+wL9R0NXlfW+SleCSv3fTqneekjFKsWt+IHOVr2Uzv5HFc4dwmthLcHLslFBvnVpauSWfewzJ2MtlibAn5fINnsUCmdNK5PhDdF2NuOMa4Z1Jiyy9HIrQ4mHiKGGsjoT5WZTlc4oS0t/+HaDQV82XIwX9Td3B+99kkNU6wMv+7hUTyEm0HgNlGu/hmpfiuaX3iNsYid/5JEQmXoW0j7Zi9w2CDjMQQZ4FpyonamCOPIKFinJNpgGHGT70FZFerA3qgQP1m7nDILOIFDodXhQNO22nP1B/lrmn7KSEqKCFWeJoW53JiN4vIuNs9NuVMUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BSPlz/7l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BSPlz/7l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsBRq0XMhz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 16:31:34 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-790ac42fd00so4596827b3.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 21:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768455092; x=1769059892; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzrY2zyUlFdBwp56KpRsHxbj2guX634diWbsvb3BOuw=;
        b=BSPlz/7ldGaqLKaWUT0Sx7FUo+8syUf1l/WfDjlE1ALp8Im10qUpbsPAMz9rAxvENe
         I0XVOEmxbXhO8mwKTfqJMUxvFi4WylMeMkblpkuLyOMf4jSGwsth3LZR7W5f+o7jsCoF
         Z3yctfoqpPW5Ekx1YaPwMHMurlRBjE9ZdC6v+RMNeE0AakOBFFSWML4B/zWXMNPcmrPs
         QK66wHY0Pe+rHjiOxMi5B2CmrGQxQ2lDi8lRkBkuhUtl47eUnsX+LCqlJR7sMvbC6eU7
         snTfl5X+Ianfmn8hzimtVFzIq88nT1B6y54gs5ZCP7ZNKRbToeKpzyZiVC2g8HV1zXqO
         xFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768455092; x=1769059892;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzrY2zyUlFdBwp56KpRsHxbj2guX634diWbsvb3BOuw=;
        b=ZqwmqKFpZMFI1bs3hu81pZ9Cu13BvGFsXjO/d9iMvVTfXo3mDaMO85bZChKAHDWO3e
         GD2GQ+R+HoR4GCPRaE9A8VddnQCJL3bFdiLJxRxVamIse5cXcQO7/QKSw/ODDRuEZgzp
         Qt4ZwXIZxju7Hk8vjSbHWrhwY9zik7QIqus9NRNmKl3jPepL6JEbElsIjgLtySFCOChq
         6EnRQIrn8i/AaJz3iicBKRO3gnOCWOvoeDmMaIy/K8N6HM1HY+t+ZtOwX3FE+uH6SwH/
         2UcPgmNTwNfX9QK6VDL/aKSkMZu4q358plas/x31kHN+8hLclLBWKdgCB0BeClRoOwKE
         0JOg==
X-Forwarded-Encrypted: i=1; AJvYcCW2E2ePYOXhAkKkAHmEoKDIRdXKTapox9bbUgndjSdj5KYWGgReUOOJ37SgKDeVBIdrHbnAgJPqIPr36TI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZV9A+Vx4gZPIhrWcnot9goP8dvVWbYlB1ZhgvbaNBjWeL17Ya
	lNalz1ySOFfV2iP6I5OHQt2hXuuCevynOkytoqmt3Rv11jFXOXwcQDJ+
X-Gm-Gg: AY/fxX4z4l/ZPPCKUPoF6MIZIOWfw6q0Ak8kMk+754UYrrgVgTmr9lGAoK4ccjpovzs
	T//VWW+tY+MCAycBd+q+RpmzHV7ZqLH5+mDnZfTEdtWi5sBx81DbmgPJX5dE9iiYutcRRqQXXm9
	nHeIBq8GSanGpOJqNjTspKozjMDPsrsoeuQn0uW+Kln60r8sq1pjgkZayFZQ7YqLqffuW/dM/Qh
	eTI73jmmi/QPw+Uwz3oUYBIfdm+sohJUC8Cbk8hOWX22didPgFb8bzTDaIjw5HTYYc+/WxLMnoU
	wOAE209FXSWJmLRv617gs96PSCWk2FJ3nOXbOJnV6EIwgbkHPk5HEr+h/N7IJDvS0ubLcIe3EAi
	lkqHeExu8KY2nf1kp+Dp+ZeHARq3/PNtOh23j4vu5JdCi5xTZPFZXCrEhQz0HDd/1pW1bgdFI+V
	TOWRBY
X-Received: by 2002:a05:690c:6a06:b0:789:3f0f:ac6a with SMTP id 00721157ae682-793a19ba6e5mr95950467b3.16.1768455092178;
        Wed, 14 Jan 2026 21:31:32 -0800 (PST)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-790aa553172sm99259437b3.11.2026.01.14.21.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 21:31:31 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Subject: [PATCH v2 0/2] Add device tree for Asus Kommando IPMI Card
Date: Wed, 14 Jan 2026 23:31:06 -0600
Message-Id: <20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJp7aGkC/5XOQQqDMBCF4atI1h1J0iK2q95DXExNNANNIhMVi
 3j3RndddvnDm4/ZRLJMNolHsQm2CyWKIYe+FKJzGAYLZHILLXUllVKAaU5Aoyew64jh2EOHbOC
 FxiBeq7uujcjnI9ue1pNu2tw9Rw+TY4s/oJZK3mSpKl3XErIfiGfjElOg5Tl4pHfZRX+IjtIU+
 XP+uqjD/Vtp933/AraGxV30AAAA
X-Change-ID: 20260111-asus-ipmi-expansion-card-baddaa36928d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Adds support for Asus Kommando IPMI Card [1] [2], which is a PCIe card
with an AST2600 on it that provides BMC functionality to any host
without an onboard BMC as long as it has a PCIe slot. The model name
Kommando is based off the model description in the vendor fw.

Currently supported functionality includes UART, booting from SPI,
KVM functionality(usb gadget for host, reading VGA framebuffer from
host) and LED/Power Control via GPIOs. NIC support is not included,
requiring additional patches which will be sent later on [3]. The
entire BMC functionality has been tested on an OpenBMC build 
available here [4] (which uses a modified u-boot device tree [5]).

The card supports some additional functionality in it's vendor firmware
like fan headers with fan speed control, host bios flashing via SPI, PSU
monitoring via an SMBUS connector, a custom ASUS SMBUS connector to talk
to select ASUS motherboards that support it and exposing a IPMI device
via PCIe to the host. These are unsupported at the moment.

[1] https://www.asus.com/ie/business/resources/news/asus-ipmi-expansion-card-gaming-pc-to-workstation/
[2] https://www.asus.com/supportonly/ipmi%20expansion%20card/helpdesk_manual/
[3] https://github.com/openbmc/linux/compare/dev-6.18...Genius1237:linux:asus-ipmi-card-6.18
[4] https://github.com/openbmc/openbmc/compare/master...Genius1237:openbmc:asus-ipmi-card
[5] https://github.com/Genius1237/u-boot/commit/1b1b7daa85f6c998e5f404296b3da43077a2758e

---
Changes in v2:
- Changed board name/compatible/dtb to be consistent with product name
- Added ast2600 to the compatible string to bindings
- Removed ethernet mac and phy, and extra blank lines from DT
- Reordered phandle references in alpabetic order in DT
- Added a label for LED nodes in DT
- Link to v1: https://lore.kernel.org/r/20260111201040.162880-1-anirudhsriniv@gmail.com

---
Anirudh Srinivasan (2):
      dt-bindings: arm: aspeed: Add Asus Kommando IPMI card
      ARM: dts: aspeed: Add Asus Kommando IPMI card

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts  | 117 +++++++++++++++++++++
 3 files changed, 119 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20260111-asus-ipmi-expansion-card-baddaa36928d

Best regards,
-- 
Anirudh Srinivasan <anirudhsriniv@gmail.com>


