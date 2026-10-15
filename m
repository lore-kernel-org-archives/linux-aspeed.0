Return-Path: <linux-aspeed+bounces-5194-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF44CC6B1C
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Oct 2026 03:51:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4vJM5X1Rz30Vy;
	Thu, 15 Oct 2026 14:51:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792036291;
	cv=none; b=ZuJxJ90lYSZqxU9mOcBj8kMY500+qzAl8uUmmgivOMjJzT3gxPKKrmjvRUcWEEUyDS4Quh3OLH30DEIxvbMhRItFiYnk9Zp1tx6KFJwaPt1/kfXVVCIpS+s5QMMDUh1t5GyDXibMWhCoJV+HtgZHAKcPleJpiCiZIhLff637WknoQOH8gYsMP/oSUjQ+Oij7KVdFZfgtDMO5byDUEfEVpUQjR1CKjqcGrDvfMva1l4mr+kD1hdIDzCCKk1VfI2BAYWGt/ASIJQIkjXFmAf9/Vn0KgmOyw7t+8FqUZW0H+kzB93wpF9nTUr6mefTapHPdW5P9Sm3AFVj/Qj2H9yoCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792036291; c=relaxed/relaxed;
	bh=5Brhdwqnp+zrXya+pAYQZ+kocBKTR7q3OUom2Y3/V6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lk+4g+dIW58U0uPoU1aJFDzlfT7ZpirZ2lMSnMngdVPG+SCJZVh51LqxP4Q2Fsa1b8fCKrLvh9S7zfciKPNZNDMnRpQ7jXV38kubEnSiwvak8XhqurR+XEXCDhVa8t0JgtTEHAbtei4Ny73z94k1NPg0KyTVoVYIwzsXb6wo345Qi41ukwkq2ZprI/3I0GP224aWtmseWy3Qdq92Ut/RSJDFStKMBpIS6qLPiQIzYGlTVrVqkVnyKiE6SpCqEaKxJ8fEwkPH7tQQUqPR9oi6yn1J3lMOpSh67/UBuob31CJbJRNuQuYgxwgXsPBOnhzArIW8SSCzyBc85YJxmnxnnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/45TtUE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/45TtUE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4vJL4YJcz3090
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 14:51:29 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so49380eec.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 20:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792036287; x=1792641087; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Brhdwqnp+zrXya+pAYQZ+kocBKTR7q3OUom2Y3/V6I=;
        b=C/45TtUEsnhiWEZUzVIPU/Xr7/O3mKTq07IFnvQuaXpnNThaydjrpLJXR2O1gvcWKr
         vWWDFQmvRFWMT93TO9FRURzcXVGtawANNxOcuz8casIngGEjuAPj6P8DZntlS1TjYQJ4
         fF7JHr3N0u0cjdpVJFvnUO3Y6PZegAFgzO5sc6VsgASof3Eo/jDnMN7ep65A7bFksNCp
         OgGDG2LIzhb3oNAQ31dVZcsm2Aeme87YlS+A2ptH3pLE/Di1MWJtbAiOKZRMvQOvNc/D
         kg8mNlVa1twyavOIrj/0B7UKOh/kKZi3O+caDeIwR1LlL2peWFx6N+PN3gIiEvUP7NOV
         z4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792036287; x=1792641087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Brhdwqnp+zrXya+pAYQZ+kocBKTR7q3OUom2Y3/V6I=;
        b=SpXKLzkJDXlZuG0wV5FWbuWMLBwwifJtBVshN6EaaDdSnwYZWnGIh6+Apw1/aAE8jF
         kc1JX9s9eaZSUPLPnWUY2gHawYsFSsqoIWi24oOepbbtv7QCAob0hdhxf4TENa8CrS2V
         a3x9BIm+SHZwujM1pZmA/yKKqLT0ZxhWDMGnYq9ZOIhoutmPgayu8R8n4SZBydWPvokC
         T53f2fwYmGL6NDDmEICStzmBHy01LUEowFjtvPZjMQT/BzGqtW4oQflZMWUO/xqZktHj
         sLEvmOU1t1PPOrg/3Pt1rwEO4P1fUuqGhsWpwthuxiji0FhmKVfJ7iHyySiLQ7ZKa/Ym
         AXMg==
