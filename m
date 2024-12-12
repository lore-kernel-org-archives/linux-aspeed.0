Return-Path: <linux-aspeed+bounces-204-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C7E7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 15:59:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8HGM72TXz30W0;
	Fri, 13 Dec 2024 02:59:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734019163;
	cv=none; b=Z6R+RX01J93XdUEd02aGQ72EELbRmEfz4vTWM9TloRMLTDKVvAaquZ09niQzh6c+odkqoXrV5rjch7a+lAGIUM2+6c2jsyUtOxYiHbqlJVuKN5SbnGNJTOF56Me5rZSVkR9v7MGjBQ+yxi6WWHRoJUPZpjENHyILWLX0BpS+M3ap3GAqjD3Qjtbg6oaqQ04gfodAM5v86ZAhQz7T30cRPYopeYrPAO2ItzqRdKn/JDLai2Ui7A2VbChkzXJyOEfzY/fuQChin2bnHoScuYF25W7YEcTbkpeo0QZa34Yb5mkIhwb2UU4FeylEFjabipyNdzywAEPW+lSafYImMdyzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734019163; c=relaxed/relaxed;
	bh=cBKADtUVe2wG6uQ4QhL+8dQx9D5L8GY0GuiYG8durAE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k81kANwdBbBgK0W4jGWTy1OKFtaDaN+rayq1ysMUx65QgHyWVqhCqMNscLeMvc409WaiOZ2PcmDUdayK47APhPX2sl9fjhcxAEI69QR4VYVpXgaKoLACcFp01Lr1b1baTsGdsuaNPk+cCJnm2ptg/0pZUzcFnX1lq42fwAENw8AjrDsygim/tEXfn6W7kiUtaMUraqGDUQRia7tUWqPvl8C/n1k60Ab698vF60iDcySafAzZf7Ls75+gySWPW7A6Nf7Zf/hBnokrW6CzPzFxnEKZkKrhCk1qjf3kHTXO+pS+plIU59rMsmerExjox4v2n9FsUOAbMv9kSKDLYfT8oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8HGM0W5Lz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 02:59:22 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
Date: Thu, 12 Dec 2024 23:52:29 +0800
Message-ID: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

---
v3:
  - Split clk and reset driver to other commits, which are in series of
    "Add support for AST2700 clk driver".
  - For BMC console by UART12, add uart12 using ASPEED INTC architecture.

aspeed,ast2700-intc.yaml
  - Add minItems to 1 to fix the warning by "make dtbs_check W=1".
  - Add intc1 into example.

Kconfig.platforms
  - Remove MACH_ASPEED_G7.

Kevin Chen (6):
  dt-bindings: interrupt-controller: Refine size/interrupt-cell usage.
  dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
  arm64: dts: aspeed: Add initial AST27XX device tree
  arm64: dts: aspeed: Add initial AST2700 EVB device tree
  arm64: defconfig: Add ASPEED AST2700 family support

 .../bindings/arm/aspeed/aspeed.yaml           |   6 +
 .../aspeed,ast2700-intc.yaml                  |  60 ++++-
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/aspeed/Makefile           |   4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     | 236 ++++++++++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  57 +++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 359 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

-- 
2.34.1


