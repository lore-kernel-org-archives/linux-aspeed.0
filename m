Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4F60A260B
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 03:16:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTFz06QCz2y8p;
	Wed, 11 Nov 2026 14:16:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794367014;
	cv=none; b=EQsTab2o6nbxySjVBeo3Ugs4Hi/C+juRYvpUlmBpVOtr2uEsQOO+wtq2gBi6Ipt3vVkkMojnl+yhs1AySBFXDmKDF3vYtfqC44Sq+z7L0mtYHzeZXGHz7vzo3ue3jYPcNbMsTkFQbVmQ9DBqPQ3ic+rD3tcSZ2ZszN7J5BepWhS+Bj94o1j9May4ztEf7PZcfv44N5pHWIyMop8EGPCT+Fqnb0QpvRbhJTpQhSPUJCusTPk0alEoiclovYbQ8kNjGAN/VreM0mICrykPU5jO/OFbGHkoMd+XNnt9sOKjLCodgehlgSlT7DG3V6MrLqT6XelT8FRN3EjunpjUm5LG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794367014; c=relaxed/relaxed;
	bh=pTpHXh+6GIcBH2u8eXmz9beVVwGcEeGGblkqfMDni5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cC9qfHqoxL04gaWTn62vfj+GCJWXvlsgqJRndlM66ebCctcvyWXcObL/VdAFjFjIg31tdQBbwB4dPTwgJ1MYqcpISI9ykOHyAS2gaohkkM0U/bUB3Pme20DozIb6e1psFwCDvpXcF6fI9y2GzJFqDbklkdETyrrpsWPmviFxo0a1tL2EK8XP368khVe91QMLf0MqQssJKHtbQBzvxxWutU9/YV2JugAjD4ei4M+tn8uWB3z2w8a44Edm6VXOwthzWD1Zgbl3FXdXQcr1uPOUbZQDDymXOLnazmw7aM326DpllvDbJqlzEVgwzUOMNDoCA0+dZbbzRrboEKuDtHdejQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTFy088lz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:54 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 11:16:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 11:16:31 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 11 Nov 2026 11:16:31 +0800
Subject: [PATCH v2 3/9] i3c: mipi-i3c-hci: Support address-indexed DAT
 slots
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
Message-ID: <20261111-b4-i3c-hci-ast2700-v2-3-4d8fff5c5196@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794366991; l=12266;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=ZEArbW99/d8elY8GLPj1BDMwgVwpVLvCWRK2HM2uP1M=;
 b=5P5gN77ujcHZD2Xmaa11CdOaglkSqaeXPeHN2F5bCNhew8BN6PloozXW0WODpgXFbmJqCxoSc
 2WHnq+5EyPVCvHHDQQHaSUJqoT9qh/KXi52RfC2hjnoZas2mYjKfzAL
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HCI v1's DEV_INDEX allocation is sequential: the driver picks any free
DAT slot, with no relationship between the slot number and the
device's I3C address. ASPEED's I3C controllers have long needed to
support more devices than the standard 5-bit DEV_INDEX field
(addresses 0-31) allows, so they use a layout where the DAT slot
number is itself the device's address, requiring DEV_INDEX to widen
to 7 bits (addresses 0-127).

The existence of I2C devices on the bus identifies why the ASPEED
controller design can't work with the driver assuming the 5-bit
DEV_INDEX field: their addresses are fixed by the device or board
configuration, not assigned by the controller, so they cannot be
restricted to addresses below 0x20. The same is true for I3C devices
that only support SETAASA: their dynamic address is their existing
static address, again fixed by the device or board rather than chosen
by the controller. With a 5-bit DEV_INDEX, only slots 0-31 exist, so
any such device landing at 0x20 or above cannot be placed in the DAT
at all, regardless of how many other devices are on the bus.

