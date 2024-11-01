Return-Path: <linux-aspeed+bounces-62-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57070E6B250
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Nov 2024 12:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xg09M5SWYz2xJy;
	Fri,  1 Nov 2024 23:12:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730463143;
	cv=none; b=V4hJ4feJTM6MMXowuXK1BsHvYTXiR1bBIvaMXlyrCqlFgsr71PfKpp2oAQrSeN6eDehuCgPGmvVV4vdhki6yDRQ8RAePPqK2hYoHpdRuouWJC8fB+u7dYo4TOshoPReNWhdw3AEe4Lhp8tszAF5h+RZWSyTjPV8NRF8fv5oY0Rwb7hEUJnpiBzLdXFXd1Po/QPRklDP4hAR4wRDciV+wYiydDkY4m3NH83Bn5XGnTfXinM4RXuDQsMIvvKstrlJmixacJ1aQJ8EoibSf6VXVMMDzndIPETeMV3xXHTx66jpMeP5NkSueUX2FN2u+6G7XxLgBbwyz/MQxL+tgdAb2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730463143; c=relaxed/relaxed;
	bh=m9/PRbACgMjhfSuZtez5+9BbrxC/xLDoQd5MuqmxU2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evRRm6A88WN2jQAmPpvxY6ht2YHPgorOMCp9l3eEK8ZRLcV8x5imXvA09gSAHQGK5G7rUwdJgXO4S4uRtAFbi4AuCIqaTvI9fC/CYTazTuyaQ8rL8vwyJgD06BsTflf23n1coE3UIu5NoInp28aeV+iYsW4UyuOaJOqjuX9XS2zldZ46lG+DQa3CrZ7lMQtl6vw4CPaPsFjZ7g1pWw5J6TfsMUbx4BgIqzRfCKe1xud6UAw6LDH4xxk1H3QxFS1lOl2wODUfDPNny6JhkKzk63po3iuqGL9mAqcEVPim/KsXtWYBVpFNWS0FLoPbxLW/SzxW8tadKCXqSZNVrm7pCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xg09L30v1z2xH9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  1 Nov 2024 23:12:21 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 1 Nov
 2024 20:12:01 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 1 Nov 2024 20:12:01 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v4 0/3] Update ASPEED WDT bootstatus
Date: Fri, 1 Nov 2024 20:11:58 +0800
Message-ID: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
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
Besides, the boot status updated in the WDT driver
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

Changes in v4:
  - Update the commit message for updating bootstatus
    handling patch.
  - Rename aspeed_wdt_config struct to aspeed_wdt_data.
  - Create restart callback function.

Chin-Ting Kuo (3):
  watchdog: aspeed: Update bootstatus handling
  watchdog: aspeed: Change aspeed_wdt_config struct name to
    aspeed_wdt_data
  watchdog: aspeed: Update restart implementations

 drivers/watchdog/aspeed_wdt.c | 170 ++++++++++++++++++++++++++++------
 1 file changed, 144 insertions(+), 26 deletions(-)

-- 
2.34.1


