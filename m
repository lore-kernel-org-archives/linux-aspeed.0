Return-Path: <linux-aspeed+bounces-2963-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6FACF8843
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 11:12:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBwgQ4pRJz2ypW;
	Thu, 20 Nov 2025 22:12:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763637170;
	cv=none; b=K9qu3MqozEtE9Ys3+dBGoDtyYLMnxRM69kEN/j4Bw+kfPYV6Fqfp4GEVjWumYMMe5U62rNwX6U2S+4V2muLdQDkHpBuOOEX/15kmm0wgx41p8H1FIFmxMb4zAGEF5CQahMJm/KaAQMFElcgvMGWD/qf9ABuz932QmhcgiCa6Xojw08irIlQNoxlBkWiJ13+PmBrWB92wjODhVFbY9OUBq2ciyD6cPvT8WgUxlTwCrg8zLtD6/DoCqBhlLHaf5kq25VnqocD7I/HY+oto+rSIx3RtvcazvdWuxIyR3W2q5+SyIWGb++YD9A58sW2Ks+ZPmXesKId5MQGI0ciI827h1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763637170; c=relaxed/relaxed;
	bh=pt4+H06TM6qgswv5vwD87h0lsny4oyy5ArHsOSJGz3g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PSkIDDzmyz8YGDizqmLibd7bwspLMjtx68G+qflsBA/ZmCf8bYDRHviZ89Ve0LqmaPwbRF77CwpUmvDyjqb8+sFlKv6mu8LI88Ix5Ggd8CjyYvOv9JkLrtDSsslWQeyszi/Jgs507uqYhpLEc5BY97vrYiWBDNMchPQXNJI/SNsyCmhizqcqi6+Vq5ttu3zmesd/A1ESYb00dfIjuTmAmd80UN99ZN+L17MEVIOVDqW+sAYgLcjIMmOcC6zkk7pcqwtin+V0Cyp58spddSRwWMIBqCUdy6tX6Kfqr3+Fb4uJ0WIJQPqV6IGyo3ex61KK+2sRjibGOqUirhMNR3YN3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBwgP6V2Bz2yFq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 22:12:49 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 20 Nov
 2025 19:12:34 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 20 Nov 2025 19:12:34 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v3 0/2] Add "aspeed,ast2700-pwm-tach" compatible string
Date: Thu, 20 Nov 2025 19:12:30 +0800
Message-ID: <20251120-upstream_pwm_tach-v3-0-eaa2f9b300a2@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAJ73HmkC/02MSw6DIBQAr2LeuhigWrSr3qNpDOKzvESEAP3Fe
 PeSrrqazGJmg4SRMMG52iDikxL5tcjxUIGxer0jo6k4SC5bIUTHHiHliNoN4eWGrI1lrZpHrVR
 vsGugdCHiTO/f83orPkfvWLYl+jvxhrcFspYn1fNOMcFGWpbPkJOmi04BccpobG28g33/AtX2n
 GioAAAA
X-Change-ID: 20251118-upstream_pwm_tach-57fba779ce84
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763637154; l=1125;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=7YzUe3MK3YytK0uTkt7q+giwkUEjWEmLwPZCbjl4/JI=;
 b=Ry5JJo5yb1rgp/9y2Gm2lB+FTnU50rMEHcFxnSx6NUIjuhSdtP3/KQCXVtUgQ4XlFp6bbjYdd
 K2HZHLO2OsGBLd0Juo3O4Up1/SkTBXOLJicdrC3q/W5x03+b5ouKuTV
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Adds the "aspeed,ast2700-pwm-tach" compatible string, which provides
fallback support for the previous version of the hardware design, to
the PWM/TACH dt-binding and driver.

---
Changes in v3:
- Drop the comments
- Link to v2: https://lore.kernel.org/r/20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com

Changes in v2:
- Reworked the binding to use a two-level compatible list with
  "aspeed,ast2600-pwm-tach" as the fallback.
- Link to v1: https://lore.kernel.org/r/20251104055112.2679087-1-billy_tsai@aspeedtech.com

---

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

---
Billy Tsai (2):
      dt-bindings: hwmon: Add AST2700 compatible
      hwmon: (aspeed-g6-pwm-tach): Add AST2700 compatible string

 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml | 7 +++++--
 drivers/hwmon/aspeed-g6-pwm-tach.c                              | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb
change-id: 20251118-upstream_pwm_tach-57fba779ce84

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


