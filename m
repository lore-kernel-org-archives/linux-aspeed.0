Return-Path: <linux-aspeed+bounces-4617-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E0C55174
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 08:19:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFNcC1dbpz2y8c;
	Wed, 05 Aug 2026 18:19:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785917963;
	cv=none; b=AQbBAACjeuQQX2hBlfWN9Fq13jLaASM1TxV64VbaQxl2sYMcQ2RzgPTobIsza/NVOnzONgPUhUuXBldVmzaV4vKos1Qf8aPbUJJtY6uvwuBqhs13HFUkmvZ7vyB+m6JjOuqrh4UtxOjrN94grd67m0nUkB5WyhgLJjRzDMvAjXY8cui7PheiZcdQ+zq/Hhc0deJ/mO3ecxksQjTNTpKf+swypac6VhjHNWavorI+vUhdgJN3fSdOruU8AhltlMA8+GrznFNzewMdcNr0t4UUjVBR2rBYH9rn0ddu74gim7s8+WcByEEsOmdLf5nfOtwGa9e2UwUeqBP7JOTtVeyGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785917963; c=relaxed/relaxed;
	bh=7Ly3YHLnm48uwYiEmyCIsl4iQ3O9RMhr22ExICtid7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7F/+tFMWMW1dz9ATIIHeHoRbzvA8TMMinOjdFUvP6vkdckW0Up4y1TgI2AZ2FE4F2d97byMq4+jorZqSMH7ZvEapeV3UANRktjhi4BcQctWCjZpHUWHnMSWHLkG5FbEqb8a48wCZcCJN+ZhUJigLBLNrxCnd64mfNi7Jg5syAsZ09MmLukd+q8Gmdfmq/r/EWmJXpJl2reLK6Ul0jvjaSijOQ4Zmc2H6uNH2KUeM8mNH7wBdS3XqQjpPOoyReD+SNI9Cd3ZUeb+J4eLDcXD8LTsx1XMBndmAoe9AvVIHqZASR2mCCNdkFvWIngHbe5U55EC6zu27PlRVa866stFRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QVBjDFvh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QVBjDFvh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFNcB2Hvjz2xl5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 18:19:22 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4955158f26aso4089215e9.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785917959; x=1786522759; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Ly3YHLnm48uwYiEmyCIsl4iQ3O9RMhr22ExICtid7I=;
        b=QVBjDFvhEcrtKHuCklpZFy3I/IUNXlYKix0t9s+AEH55gGId4heCzIlm/MUKh8o0Cp
         COFbmcmPJYYuqE7uZA6A5TNc3Ziux8VD50QjIiHhLt2lOPJJWxRDG2s5udHhR3ydJJdP
         W9G7OF0SrpVJefHnq7cKUUXz+Rqc2VIf/beNg7gnRefUfiZHaCjV8+6+YxLPe0nMwkYO
         MgNzr4oQyoqKatSpopu4jfBr0qhobJJcH6mMplHokO02DXxzuIwVkisn2iBce12LS50t
         bO1hoclz1eY6OyZeuj8nuLuAlNHqF4FKzK5WJilq9+Fb+z+HNA05UkJHz2KObTVU6ll1
         kXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785917959; x=1786522759;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Ly3YHLnm48uwYiEmyCIsl4iQ3O9RMhr22ExICtid7I=;
        b=Vk9NkBamlknsTjZPpDSdsasg2bk7pZh07dQYb+6rdtoxtb/Ly1PzxTrQDOAMkVflKk
         dL88otNKU2mE50ip1IyBh/Q3A3BgpMOpT5bfMMR1F2y7EQDzBrpmBfdHkhY7JedwUkTK
         FUskiO8NybDhSD4+96ZD+o8DSuobsTqow/+vo6EzchtaHkLdk7WZvA9NzMqLrAunJcLD
         +jG2y6Sk97HuqwoOF68o73eJFF7t1vEbjh17M5cxtZwkIsRNw28f3ZS3gArN7q65vmVn
         ir+7S9Lt1YHSomkZuXpL1jrRtRTiivVHui9TlqFGg6FtWWbhZEH3GsX9SBh+W+RD9xzY
         2Iag==
