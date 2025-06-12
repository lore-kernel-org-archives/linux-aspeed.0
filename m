Return-Path: <linux-aspeed+bounces-1413-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C1C7114C
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 23:01:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJJ194mGlz2ypV;
	Fri, 13 Jun 2025 09:01:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749714694;
	cv=none; b=hvvXaFl2mawKSTMlxFRij2A2JOvD5m8s36QNjv0C4J17RIBNVb8/ht4S9sukeihbHinOPr3Tc17cA2GKqIypqsVkadQuFmaCNW732/beQk4pwKRG3uLp7uBp/6Eg2HTwbDbTMouoMz7ODNWj9t+VhcAwDxnWXS/ayfW1b9cWDlu8JhrYGV3iL05mnTZJ7D/M7bVHIkP8KST3hLnUNqacBiWCionE5QFkDiPxG11SkNAAb1eS/q9gntQ/VoPmLlvTxqXoe8Xj5GH95Lt1HfrPp4h7JfnoQTbKoqFHHX1WndK7hB9OzDejJg2v55FWRiQpgQMvss0FB3vCi3hOd0zMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749714694; c=relaxed/relaxed;
	bh=swocyyVkC1m0yK3KFc05VY0vapacmuONNBylQbQbwQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E1dfA9TYvIgjw84E69LYT8qyRdysl9c41TgCloBGOoOvrKowqJ3x3Ei2f5/h9QMNTyMhUAbkhA7b2aBBmGONU8pF36H+dg7fzlhMjePYZgjNe3lm5eryXbKa3WLQJXXjj98qbuieg8p/wu9Vmb7YsINuR1a7v6MkJ3NSsfnCk/R4FBD0LAoVk1s9jPZP1YRxtlTUmlzN1lfvNXbb0uDoyGuFxkLRNrHJAoQeMHYdpCO0Ost0GhTpKOPZSWy2ZZbimoJUbyY7Zr5V18KciL9WEURfiSdiBTqaDv9o7r+0YeytCQo/UiRTihT4aN9MY7s7teicXlprUKQYgnHUjn9/rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bJtewI6s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ankitchauhan2065@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bJtewI6s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ankitchauhan2065@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHvqT4GBmz2xHT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 17:51:32 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so630837a91.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749714690; x=1750319490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swocyyVkC1m0yK3KFc05VY0vapacmuONNBylQbQbwQM=;
        b=bJtewI6sTpi3iM+/jAZK3DPdjTZvXoby1bYLZsYQUkNPpB+CuZJgItQ3agvmWQXG/m
         FKZBDKEkwgcEwhC2r4kNaImsZs4Wzizfk/97JjUjPmJ7CNvjSlAAa4o4SD2QMR9mhNIT
         oiSShqMYrZ/GrwpxNfQ77wkfFfr5bCXRmA6dwtPaM+dlqdlvUwpsJgeQQUUhOWaEPxa8
         2ZQ6Q94yW2J1L5pujXE/xHhCj2Pv+k0lYVzWGwyHB2rZd704Ku9S3g3TUFwmU+h057kn
         nORXgeoJJVWTbObIttbDF7sfDv+EfJ0jGO4xyGJ11ofgWb8l7e7pR5kZmjIk958/t3RP
         NE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714690; x=1750319490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swocyyVkC1m0yK3KFc05VY0vapacmuONNBylQbQbwQM=;
        b=MQsg54a1mP1rbp0RHinLGIjBw1jXJlJP3z1hC9o5VuzpYSlDBJrsvtWgdPBwXLoZmf
         smMdYXipPhQ23+qy5wUW9zDZ187tun4R7HK27ooEbBWQekiRmYLr8bIY9ttCRd5rdQ7o
         v6eDFZt7NPnu7Q32aiGPbrdwWqoGkZ/Wygy2o7Y1TPLrRFMlxPHQI9Dk6KAkGestIfEm
         TR2eH6egm9boyzX5ZM3yjHoW0lmmg539PP50/ORVkkYoLCNM1AZR6zztEHAWwOZOLKUc
         nMwx40C7Qy8+GmhpDrIGXJI+PLBlcaClnAsMGj4RwxmGsi2nEQLV7RAo+aD9AYl/6uzk
         zxjA==
X-Forwarded-Encrypted: i=1; AJvYcCWUMbxfULpQKiTJzQOcyfsszasphZlXsy0j64E2BdTbpQxTVu8fBXPiYyFNHSu9D9HxT9xsspvBgfDMK7o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywe2L0OxGDNvUpZoQwAQh4xbulwWhfaOuJg17Q+koMvk4oIg+tB
	6zFlaaABUOKiyjX8EXFx6yqgVjqTJHLp4h5dCgoxmL0gifxwNzGX2cb6
X-Gm-Gg: ASbGncsCUqj0IvlAHPP+vFqZ+CTUABGgmcQy+eV2jV0PVbHgO6J7hatMxk/TruSVw8G
	HRKggJbxXgjZz5KUGcEKl4HgT3aDqsO6E3A//V3x3KUxr8nq5+RvB6K1ZixUfceMRr5HHFnz7tf
	AxNu5UNmJeINfrImtu2/mX34j2Tp/MUrl0EoeSYxBaMsPt6q0TUoJRypYtttIhxqTZsR0NXPQww
	Fh7MhO97MrT776xn5vPVa42ajJSHMC8iPKhs4eLAeC6Uhfg7Vap7jcSFQMTNjKvQ0sb8XtROaDj
	k7IsSTpLq78HSkOKjMOthb1tBPV4q1Xlx1tx7gsGeVY/3VlzUV6apEKL/uaKTvHigquqFfedXbi
	TLha+00i1ghfdCE+4Ai36iXE=
X-Google-Smtp-Source: AGHT+IGjalZHIM8I5uIyPD4PFNJrTr3b+7NZ2QJSRfZ+xrOON4O5ngplWUEXGHHBCAbhjmak68v2CA==
X-Received: by 2002:a17:90b:4986:b0:312:e618:bd53 with SMTP id 98e67ed59e1d1-313af1e44a0mr7908723a91.26.1749714690389;
        Thu, 12 Jun 2025 00:51:30 -0700 (PDT)
Received: from ankitchauhan-Legion-5-15ITH6.. ([2405:201:4042:d128:1895:113a:65dd:3ae0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-313c1c4e3b9sm915761a91.29.2025.06.12.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:51:30 -0700 (PDT)
From: Ankit Chauhan <ankitchauhan2065@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ankit Chauhan <ankitchauhan2065@gmail.com>
Subject: [PATCH v2] ARM: dts: aspeed: lanyang: Fix 'lable' typo in LED nodes
Date: Thu, 12 Jun 2025 13:20:57 +0530
Message-Id: <20250612075057.80433-1-ankitchauhan2065@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix an obvious spelling error in the DTS file for the Lanyang BMC
("lable" → "label"). This was reported by bugzilla a few years ago
but never got fixed.

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=205891
Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
---
V1 -> V2: Changed the subject prefix and addressed review comments from Andrew Jeffery
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
index 370738572a55..8b9d382241ff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
@@ -52,12 +52,12 @@ hdd_fault {
 			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
 		};
 		bmc_err {
-			lable = "BMC_fault";
+			label = "BMC_fault";
 			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
 		};
 
 		sys_err {
-			lable = "Sys_fault";
+			label = "Sys_fault";
 			gpios = <&gpio ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.34.1


