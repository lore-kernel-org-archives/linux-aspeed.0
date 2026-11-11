Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155F606A33A
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 03:17:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTG64hNGz2yYY;
	Wed, 11 Nov 2026 14:17:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794367022;
	cv=none; b=cZ7ZZ3wi8xo00Nr8fhYmiqAlJv4PHODfblAAvCRUzC9eixoq/JQgtAdvW15nvTwzSKxLLtYxJpXqtBCczTrB7ZNFEpExNm1u6VQeJSitJXG9BJ+p+d6AOAsybC6lvMXcPLBBcZxG/daoSacQbT8w5kU3zGrygDnjOYn4NtMekiZX1lZiWF88l6dIM3jmMM+mms/C5Su6N8cFcN/u2iDO2ZTHQxTC/tuSSzcrY/50HMOqsbBiMtE7hPghwLtBYNNz1p7GN5LtcveItHSjBJ2QeC9lirszeluT+tKRCUzJmuMA+6XuAdN8rrnb5dRFAS0IglPwUdBfMCc+S1QDqgFLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794367022; c=relaxed/relaxed;
	bh=meOhYogBFYndjJYJOHnWj3u2vMsujDAyf/fw+ttqvVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mPNYvp7JCToXHkanTAAVcUpOAjUuSsOVfoqK0fFLxvc1VxC/VxkI7KUCATTLCnzgQtLjzTYoTs9ToobruJ+krN2on1n9HBYpxKlURWDgSh7DccYxqmnEH+2saxkpp0gghaPAOxfQtcBbSP5zywdveZ8n3FSsQpbX2MPAjiuA20vK2KFPs0Eehbg8Zyumg6kb8V0dnZuL0JD36RCgnBXVdAFAbowXQbaLX3+zG1KM6LkN0qJ83qJVFW/BHlMPW/Qrcc7Qy4R9h46Efdn1hHwl7SPWb0oLeSun81jeOKbB592Wq58btfjmC9aZVQLHnN2Y7gbw3YtziwW6gDQk+zrC/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTG55xjWz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 14:17:01 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 11:16:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 11:16:32 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 11 Nov 2026 11:16:37 +0800
Subject: [PATCH v2 9/9] i3c: mipi-i3c-hci: Support the AST2700 internal
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-b4-i3c-hci-ast2700-v2-9-4d8fff5c5196@aspeedtech.com>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
In-Reply-To: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>
CC: <tbevis@amazon.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794366991; l=5963;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=+kGXXSXJX0VtXkxub2tvdKAYW26lF5M0TaZsOE2nZpY=;
 b=hZxmZzQe/z1aSlXnmHlyFoWDcS006utE+vM9s5x1nRR1y42JS0t1RJRM2h7BEooIP51fJKTbt
 BvX01yKmi9hB1UVV2pGJ19gbZvfCxJ2LyQ0k0Id9XprVlGN8v8T4T3W
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 drivers/i3c/master/mipi-i3c-hci/aspeed.c | 118 +++++++++++++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/aspeed.h |   6 ++
 2 files changed, 124 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/aspeed.c b/drivers/i3c/master/mipi-i3c-hci/aspeed.c
index 8f2a00a940f7..1e093fb5d9d9 100644
--- a/drivers/i3c/master/mipi-i3c-hci/aspeed.c
+++ b/drivers/i3c/master/mipi-i3c-hci/aspeed.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/string.h>
 
 #include "hci.h"
 #include "aspeed.h"
@@ -197,6 +198,100 @@ static u32 aspeed_i3c_get_sdr_ctrl0_reg(struct i3c_hci *hci)
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
@@ -206,6 +301,7 @@ int aspeed_i3c_phy_init(struct i3c_hci *hci)
 	struct device_node *np = hci->master.dev.of_node;
 	u32 sdr_ctrl0_reg, ctrl0, ctrl1, ctrl2;
 	unsigned long core_rate, period_ns;
+	u32 pullup_ohms = 0;
 
 	core_rate = clk_get_rate(to_aspeed_vendor_data(hci)->clk);
 	if (!core_rate) {
@@ -374,6 +470,28 @@ int aspeed_i3c_phy_init(struct i3c_hci *hci)
 
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
diff --git a/drivers/i3c/master/mipi-i3c-hci/aspeed.h b/drivers/i3c/master/mipi-i3c-hci/aspeed.h
index e80a0dff0dc9..69d7ae92d3c5 100644
--- a/drivers/i3c/master/mipi-i3c-hci/aspeed.h
+++ b/drivers/i3c/master/mipi-i3c-hci/aspeed.h
@@ -69,6 +69,12 @@ unsigned int aspeed_i3c_avail_tx_entries(struct i3c_hci *hci);
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


