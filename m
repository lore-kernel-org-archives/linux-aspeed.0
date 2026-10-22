Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F10606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Oct 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vpd1V7cq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j99Sk1428z2ySc;
	Thu, 22 Oct 2026 13:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792637014;
	cv=none; b=aszq3FQCmYbpUH09Id1osQlOnQUsDNL1KTV73VbXk6GEt67pXjoHN0J7NzUJD8LMMzjC8ILElcu0/d8JdqoF+78NoMAXBNsYqdWGAR9PZlXhVqTy/L2xDXkluUIg5uGut6fgBL1Q+fK0sbAaFpqFp6/1wFPfY2KOWZHs8gbJMkMrM+4KJKNBrJt0xfLXmnajgZjV1ob880wSIuXNGg+FYJPWZMSTBGqCs1tt412x/1KYkPq1ZayCaxbuMgVEE/Ohih4H2m2oXSJ3NtqH41WCO5o57ODN0RNKf49JTmIsQWUwMY/hvoLvt4N4JC5P8mdknUZPAXRaWf+qYDaCU69rMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792637014; c=relaxed/relaxed;
	bh=TUkEOgHWS4CYXansuqJaAAhK76CRt/42A/p2kv2zT+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md/0qw/TcVujfOi9a73npfmmycwMxl/sjBgBc4OvMHeF2TQeoAGywBqwiylilJtYOZUElZ8yCnJW8IgEqeeN6/nvejNqmzPqAD+b97JbGX5vUg9+erJ2Y64b32Dp22vUSCpp9jtcqdU5IK0EsXCOgxYUdZ4TnD+Na0ggt1RTx4I4CBHo3JB0RtKyxAHqmWtxDLyHxZAz57uPNCvaAIZFy4dD0jutJ65Be3UuceYIQ+0qTlUmfvliL7PGDfWm2aYUM2S89PXW6tG3r/Q2634ZRoyE+h93zhZK0FUgTmofrQz5S/PJpKF/Wkj9MfUcsYH54REkVOuCu00y41pujWEvYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vpd1V7cq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vpd1V7cq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com [IPv6:2607:f8b0:4864:20::122d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j99Sh6Frvz2yRn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 13:43:32 +1100 (AEDT)
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-15ea896ddc8so1948725c88.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 19:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637011; x=1793241811; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TUkEOgHWS4CYXansuqJaAAhK76CRt/42A/p2kv2zT+8=;
        b=Vpd1V7cqWsfbgwEHPVWxJJWBT4NaW2JK8wJ7KmYYR0bck4x6ZywbUatCFLCf2XJW3c
         Ew0apGtbl3ix2tmeZyhC7FF/zccs1wQwSZPV2jG3f8WUMZw3BAhdM6SBrd1ODfq3HUMH
         OxI2C6D/bcyyT9QB2IirxYLRS0oA4hbPE7Ce9C1HCWVGYKPSpRTkMc0B1rBfxKA8XKfX
         LicqGdQ1XhcK7NCxAcVX2Tt/GAAScFzrms8gCqy+HtBHgKxwgy+COg7KoyWeeDZ1kyAe
         rE5WmFI1/ACSpT8Pxx5L8ILf4E2pr/kYo6Lui3HF5lTPe8TgPgd1EW5hcsSPTecbheSO
         naHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637011; x=1793241811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TUkEOgHWS4CYXansuqJaAAhK76CRt/42A/p2kv2zT+8=;
        b=xdFSA2F6ZTBGLuLz8nCDl7A4HoBmBSE2/AGMV06zc6v6fJO1IpyrPk9qMM7r3lzRM0
         xTITze0+gZzEuU9QBcO638OJCFY0yTnhrjkdoJTJGFHmG1g1T7KB8eIj1L1Y++tK/VPk
         G0LF/fQRy8gHNHVGP37fAv7rlirVuBb0/TI1YGtZFvqhYexnwOJ+QZr4bfi7JnSrhsYp
         MROfeMGFyeSHefXkRA/PPZ1LkYD934rl2EAsQ3xa0YKU5JS9/r74XDLlnS9bGuDv14uO
         9ZCC1IBqzRRKp0wXaD41+bz9Ur8yD+HxulAIQWh827vaZvWf7pzq+LUJHWu+aFZT8mh+
         b2Uw==
X-Gm-Message-State: AFq9FYLLgYAG4DaTGxU1C5Yln/RMyaxM1e7Jof7mAKHEPJIMHs3a0UYg
	BeNv15Z0uMkxYQ9xrPgYV/ZQXLvgqJoUodms56gTlqlmHCDq4oa5bYoQW2ngog==
X-Gm-Gg: AYBFou0VX7X37Y93l7D/aqumCW9miZBbs32wUH449gbREKo/oNm3Id5cFh44tmN8Aja
	/uMMetJy5BchHEf8J+u1P5nKSbIOFqCpqotXLZuxY4ZbWUVkNA8sPT8e50ORJ9Tl87GXQrlZtED
	SbpuqotY1pjOvbjJA1kJ148XJ00Ca4y7ILOZkNtyHNFfKzVPg2G1O2p6d4Tn+yblkG3ZI96EUcu
	zTbYCDZD7plPYGOhKH5mOdFZi7tVABEu7oQcd+zZdbATT3GQp1isMBF4qUMirC+rqbR9JBJgdVV
	WZDbOLLUI5sQnfhO0mv3dlBQ06fxVBX88OzqrY7Oi6hFBxXMRkOWtlZuvC39XML/27sIPQ54HsI
	xq+nXAAY+S/pv1hBio78/URQcEMnPihC+GHI11PSYMERFixuUO4lCcL8QtmPolzM4Nvsy4VVoH/
	3k5o1kwm/XlNAJBFhc+bZkt9cxolPh+Ewkyzp+6c0ux5DRG4h3LumcjVcR1hzwu6i6X5qRSpNMv
	4Hxi0+8O4bL4v50U4l337HfuuI00baSwqA6ZE7AYDFyoHiKBFbpNnJnyEyebLdMjMx6FRJ8R4BP
	Q0qq+bR/P7GecPb7aw==
X-Received: by 2002:a05:7022:7a9:b0:187:eb7f:b8f with SMTP id a92af1059eb24-190a50efe13mr6277201c88.13.1792637010372;
        Wed, 21 Oct 2026 19:43:30 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm11077386c88.17.2026.10.21.19.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:43:29 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: linux-aspeed@lists.ozlabs.org
Cc: linux-gpio@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	krzk@kernel.org,
	tan.siewert@9elements.com,
	billy_tsai@aspeedtech.com,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [RFC PATCH v2] pinctrl: aspeed: Hand over global GPIOP passthrough to local mux controls
Date: Thu, 22 Oct 2026 08:13:14 +0530
Message-ID: <20261022024314.48623-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022024314.48623-1-prasanth.padarthi10@gmail.com>
References: <20261015035118.9495-1-prasanth.padarthi10@gmail.com>
 <20261022024314.48623-1-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On B650D4U, GPIO-only host power control fails when SCU51C[9]
selects GPIOP passthrough even after the normal GPIO request path
clears the per-pin SCU4BC selections. The THRU expressions currently
model the local controls but not the shared strap source.

Experiment with transferring globally selected GPIOP0-P5 THRU roles
to SCU4BC[29:24] before registering the controller, then clear the
active shared sources. Leave PWM selection and the strap-source
selector unchanged. Subsequent requests use the existing mux helpers.
Clear SCU510[28] through SCU514 and verify the shared enables cleared.

If handover fails, record an instance-local error and reject GPIO and
mux requests involving P0-P5 before changing their mux state, while
attempting to register the controller for unrelated pins. A P0-P5
controller hog can still cause registration to fail. Retain prepared
local selections after partial failure rather than blindly restoring
a shared enable.

This RFC explores probe-time normalization rather than the previous
request callback. Mandatory initialization policy, signal continuity,
concurrent SCU writers and post-handover registration failure remain
open design questions.

On the tested B650D4U, the new image powers on the host with unchanged
GPIO-only power-control userspace. SCU4BC remains 0x30000000 and
SCU51C remains 0x1c80 before and after the request. The operator also
reports successful power-on after complete AC removal. Actual P4/P5
forwarding, transition glitches, PWM coexistence, SCU510[28] hardware
handling and restricted failure paths have not been validated.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 147 ++++++++++++++++++++-
 1 file changed, 143 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index b0c7e4f6df9c..54396f2ba91b 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -40,6 +41,8 @@
 #define SCU4D8		0x4D8 /* Multi-function Pin Control #23 */
 #define SCU500		0x500 /* Hardware Strap 1 */
 #define SCU510		0x510 /* Hardware Strap 2 */
+#define SCU514		0x514 /* Hardware Strap 2 Clear */
+#define SCU51C		0x51c /* Hardware Strap 3 */
 #define SCU610		0x610 /* Disable GPIO Internal Pull-Down #0 */
 #define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
 #define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
@@ -2747,12 +2750,56 @@ static struct aspeed_pinctrl_data aspeed_g6_pinctrl_data = {
 	.nconfmaps = ARRAY_SIZE(aspeed_g6_pin_config_map),
 };
 
+struct aspeed_g6_probe_data {
+	struct aspeed_pinctrl_data pdata;
+	int thru_error;
+};
+
+static bool aspeed_g6_is_thru_pin(unsigned int pin)
+{
+	return pin >= AB22 && pin <= AB23;
+}
+
+static int aspeed_g6_gpio_request_enable(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned int offset)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+	struct aspeed_g6_probe_data *g6 =
+		container_of(pdata, struct aspeed_g6_probe_data, pdata);
+
+	if (g6->thru_error && aspeed_g6_is_thru_pin(offset))
+		return g6->thru_error;
+
+	return aspeed_gpio_request_enable(pctldev, range, offset);
+}
+
+static int aspeed_g6_set_mux(struct pinctrl_dev *pctldev,
+			     unsigned int function, unsigned int group)
+{
+	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
+	struct aspeed_g6_probe_data *g6 =
+		container_of(pdata, struct aspeed_g6_probe_data, pdata);
+	const struct aspeed_pin_group *pgroup = &pdata->pinmux.groups[group];
+	unsigned int i;
+
+	/* Check the entire group before the shared helper changes any pin. */
+	if (g6->thru_error) {
+		for (i = 0; i < pgroup->npins; i++) {
+			if (aspeed_g6_is_thru_pin(pgroup->pins[i]))
+				return g6->thru_error;
+		}
+	}
+
+	return aspeed_pinmux_set_mux(pctldev, function, group);
+}
+
 static const struct pinmux_ops aspeed_g6_pinmux_ops = {
 	.get_functions_count = aspeed_pinmux_get_fn_count,
 	.get_function_name = aspeed_pinmux_get_fn_name,
 	.get_function_groups = aspeed_pinmux_get_fn_groups,
-	.set_mux = aspeed_pinmux_set_mux,
-	.gpio_request_enable = aspeed_gpio_request_enable,
+	.set_mux = aspeed_g6_set_mux,
+	.gpio_request_enable = aspeed_g6_gpio_request_enable,
 	.strict = true,
 };
 
