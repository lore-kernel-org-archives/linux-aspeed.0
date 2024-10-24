Return-Path: <linux-aspeed+bounces-21-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53215D0BB66
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 07:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XYxzG3ZHPz2yNJ;
	Thu, 24 Oct 2024 18:16:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729754170;
	cv=none; b=UVo4192rWb0zpFDe0g5BWn7k8+WksNxPOqE53AzXAj50zZy9ItvtsAcH4AlPdpMY5qtBWDKQnJ6GGlF3AB0I7JsiZdFTdWIHF4G2Koat6hSYlFB6jWJVETR/qle94o3N8HrR12JGHo8NYxTen9ICSvdh9wYuo2hYDGD0yZon8HWLWHVqdhEilT9yRia9Z3GZTuJsPZW8glJ93l5iN2vlFK+xUlJ/r9z2R4Y78LivTID9qeEvN5oAMWFTy1F0ZCAl3Tqiz5WuMgmjyPm2aP30sJrWW8ZFJ8ZeQN3R2I/wCQbF32xntHKlLOkDmYyuoQjDUyaqS/tsr+uwCmroNr8Hog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729754170; c=relaxed/relaxed;
	bh=/CzGqnNuGVk4KfXGc+al5gLiCBUSpWycQc4VHVwpDRk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NykZlvcHg82fO+mNzrEqkIAH9qPaN7UokT5F+1PxrUYhhxovGehXspeLrFN/7tgqcGKVJdxJj8PStw2cgyUyt4ykpQBt4GRHv0GfoRlmGSsbv+IzyejXjpFidSfyimDrtmZ+sR6LClUKzR6E6XrputCWGGZGSgfKn/B+tMougtCL6yVWTyWnCnP+RefPD2roPEQk00YWFOGj8TKcz7QSBr+SAi4n2gIku3yHZ1QDpPIaKcw+NjWbjMpCS+LvM5XJ1MBvP09SkHEanqRqn9ptAQmIwmHEVPUaSmwSzyjKuT726NbQ9Q0P0XCSjYro7GRLzoVGY/KsnjK5LGN/+67jyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XYxzB4nXyz2yF4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Oct 2024 18:16:05 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 24 Oct
 2024 15:15:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 24 Oct 2024 15:15:48 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ukleinek@kernel.org>,
	<billy_tsai@aspeedtech.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 0/2] Enable WDT reload feature
Date: Thu, 24 Oct 2024 15:15:46 +0800
Message-ID: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
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

Aspeed PWM controller has the WDT reload feature, which changes the duty
cycle to a preprogrammed value after a WDT/EXTRST#.

Billy Tsai (2):
  hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
  hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload

 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 +++++++++-
 drivers/hwmon/aspeed-g6-pwm-tach.c            | 49 +++++++++++++++++++
 drivers/pwm/core.c                            |  6 +--
 include/linux/pwm.h                           | 10 ++++
 4 files changed, 86 insertions(+), 4 deletions(-)

-- 
2.25.1


