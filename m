Return-Path: <linux-aspeed+bounces-4317-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA2C43602
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 23:56:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq38674q0z2ySJ;
	Tue, 30 Jun 2026 09:56:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782715777;
	cv=none; b=Sypkk1kQ+3h/oGe+3AH+iq7RUeEEf8hCcUeaCwVDDqtuIXg6j7ejYl5t5GnMRcbKReUYiyUwK7xHbmKNVr1u+6rbPZmP3RenaoL3lRCuVEaG9YIve82JLXmVbdHfNmTJehZrNt42fxNGY/qJFebI9/EHgPM1Z+gWVrUOZSTo/bdiiiecNTg+kNql7gj1cVJKbhnVXd+/HEyxRvqhEZ2cmYmzUx5UDzCSV9TlA+QCBNH4pcwL4G8H8Sf6lJNYWNI4D9cxNFlb6ZyRsA87mRRRLsy54WqxDD6aCG62oGSD6XX6Nc3P4wXG7PETYRFhRmDzrdnUhHOYPBnAKj7IU+p4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782715777; c=relaxed/relaxed;
	bh=LQXKnNh1b5EuPBwmDipG7e1JVmal6ripcmfgsJxs5jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lj/LacMR7DW2G2W6AwEgsLkOjwCbnsBUrRW8sThZ/2jgFmakDKtutsveUuW/O7RINJxZTuV02HwhRH5sjbKuXBKP7+5X4tTM6yms+cGng+Rt7zEORCW/kM5UNpgKyFOW+bqp3ynbKF7XmrkevsUMXve53h1pBcbwI9A4Rxrkrf4UAeHomekrbsqzDkXnjiaxTMYkY9n6bLqetIgrkMOyY0iigCONqXWaT6/Ji9jnkhsHP18oXu3sTKCwwu+ENuhS116W6jj4rkVotR4MKfKPOfl7WZPqR6wgzU8jx3rwp+zyww/SsttFmROLqleYUgaLOuBV1dydiRFNPVrVMih22g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jO8UnOjM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jO8UnOjM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpcMh5c9Hz2yf5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Jun 2026 16:49:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 45B1960052;
	Mon, 29 Jun 2026 06:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED214C2BCF6;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782715774;
	bh=o9rQxS6VSnLZ8UKdGcYxwjs9cwreXI3LIctajGTw3oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jO8UnOjMxgR7T59iLunDizziDNuV9ICXSGMpyrRKLa5eU5bVC3K23QiQ2zRu3Q6B7
	 n+D2MbuYJ2iitwtqZtWECRmaK7XM4a8uiEP6sY31YHsw9E004TMM5BHk459ZqgGzlK
	 uMIjAuDvLkEYOoF4dV8D6RSMa2PyFZOSwLEFY9eBKydN3OB1gtbKp0O02lKjbhDSZP
	 lzYASnAPeTykIhgyr/rld767lCazOM8u/AHfP/aU5z6Q+ZVa+3Te+upwTt3GKrU/et
	 euImpHD4B4TLWaH3PYxdMOZ5daR5uTcqZVRUv9EMd3Q3NvmYBF91PZxBLdwEVYRtG8
	 cp7rltm1ZAs6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F3C43602;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
From: Yu-Che Hsieh via B4 Relay <devnull+yc_hsieh.aspeedtech.com@kernel.org>
Date: Mon, 29 Jun 2026 14:48:59 +0800
Subject: [PATCH 2/4] ipmi: bt-bmc: Track open state per device
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
Message-Id: <20260629-aspeed-bt-bmc-multichannel-v1-2-fc23ee337f7a@aspeedtech.com>
References: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
In-Reply-To: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
To: Corey Minyard <corey@minyard.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782715772; l=1964;
 i=yc_hsieh@aspeedtech.com; s=20260629; h=from:subject:message-id;
 bh=kkcdpH7g4gFHRExA7T4VUvsyg0bKpkuItRJGEI3xPJA=;
 b=yHQTY1jCvmxKBbcWqHMlIZQ8QIbmxk/w14R13q3bhtuzMgZpj11PsEVwfZCzFGlKhBzXd+Lfs
 TSHkqXBCUHbCjiz3yJ7vSAa2XwHJor+R157niWVbLj+PCVz3VziveqT
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=kLxUeF7g6teciq79it9N3tYNgp3yCspZ+AHlYSnZ0gs=
X-Endpoint-Received: by B4 Relay for yc_hsieh@aspeedtech.com/20260629 with
 auth_id=844
X-Original-From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Reply-To: yc_hsieh@aspeedtech.com

From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>

The driver uses a global open count to allow only one userspace client

to open the BT device at a time. This works for a single device, but

also prevents independent BT device instances from being opened

concurrently.

Move the open count into struct bt_bmc so each device instance tracks

its own open state. This preserves the single-open behavior per device

while allowing multiple BT devices to operate independently.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
 drivers/char/ipmi/bt-bmc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index f3c67272502f..486ecc0b6815 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -64,10 +64,9 @@ struct bt_bmc {
 	wait_queue_head_t	queue;
 	struct timer_list	poll_timer;
 	struct mutex		mutex;
+	atomic_t		open_count;
 };
 
-static atomic_t open_count = ATOMIC_INIT(0);
-
 static u8 bt_inb(struct bt_bmc *bt_bmc, int reg)
 {
 	return readb(bt_bmc->base + reg);
@@ -152,12 +151,12 @@ static int bt_bmc_open(struct inode *inode, struct file *file)
 {
 	struct bt_bmc *bt_bmc = file_bt_bmc(file);
 
-	if (atomic_inc_return(&open_count) == 1) {
+	if (atomic_inc_return(&bt_bmc->open_count) == 1) {
 		clr_b_busy(bt_bmc);
 		return 0;
 	}
 
-	atomic_dec(&open_count);
+	atomic_dec(&bt_bmc->open_count);
 	return -EBUSY;
 }
 
@@ -313,7 +312,7 @@ static int bt_bmc_release(struct inode *inode, struct file *file)
 {
 	struct bt_bmc *bt_bmc = file_bt_bmc(file);
 
-	atomic_dec(&open_count);
+	atomic_dec(&bt_bmc->open_count);
 	set_b_busy(bt_bmc);
 	return 0;
 }
@@ -425,6 +424,8 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	if (IS_ERR(bt_bmc->base))
 		return PTR_ERR(bt_bmc->base);
 
+	atomic_set(&bt_bmc->open_count, 0);
+
 	mutex_init(&bt_bmc->mutex);
 	init_waitqueue_head(&bt_bmc->queue);
 

-- 
2.34.1



