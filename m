Return-Path: <linux-aspeed+bounces-1643-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1B0C83F0C
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5C1Y2bz2yRD;
	Sun,  6 Jul 2025 14:24:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775855;
	cv=none; b=DAqY2h/QplPBbaWBvp42IpVl1WHaRSGavsyUsUYPHxMLOHGoPCWa5ScSrLI8cVrHy6RZxK/qVqa2Mv5uD8PTf2gHS8gmfiQKlssNZkphEu8cRxHnGwzEqYjK0cDaCDtOWB+j5L0lCQnunjS/6GrzzFnC1AoGqlJKoahQ6yxY2He1QrrNRMLLhMnPFasCKMSFisIZyFhSFPtemWpZ6Raf7KCU7lhV7kfz/eZJwIfstgQpMGqUVc4CzXKVOt40QDFIY+Ac8M1FgyC9WQhEdISVia8oa3Mc0D94skGnS8wFv52/4AwY1AyeYc9TyTYFIWgyV2glVBJivkOAFpRDjAXh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775855; c=relaxed/relaxed;
	bh=8Q7LJMY8xVzffKNJ4NYk1OAivwG9rzCLSSHWqEjhDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak1c9qZLft1n1CQuNyD64EpNyd1Noxbz6E6nqyRDjgn3R3RW3w2jS4bAwZZIxZH0rxXw+JQ9aJIWF0Dgjkpg1qyH13KV1sOU28Q8LKHXWUSTRdwHasWq3t+B54T0NoZBHuPlx9hIYhvonzbhcOWKDtpyshK8nWNTcOK/2CHgQ2W1FGUA3dTrgjOboZ+IA9gilIUfSL5ftscJZ0WtozcmJOKIqZ5I+BSSBQAwOs0d7ui3/PzwMXD3jHO28C7h7ATMNoLorOFrPP+Ej8WwvVT+z7zwL3/rtoWo04plcLo2CV0B08ARFnIFZoEvrJOij1afw1tNfvSts5lKT5opPu0pxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xrw5mKqi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xrw5mKqi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5B3fqjz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:14 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2416643b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775852; x=1752380652; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q7LJMY8xVzffKNJ4NYk1OAivwG9rzCLSSHWqEjhDJY=;
        b=Xrw5mKqidZ1vgTaRiK04ORfi9HOYVjI6nOebgmK0ctvMg/TWOHt3hflCFud3POqD8f
         DGrUsIE4o5AUzFzIYL/QFqcy0hxDoqVF7J8u5jmc4cKaHAYcisMfXbhl57PUUUymKKop
         hV8zbmi3h8OexmnSMW0BY8VAc16/GHj/VfULp3lf4luCeLcJQkBUUi4uDNAuUDIpP+xG
         AWzyZZv37Z8ldm06TnYJ4XM6WVv2kUvZKnofLLHplv3ZI/HixhtHukfGJIu+m+19+bks
         QWdiH4dHymefNhJJKxwk0/fuzoN61BvPDp36TdsYkmN5oZa/stH+qVfjIPLoRyQMbill
         cjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775852; x=1752380652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Q7LJMY8xVzffKNJ4NYk1OAivwG9rzCLSSHWqEjhDJY=;
        b=oK/ATnxb06AfcwIApT2IPfWVjarMbPs+BuPjeSUZ0Vaibxc9PNnQG1O+VCOrqw4Lqf
         Efn8YEHiZrbG3n7GTLglv5uTQ1QKQ34R/3fc451bbdv8poz8V+qJ4LLvTfImcuvIS7Ei
         4e3vRWL2Gx3IFGMDeCESVkdQgFqA0F4nVrzN681HAaz21Ua/8EyFelbiXu7KMx9VHALh
         2qsOaKEjp/03D0UxIkjxY95nDXAUBpZT//+7qx91Fv2CBq2xNrGs6sZzpfnmcal/LPOP
         Tl+xhKyNVn/7Y1N227NhVZlq8wwl/fRQhhmPmDiCVa2nepcyMngU1Lonz6hdaYlNucQV
         ckwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNJ+s6Zx3wQLl10ZompbsEBaXZLPtDMB5pA+Ix+HlBDnvqFgkzwA+1R9oPRU060izV1adevoLO+VD+wm0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwN0hBgCNIKfe0goBJuPj7bRPAGzFC39YWpjyiZIas9gWAMI6Re
	0qOwb0jYNJVyCtsdF2F7uiLmRV0XGkb/bpavB0t0cNQd6cIGiYgUDBMP
X-Gm-Gg: ASbGnctVaEqLGDzT4pQehxJHbmvHHDT0xRFf2HHac0TCLMaxHNEMWLt454gHLIZf11y
	Z41gF3albYeyTcy/SEn9sfuf2aK/DfM38wR7LGnoLBcZknxAeECcVF6KNwXrO2Fb2CpgbLYRQAJ
	DyJCFvnNE63A34tbAK0RCqFg1otWV2KwBN05fNf5hnRTeoiAgetfncorjgaDkP2Ytyf1UkDFHGn
	/GocJ4rHaVkL/HN+lbWl6FAfluQKoqma1DQugh3OOtnLPRvx+abnaQilG5QXXqJxmOtSqz9Zksd
	/CIqDN2vVtCDFFwr5Nr1UqW+3IJcD+Bi9Go+Rma7Nm/uRyxNHg8V8E85f/d3iB9rDvGjJw9gWmK
	5eIg57+9BY6FsRQ2p4TSj3tmmtBHX1WkgVajabHY=
X-Google-Smtp-Source: AGHT+IHGJwxyT4BPTriGCEWBu4qPg2RzIh4iiJwsvscWuncu9KiKAXa2wtlgAnq/C6Jh5T4u29QO6w==
X-Received: by 2002:a05:6a21:207:b0:228:6699:87ef with SMTP id adf61e73a8af0-22866998812mr1264529637.13.1751775852509;
        Sat, 05 Jul 2025 21:24:12 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:12 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 2/9] ARM: dts: aspeed: fuji: Fix DTB warnings
Date: Sat,  5 Jul 2025 21:23:52 -0700
Message-ID: <20250706042404.138128-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Remove redundant adm1278 properties from fuji dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index f23c26a3441d..840d19d6b1d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -248,8 +248,6 @@ imux16: i2c@0 {
 			adm1278@10 {
 				compatible = "adi,adm1278";
 				reg = <0x10>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				shunt-resistor-micro-ohms = <1500>;
 			};
 		};
@@ -577,8 +575,6 @@ imux67: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
@@ -648,8 +644,6 @@ imux75: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
-- 
2.47.1


