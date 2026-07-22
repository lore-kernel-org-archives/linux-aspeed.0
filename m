Return-Path: <linux-aspeed+bounces-4537-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9357CC44536
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 15:15:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4yVr0g6sz2yVd;
	Thu, 23 Jul 2026 01:15:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784733332;
	cv=none; b=Yq14My8qRHcZuOHtAhP9tMXa8O6AuGb5zB0tFWkbOz7jhDMoGr4Xfr6TgFQ9jxcRBwWhpj6FSg94NFA4TZdqORVDPr6zwsMmsGtrdGukFdXdFutg1dzkHZeeHCeQbczRdXbrbaqks06oB4v7x/l94IBVQUERCO6ZwZEPC4BpkrubzTWNqC/xrJJhe5eZZ1R0KpulSkn0NIyUKGpw+poJSS4ABBEMVfR5hPrDRHqhkhfUdCce5+67NbXdZUkSY86oTheDA8+PHsxQhSZ8973Kc9mEt7W+APp9VDU/1lYzUuLwFvtxOOT86QAuvbaKzcm7z3KE997epb+WaDMCDLzgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784733332; c=relaxed/relaxed;
	bh=qXzXulSKAPLcRuX3YZiepbKZUvKjmLNyPDEVWHi2rOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki9Qqtdpn7EzSPNOYapB8d+aW39egt/SUFTrBz3khHLtSQFbdlxNpr2viDdIudZiAnShzrE9B7dQAz2rjkIxvZ8KcvmbOcRXWcLg9uZbN27Lha9y+shvjmVU+VoEwTkqn6yMTxjBW4a/2eQYEwuhJL9GKjR5DgGiaG/d18SdavQrewP9ZX9D5H16G+un9FHpMQ8Uon5bCSJbpfYPuXc8uwrmBRf1E5S4me63sJmhu6jkg581N2sm/BdKQmsyg8+pGDg0zcRimI/hLDq+QDrNDFtLaD21j9GfPvLN4S+Q/QN858KhHzBsh2kf2MLLdayuGluaF42KuLFVvsZxeZOSlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=SEIZ00qC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=SEIZ00qC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4yVq02V8z2yFK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:15:30 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so67624595e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784733327; x=1785338127; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qXzXulSKAPLcRuX3YZiepbKZUvKjmLNyPDEVWHi2rOQ=;
        b=SEIZ00qCuQewboG5mQsFzgihyItNiCaxsaS0H09DEWfQpg0ypt7WSbZkyr/FjQBde5
         04zM9HQDGdq9+U0BzYvTYMwImiCAKEsxIMcPbqvuO9LjsdKhJ/OQye4BUIESen3STD/J
         V1joy7vCCH958vfp98pcVK3f1W+NUFFHxbe1oRwNgv/ir83ytohvfOhhNruQ/3ZgRR7O
         LJd9DtKUb+iAPYlw7XwKLbn58H0qMK/FLDimNhrbXJXmUtpDUkL/F/p7qkHI9wt7Cyt1
         Ub7mU9GSQb1zkOp2GWFdYmKwqHDvGKFC5NFqtgaTszbHGgI8Ox5useSn5kMuJ0GPg+FK
         qBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733327; x=1785338127;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qXzXulSKAPLcRuX3YZiepbKZUvKjmLNyPDEVWHi2rOQ=;
        b=cNmWN7L5s9YS1o8Od8Sa8ACuZ2m/8FWEgHff2utLYEMQgA5xWg0/Ot3SXoN7bWs6ng
         M35nOudvbkc9gnROIVArqglY8om8wsYhOgsXiD0++HpVbeFlIN4LQPz1X5gpEWiS4exm
         FL9HYkkHnsmXkGW++e9OhrAqDjLXqlvCZrMwH09sdi8iFFEWT7Ew8gU8Gl0TipdUJHLW
         KfjrVolqeXFv4xM8QsNT+BcM/Ni3pf41cZd4x8VkzDlOytQYhy/F4j2TCXfKc4+8SNvx
         jxJltV99j1EGnbmHbAvSbtnJlIBLrPkxZCykn5uLb006vnsv7AVDZrxL4tg+Uzfr/ie6
         0ygA==
