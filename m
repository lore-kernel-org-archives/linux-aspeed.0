Return-Path: <linux-aspeed+bounces-3961-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ACEFF885C
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Apr 2026 06:22:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2frr3DBxz2yng;
	Sat, 25 Apr 2026 16:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777023026;
	cv=none; b=QPyyntHpffaJeCs8bO56edk7ZTzAAlezAzf4ccbOR0wCZ72oVRDoynpM5LKC/KOZvIymRYIc+TgddLAEBIurfX2c3WreanEKUS1ejnMq+zKN+IKC6IJZNTtTFkqQMfgJlxh7uGY1bg5jI5rmuGsXo3DDH39PnUCF/H2WWs1aULf3+fpH7WWTSRMa1cijzhCxStia8q1JEox409wOlT8FSx2iAI7Yk80xyIfsK7QcTIvhUukxYpUhrxuH1gTTkQFqv+ubu23rQZ5XWKXGmsg4xTRxSoYXM+UtQQmO6w2n7kJaEIhkM2OJ1YotKrX2a9qB49/uuFgdGBywh/4wvj7vAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777023026; c=relaxed/relaxed;
	bh=WRwTAJEdshpMeygRgfdm3dyxt0e0Cc0hy7FOZ+1cEoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tr/8bIMx+7ZFJG9t4fxQYtsIOLnWkVgZlLFtqlzCGrECi7IIYnnAQpPeXHSKBW7uz/Zi3eo9dbQlQY0usyXBuxlnvCeO/ejNfZyAckVl0pAxgq2r+JMvznplkevSflEeqPH5rsHntSQgpQv3fJA8HnZSHElFZ0uxiuANvb84Ye/Y8vAbnjjvyrDJ7kdGFWJ4GSzpGwwAAksLhOpymoFxDWJVUnk7/ksBmKtzLxcw5qFGab5kZs1o6ZfumOpWTGEa+r2qnyorMDd3vFO2gOXUlwjou8MOU9xf5aisEU945N3DnCVd3Oi7G63V+ldTq8awpFw6rRk0cLZDrdru4tJIyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mVQ/5gax; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mVQ/5gax;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g273j4BZpz2xZK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Apr 2026 19:30:24 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so2933872a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Apr 2026 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777023022; x=1777627822; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRwTAJEdshpMeygRgfdm3dyxt0e0Cc0hy7FOZ+1cEoo=;
        b=mVQ/5gaxXwYXH4enm5klrPqac80GT1ORcAE2FuUEu4YDoM0hzThDH74iNoaIArokhU
         NBBG+dndNZxFMkzlJZivU66AOcEvfKCeAWxCL8UunG8T3mUsp4jEqDedNsdO1h8eKTyZ
         fOfuBHBDHWhgLpj2upkbcS7QDmS9+Ax5VS9AQA9Yk43yZWZUcjI2KwIG5hEYmgs4p19f
         4qnCGemASMu0wjpE/nnRUnZy6w4DU5cQz2AHu7ECmskA8NGEch1j6NehjfrsKls0oS0m
         xs9juiUwk3pSGCuX0ywWTV4N/keKXcVlGHw/F/IbP/OocZ7ZGwGac8z/SICQUPHQs0Uo
         4ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777023022; x=1777627822;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRwTAJEdshpMeygRgfdm3dyxt0e0Cc0hy7FOZ+1cEoo=;
        b=N4wsc/X3WlQsFARgDy/794mUM3479dCCbiXIzwKzmVi46ocDKZJlHJPNNF2dpysbLQ
         JVcE9CO83WLz6DodZNB8xX6SCZUHyKIgF/g3ydmddGFYTAGTK3MvfRpBMYvUv8WPSOX7
         rvLXFXCqE/s4Nv420rJJYNMUfwf0MAnqMxd3YnZpPSSrjvCntp0A03u3ARZKWMOKdrWi
         QF2OAfu0Jb4B+Wonkk1nDCfTkGLwq1YsBnwXhjp//8DbERsRm90EG53agl5Gim6e2pcc
         iY67krs++Rf0VGsnYJzEfn9iEMWAe0ICKbTEfCg0uHB7MRYOnVXWdzIzpbjgPyfl/WDX
         u7SQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bf2Zzr4ZhTmqc1o/YVMKSZp+zanryWVMqCMgUL9gygElTYdLLtzImt52+s6ABwqwaYKqe5jFbkjkOXmo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy43/iUdgqjS3LsRBN4z9J2LewhcG5fyffSnm5meC7bD3DeGXPH
	qvNttCaYSZ0V4aPtZEhskwIcW9tQj3UJAd5Vk5/ocH7VAiOMT/P1TftAJaXZkw==
