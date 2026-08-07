Return-Path: <linux-aspeed+bounces-4648-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74983C5AC7C
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:32:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcnw5nj7z3c13;
	Fri, 07 Aug 2026 18:32:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091524;
	cv=none; b=MeS2vGEzN1U8O9GflCUpPCoid0H+arBC1V/8Ri4G0J8DOLeqrdivR7ljP/MMatI4YAzmwFkLuMIipJT5mS92n6i5xWL93YgwVSbtN06aPq/+XuV0TN6RJK4GHATFwWpYqpEZ1XFM7AecFHKPC+boiWDofZRTDm+FkXu4qV/andNgQLtKu6LRK0J9vsjG5yrbOQbS5X4RMrcqQfewFsChnx9WNCXSFBzb4wdk73nHorbNmGsZjtHLIbBLkb8MlN0bbpgY4ae9lrA4XSeXuQsDJrvMo4gU3U5loDKbUSzFINW1zAppua3iIi0jkGhQ9kBMpDOPZuJxQHxYnygh0m/kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091524; c=relaxed/relaxed;
	bh=6soMHfgqRF4/fxzi3W7/7Wz7EMGwWasAIJftZ/Eo2FA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIDKqmYfynwtwR/SkMEh+NFA2hpo7rV4UhP0sxDA03FJDX2tQUtKS7rqROkIfUBDNwfhYW8+bVBend/UIHMRcb/qWjM/wBJIR/buMvX6tLJvEnnmZuK5jdXEsTQPlF8P04MsfyNzxXm71CNJUQbA13Cm1KuGaOXG13LAkbpnLNCnF+7Z6u+YO00ndfFkPX6lzX7r7WDLvNBxkrVWLRAx0l5kTlpq4zdhA4fZGVWa24piaBCSsPHdN4WuiyPAnUiQ1aMIiY99I0njV5Vhcr6bCxNxkGCmLVQHa9++E3a7co+YZifxjkETOHg3/F51imXoWc5w2/mSeHKO8m93r7BEqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qUZdfM74; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qUZdfM74;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcnw0j5Kz3c01
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:32:04 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso2879922b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091522; x=1786696322; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6soMHfgqRF4/fxzi3W7/7Wz7EMGwWasAIJftZ/Eo2FA=;
        b=qUZdfM74hHdeMxJUh5m9K3azhyOrfcO3u1yZvTsOMhBqSBJMmMErEsFSvUwe3im9st
         QIkISkRMo26LjN98CZmAcuorhhF2UoVSgNe1udZBsVcPhzamUy9rweZrLVzGss7ogtBt
         /nmshJQAFWSje3QJbmHYr3ZbcmjLXpoKmVQczMBX+vzThQTAAejLW8tot+sivkC39SnN
         tptpimuNm08VoQkQOy4EtLeN0Lm+joPXlq1eAQ0OxqNr4ZSzuVesvOF1kl4oFBNbFLPq
         M8/zB2jWsSWnJ43BSlCf1OylvVe+52mYaPWW6PVnxgLkiieqd/dYHr5+Xx3OdNDocEPm
         HjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091522; x=1786696322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6soMHfgqRF4/fxzi3W7/7Wz7EMGwWasAIJftZ/Eo2FA=;
        b=WuuMhUnTy5z6oAmkw9nuLzzeG4UciqdQl3uudAGvVKsKEkzWkWmQPS2nr3REtqpBY8
         HmRwI+9/HKGI48dOn0bAkdmSNHLXWTImXanFokL7Udk9I5zNv3G/E5qVwktLUypvImPW
         dOGkqBAJVMOcWrHgbRF7GbjoIkUMHNihauH6BOMjcMoxx/E0HLfZA1LKHubsWyEAn/y0
         fDkCn5UOhRx50+nnue/Rwn7m4zZnB2e+fa2HcZ5LyRHdLcaeAQx6KPcRcqBRAZZZIdAN
         2iqkbUzYk8PUIl5ASXSv1+Zf0HbN82DE+BF5sPYpP4cNw3dElLK8sppc8y3WpcaNyX1R
         ed5g==