X-Forwarded-Encrypted: i=1; AKwUvByn6R/zfV5l++QEduy60b3vlLCQBlkt64vMMySaWMiv5EYFtIvOqbJ0bL99gTgt4pEoyCl0IMGE2aOOskY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJWyrcM+/LoTizRT8Lep/bhjAVJ5z2QYpRY2O/8ezKgmzsGxx4F
	nUlHsd0mKNB/p3wj++ijGfFZxpyhP6+nnTi11NkoQUAYwWTZYPRIc/OY
X-Gm-Gg: AYBFou0cZUPj3Pp6wNsPiInAei+vxg9OzE2G11Xcgt3GamAaXTAeGokPZqXLt5uSzcM
	IK+y5sI96B1VDZ2etM8WdGrTvgkEB5aAiN9AYA99FcXcuOZkr8x9Hs2GykM2XIXlvmOAH2FFFEd
	cgTGvkPppKkml918s2LlbOW0+GHqhSB55M7KEmtC5u18ykBUtIDfwV3XQHvi/c8xZkNPZdc8koZ
	fVzSZoOp2hvaRt2jL80GdyaF71WV0m2uXPuipptijl1vSGDRxibU81wIPBfdzqQZwfN/Rm0k3aV
	b5nIBZ5ZN6sJUuXwXl9bXhnexlrQjoqj0QZ3/OLSMVTjIYIii/Q4QnLTpZuPZhX4Q5ahiygKR/2
	b5Bkur4rkTBx7r0wkdAhnPSzJfbjgoOvQI+nZBmgfTIorLZ1+uu1cVUKux9Angu/7T99zPGRYmB
	hrUssYnErz5aCwdccz7mWJoxpdOzyGrv8KD3Hjt+yDU6/xnFyKTfpYWMIiaGu4fbynNepmgRbvj
	E3NlPrWsgi8KcNl
X-Received: by 2002:a05:7300:8b14:b0:35f:f0:8edf with SMTP id 5a478bee46e88-35f00f09f07mr2511567eec.13.1792036287168;
        Wed, 14 Oct 2026 20:51:27 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm56719830eec.30.2026.10.14.20.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:51:26 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: andrew@codeconstruct.com.au
Cc: linus.walleij@linaro.org,
	joel@jms.id.au,
	brgl@kernel.org,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [RFC PATCH] pinctrl: aspeed: Handle GPIOZ6 pass-through strap on GPIO requests
Date: Thu, 15 Oct 2026 09:21:18 +0530
Message-ID: <20261015035118.9495-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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

On the ASRock Rack B650D4U, requesting GPIOP3 through gpiolib does
not provide working host power control when the GPIOZ6 pass-through
strap in SCU51C[9] is set.

With the existing GPIO request path, SCU4BC reads zero, but a host
power-on request through x86-power-control times out waiting for
power-good:

  SCU4BC = 0x00000000
  SCU510 = 0x00000000
  SCU51C = 0x00001e80

The AST2600 A3 datasheet describes SCU51C[9] as an additional
pass-through enable for GPIOP0/P1, GPIOP2/P3 and GPIOP4/P5 when
SCU510[30] is clear.

A diagnostic experiment that cleared only SCU51C[9], preserving all
other bits, allowed the same GPIO-only power-control implementation
to power on the host:

  SCU51C: 0x00001e80 -> 0x00001c80

SCU4BC and SCU510 remained zero. No per-operation THRU1 switching
or additional userspace delay was required.

Add an AST2600-specific GPIO request callback that performs the
existing GPIO mux configuration and clears SCU51C[9] for GPIOP0-P5
when SCU510[30] is clear. Check register access errors and verify
that the strap bit cleared. Other GPIOs retain the existing path.

