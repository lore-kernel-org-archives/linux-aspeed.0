Return-Path: <linux-aspeed+bounces-111-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A94ED2E9CC
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 09:46:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4Rs675bz2yLV;
	Mon, 11 Nov 2024 20:46:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318361;
	cv=none; b=UOqsloaCoqCVcSzvxSLCvsX2XddcD7FJyBCOLFLj5FUd0EP6++pgU6FWQJy2jk7r15l/i1NWIpNfCv24cyPblHa7QZv81Ydv1Jwsjsyiit0p6MKGwSVow58Clo7N738NUq++mgQNLGnMfJ6fhmxwDmQROAY0V24KBgdlnBQ7fMALSL/jgDY7Ql05KQlfRmUkJ+ICo+C00IDqAyYx+4oXonRcCf9vcz1EhwlP22UtFmPJuQBWTm8zeGDf8JOZOUgyIIv7uotVd9hw9Tf4v7YdtX/lqiPmikzex0P++FebYqk6TPr8orcF8lx79vwXvp7kz8Tgu+rDVx+JEZ3mZDbe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318361; c=relaxed/relaxed;
	bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOe+72J6k4LO8jTDbPl8l/FeR87rVFif91Fgd6iQYh+1+1+0Jh/DxOKUQJOBm5tP9tj/4Xv5xSU+0efGskkb7oYn0lmniHl/h68dz8l1Ec2N5Tjqb8tDCEPQUSO91AqDFhw8W2MkQzfsfNhE+WYDVp5ySC/4G/kxUCnbDx0shXpaZDXnrkNNbh9XQDpRdOruX9EBik97Td034TyI8dFQqUjIb/RAwDtKOz3Jbs6SDXRks2erJRS0tL9tmFlqjud5QXWVLY5P6J8dtkpSHhRPxP8mwlFYouLE+9RhGd6SQv0kbqm7ZRVbHtUQqzkgEWkzb+P8VbL4VhS/7GVkjY20IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FBs3fU0i; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FBs3fU0i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4Rr6mVBz2yG9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 20:46:00 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-20cf6eea3c0so41526785ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318358; x=1731923158; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=FBs3fU0iBKjxR6VSAGQkMuja4TkwZNg+1y/mgjMfT575U4Z/z6FGgOn0TPN/Qc0oHu
         b4432tP0AL8pnT8DgN3WWmsdqPzK5WdR/agVBO8FimEgIpMuaFC99Qle8jdbIAMWDnqv
         XKo3xWuLJbLYhBykUVHR6E9jdm5uljPBI3V3cob+KB3W3fp1C16Hp2bHwXm/Abm1M4Lc
         hrf1exQWB440lXhpQbXrKz4FE6Gfqz34FAioLrxwTWUE7nr3ykiglp+VzoHQJ4Tl27PP
         ueZd7dq1woZSHkcY69IGljo/bDBSZTVVxX+AqJTzFLcCINKZSEQqoQhNcqSEz90LuMbR
         bxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318358; x=1731923158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=uJM0qGo1wUyYtMIdn1fMd+vHSOSbGAEkvcKMFG2oFi1YYVUByIOXOrlhEprdHHCzSF
         xQiWAbbaj5NRadDiwbnD/SDxAhONkZ+b5WH3HHYjyqiJFYlYB6CVD6k/kjWP2bhgz5h2
         f82OQ4NneHAIAes+wHiNiwLNok6vH6Fwv2geeYx0dWaVx0UB7jaFxJV46gT+B2bUP99q
         0QlBOLoWlfGpiLnYfzO4TLtajE5YQ5FeOKMtwUwcquSAVHc2y9BYgyN7UFYPo2xIPlSp
         57WM7MFTuSc0nFuLzMHzhK0m2bSN4uRdMuWItBQlJvR7yWIDWf2mbVCNRmdYeMMRhm3v
         TVsg==
X-Forwarded-Encrypted: i=1; AJvYcCWJt80mu8soUctoIDef4jA7xeD4Wp+nv45G6tUdeRt3h78a8rmMz8uMMBlWGBLQJUe8JXo8erGq8MfW4Fg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLKxkvT92vWNmzn50lvCshZf97bcnzTMLv+k1bsv6B3DgyI2sZ
	9i6KRfKalqExW0XTxV5Dd2uTrPYe0S4PEAf2gB5dcYzlqO33j4KWm/uEhg==
X-Google-Smtp-Source: AGHT+IEduPFER/8zbCIpz3Qeo+YquIeSgZo4edxmkNCTUQhErCW4SvbzAD9W8yw8RfIcEx/aOFKrAg==
X-Received: by 2002:a17:902:db0d:b0:20c:6b11:deef with SMTP id d9443c01a7336-211835bb654mr154930535ad.48.1731318358386;
        Mon, 11 Nov 2024 01:45:58 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:45:58 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: dts: aspeed: Harma: Add retimer device
Date: Mon, 11 Nov 2024 17:43:46 +0800
Message-Id: <20241111094349.2894060-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add pt5161l device in i2c bus12 and bus21.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ccb45ca840cd..fd85d5e34a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -299,6 +299,10 @@ imux21: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			retimer@24 {
+				compatible = "asteralabs,pt5161l";
+				reg = <0x24>;
+			};
 		};
 	};
 };
@@ -429,6 +433,10 @@ eeprom@52 {
 
 &i2c12 {
 	status = "okay";
+	retimer@24 {
+		compatible = "asteralabs,pt5161l";
+		reg = <0x24>;
+	};
 };
 
 &i2c13 {
-- 
2.25.1


