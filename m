Return-Path: <linux-aspeed+bounces-3514-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473AAEF48EB
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Feb 2026 08:18:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fC4mk5Tvcz2yL8;
	Fri, 13 Feb 2026 19:18:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770970694;
	cv=none; b=B0qM4hmCXFrA7fSVI+Qi5KJYyTYIFL5zb63/ULdXxKWQLqlj9JGIqkT7QIoKLvAF/DjDPXhOL/W0caKoFIll5NNIbmKlLKzwNqNSCfcFSU5uMVIk7L6o5WYVPWMPItrp+GJQ/mElWrU6jJ1pQnOCMnL5en6YGoyk7ckcG6sbdIe8AJFgE/ZsGF+CSWNljX1RvRQNCSEPGxtZ39FP+H0MEbq3QhH1qwoF1p+6I3m79z3jlDTXq4Weg+B5TNl3MNgF4VoNYlJJlhh0gTX7r7Cf8fWJLVaL6x9CLef9bbew67qUQO6L3+wOroI9OC2sNuXhyFebXAXIupUGErqhSYODsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770970694; c=relaxed/relaxed;
	bh=M8dnnrrcEDHnIimVUAM15GI9TwFy54Eqb719DGpYZB0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PNA8F9BNVou16ETsXDTp/dP4p84pj1jgYqVRt32Q5tYMUWPGeFKN37P2KYpECPwQw7py/BmBKcnm6oNAK9lXf4g6gpvuSXU85MZu/ryKyXEdzO0pf3H0W7NibZ+O0tME2+WWGj6qIchNyQr7hPxs+cjXMRL9oe+ql6qKDOYwEJ3w2dNkaN9NYix/9Pp50I4ywD03/n3me9q3Cc6OtqjP+ErFKtpOhj8wszjhrLIFHMXGtrADVeqdbw5D4Y88zBO5RdtHuiDRCPHde68ePHR66KIIh+MqdxRhX572mFLiNlcnr6ibOjL4PnUnMNKaFH0y3jMpZJKNECAGj2Io4k176Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fC4mj42N7z2xdY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Feb 2026 19:18:12 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Feb
 2026 16:17:55 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 16:17:55 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH RFC 0/2] pinctrl: add syscon-backed packed-field pinctrl
 driver and DT bindings
Date: Fri, 13 Feb 2026 16:17:41 +0800
Message-ID: <20260213-pinctrl-single-bit-v1-0-c60f2fb80efb@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIACXejmkC/x3MwQpAQBCA4VfRnE3ZEeGqPICrHNgdTGlpV1Lad
 7c5fof/f8GzE/bQJC84vsXLYSNUmoDeJrsyiokGyqjMSCk8xerL7ejFrjvjLBeaiVS+UEW6LiC
 Gp+NFnn86QN+1MIbwAdRy5kxpAAAA
X-Change-ID: 20260211-pinctrl-single-bit-da213f282c95
To: Linus Walleij <linusw@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>
CC: <patrickw3@meta.com>, <linux-gpio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<BMC-SW@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770970675; l=2131;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=GyucnYRddM+KPEwtfmXcesurg0IS8btBZhDNqZcs91M=;
 b=wnr8PkYCiaj6qIxDNo2bobprHQFZzxKZe4ITj4bP2A7etp7tWDxgaI1FFV0ZkCF8v/Mzh9EvQ
 i9jFMJZ6T+wBt80YTsSiVUTiqGAEBSJYEh8C4XVx4HGcMDlWw2KJ+jV
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

This work follows earlier review discussions around extending
pinctrl-single for bit-per-mux / packed-field controllers. Based on
feedback from Linus Walleij and Tony Lindgren, the direction was changed
towards introducing a separate targeted driver instead of further
increasing the complexity of pinctrl-single.

The prior pinctrl-single series is at:
https://lore.kernel.org/all/20260123-upstream_pinctrl_single-v2-0-40f8063cc5a2@aspeedtech.com/

This series is a replacement of that approach., targeted pinctrl driver
for controllers where pinmux and/or pin configuration are represented as
fixed-width fields packed sequentially within shared registers
(packed-field / bit-per-pin style controllers).

Although pinctrl-single contains support for some bit-per-mux use cases,
it was originally designed around direct MMIO ownership and has grown
in complexity over time. For SoCs where the pin controller lives inside
a larger SCU/syscon register block, using syscon + regmap-mmio provides
a clearer ownership model and naturally avoids MMIO resource conflicts.

The new driver is designed to be instantiated as a subnode of a syscon
device (e.g. SCU). It obtains a regmap from the parent and uses the
child node 'reg' as a window into the syscon register space.

This series includes:
  1. A generic Devicetree binding for packed-field pin controllers.
  2. The new pinctrl-packed driver (derived from pinctrl-single).

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (2):
      dt-bindings: pinctrl: Add pinctrl-packed
      pinctrl: add syscon-backed packed-field pin controller driver

 .../bindings/pinctrl/pinctrl-packed.yaml           |  166 +++
 drivers/pinctrl/Kconfig                            |   13 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-packed.c                   | 1168 ++++++++++++++++++++
 4 files changed, 1348 insertions(+)
---
base-commit: ea24857a76ad90632f86f1e8c8465f96c9f2e407
change-id: 20260211-pinctrl-single-bit-da213f282c95

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


