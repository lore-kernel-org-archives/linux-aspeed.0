Return-Path: <linux-aspeed+bounces-4901-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4531CC61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 11:36:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ3hs1d2Xz2yCL;
	Tue, 01 Sep 2026 21:36:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788262573;
	cv=none; b=KlSkv5PnDke16ouvE9WkrFVPnaFSnQiB01FAzgpJKZjU33+/P86yv6i56ara78LYyA4cxObaQ0XgvG1qHbY4Gplk9iWeIwwudDrCEkj10QJpVoHRjOoxcxku1yqtOCqltiJihzcR/SPSzvVbTvUUmDPEbbYt7US3NAPA6dzLdPn648IVMCp9qXHH1Q2Aq+CRp+xq1yijsAsyKLG5eYFI4B2JfaPYXWN/GHIms3B3XD417xKF1OV30MmLPHy+UiVARXTrA/8cwFRMmDyGI7G3eym8iBH9EG6JgqOQLP2LZv6zBBIS6jtwvOHt818yemQ0G966IX001mGbpR/keQ4cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788262573; c=relaxed/relaxed;
	bh=2JFtjDPy9+p2JLpmvsgivXYTll9l8uMUZftWeKcTRlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R0DuAjakLyp4rB57pLDlVgc4CjrDLE9rk6ozQIfoNAmh+o4uIMjQxd9aTsrytX9+JkDEjBXLIdDfZKd/ZuRurOKcrBizDUH8ERQkMn7Lbj/Beg17+LvNRH+2OQ4dx+P5IRunhrhynTIcijsK70NxY7VC8yF9tGlNOaB3TQpzlwPXTHrewo3eOXqccBNcs6v/xzbeuZA9hnnk8bh45D9Qb9mBK9iKjj/Mr5D/F5AtuEYvmJlt9zW5VezyywzNmD+whfgcL0kuDd/hpFj/uu3u/FqJfEDaMs+BQx0qPqwhReb1XKRYDslC6hUMTUiirk42ZO/RoJtbzkuRxZJIEn9QAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ3hq6dQ1z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 21:36:11 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Sep
 2026 19:35:39 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 1 Sep 2026 19:35:39 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 1 Sep 2026 19:35:35 +0800
Subject: [PATCH 8/8] i3c: mipi-i3c-hci: Support the AST2700 internal
 pull-ups
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
Message-ID: <20260901-b4-i3c-hci-ast2700-v1-8-19909e7cbd7e@aspeedtech.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788262538; l=6058;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=xkzAfCKLYQ/Xwwsdimh/tEMuOhSZZrRcVSqry9lnz3A=;
 b=azBxWolQHPu9pCSptGyEx4x+4PYzUuzgnmWwmp6rvIzxR3+3V97LKaUSwq+r2jQLcmZR6UNNQ
 CEEgKtwyI5jDGGMoQMqqH8cLz61sGNtIdz8hXv2feGg480YH4Kk43Ne
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Boards that do not populate external I3C pull-up resistors can use the
pull-ups built into the AST2700 PHY.

When bias-pull-up is present, determine the pin voltage domain from
the pinctrl-0 group already selected for the bus and enable the
internal pull-ups on both SCL and SDA at the requested strength.
Currently only pinctrl-0 is inspected; a node selecting its group
through a different pinctrl state is not yet supported. The controller
reset clears the SW force control register, so the internal pull-ups
start disabled unless bias-pull-up requests otherwise. A resistance
with no entry in the domain's table, or an unrecognized pinctrl-0
group, is rejected with an error.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c | 118 ++++++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h |   6 ++
 2 files changed, 124 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c
index 182111b857c9..d28d5680d326 100644
--- a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c
+++ b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c
@@ -12,6 +12,7 @@
 #include <linux/i3c/master.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/string.h>
 
 #include "hci.h"
 #include "vendor_aspeed.h"
@@ -86,6 +87,100 @@ static u32 aspeed_i3c_get_sdr_ctrl0_reg(struct i3c_hci *hci)
 	return ASPEED_I3C_PHY_I3C_SDR4_CTRL0;
 }
 
