Return-Path: <linux-aspeed+bounces-2057-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FECA0FF2
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 Aug 2025 07:50:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCD8G3b25z3069;
	Thu, 28 Aug 2025 17:50:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756367406;
	cv=none; b=N2Wx02r+ff5xipFwC6KeUXrLj0VvPT6h96Jh1SHRvESAPKtIo57zvyp7ilhAZ5gqteOIcUMvzgVfy2QvNrY0DQDdW6ViaOgtBDAUns+Xr1cqQHsG6rybqEI7gRVIPIa4Yym2RNr/N6iPGigWkn+JBea50AWfBR+N+GH9Hrj+Pauz/aYxQQy0XfLO6ELz2doZ9PNDJ1zG+gvA24G6hy/t0rnrfjokOinMGuQ6vR+okDqOmNxy03FNr9vIvH2bj5ri/cG2CmFq1MBtRpw9880ySqN+GA7Q3VczJ1bv8SqnUtq5bEsr6kCVBH6/oUdzZtc+2s6rvIdWCyO2tsE7OzYgag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756367406; c=relaxed/relaxed;
	bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8YIeILdo3mfwr+9wVlDvqj3PO/JqLIMCx9jQIvpXRTxWO6DIQ0rDMFwq2LGYbsBX2S3J5kdoVYOR7/RFNLVVisjGt+brJzYjkEFblEJykHhRUSldZWZk0sguwqluAXcgxKtMM/2KivmT+4vOhfo1J/YqoPDsBjyYWT4gBOIIixi0Ce7EL0Kru9yq3EbMMyBzTvHCvx2v28Sfse7UQeN3Pj5ZgXd6zQerHdAiyRwyTEFW/NfJ9+bLCMR4k0fjk7i6pMV0dOEcqRBXxzR8W96sCxSJ5fPq4mtvgvYl93QhyshPICr4xOWLWKz9Z/I1Jjxnd7mICmWfgGSdB/vacvQoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R5o8OjA1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R5o8OjA1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCD8F5WsDz3bpS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 17:50:05 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7720f23123dso644272b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367404; x=1756972204; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=R5o8OjA1xXFmr0GwRndxLEQWxNS/hwORYuQ2fL/O2dATx6phj99DXSQOPZOTBOtPgy
         W1od+frqTD5ycgmb9DPwRXL+OZ+yte1gaJ+ToIysRe/5SeiuDGGGTHocyaDTDdtjUMhv
         um4JT7DBeb4e7gGw5lk0bFCQu07uXIGxz62NaQMU4Gdi4N7lFbEhhu5FZO2e3l7RqS3u
         KK8mSKLJpSpfG4ywXheFUDp+UMPe2xTOnMH7lZvgEnbTTHAPhA+NvNmCAwM61MmhlWOE
         5YNMq28ale36ZH1krClEc107yYpmWVvLzJ0uyJh9XqWCXY35aFuhSn6Eo7Yg3wue9IUN
         0L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367404; x=1756972204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=lskjNAkhB10OHm2sySAHH0jlIkxnA6ZTi/GcToVvbRsbpDKQdoPwy09JEKaUqe9nSV
         kDJYtIJujs0pSuhcBXQrk1RE040JXEY3QmeNPYAGXWlrqhzmXiFqdXI+Qou3Bc9K9jGD
         IWcxW2lS1xAtJwO+MdICFA90baS0Wu7rNa7RXL/pfDqAaTxrwihHrA3xoKsR0rPoxALH
         ho2yDhAULHZmyYBuZlBux5wcRzxZSfouhTXCjQQp7qJ5QmMemHzQ8wUHa+rLxt2olT2r
         j8dsOKW55DbZDvatJPfT2bQLOeT+QNXRJS18eGfiy3QSV9wqlJySPqwgR5gNO0tJJfFY
         nqOg==
X-Forwarded-Encrypted: i=1; AJvYcCUfQFmxjXGIvfw/EuAmEmbETswg1d3IuBZX6/JOdGFhqAz0tNAq1cnh0DEH4FVduGiHzmC8EdE4L5ARkLo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOQQ39ETv8NnvCoPWWPsV8YD88d5MH6ihki1FvPc8v0Jx/aRAM
	/nlqRsTbhKxKydExlir2RK/41E1OPi+ABX9CVaEAf2380RLl8n8FEtYd
X-Gm-Gg: ASbGnctrGqza7M/TF3HAklwu87KRpj+V1H0mx3l7dpqca9+e7iuP4qsGrnD9BUGsVWc
	B3+URFehFOcUT6ePaFbaLa8se9zNvzGItmA8uY9cCmYwXy3KwXcpVeyc6c8/248ez0sSuMvzlAU
	Ym4pwoFrBqZ0Eb3hhvmrzsisZrNQ5cpnFSfqhJV4WrS7bAuHC1HJzpVFyWvlSan4ZYSroHRgNvB
	RQR1JlHVcrF1ABzFra25iJTGr86CDmiLqUfMlMZQMG9CtGS+qzY/JqrZHyDlG6kiqhPqiV7qqDJ
	S80/xIIMvRbLeca88gO/z9V4nrGAPNy131qDCMVVbHYdLrG3bmNK+mnrtmyO7gpLQYvDY9IE4M7
	iGQG9ttS3KCxPlIHmjAScfA+VMdUMt18duRsbug9vjp/v5R9FOLBXGSVvLiCZK5oRBdSyodnq8f
	sCy1aXlIjSN+jcysPiJQ7GI0LOJinE
X-Google-Smtp-Source: AGHT+IF9eB9YxPbxJeLTBkKeRv/n32ThRlEoj2lAY3V0vAzctsoiWpW47rObnmzff3aGP01kwQzURQ==
X-Received: by 2002:a05:6a20:6a26:b0:243:78a:8296 with SMTP id adf61e73a8af0-24340e06888mr31347144637.47.1756367403511;
        Thu, 28 Aug 2025 00:50:03 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:03 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: aspeed: harma: add power monitor support
Date: Thu, 28 Aug 2025 15:49:51 +0800
Message-ID: <20250828074955.542711-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
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

Add INA238 device on I2C bus 4 for the PDB board power monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..741d2d9b6d03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -373,6 +373,12 @@ power-monitor@40 {
 		compatible = "infineon,xdp710";
 		reg = <0x40>;
 	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


