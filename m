Return-Path: <linux-aspeed+bounces-4895-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E65C624D1
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 11:36:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ3hh3mnJz2xns;
	Tue, 01 Sep 2026 21:36:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788262564;
	cv=none; b=RODwAJQljQXcqYhXVyROm/mTS2dQHJWIQd3xnPyoBYmiKOS/9dKqcS0MudzCc2jlvPmzmX3XLMKi2RrayRJL0IbzxZua5of340NTdrU/nM3CEu2/PaCkdh3cfz24VGC9oL1Wfqbs6/vfn8OMplmEwajnG77VYQF+su0tYxGu8oK/4eNzy7LOmaFUA8t9welbGIpIXNgAd3SH0YzBuiuQOfPPH8O8U/Cdt9r4cq0N9K/MSzaq98CyLQY/AtMLCVDNoy7KrH53h07nw09EoUR3Na+STqJndk9dLWdYXU4Vx/cLpXVNKA7kaqzR3zyhAwTOoMAj4ZIjTABPFHoM9ZvQng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788262564; c=relaxed/relaxed;
	bh=4A2Dy3gZxFcJN2W8TsTgPEmcCEDuyJWPZ+H0p+JdrV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Es2z5qYW+Ksv6clClkjhINVhNx8zwBmMuWlGQMmQS2Pmf1wj9mr4lUBOa65ydK99nHqVfcyqL/yb5LhNjkQR+5d7BQzBwT8eUPVBWh2Pt9D847T4itsanKbodSDHZRMBdSf2fYTRhXEh5BNqeM6S9pDT3fu9AkAp2StRtzIYgRuvimeqUVYpCszSUKfgrQDJ9w10uXKQu3I8yLN6mfNQsF/Pmp3el325lMxIl5sHkPNhMTyFihwkJcEcXcSrcRqwLfLlgsbQDBDL9FosHFCvMO5YtPjZ4QZMrrLlWKPtFkihptcbbh74w8CQqyEzLk49p6vLVEOUWrfiCX8bhDnZrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ3hg1Y6nz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 21:36:03 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Sep
 2026 19:35:38 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 1 Sep 2026 19:35:38 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 1 Sep 2026 19:35:29 +0800
Subject: [PATCH 2/8] i3c: mipi-i3c-hci: Support address-indexed DAT slots
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
Message-ID: <20260901-b4-i3c-hci-ast2700-v1-2-19909e7cbd7e@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788262538; l=11576;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=yCD4RYCViM2mMO/TblbVOstiyco6H5e6Skzly2QPz2w=;
 b=HHpFyojL+IC4dJxfewHl7dIUzXKppiqg3u8JCaxhFqzzIxVP0WceSK9rRUCKXL7xKtSWovYaP
 hbBBXUbYVzIDhdH4nDhpKqKVQivgmu/Q0FrZ3kmjitB3Ugy/nXu5wbG
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

HCI v1's DEV_INDEX allocation is sequential: the driver picks any free
DAT slot, with no relationship between the slot number and the
device's I3C address. ASPEED's I3C controllers have long needed to
support more devices than the standard 5-bit DEV_INDEX field
(addresses 0-31) allows, so they use a layout where the DAT slot
number is itself the device's address, requiring DEV_INDEX to widen
to 7 bits (addresses 0-127).

Add HCI_QUIRK_DAT_INDEX_IS_ADDR for controllers with this layout:
allocate address-indexed DAT slots and emit the wider DEV_INDEX field.
Moving an entry on a dynamic address change can fail if its slot is
already taken, so set_dynamic_addr() now returns an error that the
reattach and DAA paths propagate. Controllers without the quirk keep
the existing behavior.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 35 ++++++++++++------
 drivers/i3c/master/mipi-i3c-hci/core.c   | 19 +++++++---
 drivers/i3c/master/mipi-i3c-hci/dat.h    |  5 ++-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c | 63 +++++++++++++++++++++++++++++---
 drivers/i3c/master/mipi-i3c-hci/hci.h    |  1 +
 5 files changed, 98 insertions(+), 25 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index 3b9345718d273..9a11affb14bf6 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -141,6 +141,14 @@ static enum hci_cmd_mode get_i2c_mode(struct i3c_hci *hci)
 	return MODE_I2C_Fm;
 }
 