X-Forwarded-Encrypted: i=1; AHgh+RqMdPSuQtNk6HJhRPeaWdfh99/xfPUWNoI/yK6O2RgsfhNsflYybWQLxo7nT5bic+gAQ48R9GQxDJlUBTg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJ0p9jYtfseYNbJBgCd9VD1Tf3sZyNJ7hOaTvWPGc3OxWJ39wf
	ONPZ+ek5fSLKmGAzzYQtLMduPN0sEDWAwt+x85mX5NE8P73o1Hz+tpU88Uqm7IXjwKg=
X-Gm-Gg: AR+sD13T0ffjYMi3lm4Q9vt9t2lmd6PDZqBh/PoyD0f4uWOjUF3UyPJMRrZj+p2sBDS
	hJqa9c492GP6NUaX55itZ4Hawog3CU0+Y70IWc17iNZHUuWJuQq3lJGrNTtysdljW3RVLe2PN2x
	GF9wu9fJL9T1dKP3BjmrbLRLzd9n/npQCocgZjvq2rn685TsSjcvz+L/POiHGARyxHNuLlRWeAS
	1RC/DqCCg5hfmAOqHkf4c78A7R9+eoKR5Oo+AeoSHYNO0u3FrHEyv/lCAe80hNNrX5B8Rm7yVu6
	F5yHAJ03YVyPRni+ti16GZ45eHbGshs1zRaSKaYyEHyBJEi78RIkzaPh4yC+wSkvZqv4/Pe5qMp
	4ct6wQYDKStonsFPFM9JJhdqcqmJBGyoyDkRGJLlC+VXmkmYN6WIeCKXlIzbvs48wromcndxduf
	ptc9/5zM+AJuuiBZQl7m5wH5sBb99xjovS8d8lyQa8n7XLXhPJYwNIJ6h5y7KV163tPbKGDP5Pu
	ljAJsLTWAgc90FE+2Lh4kzwLpD9
X-Received: by 2002:a05:600c:3153:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-4954a41382fmr284426115e9.39.1784733327405;
        Wed, 22 Jul 2026 08:15:27 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm70595615e9.6.2026.07.22.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:15:26 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v2 1/2] ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe
Date: Wed, 22 Jul 2026 15:11:57 +0000
Message-ID: <a283420c1fb6a99df5331e078c7f15b3c97822c6.1784732161.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1784732161.git.gregoire.layet@9elements.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
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
 drivers/char/ipmi/kcs_bmc_aspeed.c | 39 ++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index a13a3470c17a..4d93af2455b8 100644
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
 
@@ -191,6 +197,9 @@ static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
 	case 4:
 		regmap_update_bits(priv->map, LPC_HICRC, LPC_HICRC_IRQXE4, LPC_HICRC_IRQXE4);
 		break;
+	case 5:
+		regmap_update_bits(priv->map, PCIE_LPC_HICRC, LPC_HICRC_IRQXE4, LPC_HICRC_IRQXE4);
+		break;
 	default:
 		break;
 	}
@@ -278,6 +287,14 @@ static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2],
 
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
@@ -344,6 +361,11 @@ static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u
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
@@ -373,6 +395,9 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enabl
 	case 4:
 		regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_LPC4E, enable * LPC_HICRB_LPC4E);
 		return;
+	case 5:
+		regmap_update_bits(priv->map, PCIE_LPC_HICRB, LPC_HICRB_LPC4E, enable * LPC_HICRB_LPC4E);
+		return;
 	default:
 		pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
 		return;
@@ -452,6 +477,10 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
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
@@ -492,6 +521,7 @@ static const struct kcs_ioreg ast_kcs_bmc_ioregs[KCS_CHANNEL_MAX] = {
 	{ .idr = LPC_IDR2, .odr = LPC_ODR2, .str = LPC_STR2 },
 	{ .idr = LPC_IDR3, .odr = LPC_ODR3, .str = LPC_STR3 },
 	{ .idr = LPC_IDR4, .odr = LPC_ODR4, .str = LPC_STR4 },
+	{ .idr = PCIE_LPC_IDR4, .odr = PCIE_LPC_ODR4, .str = PCIE_LPC_STR4 },
 };
 
 static int aspeed_kcs_of_get_channel(struct platform_device *pdev)
@@ -575,11 +605,16 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
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


