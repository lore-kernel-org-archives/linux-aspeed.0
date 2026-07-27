Return-Path: <linux-aspeed+bounces-4576-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1216C5321C
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 07:30:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7qxX6PYVz2yhY;
	Mon, 27 Jul 2026 17:30:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785137408;
	cv=none; b=NkYJMw8/abvimK3IK0AQSNH5S7rR7XpC7Nl4ps4ysRl5hNjyQfOx3PiZm9XC1NkMzpn3HAPCrqKq0rVOZmLJRoDM0uBSlSo1AymIL4PKhmKdv1saZvlkt3JpIXvD9O+KTpRaSzCfdbubUIE6nMRftzVZeONmLqjwxDuO3yip/fTXeetVTMkRCtP0gRfO5v1ioGE5P7ksf74Bl5vxZg3BsTTF5MNzG+hBegvD6bE/SVIjNrUnv7MLAE2sizFr6FU0efQQCxxuOQk3BlRey0MlpZOuHL5Mdyyv8oJxc2cjkXUy9SPuy5ZbKX1u93W6Z1HUr2+vCYsOqup5oy9q34J5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785137408; c=relaxed/relaxed;
	bh=7MzOsUeybMS9dXaNgD2Ggm/YXuUKfNu/EThsAs7XLtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H13cIca5nZ2P26cE4HIQZV7PrXxflF6vtJo0ed61uWOOQRxBGFiTm7dWKq33qSE3TUy47oDkUbfDCP/Jolam10M/T92EgbeLLz6fqE2pfWMvNdH52OBztPC3SHxeLKWZPDzaonvkPIcGCP+F38Q90EcNjmGPO4AT+LuaLg2KkygLVnxJPyBSiMs5LlNh6bU3NPIlTHPvwWKs7QK7ulNAoC0rJqcBYBoyXH794DTjRBnIS8eTMNY5LysGjlQ5jQCNFBppcuuHUjpAxwzUkbRAdc2o7+03qrrqE1jRttiCuARHqLuDQokVveaQOddN4JChDf9ZRQlWqVo56kB2LzhMGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=M2WpyFds; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=M2WpyFds;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7qxW6FWwz2yRl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 17:30:07 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-47de0093c42so1811395f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785137404; x=1785742204; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7MzOsUeybMS9dXaNgD2Ggm/YXuUKfNu/EThsAs7XLtY=;
        b=M2WpyFdspElZKRXDDsMLtYbuAw5mLKBG7yRVQJCOw0L7dlmZHE/WeTIOY5UPYqqko+
         kk5iUnjZFD3k8K4lOpVDLfmbf4HM0CBe/546G+9XuD8+0lKeILgvgahtU9ABzd6/iStb
         EYq+vkTQzqteaN8bREc5x8rXJAdvLuTItxgDGQpefm9iJiS8h8jFgC6bMLBu6qT65lXT
         TIAxvZdNZneud4B2QvfgnIsC1nTOrlghv6HA/TbwfwT53RVmJsCqu7DpHJhXPV897QYL
         X7ZFiYAMKwvaSl9PBdchGE/266VjKaAtIRvnxS7fNmYfkQGejgqCxV76erkA5Zm7laqP
         EOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137404; x=1785742204;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MzOsUeybMS9dXaNgD2Ggm/YXuUKfNu/EThsAs7XLtY=;
        b=Cgh4ZSAyls8FsfWvsXuPliQRG8EUcd8NwNw6HDp637juPyLVcG5DxUfWPJ+OO6HBcD
         RIMtwPiK/YcD0D6mf3LqZvd0tNsyJaEB0e+5D4h+QEtFNFYHXOxMweKM4T2l6G776X0Z
         2ZPMGF9309Sohxo8SBCineoeF+p4HGxj5yV0oouZ7texOZkS8fpD79s4tdLPuu4Qu5+y
         8XIeOjQ3AFj0HEQRnkqoYeT6BOsRlaC//9ZwXc5AyXvJ6fBtyrO6/bV5IzDOSy0ZjE3O
         XoyjmaRKBoTOw2AzK1VLdcqJKhFdNath/mFKUfBzePuytVAIkUQzT4TMbv+3g0Y7+kLT
         KTNQ==
