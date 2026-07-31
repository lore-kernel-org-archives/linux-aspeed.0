Return-Path: <linux-aspeed+bounces-4597-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42C1C54F54
	for <linux-aspeed@archiver.kernel.org>; Fri, 31 Jul 2026 13:36:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBRt10h0xz2y1F;
	Fri, 31 Jul 2026 23:36:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785504969;
	cv=none; b=g1gg0mewmlVpHtev3hlf5R6R5AbNlpF6217XJeBSihEUTdsByNYdT1BFtQ/tIYP95CNgipbKO9sftLYa/fyS0WbTKI+pshg49NBH3NPAy+OcjPGFXawHqPkJTWXzUeyuuSxK4iTgX1/l4qMllNRTQedQFX27jFf9sxROXc1MvmLjhzluoa3EHS7WRMctsSkZf9Xblk2xrGLpoYoBCP9bfH+10o9iMtihqLxWbyAslh+jIqgLcwXT3Or1ocXgxgCrp3dYFS/5RQoW3ndLeTBSX+cEXPOein3/EV++SstZ/KyIoBi5zux2T2A5lVbJGz46YdM961+XYnD8VDsx+H4roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785504969; c=relaxed/relaxed;
	bh=uduIPrl1I11Bqm2iizUnhzteBLIc++VlIS5E5JRZkT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gUole7k/GaFYw0fotfR8mmukHg/Wr8sb2Y7N5sGJc78CUVcNm8vQv92aK+oEMWO57l2IBRtWa4+qXvms0XUnKJjVCbfvCOeW1BFp2SIbR/3EMlc9Ioxs2/GTN4MdS9as6/os7dxAt+EZMa6ZreUxIKszeS1Vn99hW4P70bgUcaTyonKZKvjZxo3h5kBM0uT4r4CQ+1K6l3mU75Zvy/uudTOYaO/w5cyJQmou3lgFJHVq4ixof5z8NOVJgd7Pc1aYifJ48p5Tsn+wK8iDpTBLSGjW5+btw2DJmFWZ3ovOv2//3jBWiuDC4x+oVobcgRO20qCOQ5AM0NakB6VZIrjGAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iw9ndCjr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iw9ndCjr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBRsy5sMwz2xl5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Jul 2026 23:36:06 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cf27856f9cso9910355ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Jul 2026 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504964; x=1786109764; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uduIPrl1I11Bqm2iizUnhzteBLIc++VlIS5E5JRZkT0=;
        b=iw9ndCjr/FO2vIFSsJbmoPphPVMtFV8qDt5OJeHO5knCWtnai+onARZjbf25OwBV6t
         aJHA178xo3NGgGITmanNgaI6bZ+qz+oFF94eISQsoWcNCb6Kr4rh+R0xEPSWolsOSQwn
         pM8OwpJGe3XZ2E5dXaf9SMSViBHq/EOoVTpwCGI3L1qZCLW67dbh1JdfBScWwlgxwiYD
         WXjc2CSUyQmRWkzK4BeMyCgFAs2do++KuQ+mIPCP6X4Vdfm/InSzTV/AsBPVYe9YcAJC
         67Edn508rSSomskmGhEwEDuX/cBB5zw621We/4aERl/lnXHnkzOYG7X47ADwZUi9L5Ce
         IriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504964; x=1786109764;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uduIPrl1I11Bqm2iizUnhzteBLIc++VlIS5E5JRZkT0=;
        b=HN35qjX5W+mElmKWcviAQSZaWhgf7mzeMF6rwMpnFchkuZ+kk7YcifNjMVq2Wd3lYy
         0z24NzaRaW73pgzgL1FSzfyaLvWuUX4HraAyjoqOPKLquiPPTm9HnnhZAu3gyFRP7ZEF
         vejKsCU291Jx1nMxMGPLrGbvcrHLojSEipc7tbnVM6ZrhzWD3O6aMEe4bvbLMlLkkC37
         GnJfMjvHfF5OxgL9uVoREToosKe2SSyTLhquQ5X+osMEnK3W+ZxGlut7K6Bsq+xRwCZO
         CoNPNeDTpgvurpl5RHySnkWxrOIQU0dvtr1KqcFtd9GPx+uTWz9f2oPK3fLgcn5Pjgj2
         JSwA==
X-Forwarded-Encrypted: i=1; AHgh+RrjcjTjh2lb5kqF2RxTCDskui7rwEGhNzPBAT6dV4mEr5x5tMtB8L7s3k/npHmX6TuUuqD+2daqWLCKiaA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzpdYoj2xIbstfvyr+JiieHv1HvxjEP2fBDZv4YKw/dSrhYyTAS
	5XPjW600FMfCVKOsaO/r/1JZABSKbgQ/840J1v4Unej/bnIk7mBbuRJ7