+static u32 cmd_v1_dev_index(struct i3c_hci *hci, unsigned int dat_idx)
+{
+	u32 mask = hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR ?
+		   W0_MASK(22, 16) : W0_MASK(20, 16);
+
+	return field_prep(mask, dat_idx);
+}
+
 static void fill_data_bytes(struct hci_xfer *xfer, u8 *data,
 			    unsigned int data_len)
 {
@@ -195,7 +203,7 @@ static int hci_cmd_v1_prep_ccc(struct i3c_hci *hci,
 			CMD_0_ATTR_I |
 			CMD_I0_TID(xfer->cmd_tid) |
 			CMD_I0_CMD(ccc_cmd) | CMD_I0_CP |
-			CMD_I0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_I0_DTT(data_len) |
 			CMD_I0_MODE(mode);
 		fill_data_bytes(xfer, data, data_len);
@@ -205,7 +213,7 @@ static int hci_cmd_v1_prep_ccc(struct i3c_hci *hci,
 			CMD_0_ATTR_R |
 			CMD_R0_TID(xfer->cmd_tid) |
 			CMD_R0_CMD(ccc_cmd) | CMD_R0_CP |
-			CMD_R0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_R0_MODE(mode) |
 			(rnw ? CMD_R0_RNW : 0);
 		xfer->cmd_desc[1] =
@@ -233,7 +241,7 @@ static void hci_cmd_v1_prep_i3c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_I |
 			CMD_I0_TID(xfer->cmd_tid) |
-			CMD_I0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_I0_DTT(data_len) |
 			CMD_I0_MODE(mode);
 		fill_data_bytes(xfer, data, data_len);
@@ -242,7 +250,7 @@ static void hci_cmd_v1_prep_i3c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_R |
 			CMD_R0_TID(xfer->cmd_tid) |
-			CMD_R0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_R0_MODE(mode) |
 			(rnw ? CMD_R0_RNW : 0);
 		xfer->cmd_desc[1] =
@@ -268,7 +276,7 @@ static void hci_cmd_v1_prep_i2c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_I |
 			CMD_I0_TID(xfer->cmd_tid) |
-			CMD_I0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_I0_DTT(data_len) |
 			CMD_I0_MODE(mode);
 		fill_data_bytes(xfer, data, data_len);
@@ -277,7 +285,7 @@ static void hci_cmd_v1_prep_i2c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_R |
 			CMD_R0_TID(xfer->cmd_tid) |
-			CMD_R0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_R0_MODE(mode) |
 			(rnw ? CMD_R0_RNW : 0);
 		xfer->cmd_desc[1] =
@@ -306,19 +314,22 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 	 * Yes, there is room for improvements.
 	 */
 	for (;;) {
-		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
-		if (ret < 0)
-			break;
-		dat_idx = ret;
 		ret = i3c_master_get_free_addr(&hci->master, next_addr);
 		if (ret < 0)
 			break;
 		next_addr = ret;
+		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci, next_addr);
+		if (ret < 0)
+			break;
+		dat_idx = ret;
 
 		dev_dbg(&hci->master.dev,
 			"next_addr = 0x%02x, DAA using DAT %d",
 			next_addr, dat_idx);
-		mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, dat_idx, next_addr);
+		ret = mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, dat_idx,
+							   next_addr);
+		if (ret < 0)
+			break;
 		mipi_i3c_hci_dct_index_reset(hci);
 
 		xfer->cmd_tid = hci_get_tid();
@@ -326,7 +337,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 			CMD_0_ATTR_A |
 			CMD_A0_TID(xfer->cmd_tid) |
 			CMD_A0_CMD(I3C_CCC_ENTDAA) |
-			CMD_A0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_A0_DEV_COUNT(1) |
 			CMD_A0_ROC | CMD_A0_TOC;
 		xfer->cmd_desc[1] = 0;
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index dadf049bd4b54..a624e3c40484e 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -574,7 +574,8 @@ static int i3c_hci_attach_i3c_dev(struct i3c_dev_desc *dev)
 	if (!dev_data)
 		return -ENOMEM;
 	if (hci->cmd == &mipi_i3c_hci_cmd_v1) {
-		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
+		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci,
+				dev->info.dyn_addr ?: dev->info.static_addr);
 		if (ret < 0) {
 			kfree(dev_data);
 			return ret;
@@ -593,9 +594,17 @@ static int i3c_hci_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 old_dyn_addr)
 	struct i3c_hci *hci = to_i3c_hci(m);
 	struct i3c_hci_dev_data *dev_data = i3c_dev_get_master_data(dev);
 
-	if (hci->cmd == &mipi_i3c_hci_cmd_v1)
-		mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, dev_data->dat_idx,
-					     dev->info.dyn_addr);
+	if (hci->cmd == &mipi_i3c_hci_cmd_v1) {
+		int ret;
+
+		ret = mipi_i3c_hci_dat_v1.set_dynamic_addr(hci,
+							   dev_data->dat_idx,
+							   dev->info.dyn_addr);
+		if (ret)
+			return ret;
+		if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR)
+			dev_data->dat_idx = dev->info.dyn_addr;
+	}
 	return 0;
 }
 
@@ -623,7 +632,7 @@ static int i3c_hci_attach_i2c_dev(struct i2c_dev_desc *dev)
 	dev_data = kzalloc_obj(*dev_data);
 	if (!dev_data)
 		return -ENOMEM;
