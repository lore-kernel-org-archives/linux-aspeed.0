Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C460A261D
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F03pacGm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPY6g03HSz2y8p;
	Wed, 11 Nov 2026 17:10:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794377450;
	cv=none; b=n46Gyxzg7jmXjhKYbVJpQHURQ7tLAvMFafmYHP632IVBHtK4/4kcnLBGFeHDvaA1bOH2Sk1Mth3JPozOdYmjDo8hc3+BbAQv52tcOavwpTwQGu80cV3iKsgN4fEVNa0OTt4bAWWa/4/IeNBGC/1P75jNPyqaCw3VFegGPLOzy+U1pmCOFRsj1wopKYvthQE6tKK89JHKus8PdnLT6ZBAWnpdCvaR3f7WtAyFcmEdFjeU7kHal0oted+fwbbMJnRFO7lVGkCbBZUfqztXW2FOqkzObdYXFcMZYd6drkrnFTugy5EA7LhE5yb+4F08kprvGPD887JPc0Ed8Fkn8wUegw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794377450; c=relaxed/relaxed;
	bh=zOej3OSGWxWCJ3XeVUCQdSFsxuuEIjtPwatxLCH1n94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FygN2EeHCfrGVwhuLuFeNqFD4K6WK4MTXHsG3kXY9F42fxuRtVhtQl9KO2TdLwTxsImvrVCd0QKWUgSnxwYKVsNIsdfCBHN/bxUS7+yqcgcdKEpdiL/LhvTOZ4YPCJTvHFb6FvNQhunSnU0tIpZ79T5jR/bPKpY2FIyTbeOA3LfzmxeVJkns4n7SXvA7EN7D36UlJMXjVvub0CHt+Y6F3A6max31HyhbX8lwuwyIB/w8pRzRD8EnzDpLxQcvhHOpAUyvgcc48zARPIr2eeX0ACSLEjssy9Sq7/WSo9cBbmmAeaz6TLEMiN9bIFVEoW/x4/dzOE+HZSBsEvIpIornVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F03pacGm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F03pacGm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPY6f2jqGz2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 17:10:50 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1130324a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377448; x=1794982248; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOej3OSGWxWCJ3XeVUCQdSFsxuuEIjtPwatxLCH1n94=;
        b=F03pacGmzDKqRuKN8zRInYTs1Ca1W0Z6a9Y8oksDcnikRRdkzNoFI07xnEg9cWQRg4
         RfZnA457CPwsv3xNkgFQNdNDBtgwGuL/a7W6GdA1GHL4WdWyoNjLYbnlfgUHgAytaoKm
         gpTGrh8hGyGR2gMb58VCnl7w6Ifibrk+Rt1IhtRrOmirSTH1DIkxFJmujkCDATHakdjy
         mIvtxJzX7ZJNLYxpP2Pb9kA61axACOiFHYv27TYRLX48HOc9sjZWe6jcwd/Xxirb+Dj+
         qhycFswBs7ShA5Qz/vkaSaGkg1OfFreX+t9UdYcB/lMw25Qwh8JZUCaAqMx55ymv/WM9
         zPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377448; x=1794982248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOej3OSGWxWCJ3XeVUCQdSFsxuuEIjtPwatxLCH1n94=;
        b=zW9wyLyOql/Cck27zVotxTtNr1bMywXUjgQfb9YYDLS6ryD0TnTWEOWHQqXm/p2gFz
         3fAP+/wLW6Wlwb3LR7g9huvDarqRTdvrNKzRrwYXFgF+BlvTsvlNLLgiJY0iE4534AgA
         SEqNKX93+H6L+qqVYamkprwRYCT/SVuH3nQEZd+Yi81psnXLDmOxULscaUfDwCyVbK7x
         juHkq+RjUZ+bYdWmRSM2A+YCoMncIYJTL/ajeqNVj0epnFuAS5YTngTHdgCjxHO+UAvb
         ipusklgTNz7MArJTNtFax2cCPi++LErXYXs8r3IpEa8PJRPvfBCaXd/Iyt2eaxt7mIu8
         Cbxg==