X-Forwarded-Encrypted: i=1; AHgh+RouJmRbYQg4kCA+IZDraN9Ch+YQPyPQjrHxruQvLVztFPlK/N4RHpOnwX06dLy8ooaebAFv4vDZ/9zE5oI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRpyyLSCzR0Bojr21J3bxnAoLeXSdQwyuQqgG7PtQmAShsM9tu
	DRw0plprXLqS0KXI+iMVOlC20vJxvcakgInJn6Us4itLiY3QFhVCr6RFDRRwXfH41x8=
X-Gm-Gg: AR+sD10Xn53Pe6vAQQvntLMUzFB+VQYyBNj7VDSIshqDc1ihqV69wvJOp4b6SyULewM
	Je+qxjD2BVMpbkeTCbpQ9riNxpEhl+o2DZR/n81juoZbd05u8D84j4mSY0uJnxvnOO8I3W4Oywy
	LJzAGvIt+6n4BxNw1moW9I+gt28TFaSHLzmAA7hKT1PMl+vGiTy6MfE7JzLWNLmWo/5lNPeK0i6
	SdAV8MOSc6+OLDwuU3I1aA4p2/0L2V99DtyDm8H3/Aoycpeouo7CcgcXWCX5hx27Vw7WILaUJpX
	D9gGa+mZ9VtTQHaXqSbSu0ssOZKmEG04s2CF5ICxR8Sv2yQuO0UTWeDBQVqNpuyI1QVTDPKvLet
	LNLtiT/6mj97WVbkFP7JONc3PbAfRg24C3ZDWQoBtuhFR1jyZ5OonMzZeDTuInoeDCtI2dsroNs
	oCsh5VzeFb7NQV4FyZ71a5v0uCUHaCexLk7as5YNGH9b1k3exTjzAMRFGRHQTj0Z+hagspSftVr
	O6+BGLsvcV1XPeSYq/UufC33MHIs8unSaR/fgXTdUXkklx5LOdVJa9NP/t89LmvUHu+EnDUFxwo
X-Received: by 2002:a05:600c:c4a3:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-4994e71eaf3mr55027305e9.7.1785917958819;
        Wed, 05 Aug 2026 01:19:18 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e0356d4sm74745695e9.10.2026.08.05.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:19:18 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: jammy_huang@aspeedtech.com,
	yc_hsieh@aspeedtech.com,
	openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 2/2 RESEND] ARM: dts: aspeed-g6: add pcie-kcs4
Date: Wed,  5 Aug 2026 10:19:01 +0200
Message-ID: <1dac6b9ae1565a2265e87537141e46c988d16de3.1785135437.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785135437.git.gregoire.layet@9elements.com>
References: <cover.1785135437.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <20260805081901.sm2P876y9_iKw0oB2VTAT2JVGf-GOiwwKdhzI9ZagIQ@z>

Add pcie_kcs4 node to the LPC bus in the ast2600 g6 common dtsi.

The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
interface on channel 4. This is a fully KCS-compatible interface
that is exposed over PCIe.

This can be used by the host for IPMI when the PCIe BMC Device is
activated.

While the PCIe to LPC Controller provides KCS channels 1, 2,
3 and 4 over PCI, this patch only adds channel 4.
This needs little adjustment to the driver and provides PCIe BMC Devices,
like the Asus IPMI Expansion Card, the IPMI over PCIe feature.

The pcie_kcs4 uses existing "aspeed,ast2600-kcs-bmc" compatible as it's a
standard KCS interface.

Node placed according to the ascending address ordering.
'dt-check-style --mode strict' reports no issues on added lines, except
'line-length' issues.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..c9d94c25d1ad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -656,6 +656,14 @@ ibt: ibt@140 {
 					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
+
+				pcie_kcs4: kcs@914 {
+					compatible = "aspeed,ast2600-kcs-bmc";
+					reg = <0x914 0x1>, <0x918 0x1>, <0x91c 0x1>;
+					interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+
+					status = "disabled";
+				};
 			};

 			sdc: sdc@1e740000 {
--
2.54.0