X-Forwarded-Encrypted: i=1; AHgh+RrzDq8uS339/zjIWf/3tokdOipNnZUpHVkkPdUdbPujthZn6CQq4J0VBI44frnatR0iKhwNOLk1dhnqvmM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0kWiXEm3wLrzOyLRATkMqczF9zQ81lDhZ5IqFxyHnCFGn5dO8
	F9OfTIhVqUodCIAS5BXjLY+Oc6Y1pDg1mzhIp024+N0aRXYGm5ZaRhpIe/+I6A==
X-Gm-Gg: AR+sD1164Oad6Sw9jEiBTla4kzLBt3LqoxBcS3HxQqF7WTC+W13YICZ1zS4Crh+Sj9M
	VkRydYvnkbPeKA38b7vRev3UhyYOwdwq6g4kF118M/2AuaJoYEjvnUQnYSY72QkSWIZFai1tusq
	U0B5lO4TTTM3qbP/FUcnKWz9BwhKM9JHtsvwwkZcnu30cltgCAVt8djqYrg/oHDnO5/JTHp0xXH
	IRlNi8O0lfCUtJi+fjmiVDQDKXR+evgApbQoxwDRFkDK9pBhDFSjRioEkJFdD7NJre5vCKv+LdV
	z0uXPHptZekXTqmeNB4Yh6vP8+VSKdhiNcIJ4SDUpolAg5Ai3MGO+R0ikpl5t6Lz3u+FXt7O6s9
	M6hnDxaefmaRFQDOgnfLCwPnOQ+RIXW9LyCFaeKJNfi4+72ucpChmPPuTQpiEIcztzuFDZm02PB
	Av1miCFwQmXEwel1C3EufZxUQuc1EU91WotZe/6cUWHsLqq4jm5PBAxd7HStf5jgM9CIeupU4lc
	eLnM0IssHOW7dJfvlxvwVHCo8dd8Eo4FLXp0wTotRM989YFGA==
X-Received: by 2002:a05:6a00:808:b0:847:973b:3cf6 with SMTP id d2e1a72fcca58-84f2de720c9mr22542758b3a.0.1786091521938;
        Fri, 07 Aug 2026 01:32:01 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm627409b3a.43.2026.08.07.01.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:32:01 -0700 (PDT)
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
Subject: [PATCH v3 3/5] ARM: dts: aspeed: santabarbara: Add JTAG GPIO line names
Date: Fri,  7 Aug 2026 16:34:06 +0800
Message-ID: <20260807083415.672008-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
References: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
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

Label the GPIO lines used for the CPU JTAG debug interface
(TDI/TCK/TMS/TDO and CPLD DBREQ/TRST). These lines are driven from
userspace via GPIO bit-banging to emulate JTAG signals for CPU
debugging, so naming them lets userspace request the lines by name.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 04fa9a5e0d04..9d334a01d407 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -199,7 +199,9 @@ &gpio0 {
 	/*F0-F7*/	"","","","","","","","",
 	/*G0-G7*/	"FM_MUX1_SEL_R","","","","","","","",
 	/*H0-H7*/	"","","","","","","","",
-	/*I0-I7*/	"","","","","","","","",
+	/*I0-I7*/	"","JTAG_1_BMC_TDI",
+			"JTAG_1_BMC_TCK","JTAG_1_BMC_TMS",
+			"JTAG_1_BMC_TDO","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
 	/*L0-L7*/	"","","","","","","","",
@@ -1911,8 +1913,8 @@ &sgpiom0 {
 	"FM_IOEXP_U541_INT_N","FM_MODULE_PWR_EN_N_3B",
 	/*H4-H7 line 120-127*/
 	"FM_IOEXP_PDB2_U1003_INT_N","FM_MODULE_PWR_EN_N_4B",
-	"","",
-	"","",
+	"","JTAG_CPLD_DBREQ",
+	"","JTAG_CPLD_TRST",
 	"FM_MAIN_PWREN_RMC_EN_ISO_R","",
 	/*I0-I3 line 128-135*/
 	"","","","",
-- 
2.52.0


