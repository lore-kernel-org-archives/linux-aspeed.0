Return-Path: <linux-aspeed+bounces-1613-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF365C8303F
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX79Y40pqz30FR;
	Wed,  2 Jul 2025 15:04:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751432673;
	cv=none; b=eawwfPSCpFau3gnjQL0I0jixB5NNlX0hNQxXmC4u+4jToFpJklTTiRnz3+Z3SpF6Lox7AWXMduGqe20Xa6GLdHsJ/MyygTETWDXfxQyCuptrD7F2j5XLKmjYgpKA1nAFFo4DAQ0qCR3uubNEjZWVxEIdUDQqvlgDf4Bh6JkaaguTW4Mvzv3QiHM19iF3AJFHWVU9RCb/af9tE7vozdc0v+4PCXbkpSb6uA3gp6gKt0s+2RP6E4a0EjP1aTyAFSo6FHvZsgFizLxIaaZQmUwr/YpXh3ewMFW8xkiUEOgSAFrXL9soddZoHDtM4ahRwOCX2R/kC5mC4L76m052LL0ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751432673; c=relaxed/relaxed;
	bh=zQrj9G+pYLe79Y4PNdw8/vBJhfuXZd5KMGob89u/rGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv//63ivhzZ4NHPourwxCfjTflmfdCrK+2fT7ZXlMWoxvO2Tg4y4YvZ21vyEeGFbTOLqBWaXjNM9ia3fEZvAeJGs7/7rMBfvvyzmtwapPgGnGKvBkixSW3/IXZz3uYeg2uHh378fNjkYCfxALRQKCP1UPxNU1wqLz10h5t9ADJK1Cmfpt//YyXBQ+J1otbxtp1FsneCjlSy3VCR5jXwZfTuqR2LY7HEQwqfWk6nxn2TVbOt2cnJGggE1xQ8es37S8uASbVpIvccIR7cUwUIzcpkAKPi5TCkzAq+2hXJYrSyuup3x9djQaLZ5Tba8adFtD+QVuOMaOnaclp9sA/daWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Gny6xMeA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Gny6xMeA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX79X4r7Fz305n
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 15:04:32 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4025229a12.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Jul 2025 22:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751432670; x=1752037470; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQrj9G+pYLe79Y4PNdw8/vBJhfuXZd5KMGob89u/rGQ=;
        b=Gny6xMeA7Pjh6TI+f9hY/wGhGWGfkIZ1ruSoc1veqojWVsyGgjDhk+GRgjnPLqLVJv
         IMMyLFxiYfySsZfstRRgpUk898aLLJDSaFUYC3p4R7DDyZ6cjU3wgFrwgzCT54xFJHDH
         2nOyQ1kk40wyHDAQ8qJwXWQznSNKocP3SzswQgkOTLHSJL5Ma9BKAa7f0yPjyrfQOkgk
         wv/YZszJYFOdjEkybSI95LTPTTOFshSoxGz+fSzQU3OFTouJ6ekBQK3ZjvmmiXg2ebmJ
         WOal4nJWki8UjnCkRqVeNyhiwm2eSwntW2WFzwg9lOzT+o+ewOgsaCYFM14wmaFpYlyl
         GbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432670; x=1752037470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQrj9G+pYLe79Y4PNdw8/vBJhfuXZd5KMGob89u/rGQ=;
        b=XPE8ofHFDnV+TFSoU0JCIjq6GIeHC6WDwv5YraYMyrtuGRfHvldtj45Dr8hfzTtLuC
         NGH6msyVA+96ZA/7yhpJvjuB/bZ52uUIJuy9BqP6Wcdzpxc/4Ls4CbDRl+RCyw2p6bXH
         abqG+kdocjSjMiIxiK3n2zhIh7rIIQo5UJpr7ycdSo7KvxgDUOylUbmpUS1+cRK+4iPz
         /dnzJ6m10Q2ML+TiMSVdAVNenJqK2xTNlnb5jlNTnDuEf4Vht+WK2/xr9lYDUvtTBijO
         Tc673r6DIkQBSS7U5mkvxMaAUbJ1GzC6088BOLqcPmuk9NI+tGeG2AqSPdjY5k+vCJXo
         h/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuTyV57lHdZsE5sURgv3TnK1BbQewjtNk3yi98yf3IUVIY2FKGY2OrSFdXQkhANXYlFhTid7HkP2pggSI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6530V9A+AQ6TYeKasQotgMFvsCFF6Vtr60z+nfchYVP3y9wOp
	+IsaGZ4m3bL0oR4DZbXrUbG9VHyJyc5DDuVI4jq3Qry7WVtMOEMu655T
X-Gm-Gg: ASbGncsV16Cw1D7cIX1VwDaUUv8d4YidpqNghFyoX+1Xjnr2CDCzNhJvs6D01OE8SVY
	5TeykAGof/u7oxg08bkV2AFIKJZTA7iJQJ9liRy9EBOcrQYQJxDRMP/U+f0/hpb5+XuMTNTiZql
	p3dWbw9lDfSqZCJchU1mPSfNOyCzpNXBCK3zumfzdFpnvBxqbIlsr/Lh5dzLCxjHZX7zhQXoll0
	qtBoBTt4kzl1F6zlW/9q9LzXaVEcnDECCrAzGd4oGnOxlEeaq3Bz15Qh3Xil9H1gcm1CB9AJH5C
	o2fdC7RXt14MF18jXvbPKh72ZWaXR2G0Fua2fzKrSij/spMQwLMYq6Ag4+/F0ijwdV3e/cMUV3X
	eHNVdBcWQWL7qGgbHDP+eLze6AaW7bOH1zwzgDXx6h3TCOWGmUQ==
X-Google-Smtp-Source: AGHT+IG/tQYmoUziIZcUILlZBz8yZIswDYIZla/dao7Lol524L9vULDjUhgzMHUYch+zfG8/Vy8Ryw==
X-Received: by 2002:a17:90a:d64e:b0:312:18e:d930 with SMTP id 98e67ed59e1d1-31a90bd4c31mr2059561a91.19.1751432670269;
        Tue, 01 Jul 2025 22:04:30 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm18168323a91.25.2025.07.01.22.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:04:29 -0700 (PDT)
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
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/5] ARM: dts: aspeed: elbert: Enable eMMC device
Date: Tue,  1 Jul 2025 22:04:14 -0700
Message-ID: <20250702050421.13729-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702050421.13729-1-rentao.bupt@gmail.com>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
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

Enable eMMC device in Elbert dts because the eMMC entries were removed
from ast2600-facebook-netbmc-common.dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 74f3c67e0eff..ff1009ea1c49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -201,3 +201,15 @@ fixed-link {
 		full-duplex;
 	};
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
-- 
2.47.1