X-Gm-Gg: AR+sD10BC8XzqCyhQjxiovXa+M99r8zweTnwI42wgNxJniJd5vJh4bYPJu6uD7cqqKI
	b1CqefFRUK7wecOxlOR+3RxP/FDS7s/71g7dsnFNFgTO9dX7XTyWT8HWGC0djh0fT40HKBg+FLN
	+EIEi3LEbcNyQqjnTewC6nLUCoxy8GCAbbrORobOXn3Q6dyGfu9V+avp1fCniZMJQoNu1njqwM5
	0hSumL0z1Dci/XL1SCcYpMVve6EfV/y/TKtcoo7HTZvbk0Au+i9TOVBfVTCruhG/SUmP8ay56ip
	GEyKaIgP5Pco+Z5saEnajD0A6+co4TUq8U0jdmIbond86jIGESkRGmgLOtXt19M2dHWj60OPr8W
	mi6kg1J/+H4tzf64i2sHyw/BpDgbJEoxei7l4VqDtD+4eZFovbiAaYAigMWM4nJiVJcD8ONJcsr
	E1uFvLugcGERe2GDKFFWZd2XCJGiTOu0tvgbjA5SDLqjcYS0eSgjZkNIZAXI4yxl1dpoLJRxq6V
	gZy7GljN+grljBMH4sr8GROofx3tNc=
X-Received: by 2002:a17:903:182:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2d0521e9560mr634015ad.1.1785504963767;
        Fri, 31 Jul 2026 06:36:03 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae196a2sm5621035ad.16.2026.07.31.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:36:03 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 31 Jul 2026 21:33:44 +0800
Subject: [PATCH v2] ARM: dts: aspeed: sanmiguel: Disable HSC nodes
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
Message-Id: <20260731-upstream-sanmiguel-remove-hsc-nodes-v2-1-6a954ea49ba8@gmail.com>
X-B4-Tracking: v=1; b=H4sIADekbGoC/5WOQQ6CMBBFr0K6dswAiVJX3sOwaMsIY2hLOkA0h
 LsLeAKXL3n57y9KKDGJumWLSjSzcAwbFKdMuc6EloCbjVWBxQWvJcI0yJjIeBATPLcT9ZDIx5m
 gEwchNiRgtXa6JIeNtmpbGhI9+X1UHvWPZbIvcuM+vRsdyxjT57gx57v3X3HOIYcnlliRrQyiu
 7fecH920at6XdcvVLZZGOgAAAA=
X-Change-ID: 20260730-upstream-sanmiguel-remove-hsc-nodes-b99c93ec0d9b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785504960; l=2663;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=eyeZF/GOeEoskqfrS05+TdeD1fnc46qKy1AQ7cbiGkU=;
 b=P/nATfAEnRGOJBomjmjs2N4AEqd1gXN+yIgUBZQpk6saBfGRcRI7xQs+RHFrBFJOxYETrt48D
 /NCKAHNgCIdCmz7h+vuw/K4ebvONGPuFhX36F8agP9n4sC1Oc+6gNEH
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

Disable Hot-Swap Controller (HSC) power monitor nodes in the DTS.

Due to design requirements, the HSC driver probing is moved to userspace.
Disabling these nodes in the device tree prevents kernel-level automatic
driver probing and allows userspace to handle HSC device instantiation.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- Set the HSC nodes status disabled instead of removing.
- Link to v1: https://patch.msgid.link/20260730-upstream-sanmiguel-remove-hsc-nodes-v1-1-f0308eb8a00c@gmail.com

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index 3cc6e772cc8c..b4463533d2d2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -445,45 +445,53 @@ &i2c9 {
 	pdb_mps_hsc1: power-monitor@10 {
 		compatible = "mps,mp5926";
 		reg = <0x10>;
+		status = "disabled";
 	};
 
 	pdb_ti_hsc1: power-monitor@11 {
 		compatible = "ti,lm5066i";
 		reg = <0x11>;
 		shunt-resistor-micro-ohms = <1000>;
+		status = "disabled";
 	};
 
 	pdb_mps_hsc2: power-monitor@12 {
 		compatible = "mps,mp5926";
 		reg = <0x12>;
+		status = "disabled";
 	};
 
 	pdb_ti_hsc2: power-monitor@13 {
 		compatible = "ti,lm5066i";
 		reg = <0x13>;
 		shunt-resistor-micro-ohms = <321>;
+		status = "disabled";
 	};
 
 	pdb_mps_hsc3: power-monitor@14 {
 		compatible = "mps,mp5926";
 		reg = <0x14>;
+		status = "disabled";
 	};
 
 	pdb_ti_hsc3: power-monitor@15 {
 		compatible = "ti,lm5066i";
 		reg = <0x15>;
 		shunt-resistor-micro-ohms = <321>;
+		status = "disabled";
 	};
 
 	pdb_mps_hsc4: power-monitor@16 {
 		compatible = "mps,mp5926";
 		reg = <0x16>;
+		status = "disabled";
 	};
 
 	pdb_ti_hsc4: power-monitor@17 {
 		compatible = "ti,lm5066i";
 		reg = <0x17>;
 		shunt-resistor-micro-ohms = <500>;
+		status = "disabled";
 	};
 
 	pdb_ioexp_20: gpio@20 {

---
base-commit: c2b9fc3f7091157518a3ac2282a0a8bc797c227a
change-id: 20260730-upstream-sanmiguel-remove-hsc-nodes-b99c93ec0d9b

Best regards,
--  
Potin Lai <potin.lai.pt@gmail.com>


