Return-Path: <linux-aspeed+bounces-4618-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C61FC55822
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 08:19:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFNcF2h5Kz2yLY;
	Wed, 05 Aug 2026 18:19:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785917965;
	cv=none; b=HzwdWBwdcxAoMD4aZNRXfADp/l2kkEn44F4eYBl8R1wrE+pv9oeFQbS3Oza143gIK4g/U84jgLKmO0NZaacKiOSBwsJRvh2haimqlbS/Zdu49rrxeUjKY8GzVyta3dRs7CE8PULBotSA4iD9hMknyz5FpGEe3D909O/e0iLp1biloZQc+bO6WeoL2XFCi9+Ts+dRyTUX20aCimQK90L/6X/4w6pH7JEUNxa9mCnm2UgKFiTx7sIjM5hPHq0NlqXuPn94q7koexqhuf5lOtCQRTJ+6VmSuJw3nqWqOGtpRLzYZDlmONX2hkrg8JvMdhomdkGByn3Wk3HYfu3isY/Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785917965; c=relaxed/relaxed;
	bh=7MzOsUeybMS9dXaNgD2Ggm/YXuUKfNu/EThsAs7XLtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZTPFVF1jyl7A2MM/M+2YwJKmC/iA17E7pk4GKsUdUfGMEqzeS0qM/DLRYp4xR4x53qDCUj2Arlj8ChknNBTwQ6ZkX6MAIZn6r2UcfcOarOmauYo22swIaUJ1O0Pfitgve/bHZe6ZH4bNw11Ud1Lm+JDVMR5B5TWnk8knY7BdAUBTA09hT2OFfKrP5vVJZ4YFjZlWg1W71PBS3XkKE9RTNaNPC0NRTi3a+4WbPFAHN12kRN6b8GQXfoCxpGBf5Nnx096HMpBYddRdQ7prrIEym3pn6p2tBChROWmW2NLJe+RZrY2FYEttJsH8tFjyuMXgWd1uGFp2IOaGG1Z7xucBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=CK5ocRtW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=CK5ocRtW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFNcD45kcz2xl5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 18:19:24 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4954afac04bso7091185e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785917956; x=1786522756; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7MzOsUeybMS9dXaNgD2Ggm/YXuUKfNu/EThsAs7XLtY=;
        b=CK5ocRtWXJZGRSYoidCEWxDV/uOgZlzV1RefEfDcpJDmpwIeEGJOcYmj4kMxd4BvAg
         67/byksay3CHp60I3SSX8pSD2YQmQB7RKq1P9w9CP19ny+9onGZYJy/87hv7TQmzI+bK
         7xFXld071Bfk4WPBBF54wo8I/RmZXK5xhNCkngIuY5gPdCTLXuZ1f+kG5Y7wlbx8NbnJ
         kNy8GXGLaPq/KPtQIpFP0oglDK8VnlPftTnlrFstokaZr5/mxS/EO5IF2H2h8epMGJhq
         eFU8dV6hejenw5A3e2YfmwUyXfn706M2Tt7CYXWIPGx9S5Ug2BkkEdkihiPrOCmM5L5T
         OCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785917956; x=1786522756;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MzOsUeybMS9dXaNgD2Ggm/YXuUKfNu/EThsAs7XLtY=;
        b=Iv4vXQN9/YPW2pPf/1rMZeVKPpioMYdbggNVCFuegRkI9r4f6ROvwpUv/rtjWlIq6G
         vifMXtvd/uTKZNlxs6TmZhGAiUY4VobCwYDcpfwDhikK+g+/m1Yd6UvSPlqzwZN3Shz6
         JBmR/dcrjuBAJDPVVW0uwUQ0E5gcUZriuAkabxKVJKz8NGCjOHTSEPBuKt/aWWfyPkG9
         yax3vmZs6C/2Y/rSubgP6P6iLbvxPzraddf8Elh2mODKPbEIt5m0w+he1ZQmxi6jseR6
         DmmBTy4v7kanxtv2zrAcEJGYI6R7OoJ7xr+TSFuCbgNAGujAxk3B4H0Z34hy9SSMi7AG
         7uFg==
X-Forwarded-Encrypted: i=1; AHgh+RqJLcF0o9r/OIdDXsr1t2MaRQA4ON1xM0atoUmB9sinAVxG0igzQ1eJBWC7k4YRxuuah44/xHFQciEG1fo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyhvlHZIl5UloOyfS8pyPkcicYEN9yWzPUAA8X54kmNQMh5xeWS
	5qliiTk4INr7jIBFUgZ3NLa8SnZo1jkMXh47/+7zrXtNPthFxm2tLO98THzOtSRYS5k=
X-Gm-Gg: AR+sD11kuT4A1/d2GY9m1RazAmgvoYWLxao9j44Qv7LVgl6CQxVhXMMyv6whdxtF4DD
	P5F9e/EWgkJeuCkpZDz7VWHeH95lrFc/XFoDHiyTlxUenEqQ6MDDvT+VpPCp/lAE4OKCrgS5YDb
	1HsDooO3LtPBfyeJa7oo/Bl0RU0tUZzM6kpv33Mfq1OoPVBFXaVxyIgHbgmH5uG7vYHjDTxIbxn
	Q1/Uhg2bVQ4x70XwEsf55GeF3daZ1gDaFGjh1+cEWZ2HT4N0XVGt7HEtCmSilHkveGm/JpwTy8n
	DX7cNmYTRNErKno74BQLPQRoHjDOK2Q2VPsqFh8D6blLupik4bm/hbRZkqtielmPYYRb1EqIP8B
	m6YwkXeMhDbFj+kOUS0xalX67N1bs/0IltADYcSWJIL/UxR/cdPPqjUNfAQ1D9D7XKm+fhvrR/7
	ajMRYt0uqkl2sx6lWAejgw8yzo4PiTkpdCTabluq+kfozqru7z7GIwABJ0dMRpqGqV4t/UCg77m
	6VeAu3uA7hIdvgDKpc6evbgmMKhzExJdapNtV6+Exex8IhnkBQX6ms4kpZOxMlW2+4mNPaKTeNe
X-Received: by 2002:a05:600c:3b22:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-4994e7bb0e5mr48896535e9.10.1785917956009;
        Wed, 05 Aug 2026 01:19:16 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e0356d4sm74745695e9.10.2026.08.05.01.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:19:15 -0700 (PDT)
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
Subject: [PATCH v3 1/2 RESEND] ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe
Date: Wed,  5 Aug 2026 10:19:00 +0200
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
Message-ID: <20260805081900.IM37rUwLGR_JPFyhAlc2VEZVjUhOGHQe7HAnpWdmQEw@z>

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

