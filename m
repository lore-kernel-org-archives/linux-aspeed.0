Return-Path: <linux-aspeed+bounces-4232-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DF0CD98CE
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 05:32:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbWVG0mnkz3brx;
	Thu, 11 Jun 2026 15:31:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781155910;
	cv=none; b=YNLtCpGEhAKkMu34H1d7JwBzTUv0Y9TBbnUzmUDRoQnSP+I8ax4P1ND2ypHBKsog76xdIvjcZbiVgAhN1y8voNmNQOzMG9XKtTqg2zf4/6ObVCuDWzxylLsfKSEYkWxkPM1UyXeU3lNmwk5hXPqYZ1OBh0UOJs5TJQ/VAEawVeBafC5msNUHRGRF1aqiDfE/RXo1J3cEhssc2UxWLjdpZq1JEkdn1A6k/cht4fJT/iOv3yalMFGaIBFCJZ47z+ls0YszFFq40ahi1racRtY7lZj9dvdVJhAkwmT6dx9UEX6lR5LW666kiOJGqYlLO9SIWdj9ISabJnZJDQYDgv/VWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781155910; c=relaxed/relaxed;
	bh=0t7dhFy32lImOq8LCqVxz1OxqsobNDkqvxBQOvsVB8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y1zMqV3AEOXcwmBRzZwcD/0EYvqDThm7mT2Yrpz5NxLWFtXC7dJh46ltmk5A0hI592WfV0SCnmBr4vTBgBlNRd6TRpJvU0ISzrBEvMopOksm4gdRk49z/eng3aqKGFxq8sz/v46bTfb7U6USAwgCm1/nbhN9yji235YWplPw0/GfEzjIBCeYz4fOnJafn2XFWHTT80QZrzjxe1Ik1A4/JV2D9xmxwhteXYjiNOBa9FoTFIP/KBYBLtUyCAfsPz1t9vFF4W1KSzp7V/MdZzFZtZcCNRsRCdggVNoF2GNjpp+KiA5/9pfVJRJFlSJjt58DqAoB7YJ8f6Ha2vUWMo4SbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbWVD3wc0z3bsM;
	Thu, 11 Jun 2026 15:31:48 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Jun
 2026 13:31:22 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Jun 2026 13:31:22 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 11 Jun 2026 13:31:25 +0800
Subject: [PATCH v32 5/5] i2c: ast2600: Add target mode support
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
Message-ID: <20260611-upstream_i2c-v32-5-b66eba921d01@aspeedtech.com>
References: <20260611-upstream_i2c-v32-0-b66eba921d01@aspeedtech.com>
In-Reply-To: <20260611-upstream_i2c-v32-0-b66eba921d01@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781155882; l=23148;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=npiiI9Zmbv87UuwKAkL7Ed+1nleBYWdl9HM4z6KU3kk=;
 b=BHPN/I5Q1pdUt/2RgNpYwwi/i+Z56QMx08pmym8qDE/+LIuOaKLFaubr4YeBN2LX2/67JBLq4
 2XM9WujfCGZAxZAvAxWNjp4f24bDmGuHx7YL+gtqSGHY6hytHiXZbmL
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add target mode support to the AST2600 I2C driver.

Target mode features implemented include:
- Add target interrupt handling
- Address match and response logic

This complements the existing controller-mode support, enabling
dual-role capability.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v32:
- Fix target RX data loss in the master-abort fast path: remove the
  BUFF_CTRL zeroing that preceded the controller IER clear. The shared
  BUFF_CTRL register holds the pending target RX length in bits [29:24];
  zeroing it before the switch statement causes target_rx_len to read
  back as 0, silently discarding all bytes already received by the
  target.
- Fix use-after-free in master-abort fast path: null msgs and re-enable
  the controller IER before calling complete(), not after. Calling
  complete() first allows process context to immediately start a new
  i2c_transfer() and install a new msgs pointer; a stale controller IRQ
  firing during the subsequent IER restore would then dereference the
  new transfer's msgs buffer.
