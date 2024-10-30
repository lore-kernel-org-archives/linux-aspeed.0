Return-Path: <linux-aspeed+bounces-51-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B622D5CC8A
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Oct 2024 10:47:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XdkNd5xm3z2yfm;
	Wed, 30 Oct 2024 21:47:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730285265;
	cv=none; b=I9zxq7te4n3vQafRVjToDyg48dXcv8XLla38Cvg6h2WLKQiw2gz/MlZoEfayCWro1gyP2jvPBuuLX/PvxBmAcSde6natYrDPsYexkvPNc/15S6/7eqLJVA8SWZOHsOfrkbLiKbvoUcfyVa+vToJxKWs3XD9DSEa/ipyxeuK4smJIKe1RzJpCiXdXR50NKcXFRvfqpGXme5BFOd4hLbns/SZ238DZGiRtgfPESJYkEZRLWRImD64vwSD+fsffR4sXVf1pYP0YHp+7sTnRQXYEyi9Wz2X1QGZHbS0ScAW4D7sTp9bI7GRAd88fNuPL+ARmnhz3dQH/IMBDOzfxBzUr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730285265; c=relaxed/relaxed;
	bh=XE1xuDxMrU2b0HEnssRqzXb8f2BqyUVJWX/M8FCo33E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J07DskzHDJ0HogTbAztfg4EJbXujQGck+3kJ0dcOzJTUyaBszb4bfKzWEEw2Oio11wCrw9wqXH8z4fYzUXNy+ySurOLXW8ZubHsXK96Inu4pQgDZSVLuqV1m1xPS39RERN/VVkgVqjAYAl/J7RRQmjUcR090qSs738BKuyZetIClZVkYBANyTraP7SA8M2LZcLSm7ZkozWJjaRV/pXqMOYxwCtT/90VV82YpYZvLQgiQCLnXDwabj4uHE8ZS2ywSGJ1lsoq4Uz6AlwCeFRDpsRP0XTByeCrcU5hTzmvnwDmC9vW4ZPtuTyoSNUFPtqsJ2QZ1elMB5nb4lKdeUPMn2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XdkNb1HJJz2xG5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Oct 2024 21:47:40 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 30 Oct
 2024 18:47:18 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 30 Oct 2024 18:47:18 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v3 0/2] Update ASPEED WDT bootstatus
Date: Wed, 30 Oct 2024 18:47:15 +0800
Message-ID: <20241030104717.168324-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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

This patch series inherits the patch submitted by Peter.
https://patchwork.kernel.org/project/linux-watchdog/patch/20240430143114.1323686-2-peteryin.openbmc@gmail.com/
Besides, the boot status modififed in the WDT driver
obeys the rules proposed in the OpenBMC.
https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-cause-update.md#proposed-design
Moreover, WDT SW restart mechanism is supported by HW
since AST2600 platform and is also included in this
patch series.

Changes in v2:
  - Support SW restart on AST2600 by default without
    adding any dts property.

Changes in v3:
  - Get watchdog controller index by dividing register
    base offset by register size.

Chin-Ting Kuo (2):
  watchdog: aspeed: Update bootstatus handling
  watchdog: aspeed: Add support for SW restart

 drivers/watchdog/aspeed_wdt.c | 154 ++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 8 deletions(-)

-- 
2.34.1


