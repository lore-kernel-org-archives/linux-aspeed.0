Return-Path: <linux-aspeed+bounces-2464-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361A4CCD185
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Y45mnzz30Ff;
	Thu, 16 Oct 2025 09:36:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539173;
	cv=none; b=RG3Alp7Xd8W0bhRijp5m9DXge11pPgsHQyq167VUBRK2/djyLCIjaeorl7FehfcLbVsTLKKJKgx86aOLuGmi3Cm6iDUhy2KeXscKzBretWH3mx2TM21BMx9JYRWhkYFco1PjZwo1GK37p/sQ8rzGI/OwFgUzn9JdFzHznlp1U1QZimBj8B1t/gLQuqiJv+DQ6xL5Iimno3RobcpXnVva0/cQ5kJvi+6A1PGHiH/oEd+DuwGNVEAczgkajfZ46Sh8cfRP6F/VRXuVM42SEOx6AWP60F50+i9zaruaiEccUPTF9QoklFcKI032eahatJj7vWlc+9QlW8elGT0w5IM7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539173; c=relaxed/relaxed;
	bh=oianJSkzTRF5G/SQIYeXjnYqhxQJXKeLJMnXmoruyyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM+uhKHkvMod4eYHOOvlUgLl4HryuZQSfDQh4pU2gbd8yvgQ5n2RnO0JFXSsTYTss7u4SCFgAolk8rxlE+y8lwMF3041zy/TfXD58D/KU+WuwvWmkG1RSx3kKTymqqTq/USAKx1spOUN4pi0m0OFwnwmVr65ZqwnZE+6rPoqB7IBncxU8yCZBik9UOLDKo1/Dy3d2QM2TemcLul9vOwCqXpqj58ipeRyRziQ3yDfAu8tBzgHbNLfSAjr65kS2uPPc8hLxdOtZg5veh0/uowkBO1Ma/k68SrOF7nV2X3ifYY4bAjlcsj9d14Bcpp1Q4S7un3xfiy5PaU2mDoJa/9v2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nQgUf7EG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nQgUf7EG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyY00p6z3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:32 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so4335298a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539171; x=1761143971; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oianJSkzTRF5G/SQIYeXjnYqhxQJXKeLJMnXmoruyyw=;
        b=nQgUf7EGzOrQAh6nRo8Ng4TRzVXLE7sdrK08a0WlQms/L4I5hqbsKEN931yO0LUAra
         p+2A2f2T9VN97uwyUvIyIGOGX/tKJP8vMbMiqjGBBoNwhqaXtuD/romGTZkWM0M6utSm
         h8wafLBrihRjrBuwDm9mWhZ+gS20uCSOub5P4Pyk27PUs+vhJ/UoYB35YdDIgR3Jk7G7
         gTm9Z6OEqVUj1+PyYSfyP7tXqY5t6rQ5oKEx/N+ehvTqzcvEvKoEq2l+m2QB48EtCkSc
         PkuNvZcczHoEIUYCtC8b4VAWfG/HilMsxEhu/JSw6L/5E5LUVAXDbr+G+Yq060x1+XOM
         0rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539171; x=1761143971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oianJSkzTRF5G/SQIYeXjnYqhxQJXKeLJMnXmoruyyw=;
        b=dx7z8/5/M+zPrQ4F4wpZb9i8fJA99XkJ8m0iGfG3Wy1BtxV8nf5oDtjmu52pFS6PoG
         2y2x7bYVpu0CLEHfQNgWhmj3rcKQJ/eRLOqih/0xiMpm+iDqEz8uf68pjWnxAy3y+ic0
         onE8evqBxtJlMAQ+khRMbUE60d+EHe91oJ0JiwhyH5JFDxH0bqn9QEmNFIphuVnkiycw
         h+A/TEbNoJmWjIpB/JeizpEQUjL4PDb/PpelcHPPYk3MtmIGffJFXFTTPEyPaGzMjmXq
         Wa1lTo0M/FpZOWnEbR1Jyhrmc9ocWJTu9cBPE8AaRITwCkk9UXxh0cKBabyUjRwOgp27
         ejrg==
X-Forwarded-Encrypted: i=1; AJvYcCWkek4XJ3de8SC/Z2k1hw3+XinEUkHzVu63YBoGIBkRwFnXvLZSUnvrbQoQEYbByoze45OTmlPvF9kViN0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyudNgnJZu2gyr++dRs5wvmZ8IWsRxBotuZI7IGa7mcalWBEaxk
	4eFsEjRr30JXYSXoat9KUIY6nLf9i0O8j3zPpk38iuxwn3LX7U8sftFP
X-Gm-Gg: ASbGnctLEktvcO5hwXhh/dQBHbqiQcCQTkAJcAz9jRTFPtYZ8mdO90NfEbi6tD++k9c
	/dFUdRi3bbznZdgHR0FqVzGmXatIrteDcxcr1z1TfvSlrB4LaHLOZUuoaChNM5XDYO+6kLJO/d4
	0f5rnFgk17sYbIy3A3wBN6OnZTShEpu+/bxPXHAXYVuNbF2S2eVYQn/Bv+ADHkIvwxofgIfKkBe
	xRFtAJX0JnNxkD+aJd+NyglKSb2qkmMDnziCRY7FaQG9Np0VQE8KHSqEofyY9BwBl+P4rdWx34J
	P+uUGoiZSmmiMY3q/fdrJK8pbBTFNWZ88ZP7CZR4xbTkoHmd99iJz2oIxGphjgweBtRK5gwAQM6
	XXFmP5XrqynOjhiEnbERE9nx1gWMAArPY7GXNat25IG3ZoR7CSLkkt51SeBnMa67TjajjPl6p3R
	cs+qiEjJxwHqlKWqfqaPrC5GfK8w2PXHMq5Ij6hpE8aqye0Bwl/vqvMRoocX/kw02a
X-Google-Smtp-Source: AGHT+IHQV5VLlGEJEx4nThpYETPXzWBCwzYZ1PXelEFJYlRZ0x4BxIFfLFgQXf99ujEGLB1D9HXqKQ==
X-Received: by 2002:a17:903:9cb:b0:266:702a:616b with SMTP id d9443c01a7336-290273799bdmr348708855ad.18.1760539171032;
        Wed, 15 Oct 2025 07:39:31 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:30 -0700 (PDT)
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
Subject: [PATCH v4 3/7] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Wed, 15 Oct 2025 22:38:59 +0800
Message-ID: <20251015143916.1850450-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
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
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 89b18afe2b00..b190ab344aa7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1279,8 +1279,15 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


