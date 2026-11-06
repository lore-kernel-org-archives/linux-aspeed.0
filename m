Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDA606A328
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g3n2IbfA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLNS21K50z2xHG;
	Fri, 06 Nov 2026 13:29:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793932194;
	cv=none; b=atUoDmXyL5wFaTwOEIRTml7yuz/5/LyI0tDYMlTSBqWMQ4XXrqfngg5CTJsGiUm2yoJW2IqtaNoiXq4W2tozlglYn9iQIvDmNr3bZqT2KG6fE+VK6yEJHe4ZW9fyQ+6x370YBK3DrXJB9qyKYUHvGnykossS7JE4n/mZ2x++jC8iNRc47RU6zdXEXv8cZw7O/A4momPhy91riC9iOYC8Ad8JcadP3pAerWYIPYdTdTcWO1d1OjZYEqxYQjyvdMrKFJEpmIDt68b8p+eipOtuL6OBj+g6yZxmV0VqC4o5qC17XpTZ0K4XiQMKjyFoYhXF+/8GZQVCFQq2+ElZZgt5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793932194; c=relaxed/relaxed;
	bh=3Cjh5kJivjhoi379WZ/ExYbSeX/mtBBoq1mcspo2n18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDcZyYqbz8JbmrnXjwEFt2eoyoJFups93HTAL+4LHGxtxcJQCLJ353+qXPkzQdjflrCyb1vS9um4IC2szJNs6IYOVSQfKo0lxdS68U8TSQE771qC+mYPrGBzJSD1/SWuCZ5/UawvSHhbl9f8APumpeXbduE62NuRtxfjfjW2ztQNz2gGzpIjao7weokB0cgiGHR/qGHXIDiz16D0PbgUmNy1nEMoCMny4MR9cV851pjJOjv55z33qf4El3FnzvVrWWbFRvUQ4aLjKCuAtqkYtDTGPgkbfRO7BRvLEl1vzcEChzdG/DFGTDK3ctuWn7H2flISDYU0zZJBhXQbJfJFjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g3n2IbfA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g3n2IbfA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLNS11Gmgz2xGg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 13:29:53 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso289193eec.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 18:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793932191; x=1794536991; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Cjh5kJivjhoi379WZ/ExYbSeX/mtBBoq1mcspo2n18=;
        b=g3n2IbfAW7PHrajfQztqTU3OJd9JZJBba3SRN3/R9KjMA5JLeu93gBygz8AoEdisJo
         f7MBAvwDjZ3iN1rPYrGOs4czY8g/h04wROk7QRTzOJVf0PkxNv9DgbVHBk1Jbj+JPbE7
         dpZdHPIHyUaT2ZiJwkukeWoTdpvNPQFoy3UwRZhbtj5bRIH4rPm8NuB3RpRazfCrHHwP
         YEvxQ2OWWeclDktrkfDmMeWQf4YHhjAA4CQoly/9CGowKl2BMxNlCjvObf42cdlhrVGE
         myhRAgSkBTNTXivbczDWZQdSgWO1BRcoTOr5Ss/ycRFNuP8oaFZvxyShmSEb25M0Rwri
         zvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793932191; x=1794536991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Cjh5kJivjhoi379WZ/ExYbSeX/mtBBoq1mcspo2n18=;
        b=qPIpsoGjsMprorebrE0KzieCpKQCwf3vWFD2gqWzX+qUwgDsWrMCxqkqLUjmaQ7ebd
         iIXERYn8nXIGEjs0rEH9ukIkZJt/SiKHHAQQn7/FbyVvAD+GrumcYiwY+dP/ZvWbeurh
         7hF4HP7pDbk6C8syDbU6tCBvusZ8LECFzHEyJm/kpVVjYj1jjd60w511epWfvo7rXFIN
         niFi0oLub6F2BEFsnijB985O51ZxwBPu29d3HKdW8/8A3iD4mpmcBD85g8xgcW2kwpRm
         z4296cn2OwDfqKNZGAWeTfJrWBX4qKFx6m0F+DZbColGdSscpFq09SCSFSaImYypx1A1
         qvXA==
X-Forwarded-Encrypted: i=1; AKwUvBwx3g12BxR59lFyfyB9uxFNGXye5pKHNAp0uatwYarJdpXFH8JH2Je7IAeIucg7SP6DRDyXRu6NYxI6zac=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8b4HKpfDDSQw8kHRU49lxGtNp620DczoviEIM5LMoxNgCURKET
	h7EW7sPMAIyPOKXjxbXVOhzM0Pt0sLozcVVKFcNxc015SSSu2/pwZruY