+struct aspeed_i3c_pullup_ohms {
+	u32 ohms;
+	u8 code;
+};
+
+/* SW_FORCE_CTRL strength selector to resistance, by pin voltage domain */
+static const struct aspeed_i3c_pullup_ohms aspeed_i3c_pullup_hv[] = {
+	{ 600, 1 },
+	{ 470, 2 },
+	{ 400, 3 },
+};
+
+static const struct aspeed_i3c_pullup_ohms aspeed_i3c_pullup_lv[] = {
+	{ 750, 1 },
+	{ 550, 2 },
+	{ 317, 3 },
+	{ 400, 4 },
+	{ 261, 5 },
+	{ 231, 6 },
+	{ 177, 7 },
+};
+
+/* pinctrl-0 group names for each pin voltage domain */
+static const char * const aspeed_i3c_hv_groups[] = {
+	"HVI3C0", "HVI3C1", "HVI3C2", "HVI3C3",
+	"HVI3C12", "HVI3C13", "HVI3C14", "HVI3C15",
+};
+
+static const char * const aspeed_i3c_lv_groups[] = {
+	"I3C4", "I3C5", "I3C6", "I3C7",
+	"I3C8", "I3C9", "I3C10", "I3C11",
+};
+
+static int aspeed_i3c_pin_is_hv(struct i3c_hci *hci, bool *is_hv)
+{
+	struct device_node *np = hci->master.dev.of_node;
+	struct device_node *state;
+	const char *group;
+	int ret, i;
+
+	state = of_parse_phandle(np, "pinctrl-0", 0);
+	if (!state)
+		return -ENODEV;
+
+	ret = of_property_read_string(state, "groups", &group);
+	if (ret)
+		goto put_state;
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_i3c_hv_groups); i++) {
+		if (!strcmp(group, aspeed_i3c_hv_groups[i])) {
+			*is_hv = true;
+			goto put_state;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(aspeed_i3c_lv_groups); i++) {
+		if (!strcmp(group, aspeed_i3c_lv_groups[i])) {
+			*is_hv = false;
+			goto put_state;
+		}
+	}
+
+	dev_err(&hci->master.dev, "unrecognized pinctrl-0 group \"%s\"\n",
+		group);
+	ret = -EINVAL;
+
+put_state:
+	of_node_put(state);
+	return ret;
+}
+
+static int aspeed_i3c_pullup_code(struct i3c_hci *hci, bool is_hv, u32 ohms)
+{
+	const struct aspeed_i3c_pullup_ohms *map;
+	size_t i, n;
+
+	if (is_hv) {
+		map = aspeed_i3c_pullup_hv;
+		n = ARRAY_SIZE(aspeed_i3c_pullup_hv);
+	} else {
+		map = aspeed_i3c_pullup_lv;
+		n = ARRAY_SIZE(aspeed_i3c_pullup_lv);
+	}
+
+	for (i = 0; i < n; i++)
+		if (map[i].ohms == ohms)
+			return map[i].code;
+
+	dev_err(&hci->master.dev,
+		"unsupported internal pull-up %u ohms for %s-voltage domain\n",
+		ohms, is_hv ? "high" : "low");
+	return -EINVAL;
+}
+
 int aspeed_i3c_phy_init(struct i3c_hci *hci)
 {
 	u16 hcnt, lcnt, total_cnt, min_tbit_cnt, cas_lcnt, cas_cnt, cbp_cnt;
@@ -95,6 +190,7 @@ int aspeed_i3c_phy_init(struct i3c_hci *hci)
 	struct device_node *np = hci->master.dev.of_node;
 	u32 sdr_ctrl0_reg, ctrl0, ctrl1, ctrl2;
 	unsigned long core_rate, period_ns;
+	u32 pullup_ohms = 0;
 
 	core_rate = clk_get_rate(to_aspeed_vendor_data(hci)->clk);
 	if (!core_rate) {
@@ -257,6 +353,28 @@ int aspeed_i3c_phy_init(struct i3c_hci *hci)
 
 	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_PULLUP_EN, 0);
 
+	of_property_read_u32(np, "bias-pull-up", &pullup_ohms);
+	if (pullup_ohms) {
+		int ret, strength;
+		bool is_hv;
+
+		ret = aspeed_i3c_pin_is_hv(hci, &is_hv);
+		if (ret)
+			return ret;
+
+		strength = aspeed_i3c_pullup_code(hci, is_hv, pullup_ohms);
+		if (strength < 0)
+			return strength;
+
+		aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_SW_FORCE_CTRL,
+				     ASPEED_I3C_PHY_SW_FORCE_SCL_PU_EN |
+				     ASPEED_I3C_PHY_SW_FORCE_SDA_PU_EN |
+				     FIELD_PREP(ASPEED_I3C_PHY_SW_FORCE_SCL_PU_VAL,
+						strength) |
+				     FIELD_PREP(ASPEED_I3C_PHY_SW_FORCE_SDA_PU_VAL,
+						strength));
+	}
+
 	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_OD_DAP_NS, period_ns);
 	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_OD_CTRL4,
 			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL4_DAP, hcnt));
diff --git a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
index 7147abea830d..80938c580800 100644
--- a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
+++ b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
@@ -83,6 +83,12 @@ unsigned int aspeed_i3c_avail_tx_entries(struct i3c_hci *hci);
 #define   ASPEED_INTR_SUM_PIO			BIT(1)
 #define   ASPEED_INTR_SUM_CAP			BIT(0)
 
+#define ASPEED_I3C_PHY_SW_FORCE_CTRL		0x04
+#define   ASPEED_I3C_PHY_SW_FORCE_SCL_PU_EN	BIT(28)
+#define   ASPEED_I3C_PHY_SW_FORCE_SDA_PU_EN	BIT(24)
+#define   ASPEED_I3C_PHY_SW_FORCE_SCL_PU_VAL	GENMASK(10, 8)
+#define   ASPEED_I3C_PHY_SW_FORCE_SDA_PU_VAL	GENMASK(2, 0)
+
 #define ASPEED_I3C_PHY_I2C_FM_CTRL0		0x08
 #define   ASPEED_I3C_PHY_I2C_FM_CTRL0_CAS	GENMASK(26, 16)
 #define   ASPEED_I3C_PHY_I2C_FM_CTRL0_SU_STO	GENMASK(10, 0)

-- 
2.34.1


