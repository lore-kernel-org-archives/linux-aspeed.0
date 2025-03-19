Return-Path: <linux-aspeed+bounces-1072-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606ADC36000
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvpG5G0bz2yrp;
	Thu, 20 Mar 2025 03:50:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742403014;
	cv=none; b=bFhhjGUJEbS4Oe0rcoZn0/G9ctzvN5IvGD4HR6g+7XQyKtxwn+J7Pnfjdxl48myiRP0fyZJKD8lgGt9drsqHZ0uW47Diw/9LJTSoriOy8Xv7RcOv31h7/krWfrHdW4OUldaOstf2xCtGllwdoOoTAVKazCbTB6BMUh+FWbLMqxwM3i2x4zn3ChYcEFDsbm8l+yz4gvylXHd7apllnLa4NFcIMV+Zd5p4728EWqLynByHLN9Q1D8fOjJ3inOGrA/V6WHWYAlC+q3RzRSeMPG72zBh3n1Dzf/WunUOdHxAj6bi+XfBduVf+ZA5fh4s8tYCnX/KBbya/CxwCjOOHw9XpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742403014; c=relaxed/relaxed;
	bh=ktd5HnARwuJ13vsAdMCAO/qEm+OczuyUS4W9n3wx7eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erERu2WRkRnhbHPVlgr6dHBXGzNhIFLZ3+7MvACl2/tm0dYW52/oomDDufIBAkX7gWLfZ5+mDWlQaRuqwm/y0KZepyfk9+aPvCoEHZquAcxHzT+2L5jE2LnLyMAK/hZm/0VUA5kiTwpL8DRtXYoxs/ccmZYmj4kkFinyUI+2G9HA3o5VJjrP3eIC1QmSgmXPJtZ0VYwovGe0GNCx411PQPX/wHJK9wLTarmjycg8ENWTG8IFG9is+i6LViefntNmRJAjYJ/w5TBOwFbWFbpZuHrBraxbMh6wjXVj7EzYSqjp3PXmMXkvVneVo3/ufukD3jcNS+iTrwlkzdqNecdkhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l1Dkxa+E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l1Dkxa+E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvpG0klkz2yqQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:50:13 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso7876980a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403012; x=1743007812; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktd5HnARwuJ13vsAdMCAO/qEm+OczuyUS4W9n3wx7eI=;
        b=l1Dkxa+EuXti2ztTw5YlWh1XEUKXPvStut0lB34gDqNXYjYmMxGOGMlhNzTPLt1+30
         NHviazh0vBJEALszIIcynzB18/SH+T/3tS8o8aKujeZygobw5Jck2K9C6D9ZjbPrLBfN
         zCma7+YV8fAwFNS70V4tyhZ8RRwcwoKXSVivCpOAvNTRNnfJGMu2zw9aGI8oCLG4XpbQ
         ZBRHln8pZz/oO1R56eTeBfqbbAOYZ9ioSuLZetl9oXszncvmCEtdUSMm6zP5W42lXoYm
         CnVZrc5jTFEDvsWD2YJfQ323PXX3TFLID4JL0+k9Maup3l5r1qq1n9Y5OVhmi3pjOYv/
         E0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403012; x=1743007812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktd5HnARwuJ13vsAdMCAO/qEm+OczuyUS4W9n3wx7eI=;
        b=FdZOcxGu1GGqqlFrAsiZbY140Cv0HMRDo/Nl8e9tNmDeO/EhsoixTuLAi0Mxk3TwSQ
         0vfnTNWzsMorJr7+vOknAyOHHWjqO9cBA9buZEj9NcGnnEBEp+Oyw/5dT0PzwN6BwgKv
         x0mQBosn9ndxveuuOZRdwsHrI3V+Jbn2sDrOfaHIA1QdwRNU3Iw1fOyr41C7OEeoG6wT
         Tyv2YJNB/lnXNb2lFTb4AoLCzqlfw+ppGN9OzekUswMijFG/HieVlRFxHaXiNcRSgpin
         yl0MEGnHTy6+3RvFjgEFZCjmzNaIZOLU6I2ACcsQJECFEGAimZ1MUpl4MAEw7x+gKX6e
         eD3g==
X-Forwarded-Encrypted: i=1; AJvYcCWff5c6LvW+0HZO/jS2bKRpDhIj52wMKmMDDL+NxV2f+QMC7ljo7YynLXkieoTSm3QxvGCsDSMO/9rmjQk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxD3wAmOFqJfS/DOmZH23L3X2mDsz7g8YeszIGxJq8t165rLI3a
	D5x50Pp5+XqFd0YVhB1Fs5eM7mmZCQomrPaI28WWK7kENae9mP+S
X-Gm-Gg: ASbGnctThAKzaL9uXgTUFCNIq4HWvEpDyg6JHiUwisQ0rmFiUmQ4aXvK58ukhNf7LSF
	izkSBMHyqB0docT1reppYoMGLQeS3IzKA9ozcf0v4Iu1xM+n2Cy3TB5l4hSn75dFMXyPdoGoEAZ
	4UofmmhN6CkiJx6OOZMMpVcjEyrdx4OMKbD56YlV8dpDdrnG7dw5IHeaRWFifRBMT8M56r4i5G0
	qlWaa6yRHDgLTah6s8OHBcqfhHSJ5cZERRSSfI0cqg6lbcbN3i+agpk4gUlAh0k7MLc/4LuaUK1
	4+ZZJ+4w2ja+J65A/Awy5o0L6fv7jFUzWsC1wnBseMpKQSgmVJL5c+l4C5bOsQc7CDKfAEk3GhK
	UCuBTA/MrIo7UYUxff01pUg==
X-Google-Smtp-Source: AGHT+IGxXevDtQdSFbDZHtjF2RHmeqCAKr0zaFPCSHEdfmgNst33MgVmH/JXly1hqvsrRFBXTDuyMw==
X-Received: by 2002:a17:90b:2647:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-301bde60960mr5555739a91.10.1742403012272;
        Wed, 19 Mar 2025 09:50:12 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:11 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:29 +0800
Subject: [PATCH v4 8/8] ARM: dts: aspeed: catalina: Enable multi-master on
 additional I2C buses
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-8-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1008;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=jtqICxpttL+081MeVsrW0PF8g0r+obZJAZMWsooXIQ0=;
 b=x6Gzmnb1MJYvPzx8ZwKN1PgPtzH5ZXo5LlnNEMXuS0IyPsgHR2WVwVGglPj2osLT16/A3QCp2
 K9s+FG9+ciTAQDpvzrXkOqQ9lzlBFMDWvik3mUz8hcRRxrN+hXsLbaH
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the device tree to enable `multi-master` mode on I2C buses shared
between the host BMC and the NV module with HMC. This ensures proper bus
arbitration and coordination in multi-master environments, preventing
communication conflicts and improving reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 573701bb7fee..c11de5a61912 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -800,6 +800,7 @@ ssif-bmc@10 {
 
 &i2c12 {
 	status = "okay";
+	multi-master;
 
 	// Module 1 FRU EEPROM
 	eeprom@50 {
@@ -810,6 +811,7 @@ eeprom@50 {
 
 &i2c13 {
 	status = "okay";
+	multi-master;
 
 	// Module 0 FRU EEPROM
 	eeprom@50 {

-- 
2.31.1