@@ -2782,15 +2829,107 @@ static const struct pinctrl_desc aspeed_g6_pinctrl_desc = {
 	.confops = &aspeed_g6_conf_ops,
 };
 
+/*
+ * Experimental: transfer the global GPIOP0-P5 THRU selection to the
+ * individual mux controls before registering any pinctrl consumers.
+ * PWM selection is higher priority and is deliberately left unchanged.
+ *
+ * Do not undo the local selections on error: a shared enable may already
+ * have cleared. Keeping the equivalent local selections preserves routing
+ * while rejecting affected requests, rather than granting an unsafe GPIO.
+ * Signal continuity during this transfer still needs hardware validation.
+ * Running before pinctrl registration excludes this controller's consumers,
+ * not independent SCU writers. Regmap locks individual accesses, not this
+ * sequence; coordination with other writers remains an RFC design question.
+ */
+static int aspeed_g6_thru_handover(struct regmap *scu)
+{
+	const u32 local_mask = GENMASK(29, 24);
+	unsigned int strap2, strap3, local;
+	int ret;
+
+	ret = regmap_read(scu, SCU510, &strap2);
+	if (ret)
+		return ret;
+	ret = regmap_read(scu, SCU51C, &strap3);
+	if (ret)
+		return ret;
+
+	if (!(strap2 & BIT(28)) &&
+	    ((strap2 & BIT(30)) || !(strap3 & BIT(9))))
+		return 0;
+
+	/* Preserve every globally selected role, including under PWM. */
+	ret = regmap_update_bits(scu, SCU4BC, local_mask, local_mask);
+	if (ret)
+		return ret;
+	ret = regmap_read(scu, SCU4BC, &local);
+	if (ret)
+		return ret;
+	if ((local & local_mask) != local_mask)
+		return -EPERM;
+
+	/* Leave the inactive GPIOZ6 source alone in dedicated-strap mode. */
+	if (!(strap2 & BIT(30)) && (strap3 & BIT(9))) {
+		ret = regmap_update_bits(scu, SCU51C, BIT(9), 0);
+		if (ret)
+			return ret;
+	}
+
+	if (strap2 & BIT(28)) {
+		/* SCU510 is write-one-set; do not use an ordinary RW clear. */
+		ret = regmap_write(scu, SCU514, BIT(28));
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(scu, SCU510, &strap2);
+	if (ret)
+		return ret;
+	ret = regmap_read(scu, SCU51C, &strap3);
+	if (ret)
+		return ret;
+	if ((strap2 & BIT(28)) ||
+	    (!(strap2 & BIT(30)) && (strap3 & BIT(9))))
+		return -EPERM;
+
+	return 0;
+}
+
 static int aspeed_g6_pinctrl_probe(struct platform_device *pdev)
 {
-	int i;
+	struct aspeed_g6_probe_data *g6;
+	struct regmap *scu;
+	int i, ret;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+	scu = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(scu))
+		return dev_err_probe(&pdev->dev, PTR_ERR(scu),
+				     "No SCU regmap for THRU handover\n");
+
+	g6 = devm_kzalloc(&pdev->dev, sizeof(*g6), GFP_KERNEL);
+	if (!g6)
+		return -ENOMEM;
+	/* Copy per-device state; referenced mapping tables remain shared. */
+	memcpy(&g6->pdata, &aspeed_g6_pinctrl_data, sizeof(g6->pdata));
+
+	ret = aspeed_g6_thru_handover(scu);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret) {
+		g6->thru_error = ret;
+		dev_warn(&pdev->dev,
+			 "THRU handover failed (%d); GPIOP0-P5 mux requests blocked\n",
+			 ret);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(aspeed_g6_pins); i++)
 		aspeed_g6_pins[i].number = i;
 
 	return aspeed_pinctrl_probe(pdev, &aspeed_g6_pinctrl_desc,
-			&aspeed_g6_pinctrl_data);
+			&g6->pdata);
 }
 
 static const struct of_device_id aspeed_g6_pinctrl_of_match[] = {
-- 
2.47.3


