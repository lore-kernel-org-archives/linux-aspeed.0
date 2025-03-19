Return-Path: <linux-aspeed+bounces-1070-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ABAC35FFC
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvp86xFTz300B;
	Thu, 20 Mar 2025 03:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742403008;
	cv=none; b=XbNht15S/e7FL5lnv8bkymfjExPreVrff6kjvmh2OJasjLXW6fjqED3CskAMuAJ1hs0FrX0m0daeRNU9aI2Huc0JPbLNkyeoeXdWIEN3v3N7Uge9YvOjJu/5oQOFo4SR18owI5YM6DzVVnL3fB3DkJcHuJQ7FFZpBONqU2Hyc6WMTLQtZ1wzIdPucLfom8qzrCBCQMCgBZoisDDofeAvoVJwybf6oap+cuyXjC/uOSWzyz0895CM5G/TBAg2V/o8X0tR00+TQF9SxyrOZS/U2yKIYTNahBMmogL7DCv5n5VZ8iU3MT/jYz0G2bZJbKE1V3Ly77pe1Sn43i1VMwDpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742403008; c=relaxed/relaxed;
	bh=2hlvFZ7mJmXGztCrB9tJtvEfBnNtJllCq8zyvSsEbwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSv+me1Ui+1KTvWyeRdxHiSm5XfQrT++NwkfCTVweybs+ZL03fyKTRHAM/yGnxvH39W/+JLSqOTJ3903JlhfA1x5wh2DEWlVGGe8pHCx6RX8FfHQZaXbxCX93ASvzmrvrwR05kGzj1pTFR4o4TaZ/3oR3pHGNRpKURYMlLOUv95VeQKTy7R1D0nPKWela0ifZSxyStXVKiL/FVUi8nQUHZLoymFSMY36c7RYWCvTBRFKkVTNzfa2L3V+F48ZjAllBuK4lR/4E7skaJsGXP2FwdiFp2wPdH5avbzhnihIUT9gMdU75Cpc9BQ6tgE4reCtBZTJW1D/vNyEeTnSPCK/yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Niq9AGsf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Niq9AGsf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvp81zvVz2yrp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:50:08 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so2210889a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403007; x=1743007807; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hlvFZ7mJmXGztCrB9tJtvEfBnNtJllCq8zyvSsEbwU=;
        b=Niq9AGsfmb5tbZMvzsnXBCHtmmxKuowJu1B2xf2q6SdhT7U3+NX/tVaJB06mHjZa7R
         uizXOauYVPV0/dPIPBsLRuJVGeV/Y0V1TsEyaPKzXe6PIndnBhrPNxcGoojaMkeIqLE7
         josHsrdyaZbpxf/7Ge2aCACSLMy4HsMCghx1uNDX7DJMdr4546azvalQAdecw/haAgAv
         Bj9m8OSX8ZgejC/9LXoJTnYTR4VO+H+TjslDXT0CbC3XhKS0/3+Y4ROjrnu/5/7bL0NE
         QsJh/uYGieqe1ufAu3oHgsRxdkqtxVHgX3E2WXiXmezrl++aHamRNrjkLkEd9cdYrHkK
         leHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403007; x=1743007807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hlvFZ7mJmXGztCrB9tJtvEfBnNtJllCq8zyvSsEbwU=;
        b=smEs7zag8vir03Sq+WMZG//avhsqwfaI+YWSHCwbejoHBHEoeIybmyGlrQc5BLKJUb
         lsngGw7dzwsL11lb5NIrnhuETsEv2FBgNJa97h7PpxsA6LRytnatgYxAVNZi+qEH3fod
         PUUNJw6AgfGKpGFQdtBHozcPko29m0bzVxOtnKkqP+Z6wzuDEaBSGuQ76+MChoxiHdCV
         0ixOQebiYlp4RX5q6MxI34esRSI0PC+Nt9rvuvgZCwEw95ZoS5SwKyIaklfZGJC/AQdD
         COh8UMZphjTz4C4RZJFIJa+nlmiPng8uiqTVrFUc9LHqMjZudsHucIlWQduIbOhNnBnV
         5b8A==
X-Forwarded-Encrypted: i=1; AJvYcCXtAUp+OXb0IA02fTdoGqqlKmy1ptjn0fv2eJSTTZ2VCKnOMjLPudpj4Wxz39j5vPvK9D10RIf3JKAkBYI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyB2at30sH+yjmru3VfgmMcCb8+dzyAjnQnJQpiMD2yFW2TWFwB
	QXG9L2rsKebXKJEKLdOmQY9xoRVdC5ZEGU6FFQoENkJriUJ2zH+J
X-Gm-Gg: ASbGnct9kS8z2YOzGRSm9NNyQyYs02CaQhxDncRUdScEenNBb9zivHKIa1LfqR32lUG
	7JiPCUqOKxHrD4ApXSftQ08DuNdbV+vUGsxgP8pGGNMRORaYJzFWsK0Oul88tWqykiti4UqSwT5
	nRvFe7IKuGgT9JkbBgqqLz4UDgtlyvqklkmDURN4Bf7ZuXNU2fM0s6TPLYAihjoAzI1QhYTOjxz
	VBuD4lPWEmteUZgycVmPl9c5Ns1nJMWNShDLyADa9y8Kp3YRMwZX35b8o0YEywPJqA5M7vDtWuo
	+anvsz9ZDd0zNPhWOjMRKRydcK94V1DhPVfIUoQe20tZyR38/9tSR7F3EyU31eCf2bJF47ZiYZh
	Sl6/P5iFPMpkVKBJl2Uo4cg==
X-Google-Smtp-Source: AGHT+IGtqikS9EAzHW75N6WWgahv90tvLMFLTPMgePX/nxiz4HcBVay/Xc5zfuHq3w1gvckMkZ6jTw==
X-Received: by 2002:a17:90a:d2cb:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-301d426aa83mr319281a91.3.1742403006734;
        Wed, 19 Mar 2025 09:50:06 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:06 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:27 +0800
Subject: [PATCH v4 6/8] ARM: dts: aspeed: catalina: Add second source HSC
 node support
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-6-7c34b8139014@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=979;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=EmGOWWjDA0fpNSOealsYbgx+a6lgY/GG4Rr46Ji+D/c=;
 b=LM3piKFik6LqjhP+loPzjTwCLNJ3u41AW30F1XD5GbKl2D+juoRBF/cT2O2koL5Efx0o0WRzx
 TbVnsGq7dT1B/g1284v3Q1rAdRyBJNRqQsKv6JiychDpyuECfJWwylY
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the XDP710 Hot-Swap Controller (HSC) to support
the Power Distribution Board (PDB) with a second-source configuration.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index e11be815a6af..fb4b236d36c0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -622,6 +622,14 @@ i2c1mux0ch4: i2c@4 {
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;

-- 
2.31.1