This RFC handles only the GPIOZ6 strap source. It leaves SCU51C
unchanged when SCU510[30] is set and returns -EOPNOTSUPP for
GPIOP0-P5 requests when SCU510[28] is set.

Hardware testing on B650D4U with this pinctrl candidate confirmed:

  - Remote power-on: power-good asserted.
  - Remote graceful power-off: power-good deasserted.
  - Physical power-button power-on.
  - Physical power-button shutdown.

These tests used x86-power-control with software button forwarding.
The earlier board-specific SoC driver, its DT node, custom sysfs
interface and diagnostic boot parameter were not used.

This replaces the approach explored in the withdrawn B650D4U
power-passthrough RFC. The new proposal changes the existing pinctrl
driver and introduces no DT binding or userspace interface.

Feedback is requested on two unresolved issues:

  1. SCU51C[9] is shared by all three GPIOP pass-through pairs.
     Clearing it for one GPIO request may affect forwarding on
     another pair. How should that shared control be represented
     and coordinated with existing mux ownership?

  2. The SCU510[28] enable path has not been validated. Returning
     -EOPNOTSUPP is a limitation of this candidate, not a proposed
     complete solution for every AST2600 configuration.

Is the GPIO request callback the appropriate place to handle this
strap interaction, or should it be modeled through the existing
signal-expression mechanism?


Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -40,6 +40,7 @@
 #define SCU4D8		0x4D8 /* Multi-function Pin Control #23 */
 #define SCU500		0x500 /* Hardware Strap 1 */
 #define SCU510		0x510 /* Hardware Strap 2 */
+#define SCU51C		0x51c /* Hardware Strap 3 */
 #define SCU610		0x610 /* Disable GPIO Internal Pull-Down #0 */
 #define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
 #define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
@@ -2747,12 +2748,56 @@
 	.nconfmaps = ARRAY_SIZE(aspeed_g6_pin_config_map),
 };
 
+/*
+ * GPIOP0-P5 have a global strap-controlled pass-through enable in addition
+ * to their individual SCU4BC mux bits. SCU51C is ordinary RW, unlike the
+ * write-one-set SCU510 register. This candidate handles the GPIOZ6 strap
+ * source only; the SCU510[28] enable path needs separate validation.
+ */
+static int aspeed_g6_gpio_request_enable(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned int offset)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+	struct regmap *scu = pdata->pinmux.maps[ASPEED_IP_SCU];
+	unsigned int strap2, strap3;
+	int ret;
+
+	if (offset < AB22 || offset > AB23)
+		return aspeed_gpio_request_enable(pctldev, range, offset);
+
+	ret = regmap_read(scu, SCU510, &strap2);
+	if (ret)
+		return ret;
+	if (strap2 & BIT(28))
+		return -EOPNOTSUPP;
+
+	ret = aspeed_gpio_request_enable(pctldev, range, offset);
+	if (ret)
+		return ret;
+
+	/* In dedicated-strap mode, SCU51C[9] does not enable pass-through. */
+	if (strap2 & BIT(30))
+		return 0;
+
+	ret = regmap_update_bits(scu, SCU51C, BIT(9), 0);
+	if (ret)
+		return ret;
+	ret = regmap_read(scu, SCU51C, &strap3);
+	if (ret)
+		return ret;
+	if (strap3 & BIT(9))
+		return -EPERM;
+
+	return 0;
+}
+
 static const struct pinmux_ops aspeed_g6_pinmux_ops = {
 	.get_functions_count = aspeed_pinmux_get_fn_count,
 	.get_function_name = aspeed_pinmux_get_fn_name,
 	.get_function_groups = aspeed_pinmux_get_fn_groups,
 	.set_mux = aspeed_pinmux_set_mux,
-	.gpio_request_enable = aspeed_gpio_request_enable,
+	.gpio_request_enable = aspeed_g6_gpio_request_enable,
 	.strict = true,
 };
 

