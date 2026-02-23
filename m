Return-Path: <linux-aspeed+bounces-3536-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413ACEEC2A8
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:00:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbsw3p02z3c95;
	Tue, 24 Feb 2026 10:00:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845476;
	cv=none; b=ZNcNa5mbZ0ItVjtRrjW5VwmTUqytboSrezaEnentKiiB+0s4YwLoISEU48p1bxFcprCe3RSzIDtnUhWwS5gpK4q/662kLbv5OUkzNqR31/E13haN7kCBG+fzaAY5rafXlVlZuz9ofKwKog0S94FYTfP3bpuQkN0goWr/eoz//JyR84RUadN8ps9EB8E5gZmaEzMEHzPPT9J2TNuMq7zSFouNL9lNfatNNPSn0DhXar4wWmbMctaqO6XLIUW7e/PZ1IxJSqo+rn3njgQ2jFMEd8aix90AVO+wTBMlJkhGiXRlW7tFfVvTsjErtcqSA86vNPu/WF3PvLlMa+hK5Qo+og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845476; c=relaxed/relaxed;
	bh=2a5/NI1b3Xz62eOwxI7HWvsJZmIoYETpiMrjetxhsrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3frd+z/1wqksGXy542so7hfQPbIdHLngUnXemspyf9+4yjCLn8+E4k872dX1ikjvYjH7Ra8TEAAe18WTONSGI5JX0dFaJjXXK+8Rvcbz242KZjBPuERAC9SyyNC2bMhbQiHqWNfEMAAIWM2GuqjCgHK2u4nh5g/ZXZa4X+Hn7aXBedh/d0gmf2DX2qLX+KtNY62EIpkZwQPSd0SL1XAJlHwzJp8Q8lmkwyqvtYPJ0/stjcV/MRAa0KhBKVoGP+NMUI1D1E7sn4A2D/NfVqhtyNMQTeD10xagrnpq6h/NhvnpQvM1It5UMxhzEOUpzkgLBOUnRw7JLjmswGYuOTxvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=j3NFWgpd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=j3NFWgpd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHS1dMCz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:17:56 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1519372a12.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845474; x=1772450274; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a5/NI1b3Xz62eOwxI7HWvsJZmIoYETpiMrjetxhsrM=;
        b=j3NFWgpdRtk/H487xi0CoLcXu0SwsdPsbWez5TCScmlJq0TUYYdS9LOV9EV+LKw/hk
         RhJM4xbCMhsC1cq9g06Q4gyih3QPiVvuYETT3gA3EvcUA78JBW7zDbe+8iAnPaizIJOo
         X3H6LpykeRbucCdTxrCTafUNYr8g3kk2Lwjc1y8uI6L4pzZhjdscOEFS4MnszThj8NZw
         TH8pkJFjqGF2DAE822PTCvRwikvdN2nV/2dKXOMj3xBlGmyZfJKZ0/b5tlHTKq8P9WXt
         23HP55JRxhjI3vu86vVyv3JkR5dnUqyua7a8qhBW9CLLpoDxE3sN0WlXXV6ORAezH958
         57gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845474; x=1772450274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2a5/NI1b3Xz62eOwxI7HWvsJZmIoYETpiMrjetxhsrM=;
        b=mXF/vcoCxsjiI4zVzY7h0F10AyuAbbjTzdDwkbYO7t2F6sZ7JP5qk2+6EglNGF8cVv
         AukbHODUJdvTZjZUqsljiIymkp0N7InMLhKxZsMlml27K7BIhvE/jB5wgBdULdpiGKAa
         9IcKM0l+6udBCh9JjhIF18rvPOoPp37JjGbKDNoAZfk3eGIESf9HVA1lw/D2ivHFcU16
         DuFzsdKAZn9C+lIlEmoeBS85nKQ6cfyEG+OhTi9TiGfYrBVow8ps4N6qNcD8A1qeEi1w
         ASTTVukzJize6ubWTUBaCcx28DyUnP+mLn5b5sCn5pn0up/TJR+9n/FDpMEUnV7a5HtB
         S9YA==
X-Forwarded-Encrypted: i=1; AJvYcCWfuCSHc6XSsCOPDuV1mRvrcXfasK28uw2QmyMyRdFDEVitsSELvXQVz4xiBnP/8vKlPK5+Y3mdOLvduJ8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyskrbM8B7c98Dn/hcZ2Acw1NtnWvG2/r/KQVy9NziqQLkvY8h
	9r0NyppYTCJaVs/w67Gw2EtV642ZP8fLd/5/rsVVVTR73SCxUlPS315KaI6g8A==