X-Gm-Gg: AYBFou0rf8t4YOEvmDxeL9G+v575jgKUjxRt2lU6fYPx+yfzdL8m4iqMf4Gtb/RM4pW
	DNl7dWOsPYq02UD3shJIR4XYVug/kh3Qrhuq2sqyw7DBKSEQvZd1bMC+FY/UftFucNL1gv8gH3J
	U15xCD3qozliyXlNW7aaREtVb0q7qgtp5qfFsbZmojKjQlxfNwducWvT7cen39u5+TiG/JrHnW5
	namaQ6NKkwpLXtsUObxX9KULPxkl1+mE9/p5yFWLON9tRMfLqQD4fzXBaRAQqhrT/CpqarxUrd5
	TlbfvUhMynGRzwWhG/ua2yWrhXvm8zvUV6yFNrXzhsjRoRdmLRu6Jwh7QYBfmL5XlbmFjhxwnIL
	eAFfVmhYjnBZmiDQkZpmdct3YhB1bMWZw3Y4URZRnzPbXZO7cnlQgLmvctzXFuIV8PZUmDWGp1I
	56Vyx2327gy4WuiH5nY7V5nln1hoMkk/CuQLg3iVBWpPOrMTW/SEv8IpHw0fcbcEiYigzvNNHiL
	Nvo5vQjGJTwdUtSYFLZoa98at13BvX3IIHGkuTvVe2Mzlm/ti6PZz5rE+89eVeqwcgQEtyCcbyz
	Kyy7z/5+n6t1B8TwdTsYXMMNtaz3OAT43CAli97u6FvEvw==
X-Received: by 2002:a05:7301:d813:b0:36f:6b99:f94d with SMTP id 5a478bee46e88-36f75b1f80cmr1323131eec.20.1793932190841;
        Thu, 05 Nov 2026 18:29:50 -0800 (PST)
Received: from debian.prasanth ([103.183.205.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a47esm1700358eec.6.2026.11.05.18.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 18:29:50 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: linusw@kernel.org
Cc: andrew@codeconstruct.com.au,
	joel@jms.id.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	brgl@kernel.org,
	tan.siewert@9elements.com,
	linux-aspeed@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v4 2/2] pinctrl: aspeed: Hand over global GPIOP passthrough to local mux controls
Date: Fri,  6 Nov 2026 07:59:07 +0530
Message-ID: <20261106022907.10735-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
 <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On B650D4U, GPIO-only host power control fails when SCU51C[9]
enables GPIOP passthrough, even after the normal GPIO request path
clears the individual SCU4BC selections.

Transfer globally selected GPIOP0-P5 THRU roles to SCU4BC[29:24]
before registering the controller, then clear the active shared
sources. Leave PWM selection and the strap-source selector unchanged.
Clear SCU510[28] through SCU514 and verify the shared enables cleared.

If handover fails, retain an instance-local error and reject affected
GPIO and mux requests before changing their mux state. Check every
pin in a mux group before calling the shared helper. Retain prepared
local selections after partial failure rather than blindly restoring
a shared enable.

Probe-time normalization policy, concurrent SCU writers and
post-handover registration failure remain open design questions.
Electrical continuity, mixed-pair forwarding, protected-write paths,
PWM coexistence and SCU510[28] hardware handling remain unvalidated.

The implementation passed remote power-on, remote graceful power-off
and physical-button power-on tests on B650D4U with an OpenBMC Linux
6.18.24-based kernel. The rebased version was ARM compile-tested on
v7.4-rc1 using aspeed_g5_defconfig with AST2600 pinctrl enabled.
With the managed-registration prerequisite, the v7.4-rc1 version
also completed one unbind/rebind cycle under generic KASAN on
B650D4U hardware and in AST2600 QEMU. Host power operations have
not been retested with the v7.4-rc1 kernel.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 145 ++++++++++++++++++++-
 1 file changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 85d6640ff..be22a9184 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -4,7 +4,10 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/types.h>
@@ -36,6 +39,8 @@
 #define SCU4D8		0x4D8 /* Multi-function Pin Control #23 */
 #define SCU500		0x500 /* Hardware Strap 1 */
 #define SCU510		0x510 /* Hardware Strap 2 */
+#define SCU514		0x514 /* Hardware Strap 2 Clear */
+#define SCU51C		0x51c /* Hardware Strap 3 */
 #define SCU610		0x610 /* Disable GPIO Internal Pull-Down #0 */
 #define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
 #define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
@@ -2743,12 +2748,56 @@ static struct aspeed_pinctrl_data aspeed_g6_pinctrl_data = {
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
 
@@ -2778,15 +2827,103 @@ static const struct pinctrl_desc aspeed_g6_pinctrl_desc = {
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


