Return-Path: <linux-aspeed+bounces-1495-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389AFC71157
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Jun 2025 10:22:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMftF4pRWz2yFJ;
	Wed, 18 Jun 2025 20:21:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750242117;
	cv=none; b=dCydc09uOYKfHeviZCdZDVX2cgjAksMLBfBFz7jZDHMEXhiDW7ZytHmnfMz/3sjhesWKh5BwrmE/CI7+07P6ZclWArpcRN00gGBN2nsgF7eTl5UiHSKfjrJ6KTxWxMVnDrpHblR23KjIQ4JR+JIeWjU/KdBheq/0iJ9IHKBXeMDS1mjyUCp39eI6bqFDM0rYP3cAQwp2AOMCjht56IsiuRFDZ9tumaTSCAWswn1BGyvfQmZF9LAzIpzbSIJ248MO7Dlb+5/UYPk4KDTJCOQRznakFcr4UPVd8dk+JfPOm9G19IMFhV6EknbqIoF2qjhvCCnf8SKphqPRtYdlmVof/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750242117; c=relaxed/relaxed;
	bh=GjmzlSMJGThF/X6xEUPvfYdLDsdkYToZuOGOEJIFwyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=meNtFJgMlSAauHMlzLJgC6ESa3V0voeXS91gRomvwDlcHAEy5UaEjDlsHldecb8t4Wv9nxjwYaxr+VzUbpTJN/8xO9vB49118IeUncFf58gjn00RKv03sSIs60cDJVDgP14bxGaz9he8acUUGDSYnaETjD0sQwVmIypSjXufok8KhJQyqOGLRPL89j7PorB8aqkqY/cMblH7aeWjdrBVsWk+6q07DY3r9/mj/VjHWd5VZvYVsEydODn/Uh3H5EEDgoOOY0EL+VDMtUfDVT2gritg97ApzkWs/d4mDXUxrNSXRAAIVMJzK3U3L2c/aWCUN3v9yKL4Ngx5oyDXimun2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kV746wtd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=zhangjian.3032@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kV746wtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=zhangjian.3032@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMftC5P8Cz2xS0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 20:21:55 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-235d6de331fso83641915ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750242112; x=1750846912; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GjmzlSMJGThF/X6xEUPvfYdLDsdkYToZuOGOEJIFwyo=;
        b=kV746wtd4W4Cys5IAHQCyJ9vEP+cdysXH9s5s/fMmcem/hFwrd59PMzTWCacAwfmEU
         YtHGcnq7iY05NAs9iJPt3VVzXZr/Kay55XlzwRS0cJCTGJhs4oeshbYMKU5bti20LOXw
         Zps9T3OSLphKdt6XYHABNUKfmDSGVlESsfqTOaXul+71JOKnZYlTUW/pDcbUZOeM2Qa1
         dGP7NDydBvdq61WzGG5hNpv2ayuE5VIXcb5epPzFpHPDxVL/gb5wKiqrRFVcjs7DZb6I
         HLoifUPRIsP7ZJ1wwAN0+9ilI7x4n3j/27ur1OphqMpmc1Y8umcyiCSOpyVgdTpubAjR
         OKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242112; x=1750846912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjmzlSMJGThF/X6xEUPvfYdLDsdkYToZuOGOEJIFwyo=;
        b=F4IBRGybB9OWQFF0PE9WMaSd6dNI1tnfIw2nTCYFz9om+luWdslz6pj/2oxAxYqtRg
         v17JhwVGO6j0XtmfbzJQX5hsHcv2GmwXF3fVVzGRh1MdrT3YUfHzDPIr5q5eBY6z91rg
         ipfEuAPR1uz952RWeDHdIRNya7WIhQwaRe+iKnmbbIBb0UExHjL4Pz2MCbeRo4zfFKQw
         jWJrWPrnu+kOnDK7gxRGyVws6zldEBrCuuNZ4Qa/nMtW3m8F7ITwZDQ6K6eAiBc/Bz7y
         toOlcMVvn8n9JjbxAhkbtWSq6qgWrCX2m0ONz7DOKdfA/n1xkoKfnF9LJGLWCesDL2KI
         Jnew==
X-Forwarded-Encrypted: i=1; AJvYcCXOAze+fx51qCgar95dO6RxGBIV3bROZNeq1nEppd0gme7O/EvjKqws9wxitIuy+deDr6qyVZNLn2i3pIA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSsAT9Lh2+KtwEweYS6jMtQTuKRZLiFH4E4/uVCh57aJ08O4WD
	KfIDrrga0H9FPfWnqtX9NV/S9woakRSiAnVO7RIudOpwkeL7GiJBiaRfbZpYVrO3Lbs=