X-Gm-Gg: AeBDiev+UfEO44HDSO2+CuWFimaxAi2YuQRVTV9rhKbmRiC7yznDdFqd20+SUoZxGpk
	RZvqQ2I6DnnhsqnSQ3KpdKopOa2CN4HsTL8mNLpcxVolKRA1f21NgFli3F0FCBuhxhCEkd/cvLR
	7e1wlVlBEH+6f3wCgPmYx5gstfemW7HbbUSUFYpa1EKi4zf0T23hNZ8JKr7eWHZmgT2vwVOICHJ
	3B+CqI4reJS2MqUJ0myqdkhAD02VpUta22R9zrqZg4pQBFf4ypd4J0wengNGDSfjNskTDC3Ay/z
	aMNxlFnHx/4Jr75Gb3Ng6nBJGsjAhLf7K/O/dYyjkgmjmxMLjQNeD78OECzcrnYrUHE8zFBW0+Q
	MBPdJdfLLzXhx7MBUvmlTwge74PU9crOw/rYKKp26E7DB5OyFYkTHaOsrxanCOOhCAzG/+vIq15
	1U6DWQcBKuiAh9UVExxdeSgToYqOja+4pNsOgVbtZ3YqH0nLKSysSbjq62hAxpZBGVnvkCeFTOD
	w==
X-Received: by 2002:a05:6a20:3d85:b0:398:a659:eb0 with SMTP id adf61e73a8af0-3a08d8a6695mr36356423637.34.1777023021700;
        Fri, 24 Apr 2026 02:30:21 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe92desm22658143b3a.44.2026.04.24.02.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:30:21 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v4 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Fri, 24 Apr 2026 17:30:48 +0800
Message-Id: <20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAEg462kC/4XN3wqCMBTH8VeJXbfYznTLrnqPCJlu6gH/xGajE
 N+9KQRCSJffH5zPmYi3Dq0nl8NEnA3ocehjJMcDKRvd15aiiU2AQcoBgAbbj0+nIcceR9RtbkZ
 PM5YVApQyUqYknj6crfC1srd77Ab9OLj3+iXwZf0DBk4Z5RWTXMpSnbW41p3G9lQOHVnAAFsk2
 UEgIhXPRKFTkzD1g4gvIhnnYgcREQFTVEZLnRaJ2iLzPH8AXyb320IBAAA=
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=OsNPHX4jeofbnoke8t+ygRvQX/qpdNEBz1MsGO83J8c=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBp6zhMtNInLf1W8Lk5DvyqGuC2M/I8frqBBvEe/
 b8/gD36idKJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaes4TAAKCRClg0K3CVbE
 gdc3CACqDuZpjAuJQGDt4CwXYmls3MIocoPuyLH5gxIO7xr5zKFYT36q71wL9C2iVRF0xs2xiFM
 RQFU3Z2bvxNhZ/7Scm17U5hEvK6cl4+xSUil/dTnX1YToXrvhuXKkUgFB/KShUr0sxqJM1goh96
 vxqLOder7vKskzFo4axbeEpgLShGAgtU2SDkSJh7WUJzsaJ+alUK49AGFqLL6TAFTV/l3rgj1K3
 cu29OVgwMmtsuC1Df74d6ZQtzsAi9FU8Ltqg6mUVLNLdc/0UC0TbZ0JJa8Bmx20bS7JKnUhNbYr
 xrI0bWR7U29BXya2NaNhE4fimtycS1nGWEeObDa9gOo4Umzw
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v4:
- Fixed capitalization: "ventura2" -> "Ventura2".
- Reordered I2C child nodes in ascending order of unit addresses.
- Enable PECI, LPC control, and KCS3 interfaces for host communication.
- Configure MCTP controller on I2C4 and enable MCTP support for specific mux channels.
- Add Infineon TDA38640 and TI INA230 power monitor nodes.
- GPIO and Pinmux cleanup for PVT:
    - Aligned gpio-line-names as requested.
    - Remove unused or non-existent GPIO line names to align with Ventura2 PVT.
    - Update specific GPIO pins to empty strings where signals were removed or consolidated.
- Adjust SGPIOM frequency to 200kHz and update signal line names.
- Enable UART3 and add serial2 alias.
- Link to v3: https://lore.kernel.org/r/20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com

Changes in v3:
- Add annotation for marvel 88e6393x
- Modify the gpio-line-name
- Modify the node order alphabetically
- Modify dt-bindings document for rmc instead of bmc
- Move the gpio-line-names to original node
- Link to v2: https://lore.kernel.org/r/20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com

Changes in v2:
- Remove unused mdio
- Link to v1: https://lore.kernel.org/r/20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: arm: aspeed: add Meta ventura2 board
      ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2925 ++++++++++++++++++++
 3 files changed, 2927 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


