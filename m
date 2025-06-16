Return-Path: <linux-aspeed+bounces-1479-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C63C71159
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnm6lKdz30Wg;
	Mon, 16 Jun 2025 23:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079644;
	cv=none; b=ioBlyXLrVVpjbeK+Tt2dIBKYJ+jooGtAal2uAcEcr7BdazJXvu2mSVv/mTJc2BHEl6CI21WvAbqVisinIL91F7owWIros9tH55K+/6ijPWgZumzqaJERRR+W1kxKhcQt2hx89aiXIICrBF7p+4qgmW4oGbcNicl1eTehtY6AhcdvlLh9jQwiYpWhLkyv0Uxtqx3LYbymjIijhGIXzbgo54E6JoMpPE6eO9sqzgX+5XChIJB8NrVrq8MOWDB7xVgoADMZ5QKD4mbRXjv1xhl8KqLHkXF2fkAhZA24hH3BAzeI9Es2I7cT3Dj5YEG87F9oHHB8I2s9QJWL3wc9MI0JAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079644; c=relaxed/relaxed;
	bh=i2REkO5gC9yhhzzDAZNsIufUfzsU30pxXTvOzVJMONo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXYzxcxVBQS348jwsZGYRKK/ApUe1pA5oQKvm1OnnvZaKM3+9l21XSaHW6Iwt0F6RfRqpvGXI8qv0feBvA/f6dU34aTQz6ZTX0GyIrxhJR3AtMOSkMD0QMm0HFZIcPx4RD6CuaTilYYTUE9Doh1dJbNgoLwLCXywZ302YYaP+U1939aOEQz5XtD9hsI+WN5l79lxkCwcLtLiHsTZ5Vkn72vQF/TwJb7/faH9k9cOWa5wrRiqiB47jnRWeU9ccnVbp+rG40QMU6b5PVPQ8Z1TYVuZm/eE4DGHGYCfn5X+eEOWXYEIU4cemZyuYJniDt3BTXqzWeK+DJ/N0ZLdz/hRQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GIzxj/i+; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GIzxj/i+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnm4XHcz30Vn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079644;
	bh=i2REkO5gC9yhhzzDAZNsIufUfzsU30pxXTvOzVJMONo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GIzxj/i++dzVYAoGl+ADpT2pTEv0hdoXLGIxEUVZz1a/E+B98oW7o5wNsBrLAfXoH
	 wq9mkz2SyLLhoCfSHmB9930qF/GxE+rLlTgfQqMr12CEQVqvcwhVNtqzxd1ghLWTh+
	 LG/awzjWC14PBNqnHQhBE7BRWnRsMrIILflBvw+646t+NatPDi2mQhrpFCcy9iJnhq
	 BhqH6GNGLkUI0WA+XkMNbWIxAMAtsVfiUDzq9QAwrAcuthlwK7HhM4dfYuR0ieDV+5
	 JD/TONikpwaOXW+EoVm3kSeavD3PbVpHuJbAHwd9c8BedB3Lh3FoIFv0FrKX5G1s8W
	 dfkFDicFHXfdg==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6552E68856;
	Mon, 16 Jun 2025 21:14:03 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:45 +0930
Subject: [PATCH v2 08/10] soc: aspeed: lpc-snoop: Use dev_err_probe() where
 possible
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-8-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Exploit that it returns the provided error to eliminate some lines, and
return the actual error involved rather than -ENODEV.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index bd4afa7f258eb3c1e64fe87d2b4be5f8422fbaf7..8dbc9d4158b89f23bda340f060d205a29bbb43c3 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -12,6 +12,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/dev_printk.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/kfifo.h>
@@ -316,10 +317,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	}
 
 	lpc_snoop->regmap = syscon_node_to_regmap(np);
-	if (IS_ERR(lpc_snoop->regmap)) {
-		dev_err(dev, "Couldn't get regmap\n");
-		return -ENODEV;
-	}
+	if (IS_ERR(lpc_snoop->regmap))
+		return dev_err_probe(dev, PTR_ERR(lpc_snoop->regmap), "Couldn't get regmap\n");
 
 	dev_set_drvdata(&pdev->dev, lpc_snoop);
 
@@ -330,12 +329,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	}
 
 	lpc_snoop->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(lpc_snoop->clk)) {
-		rc = PTR_ERR(lpc_snoop->clk);
-		if (rc != -EPROBE_DEFER)
-			dev_err(dev, "couldn't get clock\n");
-		return rc;
-	}
+	if (IS_ERR(lpc_snoop->clk))
+		return dev_err_probe(dev, PTR_ERR(lpc_snoop->clk), "couldn't get clock");
 
 	rc = aspeed_lpc_snoop_config_irq(lpc_snoop, pdev);
 	if (rc)

-- 
2.39.5


