Return-Path: <linux-aspeed+bounces-1614-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4583C83F07
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX79Z301zz30Pn;
	Wed,  2 Jul 2025 15:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751432674;
	cv=none; b=jDgwx3do63sEiGmSTBiBxgRneY2ntPhRzZDgVVMwBR3yddJTxM+lgUws4fNeVV2E9nRAx7Z6f9mhzYKaNB10oYFq8oWkZIjv4Bna5b0dJI08LRkyQAHf6Zr/y7lVlJk/Wkym5GqJAdwHo1rgheuVVJrmgtIRYskn3X+j+bo356Pty8oggzzZVcxxnyjinbj6HjdIwyBRtL/IJblpBJ/dzjZ3EpY/M46IVl3V5pj8hoN0Y/MRQ+FAbf2AVRuq2NwwVH7N+ONX5rubLfCLyqeh2V7NFzJ24Gw9QVmIlP3VrZo1T1GPF42bH2Gnj+Iq03J2uf+RBX5ADpbo+Qpoav3LQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751432674; c=relaxed/relaxed;
	bh=LIMFKP9o9HCYgCUtge56j7nt4ExnHtWvQ7QUrOurhM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ferNPaVxf9hM17LWgIuuD/74pUnpIufEjKAh0/X97mCTNOQGivK8dF/l7zKeQdfCI/XcC46NRCa+Mulrz07Z1sVl188xLAmwbZruuFlYQFhEqzxq2nAw4QpKBSOOOsb7yYqnWlrUu0F+O6bWwUYBP5IYmBBsouOnIv4Sg9Lh33RZbxp/0aBj98eVctPIsnoBi7FVEL6dHaOg2qL0GnTTPrU4rrvJxvhV+HI1yCIVaFmvXDENPU5+ErmJXV/lTZbl4FmyC/H28WoeUDc1WMQ+f+mWttJ4smTfLBIWVTxLFCGGASdXR+QaOUrJJ2WowsKzQIL84XX7qI3aECE7/s2T/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gEbx6oJU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gEbx6oJU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX79Y5m30z305n
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 15:04:33 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-234bfe37cccso77469005ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Jul 2025 22:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751432672; x=1752037472; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIMFKP9o9HCYgCUtge56j7nt4ExnHtWvQ7QUrOurhM8=;
        b=gEbx6oJURGgX8NmDRT/WwgNNppmuR1s/XVUdsMcY9HNMozlIqYIZI3itlXwRi+892E
         ORev6F8+ZyKfvuX9JlhC6gVweNsTVGHCi60WSTCLk6ZTuk5eeNoGg9ZAdIUeicUMq5N4
         pq4Hynl08l7I+OCUoTpvN74/9h1mM/QjrpIoJbYsN+Nhx2w9+6iPmk81TPlQ78IbvrfU
         qCgUQD8uvuU5QeQfKgFWJ4X8G8f0Nt3dmq6NnwcWRFOrcho2z8YfmJAynlNxDthkEIET
         2QBJeI2wQSYKa6mjHxAS9jGkcMbbAfIYEqfj6PPCf59b9CeU6tquIy9iaFOZ5wA0rj2e
         K8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432672; x=1752037472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIMFKP9o9HCYgCUtge56j7nt4ExnHtWvQ7QUrOurhM8=;
        b=IEs1OMv+I3bOvZm0klccYprbnFwcG68nfPO2N3AdX6sJUWbk76wJpkJnh6SGQRi3db
         9w4tNeJ8Gz8OViRoS3BJJV5DdtP6l0SNSuq8M2VpNS22feWQPGbezP87qfpmHDpvkQOX
         rXpSxiQqXQKVPp2vzJK5ZFkTZtMi2eiJ3VV1dJHSXwdpdeXRyllHn53YC/0Aua40bnGv
         meJSRND5sbdxr2bpi89oG6fWgZuGMj5OC96F8La/NBZEQxsDSA7g2CXeXBqnqdhJXpXu
         P/KXHJRzREhbBvUBx+xOeeL+3CAOro7ili3ZUcDZ2L+EilxHAqFY7XEt2YM4L90uSSqq
         BnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGlHpD6j/LzC44vUrqq9q8unY2IWwjsQGwmz5xfuXFxNNPIEGheaBcM1mzToFKTvnxFZobkSioa6t4uQQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmRmrpzgI+L/u+tjS/je7eETb6baNmkdCFe9gxAAuhf52Qz02W
	djpfKf959OCepiU6dZ8LfYqCpRBzp3HpV6Qm+t0Hn5tLA7G0mz4g2GUq
X-Gm-Gg: ASbGncvKPIYG+V5BFaGW0URpsjLZq0pNDPs+JDkFPQqoKOvocmXSMToUlcoK+Aud7ex
	/cJeXN+7c7JB05K+FJYQdQIbDl/M/Y/zZSr1nSMk/jUdNQA8M3+IM8FRWlofgg0mmHL95kdinaJ
	LoEKcBf3lMnL+XHUA15ltemR8Yj2Cq91MHeCnFNdunGlnFaZbXzrkCizXEldrFlk9mkAVEwkkFA
	U9/bO15qg6QHzi87M7NLSo+7ZwXeaTYRynnFYz+BuzAFbHNEbA3NsJE9+ksrvFQlf4EQWJbJle5
	Vcfjr7dDW1LVfcrIXopqglV5Xf6nfyel/yeSJYIKQQVWZlC7HWA4pv8/JYy1adjK/Lf5Z12unn2
	/jUxEj6NC4vTql2Zg8XYedlpieG1szFtWf/2kXwE=
X-Google-Smtp-Source: AGHT+IEQ3S87fa9ZqPvK0q7rgVUNEWS84VK96kAXRXHNuFvPbQyf8Vjt0suBBc0zAlqL2fFCZPSi+w==
X-Received: by 2002:a17:90b:4c0a:b0:311:e8cc:425e with SMTP id 98e67ed59e1d1-31a90c0e00fmr2518373a91.31.1751432671900;
        Tue, 01 Jul 2025 22:04:31 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm18168323a91.25.2025.07.01.22.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:04:31 -0700 (PDT)
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
Subject: [PATCH 4/5] ARM: dts: aspeed: fuji: Enable eMMC device
Date: Tue,  1 Jul 2025 22:04:15 -0700
Message-ID: <20250702050421.13729-5-rentao.bupt@gmail.com>
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

Enable eMMC device in Fuji dts because the eMMC entries were removed
from ast2600-facebook-netbmc-common.dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index f23c26a3441d..8602ede3ec7e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1249,3 +1249,15 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
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


