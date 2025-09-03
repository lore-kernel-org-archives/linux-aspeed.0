Return-Path: <linux-aspeed+bounces-2140-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFD3CA1013
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 23:42:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHK0N4Fgdz2yrX;
	Thu,  4 Sep 2025 09:42:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756901170;
	cv=none; b=XqzNBYwQ26YDbotM7CCwwnZkcb5UIUW6fL4hASwBUV9vGy15SsTUoMyz/j0Q14q+DMEUAk3FrTMwjJ1Q4LM5g8WUCldv2BbSzDStiKaNuTW5zRzRhpyJ0Ph4N74ZCVFd/CfVIV1uADZy9qMBUB3KK5vcLC2Y5kpXjS7A7ZIi1+Ei/LZCAeuLuIQyz0D4Da3N1KIK8nH8pTMbEbn8nawexpe9643YpKGbIFyoayP3iOfPgZ8TfU310N4yDjypM1mo8span4+psI7rF427fDGZlETGBc4cHIAripKQyG4/QwAQSPKkYOQL38hXI5SlccV1qbYmICCoU3e3mW3eJe7Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756901170; c=relaxed/relaxed;
	bh=RqGQhSrmR9KNt2mlgrpLBIlQIaWDRnvltPL/Gn6wm7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgFWJjrh1RcAJhhc/jjY7gq/tiXcHLey1U+lFcjKCav3OOZlKliJ8PDw4QlzKkXaG3dS1HdfEpqBuqS4sHPuJv0kRLp32I8LBXu8SqokJmIPrrdSk33B5v1OX5FxQS22kRzZWIwMpEnS6SFABpTBORmV62FcrN3A6QGRxhMqBjs3OxXVw6//3qWSyhzWiDSvZV8Gi4YJzuL51HkRW7v59P3q6vYC4QEc8HFv0z1Ylgoi98out1J1Q8z4O9dv7SOl9nKkQaewcmN/YqKNAsJZsmx2wJDzUXiEkwHosD779FyiNZK3K0kizJxiZptSbRcEyVZfiwWMUhovbIRllxz/IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XxnZVBVt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XxnZVBVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cH1Xy0dL6z2yr4
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 22:06:09 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso4092285a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Sep 2025 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901168; x=1757505968; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqGQhSrmR9KNt2mlgrpLBIlQIaWDRnvltPL/Gn6wm7Q=;
        b=XxnZVBVt1456mYS6IEHHx43T5dZc4VGPiUJtpmPMwCrtyaZkiYYn9F5rV5ujiy1rKN
         lFUIvzB5x0Fi3lvvOhIjv0POJMGKkO/eqReWLm/C/Tl4rIcHG2GRb+Iv6bzskI+sKg+n
         r61ZEkAQuZ1Vk6LbVEJkPbCaQd5wF6BhBZAdhPxH2RuiL4xb+Tga+zRCn9dNv+44yhsg
         iOu2ymwaxoEvsJZKpqATs1DQ08gTtf6ErqzGyouxGNJVSG3dAwhp1EklgdYSlAaSi1Nk
         51s3k+s2GKD+pkg5OvE9dzJ5/pFCVZ0PCXx+BkM1m92A+GxPhSusmzjLNtmYdfRiUubE
         c69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901168; x=1757505968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqGQhSrmR9KNt2mlgrpLBIlQIaWDRnvltPL/Gn6wm7Q=;
        b=WEaC47J8OETYDNcVYcKLJvmOeE+rlGZMuVIwSMsbunzrgn6NwxqqJPhw1f/N4s1J6N
         D24lr0Tf6EcE7POS5jT6bNSpLbb5uUt89A637ooJAeTLMNFvzSYpMlbX7jWnto5w10Py
         sUSOHlzlTZdlggV7JthFJhku3PfeVKsy48prP0OPil0Z6akmCojNOcGUs3DmzCUa6gak
         N5s4ZEM64rxL2a4NIhmxTQD5k49iTxa+0S1W6oJ2JpSSlBlZhILnwvSTxgatrSm3In96
         j8bDc7YXhQx1FETa7AP6MUxPo8DJBuQRvAM6fyRWkbydpXd2uTPf/aSebreOqK3ygBAo
         AdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu4xcsbd/hQXfIDQYC71ZVk+Cktfbg1h8Uyit+c5fdUsyfHJYZgStqtAOo2yGzRreChyJJkAjEKvC99rU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxulgz1BlJbTjKvrlvk1RTVFU4D0WraqqVcPDvi3oeEG1aWT7GO
	imjMMuo1Z7hWxWJGjCexagYRDAF+6K1FgD3TqP55emzFUW6cahYw9OgT
X-Gm-Gg: ASbGnctLmR1Fv007UgQtRYq6TluOx74AUCkca1u3cm4GnuzTcKk7YkHGnnEteFIdqef
	4X84cEDhpgcmUr13igsOtMeRMlQYvdQyKB+eEcPADuFgvHzBWyOALADfXF6GdVgtQmIFSNRkWwU
	0lKXmD8Yz+jSpIo29yqwFnmklmhLbyoLA1l4TJhKHF9n4pVe3Nif5ZhwhOZUauxMwLO0DpEK7Qw
	QJfkEvq5ZPVfn4rKih7acClnsDE9doq2b7H3iFyEq7SbvvtXZYeES94/sDGm3bT1AznTOvhBjLH
	66lbTD+uJvTTby2Tu+D+lCRw4RWNbe4kjJFpuseCuLJsX5NTgIajhp5o1MNJCwwiUin5/YnMpsr
	AWLKnl0LvH6WV9ncXRDq7XteEuNwThCDtfyiuRQ2TwTeX3xrXylldx5rtzBUEBrpxbtSVgYR24f
	cTlDNlPz68fybEQCIBE8o=
X-Google-Smtp-Source: AGHT+IGRwP+2jhI7HlYV8PivgRIYsoYupEDByvIyv5rCdBLRIMTGG2RxKeItgA988VxEJG/hq8+L9g==
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr227499035ad.3.1756901167713;
        Wed, 03 Sep 2025 05:06:07 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm160905185ad.109.2025.09.03.05.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:07 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v11 1/2] dt-bindings: arm:aspeed add Meta Ventura board
Date: Wed,  3 Sep 2025 20:05:59 +0800
Message-ID: <20250903120600.632041-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903120600.632041-1-pkleequanta@gmail.com>
References: <20250903120600.632041-1-pkleequanta@gmail.com>
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

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..1eecb4b69fe6 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
-- 
2.43.0