- Fix shared-buffer corruption on coalesced STOP+SLAVE_MATCH IRQ:
  restore the SLAVE_PENDING guard on the target_active = false
  transition. SLAVE_PENDING (bit 29) is set precisely when a new
  address-match is already queued while the previous DMA receive has
  not yet been processed. Clearing target_active unconditionally on
  STOP in that case lets the controller side overwrite the shared Tx/Rx
  buffer before the new target transaction has been re-armed.
- Use READ_ONCE() for all process-context reads of target_active.
  The IRQ path writes target_active with WRITE_ONCE(); plain loads in
  process context allow the compiler to cache the value across the
  IER-disable window, potentially seeing a stale false and starting a
  controller transfer that races with an active target transaction.

Changes in v31:
- Address Sashiko AI code review feedback on the target patch:
  - Clear target_active on any STOP. The previous condition
    `(sts & STOP) && !(sts & SLAVE_PENDING)` failed under coalesced
    STOP+SLAVE_PENDING IRQs and left target_active stuck true,
    deadlocking controller_xfer() with -EBUSY forever.
  - Enable the target IER inside reg_target() instead of
    unconditionally in probe(). unreg_target() disables it; without
    matching re-enable in reg_target() a subsequent re-registration
    would never receive IRQs. Also avoids spurious IRQ activity when
    no slave is registered.
  - Add the missing CMD_STS write in the
    SLAVE_PENDING|RX_DONE|WAIT_TX_DMA|STOP target ISR case so the
    HW state machine is re-armed (TRIGGER | TX_BUFF_EN); otherwise
    the controller stretches SCL until INACTIVE_TO recovers.
  - Default target ISR case now writes TARGET_TRIGGER_CMD to re-arm
    the HW state machine instead of silently breaking, which
    previously left the bus hung on unhandled sts combinations.
  - W1C-clear the ADDR1/2/3_NAK bits in HW (not just locally) in
    ast2600_i2c_target_irq(); stale ADDR_NAK bits made
    controller_xfer() see I2CS_ISR != 0 and bounce every transfer
    with -EBUSY.

- unreg_target(): replace masked ADDR_CTRL write with writel(0, ...);
  AST2600_I2CS_ADDR1_MASK covers only bits[6:0] (the 7-bit address),
  leaving ADDR1_ENABLE (BIT(7)) set after unregister. Although SLAVE_EN
  is cleared first, writing 0 is the correct and complete teardown.

Changes in v30:
- Address Sashiko AI code review feedback:
  - Force-stop path (target IRQ aborting an in-flight controller
    transfer): disable the controller IER and W1C-clear pending ISR
    before calling complete(), then restore the IER after the wake-up.
    Without the disable/clear sequence the controller IRQ handler can
    race with the target abort path and double-complete or touch
    freed msgs.
  - unreg_target() teardown ordering: disable the target IER first,
    then disable SLAVE_EN / clear ADDR_CTRL, synchronize_irq(), W1C
    pending ISR, and only then NULL i2c_bus->target and clear
    target_active. The old order left IER enabled while target was
    being cleared, allowing an in-flight handler to dereference a
    target pointer the caller had already freed.
  - reg_target() bring-up ordering: assign i2c_bus->target before
    enabling SLAVE_EN. Otherwise an IRQ that fires after SLAVE_EN is
    set but before the pointer is stored finds target == NULL, exits
    without clearing the ISR, and the unmasked event re-fires as an
    IRQ storm.
  - Use writel() instead of writeb() when staging a TX byte into the
    target buffer. The AST2600 buffer SRAM only supports 32-bit
    accesses; byte writes are silently dropped (or, on some
    revisions, raise a bus fault), so a SLAVE_READ_REQUESTED reply
    never reaches the master.
  - reg_target() rejects 10-bit client addresses with -EAFNOSUPPORT.
    AST2600_I2CS_ADDR1 is only a 7-bit field; without the check, the
    high bits of a 10-bit address overflow into the adjacent ADDR2
    field and silently corrupt a second target slot.
  - Initialise the local `u8 value` to 0 in the target packet IRQ
    handler. Its address is passed to i2c_slave_event() for events
    such as I2C_SLAVE_STOP / I2C_SLAVE_READ_REQUESTED; a slave
    backend that reads the byte before writing would otherwise leak
    uninitialised kernel stack.

