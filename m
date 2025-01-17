Return-Path: <linux-aspeed+bounces-520-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310AC02183
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Jan 2025 09:52:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFQd4JTjz3cgk;
	Fri, 17 Jan 2025 20:52:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737107561;
	cv=none; b=X0HSk0yWnU1/4SDkQHeDIpENqGHlxUYBlXJyZQHhLKegTc0snvIsvdb4rzQSaBiKXx6HZTO9ke7KdHgmKooo5R5O1ZrksyEPgjr/jqu7IjxIcrhf3g04pwUPY0WnO/FHvcXZq4pds7tQxyCGWiIInV1Hgg3yBtbZkr9kSin1HX0OwKBG8SdfItatTzx7c7RZ+9+l0X/O8CvepF7VamR32PG2f53gDCWdYZHxE7j8CVyZFOqbmWEfBYafmgcU1v8uOfna5jbuakTVl6pQ8JhocQvEetuD4VVcRC11LLw61+WdA+XdoSkJ5KYNoSaRKcC2Jxl7h93WWspTz9T70VfNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737107561; c=relaxed/relaxed;
	bh=ic9OtFqRlWUcBS/MPE0Sm7R5wsen/MvTyrY5f/59wMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hTW10bUTFDWNEnMtDVaM3jzavo6kaVsvxivWKw+tMYK9lHPaT0gkezHl2XiNvhuRHkGoDGsMBGZ4AXte/CQ/hpaJpL/rosp9dS+whJSjydIU+KomenPLggxIFo6wjj5ew4xvyuLajnsioGBSzb2R2ksomeuUEFKdK2jiX9Pu2aQXStw74NzB+EzJ6Dx/SpQeQ1LQ3VeG/gCc+OF/dJsdAx3ZtYMbOTPdxHp4aOLwp6d+ZsCEqFk0poyERos9tbXKSGZTEAtWfiOTBgjxrzkknfNHdERWyn8TR8Xar49CCDq3vUa5c1yfGg+IzRzDTRvQ/LVCbi/KgBPmnMRmx7wlQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFQc5LnCz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 20:52:37 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 17 Jan
 2025 17:52:19 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 17 Jan 2025 17:52:19 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <elbadrym@google.com>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v0 0/3] Add AST2600 LPC PCC support
Date: Fri, 17 Jan 2025 17:52:14 +0800
Message-ID: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
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

The AST2600 has PCC controller in LPC, placed in LPC node. As a result,
add LPC PCC controller driver to support POST code capture.

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../bindings/soc/aspeed/lpc-pcc.yaml          |  51 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-lpc-pcc.c           | 505 ++++++++++++++++++
 5 files changed, 574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/lpc-pcc.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-pcc.c

-- 
2.34.1


