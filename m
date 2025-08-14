Return-Path: <linux-aspeed+bounces-1966-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7ECCA0EDC
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 Aug 2025 23:51:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c327h3Z92z3bTf;
	Fri, 15 Aug 2025 09:51:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755177440;
	cv=none; b=ZLTdTtNXmr9glNo6HLddFGWLPE6WuVgDAGiYNjXq1EZnQstO7A18I7Se11MaRwLKi8VobjzVeAJzRAVucfEpQwUEAHQL/+Lb/q+3H5qGcjOZlU+NltJrbFjXsZSqdDtDKtWQMKpxflOfkHqRHrXoCu4b4/wQpNuSsCQwsUp+IoFai+tcB/GkBiCMt5Uie+qHDn0X+82LmIRyuzm4Ohn1AKBx5JWBGiTlJr0wkvMsXHNxHQxPYdPb0ie+yMmLMsDmy8v11PYQn5zp6XSmpCT1JexfAW7gN18itTCaPYnQYVY4ItRaw0YLhuVdCY5nc6/30W5P+lbnjArHP1/NzY2SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755177440; c=relaxed/relaxed;
	bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUvXmiCfj8f3sSIhLRSZVfK+VWkWEI9/8Fv3vM7/h/7GRANaUHPVlWQ0MQULB8Opngs4p7ZrsCaTZSGWZTSxWq7yF561mfLC/QX+2GPXcqKfe+sDP6DxuKzGRotGzLylDqmP2HK4DuZ2BC7YSZrXs7pOz3gX130GWrjYAfn4GWh0QXOnt4YK+uCEuS7JJ0lX1hCGYwzPQeUsWgUp26N1Vd2i0L8UjwoHTOEz0X4H99fTTc6gfNA5P9k3FLXEpeoArueCGLZz8UmM2kaL7Nx4TgzRU0v/Xq0wdCYtYvgU4ESFYpRryb3R4TQfQG1eNZ/1eDImATqx00td6LtEmRG7Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OgHY/55I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OgHY/55I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2m4H6yTcz30W5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 23:17:19 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-24457f47000so7344185ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177438; x=1755782238; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=OgHY/55IoECPUmEl1UdqFCxPrKWDNNJ7ZQbTujN5BIIqz6fMcZngIF6g8HcpxYoFpD
         Mmom93WPqgkxYrFvwQQevBSMhEeMDEnjV0kOLAoF7460IW2UVMfxqQupbuhZ+WFJajxh
         rSrLpZ7MdYSZKdMPVmBSkVBXbZXzGVlaTdYQLZIRgCDRF9TpB2OreyXY7FOkvTxke5Pu
         sdMc/dpL0u6kEyE9JJ4U9b2ooY73zqtAvSQVjlUrLc5viL7uVi5+t1Q7GdUo6qs2FDk6
         mzzVBKVJy0VU7wPhJ+QYw66tuHuiJdf5dEFtejy0hRN4Sa23U5l2rGcGsl/HUcPKYSw8
         HnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177438; x=1755782238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=j4/HCtzYyi8yNbkbSPCetM+hVycndQ/QfbjRCGpftVO1WI0dn5TZsmSgv/hw36qnvv
         aGS69OQu+8u8uarcg4d0naiKNnhb18w9E5W0w+Sij+v8l99HNX/XlDuskrVZH3ivkV9e
         TRGBDmBPrNP19po1mYVTrWr7JNgI801HSt6gCfWBfjpBdS6vvWz0/MNS7+0VoakScAdi
         QZKQ7GEv4It7Msw/rLYqJMvALuNLx75gABcHQbnWb4Ala225OxmRFeu3MSEuDXORlhG5
         Xieqb4JG7etMUXkKRZ30QQnT2QCzYqtqmivU/FOd8IWsVYaBrVOo2eDgrOkNQQdWH4Jy
         gL9A==
X-Forwarded-Encrypted: i=1; AJvYcCXhMfnvJ3Nbs27JbrcaE7IRgm6yZZzR34A0aC+D/JM2m9wTMd5XjraQLDgIt7iCll0os/SKcoyjtCN27Hk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5Bjs+CohkYnNywyDiGUAXsv6B1kJ4eQFk7O5dJ1jsOaGCbHaJ
	5ot1UW/R2ekTQonjiPuxCMrEztJxEVZ1ZEsvs4M7EkhSSl5jYiW0+mgWiu51Bg==
X-Gm-Gg: ASbGnct14G5e15mhkS7F9OHRLFrr//HpgaJ8zYA8kqCDXKeYCPeX/cg/VFI5h/EDD9A
	UN4WGJU00En09XpfgucnhdHSsCAOVaxS/Vs/SAEhtmE3Gs2E4QpyEWJ6xBDr2Z8Gh6bHShYhLF6
	He1ejQWtL1d21CNc9X50LiTT8jR6FN7I1U/YsMEf5hhVIoqvCASZiYJyFfnNXWec+9mz1ePPW+1
	Iblbmds6K5cGH+ZugQWaaE4L2fZ05miCPd+a3s85kZHSUGi5Ej1QAFkWLDmH6a7SVWhZ5CYy+Nc
	7DJ0saOnUPLYNnQfv2K+674CCiGIL5MjTNMD8q+ZsNIqM9xvoEy58chogQN9U1nxRNqKcn89/X9
	8xXDhiBatZgDTRmxjHOL/gAJDiIYvoZ1fyH3McJpmTITkphnrpixd9oBrXEMOzymZTjJ6vseZXC
	6tAxLtUoRDE8M=
X-Google-Smtp-Source: AGHT+IHJTBWuxjynBe00sfTNegD+JzVwhghLenRNVmzvPfO9IQgdbzp+OP9LwO/SXZV/Xcl6IoJ+jQ==
X-Received: by 2002:a17:903:3c2f:b0:240:3e40:43b0 with SMTP id d9443c01a7336-244586c262fmr43696825ad.43.1755177437402;
        Thu, 14 Aug 2025 06:17:17 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:17 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Thu, 14 Aug 2025 21:16:58 +0800
Message-ID: <20250814131706.1567067-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add the mctp-controller property and MCTP node to enable frontend NIC
management via PLDM over MCTP.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2f5712e9ba9f..ed30f3bf61a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1248,8 +1248,16 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		label = "mb_nic0_mctp";
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