X-Forwarded-Encrypted: i=1; AHgh+RreDyq6rOHk1Lrr6p13x4JoJchvr5PM6qsYCBb/WIGAgyaZoQ07zYMS75KwYdB20djHSB7wqB2KMM01Xzo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyE9HmbeRnHV/pj+8u+djqL/RbMFylSXUWr7QdaXqneXf1N1Cny
	7DFZqeGIgrHHWuHH1V+VHN5Gyv6eunTnGo/zFuxQSqzeTDmDloQNPSfHBHhHBRDc99M=
X-Gm-Gg: AR+sD12yy+F4ssCkDKAT0OKkRPNbdTiULjVsa5JBaDozfwlJc6kj0U5p+0tV+ksXH5j
	Oyf7Tw1jXzpNhrLStDdJ6OjFSqECXzBMVb+UDZqqoSypnfjFddeMLqhFcl19JRAtNUOKRGUsMHt
	Mm2AKlAOO7Wj/tgENtpMxHvRL4pjyIlPUOsKMIfX5tjiQQwRfls11PhtWQjYuONtALQ2VNm4RCs
	guCDzE5uEaucluwihlEOd5iighM3Uz7iuLzwMLWmaTnYnfmIeW9QblmBRMjckxU/Oo7IvZw9LFl
	M60rHCm+a5xhtgHN4n9KWnvLR8JqYBYVTFeMknQNWZSMbHhnDodr7J0hFAKx2xCIPZTF+1hPqQh
	qK9h4zCZLWRe7KO5J+E577uEvC8kFS57zBqQHU0xVuUCvOf9oQLpMpd9td5PNrB3aFq7gWVhlr8
	q922YZNGxBZDQOs4ghXqNthXfC05yEHC6iZJN4ejuALoxszbUxMer675MhBRudthYkGB/R9mhGq
	sM6eXC+0Gzw1MUFFA==
X-Received: by 2002:a05:600c:310d:b0:495:7b1b:f387 with SMTP id 5b1f17b1804b1-496b56f141dmr93289595e9.24.1785137404083;
        Mon, 27 Jul 2026 00:30:04 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee4504sm201823685e9.6.2026.07.27.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:30:03 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: jammy_huang@aspeedtech.com,
	yc_hsieh@aspeedtech.com,
	openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 1/2] ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe
Date: Mon, 27 Jul 2026 09:27:40 +0200
Message-ID: <45f36ea6a3a2df18b51c5b83200c7596dbafe133.1785135437.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785135437.git.gregoire.layet@9elements.com>
References: <cover.1785135437.git.gregoire.layet@9elements.com>
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

Created a 5th KCS channel to match against the KCS 4 over PCIe addresses.

The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
interface on channel 4. This is a fully KCS-compatible interface
that is exposed over PCIe.

The 5th channel created is only valid on the AST2600.
This cannot be used for AST2400 and AST2500 chips, as they don't have LPC
over PCIE.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 41 ++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index a13a3470c17a..97daa2b3d6a0 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -26,7 +26,7 @@
 
 #define DEVICE_NAME     "ast-kcs-bmc"
 
