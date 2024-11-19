Return-Path: <linux-aspeed+bounces-146-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFDFD6C2B4
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 22:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XtJVH2yFSz2xks;
	Wed, 20 Nov 2024 09:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.12.242.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732053975;
	cv=none; b=OBypbejc/j5WElDklEtiEsyA5WiO7l83C7DHwscxF+xn9qUeazBIl/xbr90FwPFWj9f8rQpEMUgaOTgW1mhwBtTmOT+movaJMJScuxzZtVi1vwaqUVucsT5uuSLGnwU/ATUEwIMdr4Cbi8x+Fm0CJoRjZbpXwpbQsyP6pFDAl3/5tbEfI2Je/eKGzsFQj8e+j4LAC5QRKLdP7Z8/g8G/aVAexjus5rycN9mrfB7YZ1/MzPLb56Ol7fBcUjmIFzXyg9g3worjP3UaaXowyCSC3nyPvyYgyc9JkqAu3F4Byw/jISTMQvLYF0th/ftF+9lvqXX7Ew9BNqrELtGENtFfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732053975; c=relaxed/relaxed;
	bh=EjYh1cknlZ7PMy6sRG187xTDVC5FFJcX/Odw6mzP5bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDZc+12MGDVFINRW94S2nRZRAMCl8IOoQ2jmDHQc01GQvH8lEuOyFPCGt7QsuRr5X06ZGD2ymBsQDP97xPmprHy3Ztq1GMWxd5ecCjeLbfaKNg1mhHAT/2n5XJNXChUWmicFK0ltutbFPw5rkHDZucBW7ZIfwnrriBWN+/AWSTAQTFsKpu/TDDD3EPRjcnjZk1IqTxbumaumRUnB+Yi5mm4RZMOzWpKmvhNqKNdkx2VzsQ8r6PYNYaxixcfJnVV9eOqWdycWEmXc14U8HiqUxrKa+gQXDiWJskgCVEaCAA+5b4pinkPXl3snVhC+lKUJ6fBHQUa0Zl2CDvWvjhvJJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=fs6XKAXK; dkim-atps=neutral; spf=pass (client-ip=80.12.242.28; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org) smtp.mailfrom=wanadoo.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=fs6XKAXK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=80.12.242.28; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 2054 seconds by postgrey-1.37 at boromir; Wed, 20 Nov 2024 09:06:13 AEDT
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XtJVF37qDz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 09:06:12 +1100 (AEDT)
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id DVo0tZBgMlMRCDVo0teyUl; Tue, 19 Nov 2024 22:30:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732051849;
	bh=EjYh1cknlZ7PMy6sRG187xTDVC5FFJcX/Odw6mzP5bM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fs6XKAXKEa7OiGdYVIxWxoX52NB9X9sFNwHavWtknoVS7Z1y0i9KjA7T5Hcz2N04G
	 oGU7ylyi7JaqkPL4uNOf8Qk/bK7w/mBi0klb3GdO73sCvx76Qx4AGs7GAZjXMWs0N3
	 uX/cFd2bZHVehren5fcaR5tkVEH+EmLU1QCfrLU9crfmdQO+ck55e3SvNxfM1ycuM3
	 0dZbgx1nxMHEae/5hr54Un7Ta4Y1f49V21pB9poCOHlOuJMQ2pHfL21MvriwpNQM+w
	 eWKSG3bJhYwZT1m1VrxKdg4OqVRgIQpGTtElsaT46/a3uXEqkcMPWrNN1N57pXeVyT
	 QqRSxYCfY4y1g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 22:30:49 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Mark Brown <broonie@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()
Date: Tue, 19 Nov 2024 22:30:29 +0100
Message-ID: <4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A aspeed_spi_start_user() is not balanced by a corresponding
aspeed_spi_stop_user().
Add the missing call.

Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.


This patch is completely speculative, review with care!

It is only based on naming where a _start() function if not followed by a
_stop() in some paths but is in other paths.
---
 drivers/spi/spi-aspeed-smc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 8eb843ddb25f..e9beae95dded 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -239,7 +239,7 @@ static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
 
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, offset, op->cmd.opcode);
 	if (ret < 0)
-		return ret;
+		goto stop_user;
 
 	if (op->dummy.buswidth && op->dummy.nbytes) {
 		for (i = 0; i < op->dummy.nbytes / op->dummy.buswidth; i++)
@@ -249,8 +249,9 @@ static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
 	aspeed_spi_set_io_mode(chip, io_mode);
 
 	aspeed_spi_read_from_ahb(buf, chip->ahb_base, len);
+stop_user:
 	aspeed_spi_stop_user(chip);
-	return 0;
+	return ret;
 }
 
 static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
@@ -261,10 +262,11 @@ static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
 	aspeed_spi_start_user(chip);
 	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, op->addr.val, op->cmd.opcode);
 	if (ret < 0)
-		return ret;
+		goto stop_user;
 	aspeed_spi_write_to_ahb(chip->ahb_base, op->data.buf.out, op->data.nbytes);
+stop_user:
 	aspeed_spi_stop_user(chip);
-	return 0;
+	return ret;
 }
 
 /* support for 1-1-1, 1-1-2 or 1-1-4 */
-- 
2.47.0