X-Forwarded-Encrypted: i=1; AL+hErGuprw4s/mzUoze4ULoHnc/QSuVTAnFWidC2D+BLxqmhDtjqPdb+WjQerxkNHpi4iqHD5LDZuyucbnI+W8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+h+tFYTNYegLVZZC7r/FMpFphEuWQsTZWaolHNw1TxoLOiDnvm
	2UYcViMeimb3q7FT3JbqpafQ/4COM+I60QGxNppAxij1dH1jNchm7hJv
X-Gm-Gg: AYBFou37NHOKwn2xWMB612Gqa1ZaES5lR1kyyBlO2WSND34ygrCuP6yv5AGL9S76h2I
	58S1UbJ90FOJQbibv7vC72HOyVjDBWZZ6gbg99B/p3FoeCqMLPBhtjbGRg9eCFR14o3KAWoVspw
	RoipUMJ6KCs7rx0Otw56X32pQSZsNJ+vST7+jmOxaB2SC7+Fxu4513rqhNy/5yPzHBhg0Xmt5pw
	UYWxbD6JzzHYzjDPbzHnEzK6IDAA2dlX1fkS4SPsfP4ZFWv084rOWCkzv7d/2BAQMSJSXkmknOZ
	FoaJlbQXVJQpfyMaARQOTKwTs/PtSbFBAg75RclPrD50Q4MGeV6xLpFxL3sC5kcF2Nkx/KpuMUR
	un0sTEY9U4SaTcnoI8J0ykjq0xAawuIMIVas+pb/S5XaXCp+7AQxZbsxRzO/1wBeHUmdcpl1sRL
	8JNmWlneyjYSH5FChGT3p1sTrRd2imSuiyuXkUppZdcZw/YtZxwBu3alRlJT7vS5yrtISC03fW1
	s271zjcIpk2dzYhQG5YIHU1yaGa+QXcRAQga/xtaqYSVB4dx7ZV/u/wHlhjfE8oEiNcqdphrvKV
	IWBLbHRsrGXkOXQSjk6QqGv2QCt4iDqwZ34m7LRC1fqhk4/GRh8+BO4bKFLQ0uxWlPby
X-Received: by 2002:a17:90b:1f87:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3b182f0d1e4mr1310292a91.43.1794377448229;
        Tue, 10 Nov 2026 22:10:48 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7e8b1sm2978557a91.12.2026.11.10.22.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:10:47 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Nov 2026 14:14:43 +0800
Subject: [PATCH v2 2/5] ARM: dts: aspeed: ventura2: Add ADS1015 ADC
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-ventura2-dts-update-v2-2-bce5b5dafc1f@gmail.com>
References: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
In-Reply-To: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=xPQqV3YI1Vbg3zoEBrsSwuLJ278Wah93Qbu60OSxVxs=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq9Af1GDj92rCYara8OWnsCKcFq76imAFe5qamq
 9/KCtbUobSJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavQH9QAKCRClg0K3CVbE
 gVo7B/0ZynYot9Je1040D/lbTGvzkWrbY4vtT8cQRJTXAHiAE6QNwPWG2ALgj+BrhuQRGEc0xVb
 6kw1vL3VB7rbF6TWstqa0zhqev/6glQe4IzGMqn5+HHEHAcVy3SrLRFt8V5YSHpu4ONibR/N3mZ
 U+n44kXd6Djn08M+YX/uIYdFa7gGUZhxd7xVVU5+qa7CxxQnqxPS4NcEvTL93/z0qgVuY0ZjCmq
 0/p93zt3zAiWvPAfAcG0XYdYqraRVFFb0f/XvEBtrRWihLAUR8Vz9tiK8tSrkKEcWx2kFO4aNHj
 LorR0ty1dA80hB0TVYarsdspFdZ7wYGtqSUpIMPimhCkZXUu
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ventura2 has a TI ADS1015 4-channel 12-bit ADC at address 0x48 on I2C
bus 10.

Describe the ADC so it is instantiated by the ti-ads1015 driver.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
index 50e652cc37a1..21c40dd4bb84 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
@@ -2405,6 +2405,13 @@ power-monitor@44 {
 		shunt-resistor-micro-ohms = <500>;
 	};
 
+	adc@48 {
+		compatible = "ti,ads1015";
+		reg = <0x48>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	gpio@64 {
 		compatible = "nxp,pca9555";
 		reg = <0x64>;

-- 
2.34.1