Add HCI_QUIRK_DAT_INDEX_IS_ADDR for controllers with this layout:
allocate address-indexed DAT slots and emit the wider DEV_INDEX field
mask. Moving an entry on a dynamic address change can fail if its slot
is already taken, so set_dynamic_addr() now returns an error that the
reattach and DAA paths propagate. Controllers without the quirk keep
the existing behavior.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 35 ++++++++++++------
 drivers/i3c/master/mipi-i3c-hci/core.c   | 19 +++++++---
 drivers/i3c/master/mipi-i3c-hci/dat.h    |  6 ++-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c | 63 +++++++++++++++++++++++++++++---
 drivers/i3c/master/mipi-i3c-hci/hci.h    |  1 +
 5 files changed, 99 insertions(+), 25 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index 78ad2ec2bd93..d267aa19cb75 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -139,6 +139,14 @@ static enum hci_cmd_mode get_i2c_mode(struct i3c_hci *hci)
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
@@ -193,7 +201,7 @@ static int hci_cmd_v1_prep_ccc(struct i3c_hci *hci,
 			CMD_0_ATTR_I |
 			CMD_I0_TID(xfer->cmd_tid) |
 			CMD_I0_CMD(ccc_cmd) | CMD_I0_CP |
-			CMD_I0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_I0_DTT(data_len) |
 			CMD_I0_MODE(mode);
 		fill_data_bytes(xfer, data, data_len);
@@ -203,7 +211,7 @@ static int hci_cmd_v1_prep_ccc(struct i3c_hci *hci,
 			CMD_0_ATTR_R |
 			CMD_R0_TID(xfer->cmd_tid) |
 			CMD_R0_CMD(ccc_cmd) | CMD_R0_CP |
-			CMD_R0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_R0_MODE(mode) |
 			(rnw ? CMD_R0_RNW : 0);
 		xfer->cmd_desc[1] =
@@ -247,7 +255,7 @@ static void hci_cmd_v1_prep_i3c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_I |
 			CMD_I0_TID(xfer->cmd_tid) |
-			CMD_I0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_I0_DTT(data_len) |
 			CMD_I0_MODE(mode) |
 			cp_cmd;
@@ -257,7 +265,7 @@ static void hci_cmd_v1_prep_i3c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_R |
 			CMD_R0_TID(xfer->cmd_tid) |
-			CMD_R0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_R0_MODE(mode) |
 			(rnw ? CMD_R0_RNW : 0) |
 			cp_cmd;
@@ -284,7 +292,7 @@ static void hci_cmd_v1_prep_i2c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_I |
 			CMD_I0_TID(xfer->cmd_tid) |
-			CMD_I0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_I0_DTT(data_len) |
 			CMD_I0_MODE(mode);
 		fill_data_bytes(xfer, data, data_len);
@@ -293,7 +301,7 @@ static void hci_cmd_v1_prep_i2c_xfer(struct i3c_hci *hci,
 		xfer->cmd_desc[0] =
 			CMD_0_ATTR_R |
 			CMD_R0_TID(xfer->cmd_tid) |
-			CMD_R0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_R0_MODE(mode) |
 			(rnw ? CMD_R0_RNW : 0);
 		xfer->cmd_desc[1] =
@@ -322,19 +330,22 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
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
@@ -342,7 +353,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 			CMD_0_ATTR_A |
 			CMD_A0_TID(xfer->cmd_tid) |
 			CMD_A0_CMD(I3C_CCC_ENTDAA) |
-			CMD_A0_DEV_INDEX(dat_idx) |
+			cmd_v1_dev_index(hci, dat_idx) |
 			CMD_A0_DEV_COUNT(1) |
 			CMD_A0_ROC | CMD_A0_TOC;
 		xfer->cmd_desc[1] = 0;
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 23853ca134fb..b8f8254ed19c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -608,7 +608,8 @@ static int i3c_hci_attach_i3c_dev(struct i3c_dev_desc *dev)
 	if (!dev_data)
 		return -ENOMEM;
 	if (hci->cmd == &mipi_i3c_hci_cmd_v1) {
-		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
+		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci,
+				dev->info.dyn_addr ?: dev->info.static_addr);
 		if (ret < 0) {
 			kfree(dev_data);
 			return ret;
@@ -628,9 +629,17 @@ static int i3c_hci_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 old_dyn_addr)
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
 
@@ -658,7 +667,7 @@ static int i3c_hci_attach_i2c_dev(struct i2c_dev_desc *dev)
 	dev_data = kzalloc_obj(*dev_data);
 	if (!dev_data)
 		return -ENOMEM;
-	ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
+	ret = mipi_i3c_hci_dat_v1.alloc_entry(hci, dev->addr);
 	if (ret < 0) {
 		kfree(dev_data);
 		return ret;
diff --git a/drivers/i3c/master/mipi-i3c-hci/dat.h b/drivers/i3c/master/mipi-i3c-hci/dat.h
index 31becc6f9aec..622f8e248463 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat.h
+++ b/drivers/i3c/master/mipi-i3c-hci/dat.h
@@ -10,6 +10,8 @@
 #ifndef DAT_H
 #define DAT_H
 
+struct i3c_hci;
+
 /* Global DAT flags */
 #define DAT_0_I2C_DEVICE		W0_BIT_(31)
 #define DAT_0_DEV_NACK_RETRY_CNT	W0_MASK(30, 29)
@@ -18,9 +20,9 @@
 
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
index ec0764a27c62..485ad0a44b34 100644
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
@@ -172,6 +216,13 @@ static int hci_dat_v1_get_index(struct i3c_hci *hci, u8 dev_addr)
 	unsigned int dat_idx;
 	u32 dat_w0;
 
+	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
+		if (dev_addr < hci->DAT_entries &&
+		    test_bit(dev_addr, hci->DAT_data))
+			return dev_addr;
+		return -ENODEV;
+	}
+
 	for_each_set_bit(dat_idx, hci->DAT_data, hci->DAT_entries) {
 		dat_w0 = dat_w0_read(dat_idx);
 		if (FIELD_GET(DAT_0_DYNAMIC_ADDRESS, dat_w0) == dev_addr)
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 4288a1b5b491..2e610373600e 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -178,6 +178,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
 #define HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET	BIT(8)  /* Do PIO queue SW resets after DMA abort */
 #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
+#define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);

-- 
2.34.1


