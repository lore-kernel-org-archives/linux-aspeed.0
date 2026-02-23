Return-Path: <linux-aspeed+bounces-3537-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3D1EEC2A8
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:00:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbtT1Sg3z3c9M;
	Tue, 24 Feb 2026 10:00:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845470;
	cv=none; b=inQvisKkjwEP1IiLHKeiqLrRpOrg2U9+liMJgZ25qPFQop1dAKuanfeVxGOxi16FMlPX4jpp656esveh4Y25HuPvqTxrxy7739I8HUCxD+FwMbqgDuVf+qTgkzHZssDxiHzkomW9lZYC/TY6NVvl8p0VsNGrfQq5mmO4a7A+bAhZRqahMT4nWQEWMxkSzX6w6DXGeFD5PofjpFYXStXs2bbrTVqEZp8Nu1dplkIwiDPwtffxd9juRdH+Pxkf0dVGHgudHzuKnIJ/j2VCGt1OGOxGVlkY7kmnYeHD1+TOUHyB9gMHPduOEUV36QKLmYWnvhoFD2MIAk1iV18mEgMkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845470; c=relaxed/relaxed;
	bh=5wwrI25iLIFnHM5KoM7IfI6VZoQcq26sDFnBNFy9YZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUBxRDIcIZoPgQjhqASMBjk92dEhCV+bI21UejlbiLPX2/GGsmTYJv0VL5dpKIGDDlhcN2uQDyVb0TPCcEbLMolrxfhrcgu6gouvQefzkOMK6cjeQCGLb1XI767pKgG8ILTe0TEBRQEF/t7/cjR+SXq2+JqxfT2IpJOFyy4d2j38QkJtJh3hgVkiKYVuIEf0vVWBpakR5FI0KTynnfqMuKH7nscIizmSDhLSyriiIna35njkK1Pkj1S0cadXv/IzDNDWZEtFRskzOsdfdPLTAwfDjA3eoA8SoOIdHs6a9Cvq7J7MvG+6j4eydaJ41kTft/fJRR08SgpL7YDaMlVq/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AXo7/NMF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AXo7/NMF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHL0MnTz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:17:49 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2a9296b3926so28478815ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845468; x=1772450268; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wwrI25iLIFnHM5KoM7IfI6VZoQcq26sDFnBNFy9YZM=;
        b=AXo7/NMFigp8fJQa5JBjizzyP46h0tU+PUYpKkhrM/yqsuCpCcFvHsTq7IvDJMN1IM
         L2u2J38amsHGuK70fq1EQxf8henmYzGk2ZTFa+dVy1VE9i8qWZPM7FLVVco5ucWz9YX0
         sVAQ0bSztyrpR9Ctph4lMslc2+DoMPXrjrBHHFksurciaNN9CC8SyZ9epPCfLfrfX54m
         9jFk+mmLQuFgZScUwV4Dp13r9IWHE371lNm73pPfip04zqqVCPdu1SKsOyY2lp7GoU6b
         orWGVKJstFv9ZBEYiSH0aUNaiP63LUGQwjUlLe9HYrVNI45A+AsWlBe0EwrF9QnwRVj2
         Z6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845468; x=1772450268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5wwrI25iLIFnHM5KoM7IfI6VZoQcq26sDFnBNFy9YZM=;
        b=jbrRAn73LX25OqX7G3fi/cFzPkcKvRPcTgpUmY9i0LdLooP1haeFsvXCXBd0YjYiy5
         cztqAhp5Dj56RK+QFgVo7ax2V1C9hsBsZ8b2oxBrZOY7BklDci54gkH21l31UT/wyQnb
         FQdwJzYaDLnig+zQYwVOGJONINJVo1v+3b6Y0Wjobv6AnnO7hEm7SUSeF8E4I8E+eLbC
         W5qM7ErQTV58JbFAB6bXp1o4hSqqZoed0Ay/1yTtEfNh+5+4ZxCmJ70hS43AWkHmNz7k
         LDva54r1wiFS/UktqHFNZBgEw1i+/UuMJOD48t3QtCJlTxDOcOe5X7d+Xf4ZldFIgrGd
         oTnA==
X-Forwarded-Encrypted: i=1; AJvYcCXzvH+i63JLXJCvVueSIilRSrUt3S2BzX0fa/JcXgFVtMoSZ05DqPU6h1wCXTq0aUG+D/OBMHZuAHn13bY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzr//GCPvNDR+JpNAyBIOkWqKXwvcoEaGl8rttmlQVKXr4QVFY6
	8bKwduyYH/xAMI7xzmVwiNXiyh2ecasYndTj+rV2Fwj3wcu6fA+f2ucA