-#define KCS_CHANNEL_MAX     4
+#define KCS_CHANNEL_MAX     5
 
 /*
  * Field class descriptions
@@ -102,6 +102,12 @@
 #define     LPC_LSADR12_LSADR2_SHIFT 16
 #define     LPC_LSADR12_LSADR1_MASK  GENMASK(15, 0)
 #define     LPC_LSADR12_LSADR1_SHIFT 0
+#define PCIE_LPC_HICRB       0x900
+#define PCIE_LPC_HICRC       0x904
+#define PCIE_LPC_LADR4       0x910
+#define PCIE_LPC_IDR4        0x914
+#define PCIE_LPC_ODR4        0x918
+#define PCIE_LPC_STR4        0x91C
 
 #define OBE_POLL_PERIOD	     (HZ / 2)
 
@@ -159,6 +165,7 @@ static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
 	case LPC_ODR2:
 	case LPC_ODR3:
 	case LPC_ODR4:
+	case PCIE_LPC_ODR4:
 		break;
 	default:
 		return;
@@ -191,6 +198,9 @@ static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
 	case 4:
 		regmap_update_bits(priv->map, LPC_HICRC, LPC_HICRC_IRQXE4, LPC_HICRC_IRQXE4);
 		break;
+	case 5:
+		regmap_update_bits(priv->map, PCIE_LPC_HICRC, LPC_HICRC_IRQXE4, LPC_HICRC_IRQXE4);
+		break;
 	default:
 		break;
 	}
@@ -278,6 +288,14 @@ static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2],
 
 		break;
 
+	case 5:
+		if (nr_addrs == 1)
+			regmap_write(priv->map, PCIE_LPC_LADR4, ((addrs[0] + 1) << 16) | addrs[0]);
+		else
+			regmap_write(priv->map, PCIE_LPC_LADR4, (addrs[1] << 16) | addrs[0]);
+
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -344,6 +362,11 @@ static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u
 		val = (id << LPC_HICRC_ID4IRQX_SHIFT) | (hw_type << LPC_HICRC_TY4IRQX_SHIFT);
 		regmap_update_bits(priv->map, LPC_HICRC, mask, val);
 		break;
+	case 5:
+		mask = LPC_HICRC_ID4IRQX_MASK | LPC_HICRC_TY4IRQX_MASK | LPC_HICRC_OBF4_AUTO_CLR;
+		val = (id << LPC_HICRC_ID4IRQX_SHIFT) | (hw_type << LPC_HICRC_TY4IRQX_SHIFT);
+		regmap_update_bits(priv->map, PCIE_LPC_HICRC, mask, val);
+		break;
 	default:
 		dev_warn(priv->kcs_bmc.dev,
 			 "SerIRQ configuration not supported on KCS channel %d\n",
@@ -373,6 +396,10 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enabl
 	case 4:
 		regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_LPC4E, enable * LPC_HICRB_LPC4E);
 		return;
+	case 5:
+		regmap_update_bits(priv->map, PCIE_LPC_HICRB, LPC_HICRB_LPC4E,
+				   enable * LPC_HICRB_LPC4E);
+		return;
 	default:
 		pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
 		return;
@@ -452,6 +479,10 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 			regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_IBFIE4,
 					   enable * LPC_HICRB_IBFIE4);
 			return;
+		case 5:
+			regmap_update_bits(priv->map, PCIE_LPC_HICRB, LPC_HICRB_IBFIE4,
+					   enable * LPC_HICRB_IBFIE4);
+			return;
 		default:
 			pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
 			return;
@@ -492,6 +523,7 @@ static const struct kcs_ioreg ast_kcs_bmc_ioregs[KCS_CHANNEL_MAX] = {
 	{ .idr = LPC_IDR2, .odr = LPC_ODR2, .str = LPC_STR2 },
 	{ .idr = LPC_IDR3, .odr = LPC_ODR3, .str = LPC_STR3 },
 	{ .idr = LPC_IDR4, .odr = LPC_ODR4, .str = LPC_STR4 },
+	{ .idr = PCIE_LPC_IDR4, .odr = PCIE_LPC_ODR4, .str = PCIE_LPC_STR4 },
 };
 
 static int aspeed_kcs_of_get_channel(struct platform_device *pdev)
@@ -575,11 +607,16 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (channel < 0)
 		return channel;
 
+	np = pdev->dev.of_node;
+	if (channel == 5 && !of_device_is_compatible(np, "aspeed,ast2600-kcs-bmc")) {
+		dev_err(&pdev->dev, "LPC over PCIE KCS4 only supported on ast2600\n");
+		return -ENODEV;
+	}
+
 	nr_addrs = aspeed_kcs_of_get_io_address(pdev, addrs);
 	if (nr_addrs < 0)
 		return nr_addrs;
 
-	np = pdev->dev.of_node;
 	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", upstream_irq, 2);
 	if (rc && rc != -EINVAL)
 		return -EINVAL;
-- 
2.54.0