Changes in v29:
- fix race between unreg_target and IRQ handler.
- move i2cs ier enable from ast2600_i2c_init to probe after master ier enable.
- remove dma/byte transfer, use buffer mode only.

Changes in v28:
- fix typo condication -> condition
- fix compile error, when disable CONFIG_I2C_SLAVE

Changes in v26:
- change int to bool target_operate
- rename target_operate to target_active
- use i2c_bus->target replace require IO
- use WRITE_ONCE replace target_operate write.
---
 drivers/i2c/busses/i2c-ast2600.c | 359 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ast2600.c b/drivers/i2c/busses/i2c-ast2600.c
index 70f37dc77468..aace0c7eeb72 100644
--- a/drivers/i2c/busses/i2c-ast2600.c
+++ b/drivers/i2c/busses/i2c-ast2600.c
@@ -255,6 +255,11 @@ struct ast2600_i2c_bus {
 	bool			multi_master;
 	bool			stop_pending;
 	void __iomem		*buf_base;
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	/* target structure */
+	bool			target_active;
+	struct i2c_client	*target;
+#endif
 };
 
 static void ast2600_i2c_ac_timing_config(struct ast2600_i2c_bus *i2c_bus)
@@ -348,6 +353,253 @@ static int ast2600_i2c_recover_bus(struct ast2600_i2c_bus *i2c_bus)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+static void ast2600_i2c_target_packet_buff_irq(struct ast2600_i2c_bus *i2c_bus, u32 sts)
+{
+	u8 value = 0;
+	int target_rx_len = 0;
+	u32 cmd = 0;
+	int i;
+
+	/* due to controller target is common buffer, need force the master stop not issue */
+	if (readl(i2c_bus->reg_base + AST2600_I2CM_CMD_STS) & GENMASK(15, 0)) {
+		writel(0, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
+		writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
+		writel(readl(i2c_bus->reg_base + AST2600_I2CM_ISR),
+		       i2c_bus->reg_base + AST2600_I2CM_ISR);
+		i2c_bus->cmd_err = -EBUSY;
+		WRITE_ONCE(i2c_bus->msgs, NULL);
+		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER,
+		       i2c_bus->reg_base + AST2600_I2CM_IER);
+		complete(&i2c_bus->cmd_complete);
+	}
+
+	/* Handle i2c target timeout condition */
+	if (sts & AST2600_I2CS_INACTIVE_TO) {
+		/* Reset timeout counter */
+		u32 ac_timing = readl(i2c_bus->reg_base + AST2600_I2CC_AC_TIMING) &
+				AST2600_I2CC_AC_TIMING_MASK;
+
+		writel(ac_timing, i2c_bus->reg_base + AST2600_I2CC_AC_TIMING);
+		ac_timing |= AST2600_I2CC_TTIMEOUT(i2c_bus->timeout);
+		writel(ac_timing, i2c_bus->reg_base + AST2600_I2CC_AC_TIMING);
+		writel(TARGET_TRIGGER_CMD, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+		writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base + AST2600_I2CS_ISR);
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		WRITE_ONCE(i2c_bus->target_active, false);
+		return;
+	}
+
+	sts &= ~(AST2600_I2CS_PKT_DONE | AST2600_I2CS_PKT_ERROR);
+
+	if (sts & AST2600_I2CS_SLAVE_MATCH)
+		WRITE_ONCE(i2c_bus->target_active, true);
+
+	switch (sts) {
+	case AST2600_I2CS_SLAVE_PENDING | AST2600_I2CS_WAIT_RX_DMA |
+		 AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
+	case AST2600_I2CS_SLAVE_PENDING |
+		 AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
+	case AST2600_I2CS_SLAVE_PENDING |
+		 AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_STOP:
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		fallthrough;
+	case AST2600_I2CS_SLAVE_PENDING |
+		 AST2600_I2CS_WAIT_RX_DMA | AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE:
+	case AST2600_I2CS_WAIT_RX_DMA | AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE:
+	case AST2600_I2CS_WAIT_RX_DMA | AST2600_I2CS_SLAVE_MATCH:
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_REQUESTED, &value);
+		cmd = TARGET_TRIGGER_CMD;
+		if (sts & AST2600_I2CS_RX_DONE) {
+			target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+			for (i = 0; i < target_rx_len; i++) {
+				value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+				i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+			}
+		}
+		if (readl(i2c_bus->reg_base + AST2600_I2CS_CMD_STS) & AST2600_I2CS_RX_BUFF_EN)
+			cmd = 0;
+		else
+			cmd = TARGET_TRIGGER_CMD | AST2600_I2CS_RX_BUFF_EN;
+
+		writel(AST2600_I2CC_SET_RX_BUF_LEN(i2c_bus->buf_size),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		break;
+	case AST2600_I2CS_WAIT_RX_DMA | AST2600_I2CS_RX_DONE:
+		cmd = TARGET_TRIGGER_CMD;
+		target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+		for (i = 0; i < target_rx_len; i++) {
+			value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+		cmd |= AST2600_I2CS_RX_BUFF_EN;
+		writel(AST2600_I2CC_SET_RX_BUF_LEN(i2c_bus->buf_size),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		break;
+	case AST2600_I2CS_SLAVE_PENDING | AST2600_I2CS_WAIT_RX_DMA |
+				AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
+		cmd = TARGET_TRIGGER_CMD;
+		target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+		for (i = 0; i < target_rx_len; i++) {
+			value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		cmd |= AST2600_I2CS_RX_BUFF_EN;
+		writel(AST2600_I2CC_SET_RX_BUF_LEN(i2c_bus->buf_size),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		break;
+	case AST2600_I2CS_SLAVE_PENDING | AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
+		cmd = TARGET_TRIGGER_CMD;
+		target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+		for (i = 0; i < target_rx_len; i++) {
+			value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+		/* workaround for avoid next start with len != 0 */
+		writel(BIT(0), i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		break;
+	case AST2600_I2CS_RX_DONE | AST2600_I2CS_STOP:
+		cmd = TARGET_TRIGGER_CMD;
+		target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+		for (i = 0; i < target_rx_len; i++) {
+			value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+		/* workaround for avoid next start with len != 0 */
+		writel(BIT(0), i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		break;
+	case AST2600_I2CS_SLAVE_PENDING | AST2600_I2CS_RX_DONE |
+	     AST2600_I2CS_WAIT_TX_DMA | AST2600_I2CS_STOP:
+		target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+		for (i = 0; i < target_rx_len; i++) {
+			value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_READ_REQUESTED, &value);
+		writel(value, i2c_bus->buf_base);
+		writel(AST2600_I2CC_SET_TX_BUF_LEN(1),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		cmd = TARGET_TRIGGER_CMD | AST2600_I2CS_TX_BUFF_EN;
+		break;
+	case AST2600_I2CS_WAIT_TX_DMA | AST2600_I2CS_SLAVE_MATCH:
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_READ_REQUESTED, &value);
+		writel(value, i2c_bus->buf_base);
+		writel(AST2600_I2CC_SET_TX_BUF_LEN(1),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		cmd = TARGET_TRIGGER_CMD | AST2600_I2CS_TX_BUFF_EN;
+		break;
+	case AST2600_I2CS_SLAVE_PENDING | AST2600_I2CS_STOP |
+	     AST2600_I2CS_TX_NAK | AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE:
+	case AST2600_I2CS_SLAVE_PENDING | AST2600_I2CS_WAIT_RX_DMA | AST2600_I2CS_STOP |
+	     AST2600_I2CS_TX_NAK | AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE:
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_REQUESTED, &value);
+		target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+		for (i = 0; i < target_rx_len; i++) {
+			value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+		writel(AST2600_I2CC_SET_RX_BUF_LEN(i2c_bus->buf_size),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		cmd = TARGET_TRIGGER_CMD | AST2600_I2CS_RX_BUFF_EN;
+		break;
+	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_WAIT_TX_DMA | AST2600_I2CS_RX_DONE:
+	case AST2600_I2CS_WAIT_TX_DMA | AST2600_I2CS_RX_DONE:
+	case AST2600_I2CS_WAIT_TX_DMA:
+		if (sts & AST2600_I2CS_SLAVE_MATCH)
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_REQUESTED, &value);
+
+		if (sts & AST2600_I2CS_RX_DONE) {
+			target_rx_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
+						       AST2600_I2CC_BUFF_CTRL));
+			for (i = 0; i < target_rx_len; i++) {
+				value = readb(i2c_bus->buf_base + i2c_bus->buf_size + i);
+				i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_RECEIVED, &value);
+			}
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_READ_REQUESTED, &value);
+		} else {
+			i2c_slave_event(i2c_bus->target, I2C_SLAVE_READ_PROCESSED, &value);
+		}
+		writel(value, i2c_bus->buf_base);
+		writel(AST2600_I2CC_SET_TX_BUF_LEN(1),
+		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
+		cmd = TARGET_TRIGGER_CMD | AST2600_I2CS_TX_BUFF_EN;
+		break;
+	/* workaround : trigger the cmd twice to fix next state keep 1000000 */
+	case AST2600_I2CS_SLAVE_MATCH | AST2600_I2CS_RX_DONE:
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_WRITE_REQUESTED, &value);
+		cmd = TARGET_TRIGGER_CMD | AST2600_I2CS_RX_BUFF_EN;
+		writel(cmd, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+		break;
+	case AST2600_I2CS_TX_NAK | AST2600_I2CS_STOP:
+	case AST2600_I2CS_STOP:
+		cmd = TARGET_TRIGGER_CMD;
+		i2c_slave_event(i2c_bus->target, I2C_SLAVE_STOP, &value);
+		break;
+	default:
+		dev_dbg(i2c_bus->dev, "unhandled target isr case %x, sts %x\n", sts,
+			readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
+		cmd = TARGET_TRIGGER_CMD;
+		break;
+	}
+
+	if (cmd)
+		writel(cmd, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+
+	writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base + AST2600_I2CS_ISR);
+	readl(i2c_bus->reg_base + AST2600_I2CS_ISR);
+
+	if ((sts & AST2600_I2CS_STOP) && !(sts & AST2600_I2CS_SLAVE_PENDING))
+		WRITE_ONCE(i2c_bus->target_active, false);
+}
+
+static int ast2600_i2c_target_irq(struct ast2600_i2c_bus *i2c_bus)
+{
+	u32 ier = readl(i2c_bus->reg_base + AST2600_I2CS_IER);
+	u32 isr = readl(i2c_bus->reg_base + AST2600_I2CS_ISR);
+
+	if (!(isr & ier))
+		return 0;
+
+	/*
+	 * Target interrupt coming after controller packet done
+	 * So need handle controller first.
+	 */
+	if (readl(i2c_bus->reg_base + AST2600_I2CM_ISR) & AST2600_I2CM_PKT_DONE)
+		return 0;
+
+	isr &= ~(AST2600_I2CS_ADDR_INDICATE_MASK);
+
+	if (isr & (AST2600_I2CS_ADDR1_NAK | AST2600_I2CS_ADDR2_NAK |
+		   AST2600_I2CS_ADDR3_NAK)) {
+		writel(isr & (AST2600_I2CS_ADDR1_NAK | AST2600_I2CS_ADDR2_NAK |
+			      AST2600_I2CS_ADDR3_NAK),
+		       i2c_bus->reg_base + AST2600_I2CS_ISR);
+		isr &= ~(AST2600_I2CS_ADDR1_NAK | AST2600_I2CS_ADDR2_NAK |
+			 AST2600_I2CS_ADDR3_NAK);
+	}
+
+	if (AST2600_I2CS_ADDR_MASK & isr)
+		isr &= ~AST2600_I2CS_ADDR_MASK;
+
+	if (AST2600_I2CS_PKT_DONE & isr)
+		ast2600_i2c_target_packet_buff_irq(i2c_bus, isr);
+
+	return 1;
+}
+#endif
+
 static int ast2600_i2c_setup_buff_tx(u32 cmd, struct ast2600_i2c_bus *i2c_bus)
 {
 	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
@@ -559,6 +811,20 @@ static void ast2600_i2c_controller_packet_irq(struct ast2600_i2c_bus *i2c_bus, u
 		}
 		break;
 	case AST2600_I2CM_RX_DONE:
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+		/*
+		 * Workaround for controller/target packet mode enable rx done stuck issue
+		 * When controller go for first read (RX_DONE), target mode will also effect
+		 * Then controller will send nack, not operate anymore.
+		 */
+		if (readl(i2c_bus->reg_base + AST2600_I2CS_CMD_STS) & AST2600_I2CS_PKT_MODE_EN) {
+			u32 target_cmd = readl(i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+
+			writel(0, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+			writel(target_cmd, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+		}
+		fallthrough;
+#endif
 	case AST2600_I2CM_RX_DONE | AST2600_I2CM_NORMAL_STOP:
 		xfer_len = AST2600_I2CC_GET_RX_BUF_LEN(readl(i2c_bus->reg_base +
 							     AST2600_I2CC_BUFF_CTRL));
@@ -666,6 +932,12 @@ static irqreturn_t ast2600_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct ast2600_i2c_bus *i2c_bus = dev_id;
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	if (i2c_bus->target) {
+		if (ast2600_i2c_target_irq(i2c_bus))
+			return IRQ_HANDLED;
+	}
+#endif
 	return IRQ_RETVAL(ast2600_i2c_controller_irq(i2c_bus));
 }
 
@@ -682,6 +954,21 @@ static int ast2600_i2c_controller_xfer(struct i2c_adapter *adap, struct i2c_msg
 			return ret;
 	}
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	if (READ_ONCE(i2c_bus->target_active))
+		return -EBUSY;
+	/*
+	 * Controller and target share the same buffer register. A target
+	 * transaction can update buffer state asynchronously via IRQ, so block
+	 * controller transfers while target is active to avoid buffer corruption.
+	 */
+	writel(0, i2c_bus->reg_base + AST2600_I2CS_IER);
+	if (readl(i2c_bus->reg_base + AST2600_I2CS_ISR) || READ_ONCE(i2c_bus->target_active)) {
+		writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base + AST2600_I2CS_IER);
+		return -EBUSY;
+	}
+#endif
+
 	i2c_bus->cmd_err = 0;
 	i2c_bus->msgs = msgs;
 	i2c_bus->msgs_index = 0;
@@ -689,6 +976,10 @@ static int ast2600_i2c_controller_xfer(struct i2c_adapter *adap, struct i2c_msg
 	WRITE_ONCE(i2c_bus->stop_pending, false);
 	reinit_completion(&i2c_bus->cmd_complete);
 	ret = ast2600_i2c_do_start(i2c_bus);
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	/* avoid race condition target is wait and controller wait 1st target operate */
+	writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base + AST2600_I2CS_IER);
+#endif
 	if (ret)
 		goto controller_out;
 	timeout = wait_for_completion_timeout(&i2c_bus->cmd_complete, i2c_bus->adap.timeout);
@@ -717,6 +1008,9 @@ static int ast2600_i2c_controller_xfer(struct i2c_adapter *adap, struct i2c_msg
 		 * if the bus is still busy.
 		 */
 		if (i2c_bus->multi_master &&
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+		    !READ_ONCE(i2c_bus->target_active) &&
+#endif
 		    (readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF) &
 		    AST2600_I2CC_BUS_BUSY_STS))
 			ast2600_i2c_recover_bus(i2c_bus);
@@ -765,8 +1059,66 @@ static int ast2600_i2c_init(struct ast2600_i2c_bus *i2c_bus)
 	/* Clear Interrupt */
 	writel(GENMASK(27, 0), i2c_bus->reg_base + AST2600_I2CM_ISR);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	writel(GENMASK(27, 0), i2c_bus->reg_base + AST2600_I2CS_ISR);
+#endif
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+static int ast2600_i2c_reg_target(struct i2c_client *client)
+{
+	struct ast2600_i2c_bus *i2c_bus = i2c_get_adapdata(client->adapter);
+	u32 cmd = TARGET_TRIGGER_CMD;
+
+	if (i2c_bus->target)
+		return -EINVAL;
+
+	if (client->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	dev_dbg(i2c_bus->dev, "target addr %x\n", client->addr);
+
+	writel(0, i2c_bus->reg_base + AST2600_I2CS_ADDR_CTRL);
+
+	i2c_bus->target = client;
+
+	writel(AST2600_I2CC_SLAVE_EN | readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL),
+	       i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
+
+	writel(cmd, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
+	/* Set target addr. */
+	writel(client->addr | AST2600_I2CS_ADDR1_ENABLE,
+	       i2c_bus->reg_base + AST2600_I2CS_ADDR_CTRL);
+
+	writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base + AST2600_I2CS_IER);
+
+	return 0;
+}
+
+static int ast2600_i2c_unreg_target(struct i2c_client *client)
+{
+	struct ast2600_i2c_bus *i2c_bus = i2c_get_adapdata(client->adapter);
+	u32 val;
+
+	writel(0, i2c_bus->reg_base + AST2600_I2CS_IER);
+
+	val = readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
+	writel(val & ~AST2600_I2CC_SLAVE_EN, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
+	writel(0, i2c_bus->reg_base + AST2600_I2CS_ADDR_CTRL);
+
+	synchronize_irq(i2c_bus->irq);
+
+	writel(readl(i2c_bus->reg_base + AST2600_I2CS_ISR),
+	       i2c_bus->reg_base + AST2600_I2CS_ISR);
+
+	i2c_bus->target = NULL;
+	WRITE_ONCE(i2c_bus->target_active, false);
+
 	return 0;
 }
+#endif
 
 static u32 ast2600_i2c_functionality(struct i2c_adapter *adap)
 {
@@ -776,6 +1128,10 @@ static u32 ast2600_i2c_functionality(struct i2c_adapter *adap)
 static const struct i2c_algorithm i2c_ast2600_algorithm = {
 	.xfer = ast2600_i2c_controller_xfer,
 	.functionality = ast2600_i2c_functionality,
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	.reg_target = ast2600_i2c_reg_target,
+	.unreg_target = ast2600_i2c_unreg_target,
+#endif
 };
 
 static const struct i2c_adapter_quirks ast2600_i2c_quirks = {
@@ -819,6 +1175,9 @@ static int ast2600_i2c_probe(struct platform_device *pdev)
 		regmap_write(i2c_bus->global_regs, AST2600_I2CG_CLK_DIV_CTRL, I2CCG_DIV_CTRL);
 	}
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	WRITE_ONCE(i2c_bus->target_active, false);
+#endif
 	i2c_bus->dev = dev;
 	i2c_bus->multi_master = device_property_read_bool(dev, "multi-master");
 

-- 
2.34.1


