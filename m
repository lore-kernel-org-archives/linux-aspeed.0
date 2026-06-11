Return-Path: <linux-aspeed+bounces-4237-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9989FCD98C7
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbcDj0K0qz3bpP;
	Thu, 11 Jun 2026 19:05:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781168725;
	cv=none; b=W2jDGhxfzJrhjPnnauHQXRMU6tFxRXoFLQkLX+DqfklDOzVUhnqzQU3MZF2EeqcjXV9i9LwKt/0kMn7Foa5EO0EsSDnDhWmytnl5J+TNCh0Xr49oAuLywJUwUA9Ddk8Rde99Dyg9vyhgnyhGTX85O5sxLHyQUof8mr4WKwXZ9v0FxWcol5BrSHFUrAo+L0HZtoasxbCEUNbCfGEMj4WLWwXYHNAaxXUCDUJwEFwNbNbeaO9HlB/XL67VS9HpGtCjPRE5WgLFivznjqSDmBkcwX7rVlsyNWi5+x+xlkoPUeAjc5Q8ey/iP/jmBJ/eiMszxxylo9G+FTee922pl1nsww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781168725; c=relaxed/relaxed;
	bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6i4h6tjNdg7uNvfx0BOUOJ7vaGyLkYdv4res0SKibOL73Axkb5hBHFXfMawKYy0szIu5xVN/wYvly5tTH5E1bmieL9PLeXehkpcJuVj3vcUdcH12LjgDTWD8UXdhLIdbtxtXkmJu25kJ1ftkB4nHBXLNC89v6QUKJNvFK6RLHx3fO05rm6JJ3n/YK3r3WVZKB/U4qxNNT0o9Ie5jyDgt71IjnWKtJtGvv0wpf9dCGJA/PYQy1x8BGuWZco7VhGeNwX9XgYzuDzE3aYjRQl+C8Yx3GHCfjhZ7qsLzJF0/kGuKEGxqsxYw6/9PsFclAs+leGl2tOg+61w0Do2bKfRHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kfZi2q1k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kfZi2q1k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbcDh2GXnz2xl6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 19:05:24 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-84231305a80so4333552b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168722; x=1781773522; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=kfZi2q1kmxoNWf/PsR6yAtP7WXeUGHpp1On/EcvtguXEdiW0T6UocETdGXMjc+7h0Q
         Ka4ehyvZlRcajtV5SBC8e0qNDzGZNH75foMCHaU7/mWsb1bd8vPz1FqPqnTSNbnjujHu
         THJW3xJ8v2VUjST7wuAC4ywCm5ZdVwb/MxdnIyaO3Ua6qsr3u1+gfkhpLXfCYYgLN0tX
         EChCeOdAO00h8/F9r0IhygRdamime0JKxW/Bm2/boJkkfwlhiPISxpRvclViHsjgkDQ9
         0YiRxM76pjhFY1WNP8QvFvQavzdCPi2VDrGQn+IAuiM2tw6aU7nEKgd3km9ZjaiTRkIR
         sJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168722; x=1781773522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=OYoJ9pXmgq/ALtrVhrxppDyf7WQE0q9ExXFRoQy+uz70A3wV52siK1lLZrsEZRdoY6
         bvR52uUz/c/O6C6IM8Lqz1srUpdt8hUmLk3HAwv6/khIJYiAUaJpWPft4w4pbY+Vb+db
         O68AEmiq2HqbWbtkzUxmNOnFi7+Atk4zuowVcNqmnf0NHmGmbyM0JgkPMRKfPYSKuJqG
         W98mnPbjnU1IQwifLhNi6seshZlRCvEwTti2AGsMNu7PbkHcWWuxvg+JvzEKjJjHHpT2
         HdzMXTAk8LzEpFunEMg03J5/CEWfNwUJfm6cPV8EKT+lrEEtuKNfNCux2Pifwq6+uNgg
         cSqA==
X-Forwarded-Encrypted: i=1; AFNElJ8GiMa+R0Pr1cbQEp+2dhMV2iLXoaIpJkaxqMY9ficphXJq3p5AmgVKkS9gotRTOxm/UskAWl2XBdRijdk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdCy29BKZcemTRsiANx+nXgsAtd5NpKWdqKAzrMi/oBOqr6JGw
	dJPQvh/2HaVne8p07+LNc0Cul9QDkyarB6xvTmUemdXMwoh+dfKLbPtfoLYOKA==
X-Gm-Gg: Acq92OFfthqly4tljGaYHotQeDrvrT1M7DCuluKw+R0qMWdZqkv907fOJDarVwTMIKV
	+183Xql1oOI8BPhU2jSyodS29E2g98j3CCVb7Rp5Bc3w3wXZ7Q04K+lO/8QthcgOsJrGee3EnWC
	tofsrIWfREY0R4kICAjyt4hRD9Bm+hw0eZRpEFcn25dvNacNB6koVx2hlGePHmg8pnL3sbhav0Z
	3BNjwi3iTamYZBsrG0RWtBRc8eYLPQ9mLOg2okTX5NuD8wOSDxx/vKIm79qGmLvD2y+Bpv5Y5bN
	y4ktHwzQ262o50RKkl4kUPBPU/GLlPV3VGIFFFf1SpY3nG+Vc40e/JyApAI/aZp8sK47/PeW9F6
	LbLaLJ98gmHeU6KpmmNHhfMGbgjtEEWhIBew4bCB5C/PhfQa1YVIOx+1UfuXs96aoCYRdmS3oem
	i6b/d3BpS9D4DhjyFyMPETvklA+yJ18FzxPZ5O4aO3ZgMIs+5MlvFfn+RGbTSIZKvVzoYG1UfBI
	Q==
X-Received: by 2002:a05:6a00:84e:b0:842:54e8:bdd with SMTP id d2e1a72fcca58-84336bda738mr2313252b3a.40.1781168722062;
        Thu, 11 Jun 2026 02:05:22 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337b8f8f5sm1456306b3a.5.2026.06.11.02.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:05:21 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Thu, 11 Jun 2026 17:06:53 +0800
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260611-ventura2_initial_dts-v7-1-a61d8902bc5f@gmail.com>
References: <20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com>
In-Reply-To: <20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=J3z5h5jN99f1BFk7jnvt5xoq1tLRgjc3X0kRzaksvsA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqKnqyMNDpdkWIqPHwR0dlpgB0K+02uT58R/Zlv
 hr8jCJ7+g+JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaip6sgAKCRClg0K3CVbE
 gTJTB/9N8Hh3uD2G5CWGKkfbVcJSGlj9ZoSzF0Glya/xrOJJFPVtC/ajfoCSwTVy1rhaYUG8jBL
 t/E1VKn5kHNWYTo1MHmgJU5QtoL2Bcc4qXVqIgqN0TLVBBmipTi7KsWH2LEZuJyjKsyw+i8UIia
 vJxfeXnNdPDZ/VPmgBBf7TjWgdDtAN5+04rc2SXuZiiPva+Zie5z79VWAXANblXvXaSZcRwghI/
 8JR/rKkBskqPb5CoijJNRpo+WKR/9uiBpdFyBZFNHVmrcc8R777orB33SUakJlNh/pWCWFW+D25
 lbYo4Is+5fnkYKLwGRnmPOA1mW0xdBjphl9CkVqnkNbDkimV
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..d48607c86e8e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


