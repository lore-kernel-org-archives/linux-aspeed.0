Return-Path: <linux-aspeed+bounces-4695-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE524C5CFEB
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Aug 2026 06:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLG5G4nrPz2ypm;
	Thu, 13 Aug 2026 16:42:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786603378;
	cv=none; b=X7zFgomFtBULyptdaSS7F0uyEkw+xpBvdRzG1KDtYWdIyN6h7O4xQOKMk+pJ0uTshIF+DbG5yrqbNRcHSDzuV0v7Zb+rL6Q5r3mDOwFPtHiycL3I+GuwsRgHzpXRYPC4lBV7qkLpZLPZKMCo4/aVQXz5jSEr9BgoSK2JhxfksocLuo7A+LSyqyq+iiT97q/rR5ErrN0XOqBOufF6BonbpcclgUIN4jWvqFlB5bMfqKwc9wSiPHbG6egHr5+ZaGcXtyMzXxtlJvAPWu5Q56OmQM/ukq5oKlWTIguS6z6YR1uAAqDGyUKnC6ldYpLzxomhZ7XsJc8B2xugnPrx2MfUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786603378; c=relaxed/relaxed;
	bh=QevU8zqR57gnVydkv8ewKiACEVl739ECisJmMR/oK3Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ETpl2DFAGlqwMbbfTpo/wR/e45CW20uCjZLJ7NiHUeBzQg7pTctvyPTtqPTRdOqwwunsC/PzjvS3H8h3j2HvlH9U2/LAJ0f9KfOVqxAR3yxSDqO3IyKdN3ZQWMIjGPiZKJJtiU/xeX9F3/SmcWkNwv5RVQUKFzLMDCzIXujITuY+C3SIJuTIBQks3wgXdZ0zLC37WI9xybblc2D9q5qLTSu8/iLIv3Wr69Fruve5E18SD2bqHZMZzmUh5vUi0YQXiOmq8eOoWqPtaj92j1uxwS0ObRpqc51S8/6ZEnrdQlpTxCSDj+/vHamtlgspzU8HmtiiEySv4/sp4jEbA78rug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLG5F35Znz2y0B
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 16:42:56 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 13 Aug
 2026 14:42:33 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 13 Aug 2026 14:42:33 +0800
From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Subject: [PATCH v2 0/2] ipmi: kcs_bmc_aspeed: Support multiple LPC
 controller instances
Date: Thu, 13 Aug 2026 14:42:30 +0800
Message-ID: <20260813-upstream_kcs_multiple_lpc-v2-0-775b1db3fe95@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAFZnfWoC/32Nyw6CMBBFf4V0bU07yHPlfxhCoIwykUfTKURD+
 HcriVuX5yT33E0wOkIWZbQJhysxzVMAOEXC9M30QEldYAEKUpUByMWyd9iM9dNwPS6DJztgPVg
 jszgpLgBaJyoXYW8d3ul1tG9V4J7Yz+59XK36a3/V+E911VLJrtB5m0Cm2jy9NmwRO4+mP5t5F
 NW+7x+FcsuTxwAAAA==
X-Change-ID: 20260722-upstream_kcs_multiple_lpc-735942211508
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Corey Minyard
	<corey@minyard.net>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openipmi-developer@lists.sourceforge.net>,
	<jammy_huang@aspeedtech.com>, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786603353; l=2839;
 i=yc_hsieh@aspeedtech.com; s=20260721; h=from:subject:message-id;
 bh=T3p08Mixb/u4ni/RDlvjAkSIBn3qHMVaciIoHqagm9M=;
 b=fnig07TEfuecXa6JTRfT91GpXACWIBVvCKuFrTLVUV7epepRZ87Wtat90R+8CLuA9Mis5XU27
 epM6OLJpnPYDmdwobZJsltNVLjo3cxlcY50NXh0s9yrmbFt+4OCRupk
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=7KnU2ozXGF2IATT+Hvu7RbRwPxBA3/b+zhfM+UsPJMs=

Hi,

Aspeed AST2700 SoC exposes more than one physical LPC controller
instance. Each instance provides its own KCS1-KCS4 devices, with
identical IDR/ODR/STR register offsets within that controller's register
file.

kcs_bmc_device::channel currently serves two purposes at once:

  1. Selecting which HICR0/HICR2/HICRB bit-group to touch within a single
     LPC controller's register file. aspeed_kcs_of_get_channel() derives
     this purely from the KCS node's register offset, yielding values
     1..4.

  2. Naming the misc chardev (/dev/ipmi-kcsN) exposed to userspace, which
     must be unique system-wide. kcs_bmc_cdev_ipmi.c uses "ipmi-kcs%u".

Both happen to be the same value only because this driver has only ever
had to support SoCs with a single LPC controller. On AST2700, KCS1 on
each LPC controller computes to the same channel number, and whichever
instance probes second fails due to the duplicate miscdevice name.

This series keeps a driver-private channel value (1..4) in struct
aspeed_kcs_bmc for register access, and computes a globally unique
kcs_bmc_device::channel as:

	bank * KCS_CHANNEL_MAX + channel

where bank identifies which LPC controller instance a KCS device belongs
to.

bank is derived via of_alias_get_id() from an optional "lpcN" alias on
the LPC controller node, mirroring the existing alias-based numbering
convention used by mmc/i2c/spi/serial. For example, with aliases
assigning lpc0 and lpc1 to banks 0 and 1, their KCS channels are exposed
as /dev/ipmi-kcs1..4 and /dev/ipmi-kcs5..8 respectively. If no lpcN
alias is present, of_alias_get_id() fails and the driver uses bank 0,
preserving the existing numbering for single-LPC-controller systems.

This puts the numbering under DT-author control instead of deriving it
from probe order or DT traversal order. It also generalizes across
however many LPC-compatible instances a future SoC exposes, regardless
of tree placement, while preserving compatibility for existing
single-LPC-controller boards.

Changes in v2:
  - Drop the RFC tag, per Lee Jones' feedback.
  - Keep the alias-based bank-numbering approach unchanged.

Link to v1: https://lore.kernel.org/r/20260723-upstream_kcs_multiple_lpc-v1-0-d918b5270b86@aspeedtech.com

---
Yu-Che Hsieh (2):
      dt-bindings: mfd: aspeed-lpc: Document lpcN alias for multi-instance SoCs
      ipmi: kcs_bmc_aspeed: Support multiple LPC controller instances

 .../devicetree/bindings/mfd/aspeed-lpc.yaml        |  7 ++++
 drivers/char/ipmi/kcs_bmc_aspeed.c                 | 37 ++++++++++++++++------
 2 files changed, 34 insertions(+), 10 deletions(-)
---
base-commit: f0e6f20cb52b14c2c441f04e21cef0c95d498cac
change-id: 20260722-upstream_kcs_multiple_lpc-735942211508

Best regards,
-- 
Yu-Che Hsieh <yc_hsieh@aspeedtech.com>