X-Gm-Gg: ASbGncu5X6rEGUUcqJ91uLOSr/KjkvlAgmWOUaSzDYCnjCEWAm9HuXw8nbXYVvTNXDY
	UTX3GhNwHFMBkzVDapZ16q/r+ZwNud7VcsrM0C4bu0ytuKkjX8hyEqovlV2KQSowOcBvzxS3vvB
	HBIdsWiPi11pTgxMlOKKqiT2CWGC4PUoDMFeoP9SLjni61m48Ts1Ixehb+tL7Xk2GdaDwY+XqjS
	eKeDi7/7Haf7LsSXPlxA2v1R9OWmVbhfrZh/IHNC5uFWQMVQ42Nu10ojxxgOWGtVuuCpLE6c5br
	lffR550f9njc7ysK7/0jYe70xrCm+8k6NZJPSkOT8+rmp6qdI9f4OZjyqVREjxg0UCSVa49sn4Q
	Mpz9DYAM=
X-Google-Smtp-Source: AGHT+IFazvSPNlbUxR4VYiAlmcTE9A4W+7BMiVTRCRXWqUGSyQF3kdAvM4//0ZOLw44KbimyVMMUYw==
X-Received: by 2002:a17:902:c946:b0:234:d292:be95 with SMTP id d9443c01a7336-2366b149f20mr223382045ad.42.1750242112586;
        Wed, 18 Jun 2025 03:21:52 -0700 (PDT)
Received: from localhost ([106.38.221.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781dfsm96547735ad.131.2025.06.18.03.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:21:52 -0700 (PDT)
From: Jian Zhang <zhangjian.3032@bytedance.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: aspeed: change debug level in irq handler
Date: Wed, 18 Jun 2025 18:21:48 +0800
Message-ID: <20250618102148.3085214-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.47.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In interrupt context, using dev_err() can potentially cause latency
or affect system responsiveness due to printing to console.

In our scenario, under certain conditions, i2c1 repeatedly printed
"irq handled != irq. expected ..." around 20 times within 1 second.
Each dev_err() log introduced approximately 10ms of blocking time,
which delayed the handling of other interrupts — for example, i2c2.

At the time, i2c2 was performing a PMBus firmware upgrade. The
target device on i2c2 was time-sensitive, and the upgrade protocol
was non-retryable. As a result, the delay caused by frequent error
logging led to a timeout and ultimately a failed firmware upgrade.

Frequent error printing in interrupt context can be dangerous,
as it introduces latency and interferes with time-critical tasks.
This patch changes the log level from dev_err() to dev_dbg() to
reduce potential impact.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 1550d3d552ae..38e23c826f39 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -317,7 +317,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
 		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_ACK))
-			dev_err(bus->dev, "Unexpected ACK on read request.\n");
+			dev_dbg(bus->dev, "Unexpected ACK on read request.\n");
 		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
 		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
 		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
@@ -325,7 +325,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		break;
 	case ASPEED_I2C_SLAVE_READ_PROCESSED:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
-			dev_err(bus->dev,
+			dev_dbg(bus->dev,
 				"Expected ACK after processed read.\n");
 			break;
 		}
@@ -354,7 +354,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		/* Slave was just started. Waiting for the next event. */;
 		break;
 	default:
-		dev_err(bus->dev, "unknown slave_state: %d\n",
+		dev_dbg(bus->dev, "unknown slave_state: %d\n",
 			bus->slave_state);
 		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 		break;
@@ -459,7 +459,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
-		dev_err(bus->dev, "bus in unknown state. irq_status: 0x%x\n",
+		dev_dbg(bus->dev, "bus in unknown state. irq_status: 0x%x\n",
 			irq_status);
 		bus->cmd_err = -EIO;
 		if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
@@ -523,7 +523,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
 			goto error_and_stop;
 		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
-			dev_err(bus->dev, "slave failed to ACK TX\n");
+			dev_dbg(bus->dev, "slave failed to ACK TX\n");
 			goto error_and_stop;
 		}
 		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
@@ -546,7 +546,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		fallthrough;
 	case ASPEED_I2C_MASTER_RX:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
-			dev_err(bus->dev, "master failed to RX\n");
+			dev_dbg(bus->dev, "master failed to RX\n");
 			goto error_and_stop;
 		}
 		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
@@ -577,7 +577,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_STOP:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
-			dev_err(bus->dev,
+			dev_dbg(bus->dev,
 				"master failed to STOP. irq_status:0x%x\n",
 				irq_status);
 			bus->cmd_err = -EIO;
@@ -589,7 +589,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
 		goto out_complete;
 	case ASPEED_I2C_MASTER_INACTIVE:
-		dev_err(bus->dev,
+		dev_dbg(bus->dev,
 			"master received interrupt 0x%08x, but is inactive\n",
 			irq_status);
 		bus->cmd_err = -EIO;
@@ -665,7 +665,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	irq_remaining &= ~irq_handled;
 	if (irq_remaining)
-		dev_err(bus->dev,
+		dev_dbg(bus->dev,
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-- 
2.47.0


