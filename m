Return-Path: <linux-aspeed+bounces-5035-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBADC982FF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 12:37:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq03s03ygz2ygK;
	Tue, 22 Sep 2026 22:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790080648;
	cv=none; b=J1W3NsUqnW74jczc/+AiJWeLhS1dnHG01dvUPu5rmDPA9P18PbC3raV+aLdDPb+Kxv2ml/Um4ax6AioVmeD/Q4PMF90bHz/aeXOwTPr1w7LJd1pAmCOj/QzNS2cPPM/Idl+M5cj7fUFI9VbtzbVq30MGerlMX6fwJfluPYwNMxB8X/U01Zmi3O7/e19Tn4f70nKXaF7LaemMU+yvSlN9TST1Zz2tauLDbZJeNEkv2cztC4ykiZGjL5WSaqALtoc9H6+XHTIdFFDLIvtNH5ftHljC6lo3Mxh05CEslzPM9Z3o3NpY+SKdz+nEEoyiy1TM97O62tNO2CcQusBRrhldTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790080648; c=relaxed/relaxed;
	bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF4v+Gz/aTNYZOFfPlJnnjfqqLTmta+wQowjsDpOLyj/EqAxJ/bxIwPmm1a4oL/9vwMaBN15t0eSgm4gMW89rondLCBBKhPB1Rd8nQGZL6ci/aAMD4dWkgwoIE6twvxGVnG+PrJvQPVts9UleuJcRhpf+LTbocAdXblmG2slaC0ksfBSfeKKa0oH9mEWCfD68kPlNyxuA0oHjFWNeA/cvfT9A9ydfPSFAip0sF8MOtaC5hIWH+QFIt3+girBsXLbEYQGqGUH20BNHil47suc1cwbp1zAxQEtgPu+sm3eF7w6Y00GuPAzps2wTGfhq0orJmRy8KBIh4HWdTrwMQMbHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hg2ZRFjo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hg2ZRFjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq03r1jgkz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 22:37:28 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so1854832a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790080646; x=1790685446; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
        b=hg2ZRFjoAeH4tPEgNbf5pZIyfSE0GdSX1lZE1/vNC/1Bv4Q+b9FkYjxcDiacVYtpFU
         PlzpeQB2Y/WDW4sfWi8Q/+K9U0G48MOIY4jxjMQH7BZOMnUo/E2k+SIQsOftD3noX5N3
         j4yrBFOvJFhezBTLuwqI8j4s4sHOrX2lG4NyUt/qUiPxixul1fWtDtlN0T231eqlelcu
         ksNVgMgB88qGqj+iSPT74voOLjExVCzX2GIsloMyMtvgNYO9NOgoEckfxDj+2mdsfJBT
         bm5wEWYUh/KzonmKptJzCXi7ph1MvbNxFoQTdZIaOA56bVVp5KH5/JZlaoORzCsvSx4a
         d9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080646; x=1790685446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
        b=tNxPspvzKcJhUZ3TitXEVeBlHaFhMk8qE9YEY4TlKzaQB+OxKYOAItbZ9CjlWBtM34
         RIWERyX75/3UFbPCUPFIMIMV1wvQ8GoRWQx513NGPkcb7qt7cOrQslcOn3Q9GeGInch7
         xvw0xrEBvLnXhnYVLea3YaRFIlm7OeQW2qIrCw+srh7UQMjdDxoH76MbUM47wRrMyo7q
         cAHSCo+lvJrR2yB9nNwHV1UOq9aYbxcO+vG2UWPlHh01VI1I6zYGe+w7LeNQUX+zT7ss
         AYQMbPZS5rHnZqfpL5dpw8fxNFJxGKpCcrh4F+utkHXOZlh4QbcRkAbpDWlJUZ3ZINuo
         cxCw==
X-Forwarded-Encrypted: i=1; AKwUvBzguXhGkL4ZiXUbzl2wRy5RowO8+quLI7970YCVbSrq4k6ZuYGpsG+V3kASWqM5RWvNJrzMyV589K7meK8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nZNPvPtBtnzP38Px/uiKiX3PAKYtx27vubWrR2Gza9Q/o+UGlq
	5Iws8KQ38WRdJYnQfud+euTphLimWHARzgc6FPv/cXgNNGvPdDIiz1dd
X-Gm-Gg: AYBFou3QqqV1zM7qGUaoKexdoBSA83PSIuHY9t7woRN0/uDnYGGuY+O6ieaF4x53V2J
	5yhETsiOz0yf/ZOYRGeakcZz/YeiB2+yPQ0lTlmybMQrC+W4CtR8ny7nlC4kU/gN1mWVjEraIeN
	MKP7eU7t8p565LbHpelW1f5iQnA0kSzc7qJG2TcNC3inwpRHrALObZr7mEGT+YpEkMpHJXMXDtz
	UBPd6ai3+3CHMoY+fU/KF1srBO41CRmui8rIQN9hwyJA7hfnBbd04y8t3Xa8+cTyJOJGRq+pPmJ
	Kh7kg0V3w48DGlvTXktzu8FhkF36hUHjCwii/JGrb3CV4TG3Kfh4QqYytVJi+f7H99u0+kCf6D9
	TdiezN05k5LbIazbJvGWWLMfKrSd9GobEnryMBLB4idFUoqNzCOhDIhCQXX5TATvCSp8Sx5Fgqb
	VuzhE3bhkol1hjeJeRQMjkYhIHV1MjEuiNODDUWId/rcmYBWMQfKVUAS3yRj+L0fcplbSZhBucB
	T4P7FgIJCQCpDgP
X-Received: by 2002:a17:90b:1fcd:b0:39f:d323:c988 with SMTP id 98e67ed59e1d1-3a073241ff2mr1206949a91.48.1790080645673;
        Tue, 22 Sep 2026 05:37:25 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612ccd46sm6453922eec.18.2026.09.22.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:37:25 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au
Cc: andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	andrew@lunn.ch,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Tue, 22 Sep 2026 18:04:59 +0530
Message-ID: <017f5ab1176b12a9d56cbc060f3ccc1d6ce8332e.1790079398.git.prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
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

Add the compatible string for the ASRock Rack B650D4U BMC,
which is an AST2600-based server motherboard.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9ba195b8f22d..4c9e96801c1a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asrock,b650d4u-bmc
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
-- 
2.47.3


