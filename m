Return-Path: <linux-aspeed+bounces-2733-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FE3CCFA00
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 05:51:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0yJ05Vvcz304H;
	Tue,  4 Nov 2025 16:51:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762235488;
	cv=none; b=AkNwQDOJYltqdbZnP3FcvmqbW+hGRa5kqnFca54Iiy+mOa+PkjaoDYPXeSjfnFtVCWtVlMr/n2zpy7VXeB7hA+6ONOgSGsMWX1ATrxzciOuLP/InvGZnoUCTkkqC97AO9pwXkLzbZe5696I8mGlZ2ATuIqFSCgheigJd/ArCVV29+sPniabVNKxgedqqsbSwpsCvDTaZCVv8xGFGpuDet5w0eIvW33VUsCAQM1aQayQu71PmaMF6XkPjlZiDxLlX1iwFLOX2fRtOBl1dKYg3AURaO2NxQIK0IViAlRw4u8s4cE9oiyUbZCSE+Tx+N9J49rZ0cHePBBnKLfXkhAaIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762235488; c=relaxed/relaxed;
	bh=Eu05ZZeTLarHGR2C8CjMLuNqkuuRSz/iA3vMMUUjDWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PSh+ApRw7+KYbnzwdnrl2D7apTGqcgFkiBGwJCJBYGika6SEGl+02Xhi5EIrdYwoU3KJr6E/y6VXY5goG4i6aJFl9kR58EochhqcIeXvStLJLoCjCwy7bTeiCGEnr7Ab5TY8k/rM/7BtGYx/mIQOhnRFtjapHjbCERWu2AxjYlnz6IPJryW+gB/nzDLuYOrmdhqGXMGvK2uNqaIzP5yt9Je0nZ1/4mRte7/jalMRPKU+Oxc2CS6vCxKV45j/qm4vqtLEtYMufYP1GAKNwmWJwdUzxg8PWqoiQ11ofAcfpChsM3rCZR/nsQ1xBzGs6NQM1mNuXXhbxtA9uWrt4L6vag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0yHz67Tyz2yr9
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 16:51:27 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 13:51:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 13:51:12 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <linux@roeck-us.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: hwmon: Add AST2700 compatible
Date: Tue, 4 Nov 2025 13:51:11 +0800
Message-ID: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for the AST2700 PWM/Tach controller by extending the
compatible string enumeration in the device tree binding.

The AST2700 PWM/Tach hardware is compatible with the existing binding
schema and requires no additional properties or modifications beyond
the new compatible string.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
index 9e5ed901ae54..d6ff4182085e 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - aspeed,ast2600-pwm-tach
+      - aspeed,ast2700-pwm-tach
 
   reg:
     maxItems: 1
-- 
2.25.1