-	ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
+	ret = mipi_i3c_hci_dat_v1.alloc_entry(hci, dev->addr);
 	if (ret < 0) {
 		kfree(dev_data);
 		return ret;
diff --git a/drivers/i3c/master/mipi-i3c-hci/dat.h b/drivers/i3c/master/mipi-i3c-hci/dat.h
index 6881f19da77f2..d4c7b03724d37 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat.h
+++ b/drivers/i3c/master/mipi-i3c-hci/dat.h
@@ -14,12 +14,13 @@
 #define DAT_0_I2C_DEVICE		W0_BIT_(31)
 #define DAT_0_SIR_REJECT		W0_BIT_(13)
 #define DAT_0_IBI_PAYLOAD		W0_BIT_(12)
+#define HCI_DAT_ANY_ADDRESS		((unsigned int)-1)
 
 struct hci_dat_ops {
 	int (*init)(struct i3c_hci *hci);
-	int (*alloc_entry)(struct i3c_hci *hci);
+	int (*alloc_entry)(struct i3c_hci *hci, unsigned int address);
 	void (*free_entry)(struct i3c_hci *hci, unsigned int dat_idx);
-	void (*set_dynamic_addr)(struct i3c_hci *hci, unsigned int dat_idx, u8 addr);
+	int (*set_dynamic_addr)(struct i3c_hci *hci, unsigned int dat_idx, u8 addr);
 	void (*set_static_addr)(struct i3c_hci *hci, unsigned int dat_idx, u8 addr);
 	void (*set_flags)(struct i3c_hci *hci, unsigned int dat_idx, u32 w0, u32 w1);
 	void (*clear_flags)(struct i3c_hci *hci, unsigned int dat_idx, u32 w0, u32 w1);
diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
index 852966aa20d98..19b0f72e4ac82 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
@@ -89,7 +89,7 @@ static int hci_dat_v1_init(struct i3c_hci *hci)
 	return 0;
 }
 
-static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
+static int hci_dat_v1_alloc_entry(struct i3c_hci *hci, unsigned int address)
 {
 	unsigned int dat_idx;
 	int ret;
@@ -99,9 +99,17 @@ static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
 		if (ret)
 			return ret;
 	}
-	dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
-	if (dat_idx >= hci->DAT_entries)
-		return -ENOENT;
+	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
+		if (address >= hci->DAT_entries)
+			return -EINVAL;
+		if (test_bit_acquire(address, hci->DAT_data))
+			return -ENOENT;
+		dat_idx = address;
+	} else {
+		dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
+		if (dat_idx >= hci->DAT_entries)
+			return -ENOENT;
+	}
 	__set_bit(dat_idx, hci->DAT_data);
 
 	/* default flags */
@@ -118,9 +126,43 @@ static void hci_dat_v1_free_entry(struct i3c_hci *hci, unsigned int dat_idx)
 		__clear_bit(dat_idx, hci->DAT_data);
 }
 
-static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
-					unsigned int dat_idx, u8 address)
+static int hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
+				       unsigned int dat_idx, u8 address)
 {
+	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
+		u32 dat_w0, dat_w1;
+
+		/*
+		 * The controller derives the device address from the DAT slot
+		 * index, so DAT_0_DYNAMIC_ADDRESS is never written: an address
+		 * change moves the whole entry to the slot named by the new
+		 * address instead.
+		 */
+		if (dat_idx == address)
+			return 0;
+		if (address >= hci->DAT_entries) {
+			dev_err(&hci->master.dev, "invalid DAT slot %u\n", address);
+			return -EINVAL;
+		}
+		if (test_bit(address, hci->DAT_data)) {
+			dev_err(&hci->master.dev, "DAT slot %u already in use\n",
+				address);
+			return -EBUSY;
+		}
+
+		dat_w0 = dat_w0_read(dat_idx);
+		dat_w1 = dat_w1_read(dat_idx);
+
+		__set_bit(address, hci->DAT_data);
+		dat_w0_write(address, dat_w0);
+		dat_w1_write(address, dat_w1);
+
+		dat_w0_write(dat_idx, 0);
+		dat_w1_write(dat_idx, 0);
+		__clear_bit(dat_idx, hci->DAT_data);
+		return 0;
+	}
+
 	u32 dat_w0;
 
 	dat_w0 = dat_w0_read(dat_idx);
@@ -128,6 +170,8 @@ static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
 	dat_w0 |= FIELD_PREP(DAT_0_DYNAMIC_ADDRESS, address) |
 		  (parity8(address) ? 0 : DAT_0_DYNADDR_PARITY);
 	dat_w0_write(dat_idx, dat_w0);
+
+	return 0;
 }
 
 static void hci_dat_v1_set_static_addr(struct i3c_hci *hci,
@@ -169,6 +213,13 @@ static void hci_dat_v1_clear_flags(struct i3c_hci *hci, unsigned int dat_idx,
 
 static int hci_dat_v1_get_index(struct i3c_hci *hci, u8 dev_addr)
 {
+	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
+		if (dev_addr < hci->DAT_entries &&
+		    test_bit(dev_addr, hci->DAT_data))
+			return dev_addr;
+		return -ENODEV;
+	}
+
 	unsigned int dat_idx;
 	u32 dat_w0;
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index ee73f6e6756a1..f50fc1e22a855 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -177,6 +177,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
 #define HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET	BIT(8)  /* Do PIO queue SW resets after DMA abort */
 #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
+#define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);

-- 
2.34.1