X-Gm-Gg: ATEYQzyb4U8xPhMFjPJ1BJjXczmqEPF7QvsewMktUnlJtW1lZ6YN1MNPSjyCmHcH/jw
	PSQZu/CUkLAM5uQxnJat9gmZVeFPnufyVrxwEQSKk96UsesYWAm4R2ZsgUjEK60Fqov8gDmNNL5
	5vtRIntWf8S86EsurFVoQ+jqnG/MGRv6n6NGDUv5n8ugIucrJnAfH+b/vj65HKBPZ4c1WLPEfyQ
	sS5YMbxLxLHOb+UhixbTkNVrEx7s2JoylPgHyob/bTFW4Fqk94AwLy+9lovz8mF8vfa3iiR6zgh
	rhbu5FPbEwCEC3rP9ZS2YvNl5zizPGF5i2+yAwDhTBnLKEu6kBu0EE2hV3UcXDoCNdi3YuhpDYa
	JiScoYvcB2jO1iCxpTHfkVFffShtfbkn0OnKUoT5GsDcJGEPh59HP6zYjHEvqZKASyakolkXDcO
	6OzC3AD+rjU4mwH0qQZMOatf1ZiKVv2qRqux93Vfr9GTPgHWlIRaisNPSlWtmWRiPOSsI79CFcx
	gVh3DBtq2g8CrZi61PNgN5hJLQoBbHtXiJxf2F/PyXRTat0YkYDbi2n2qYeq7Da//GLfQPxVQwq
	ZCFMAE2PrTP1Afgq4EbpLatIsXazHBo=
X-Received: by 2002:a17:903:1a8f:b0:2aa:f2ce:5ac5 with SMTP id d9443c01a7336-2ad744e0d19mr87934095ad.32.1771845468170;
        Mon, 23 Feb 2026 03:17:48 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:17:47 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:17:35 +0800
Subject: [PATCH v5 3/8] ARM: dts: aspeed: yosemite5: Add new SGPIO line
 names and rename signal
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
Message-Id: <20260223-yv5_revise_dts-v5-3-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
In-Reply-To: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=1856;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=uTj4gapYUMyafJqifSahFMkj6rVicJqXTR5n6i+21+w=;
 b=HNnQYw21qw/5gIdn25f/liNOn6HycN5hMNxj1h1M8Hd4NAbVZdYM4erJQgerztGtI+WIRUPhJ
 K6MsgL/vOYgB5DYpyxQENGiO2ESFXi0de/QBlYMC+SvhKVbWQOME2qa
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add new SGPIO line names for user space monitoring and event logging.

Also rename PADDLE_BD_IOEXP_INT to ALERT_IRQ_PMBUS_PWR2_N to match
hardware naming. The original PADDLE_BD_IOEXP_INT is unused, so this
change does not affect current system functionality.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 31 ++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 45b8ac2e8c65a4f672e64571631b7f6944f26213..983aebc394d9159c7e3db2e7c39e963f7b64c855 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -978,7 +978,7 @@ &sgpiom0 {
 	"E1S_0_BD_IOEXP","",
 	"E1S_1_BD_IOEXP","",
 	/*bit88-bit95*/
-	"PADDLE_BD_IOEXP_INT","",
+	"ALERT_IRQ_PMBUS_PWR2_N","",
 	"FM_BOARD_REV_ID0","",
 	"FM_BOARD_REV_ID1","",
 	"FM_BOARD_REV_ID2","",
@@ -991,16 +991,37 @@ &sgpiom0 {
 	"PRSNT_BOOT_N_FF","",
 	"PRSNT_MCIO1A_N_FF","",
 	"NIC_PRSNT_N","",
-	"","",
+	"FM_CPU_BMC_RST_N","",
 	"","",
 	"","",
 	"","",
 	/*bit104-bit111*/
-	"","","","","","","","","","","","","","","","",
+	"MASTER_PWR_EN","",
+	"MASTER_PWR2_EN","",
+	"PRSNT_MCIO0A_E1S0_N","",
+	"","",
+	"PRSNT_MCIO0A_E1S1_N","",
+	"","",
+	"","",
+	"Fault","",
 	/*bit112-bit119*/
-	"","","","","","","","","","","","","","","","",
+	"FM_CPLD_RSVD_MCIO0A_SB1","",
+	"FM_CPLD_RSVD_MCIO0A_SB2","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
 	/*bit120-bit127*/
-	"","","","","","","","","","","","","","","","";
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","";
 	status = "okay";
 };
 

-- 
2.53.0