X-Gm-Gg: ATEYQzy3/UW1HYQDK4EvBDO8oCHV+4FVAP02ddBTUWGlS/eCn+qjGyFXsxiMJJHMd5B
	1+gxZkabSoquGOOtYBwN85EUll9Bl0ry3PO3GZPJ4QCLT1fDqJ7l7tQNE2GUa+t/gRlk+1VyvAI
	3IOf77Lh4BZnry2UrMEDWxA8wmyxbuawNR0bbo2tATsis3dZ7Pl08Qgma9GqYPOvTJUShwNq75d
	xbKDUzIp8yt0Be2hwXeZnj5MQdkJTKgHMzAg3szwcQcVH1CjHFZs3XJ50UmoqqFSemu0S/0aBl+
	plCJlAw4bTj9B2UyepvLMhQKaXI7ckEGxhvFeMQqeVY8pbTf5OIuSIzITxF8BpTVRlR/SSS2Hk2
	xXriQlzNFsw2NyGj0votPXLXEy3JIX2bMy/6EAfDhA4QGMXsE3F74n7OhdzuQtYSFUVpEbDkeqt
	UNC1m8SSppVkiIY8ITNDv9Jl4PdmCPwXUC6IPOGnwUzLsBrw6H9Mt74x9XkQzH880j9ro8ylxqk
	3xtjY46y8uT/7U4dk8MidxcZTw+et+XvzsE3jkaJdK7SIm+MIpN42/ayalqE4cRPc890D8mruId
	PtzqYRHfW9aIHqLoJjTo
X-Received: by 2002:a17:902:e5cb:b0:2aa:e55b:22b9 with SMTP id d9443c01a7336-2ad7455429dmr80003975ad.41.1771845474242;
        Mon, 23 Feb 2026 03:17:54 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:17:54 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:17:37 +0800
Subject: [PATCH v5 5/8] ARM: dts: aspeed: yosemite5: Correct power monitor
 shunt resistor
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
Message-Id: <20260223-yv5_revise_dts-v5-5-fc913e902488@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=2405;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=ixqQRGuzXvJ/yWnzkJIxe9zfdUzHdt5VjvjnntBpEuc=;
 b=rEG1ITCj4xw+8LHWUtz1K9lRGjkpb8uwC29tFg8vEbG1Nztv83RRuY/28KwaccWv+E5EDN7a5
 F7DDcO4w3mXDyQTbjKx+NT2Tdcr3zsA7eLpOO8wKtZtuwQUbVucA3m2
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Correct the shunt resistor values for the power monitor devices in the
Yosemite5 devicetree.

The values originally defined in the DTS do not match the resistor
values populated on the production board. The discrepancy was caused by
using outdated pre-production hardware documentation during the initial
DTS development. As a result, the power and current readings calculated
by the driver were inaccurate.

Update the DTS to reflect the actual resistor values present on the
board so that the reported power and current measurements are correct.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 84d3731b17f7c7c87338672bbcc859de2b89b722..524597a81365ef10cd03b67d35eeb88a965cbe0a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -415,7 +415,7 @@ power-sensor@42 {
 	power-monitor@43 {
 		compatible = "lltc,ltc4287";
 		reg = <0x43>;
-		shunt-resistor-micro-ohms = <250>;
+		shunt-resistor-micro-ohms = <100>;
 	};
 
 	power-sensor@44 {
@@ -461,25 +461,25 @@ eeprom@57 {
 	power-monitor@58 {
 		compatible = "renesas,isl28022";
 		reg = <0x58>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	power-monitor@59 {
 		compatible = "renesas,isl28022";
 		reg = <0x59>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	power-monitor@5a {
 		compatible = "renesas,isl28022";
 		reg = <0x5a>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	power-monitor@5b {
 		compatible = "renesas,isl28022";
 		reg = <0x5b>;
-		shunt-resistor-micro-ohms = <1000>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 
 	psu@5c {
@@ -723,13 +723,13 @@ gpio-expander@21 {
 	power-sensor@40 {
 		compatible = "ti,ina230";
 		reg = <0x40>;
-		shunt-resistor = <2000>;
+		shunt-resistor = <1000>;
 	};
 
 	power-sensor@41 {
 		compatible = "ti,ina230";
 		reg = <0x41>;
-		shunt-resistor = <2000>;
+		shunt-resistor = <1000>;
 	};
 
 	power-sensor@42 {

-- 
2.53.0


