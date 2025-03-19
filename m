Return-Path: <linux-aspeed+bounces-1067-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCB3C35FFA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvp11V27z2yqQ;
	Thu, 20 Mar 2025 03:50:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742403001;
	cv=none; b=le4Lky13+Gy7tLTLbZ/ri7bn6Me6hnjoKXhrSsr3ZdthVFusqt8B7FuP3YASAhbUvcwl1JvKrEYH9mabjd83dlo/870dIW+HbacS+V0blVkB/T5TX7C0bdFyF5POMGcJgjDTdmV0XR67zf80thzIRPbOyzg1qx9yRs+FzTSaBo5BUqz5KYwJTTZYGEtEjg/bi7SNZReE9WljPU48gwlCqzVSTmerGX0JSxWGicqw5jzs/Q29Idj3HJYV1NaXNSRItwQ9Z1zWCmhV92vZk+yvnli+Owuodg8mnPC9mgYSlnuQfkrFwRV0pgr3lYQhEKeV6UnysMCDbf/M+tNJgClqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742403001; c=relaxed/relaxed;
	bh=oMF3mmtUwmD4khm3oKxn+aJ/nnA528F+Soa/iVE6C0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5GCZU2vQAQ3WtAorCBKIXLifihSRmm5tuERSzhLWFr2IMgeKabkJe0ne47Ni2mE8zlkVNmpO0BEJztET3US/G+UlZy4Xa8hQ2GZVXu1oww9tvw1zG/yhRZ4ywYWtGx78H1DLPFnevzcJFj7P3LblXojDq9WkfZsjDJ298IpfQaJE6FYnTtSFIaLeskbFbSS8C/t7DB0UJ6hRcWt/f0ubJSYoOcuuyg3oLByP8glml+CiLqsglK+0RAtYukr06wnAlqAsHlLJ0t21FMwKf9A3YrsV6VUx1nwVZWZc/eORIoc5XP5Xx+th1GUJH5vOQ/Udyk/xQfs04eR2Ute8zuFrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UG2XA/7f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UG2XA/7f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvp02td8z2xGw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:50:00 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-224100e9a5cso140113465ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402999; x=1743007799; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMF3mmtUwmD4khm3oKxn+aJ/nnA528F+Soa/iVE6C0c=;
        b=UG2XA/7fKE5a+4d/6ZIvqnz15ZfOXDGMXqC9C/CXOevjBcXib0efX6Di6JvyikEN6X
         vEmoN5bo7CHT5bDlhbQTZhB7HNVejvOO5v2i1aytpEqXcMCTImDOUSqGaC/DrN3MxfGi
         9jnoACjKkkvImWUwX7WPmSKtUg3/K6wt3Ew7OsYpL+4CWWNNarHCtspyKOpV06ptLAFN
         PXFigI9FTpDbVHGMosHlBAjegE015gYA1QtXs/zALEWBiwfNaIbsSnV5IBgV5v7WdvAE
         1E+fLOovaFFmB33Od5lBSy0ro//ImxJBasZtQaMoUJyKxGmDb7aFv91RW+y5vwLnAxfC
         DaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402999; x=1743007799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMF3mmtUwmD4khm3oKxn+aJ/nnA528F+Soa/iVE6C0c=;
        b=UMDO4/uHOr+maFa4ZER83SW3MEUdN+l2uP8/VFxdgkzB7SOl+ngeOBYblJeDXnueW0
         xc/oWEggJQKzK4EHHNoBGkjbocHnFKNT2sKcKhm57QCPBkiUe3pfNyMzDMGp6LjWNLBt
         YiFRa8m0F/1KWl8ldr2lMZmH3iERjyLF+0eRrqkBvVGlV2NCBXTSCfBEztk1LAWfksNX
         6QcFf1OtbE4KeH4aPzt3KBCEZyQqn4Hw9ezfXZg37oBY0f69VOs/sDNodvTDx/TjxmMe
         9cBpGSUfcH10aOdF7KjCJf5GjnNFJOzksp9UP3UFKCub/HWXx8UCnPGpxndMo+tem1Y9
         PnGA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAyKf/wZpGGineaBMCuhz9KIVCT3f8q4KkCaqsVo112ZYjQflAjAxDO7EajjreZ5IqJbaBXAwzreUTWU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwjTVgPPvEq7llSgfSIp+p5QUy3iYWGNrbD3ssOfN+rQQLDLM7T
	W3isvUFYbiRcJhcLzGfJ6zGu6BJ562WmLvaNz7sGmtVgmX5HpA0N
X-Gm-Gg: ASbGnctGjh9W6ms4xX8f+STT06BmiNIkIDA97+38xTe5Z1CX+CcH0jHRxEGjN6pYmkg
	Pjd4yxmW0ECrgLRhKn4ypfHWubGotIgAN5pUm0f5l4HzKPMAtBW2aoJgL812nUJEQc9weBIaKCn
	8GrVayHnfHU+qMRgeNm7z66O/JdR7OsdQAu8JGc38IqAqvlEaP1b8PZ1kNhWfPikYRxMB1oyJSk
	kBtKhLFL0N4lW8+L+0eGluq5gImN1Nn3DTAu1uOITMkUI2L1ttgPdcnoRrCrrekC0WCq1uv0VuE
	at6LNf0OQEDrbH8cA3iqZSpJUhMGSUh1HaV4EhoRjBVoZIj+65Ckf3BukpIQoPCmIDu8A1Xx+Sr
	drETeQEFZEMVsAfsHQq38qw==
X-Google-Smtp-Source: AGHT+IGjgiVPyA5L8/7CTCtOk0Zz6PfpxKffD6G4wKCNeDm6lFH0aMgXYouj2+uALNgBvpYJUDjDpQ==
X-Received: by 2002:a17:90b:3e48:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-301bde580ecmr5237088a91.10.1742402998676;
        Wed, 19 Mar 2025 09:49:58 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:58 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:24 +0800
Subject: [PATCH v4 3/8] ARM: dts: aspeed: catalina: Add MP5990 power sensor
 node
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-3-7c34b8139014@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=843;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=fRj+HqS0/z/8bGgHjoodt0B9Ir0h5V8r9zzaAzc3/NA=;
 b=w7NllEGYLAQNI5dy6Ou6SwtDdfHSy9epo01/OneSo4p26+sdl2YvSaKvr8R1wFWhXByeuM1GA
 lbAyblEy76eDZeJyGe1BTHfH1zULojNUw5W6S1DW1z7zIy5h6FzNTrA
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a device tree node for the MP5990 power sensor to enable monitoring of
the P12V supplying power to the fans.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index b9a7654325f0..db999408e397 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -488,6 +488,10 @@ i2c1mux0ch0: i2c@0 {
 			#size-cells = <0>;
 			reg = <0x0>;
 
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
+			};
 			power-sensor@41 {
 				compatible = "ti,ina238";
 				reg = <0x41>;

-- 
2.31.1


