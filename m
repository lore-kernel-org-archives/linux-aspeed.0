Return-Path: <linux-aspeed+bounces-1649-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBBC83F05
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5P0FxSz2yRn;
	Sun,  6 Jul 2025 14:24:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775865;
	cv=none; b=QqOQdudJEXYMRVciqacj57G/Vu+CIBkZI4XpVV0HQUAtMOO2eVkEuF23EQTXFYaGJydm/jtWinfXXBnD77U3KHm6Ph5uMFu1cRPIqvzMJeYKpxt121BLlaCQbYa0B9OqCKjMejEgRXpoiSQqNG61X5HlAzVE5C280DlKKbkrtmFHAhHO1zWRAuukR29pbaJOOLWcusrKNx3f1vRbf5eNeoHgbVVHe9+r5+/YhYgkcXDTVcJjhVNs9hgJhaVEttdbWyulO7OgoGjaMLCKCUsrGd8Z5Y66SlicXbY1VZVmAd897mUP/PpzpCd6Sy1zpZ75YVGVtE21FyvPU4ARV6c9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775865; c=relaxed/relaxed;
	bh=a+TNVR+2IFzAtjBiWC0iEjjaf81G6DZHJX+L9O53iPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDrmUneGpn6KIFyrxMacSk5SNm+Zm5uU9nyJKJFboJQZDispMUMCJqLFqhKHl+7GKat49Mb+idQotP1gZK1NAj8xIPnUSZIF91ZZt2iZYenG/TSb9x5ixGPU0FFgh1HOzJirL8S4rbFKD4eCMQFgAZoYVCd24LXLJn2JSWZL+oWSMltfhLKtgxoWYF1KO49DHAFiDnz73eI0aP6vNFA5uILPTGsRaFXERiDcT1/Y09+9+e7yoKCK73ojmp+WxNrMMkpcn3dBDQzHKWg9GUz4RvJ52wlO6Srlx/5pzKxXaCDUmhdWRR4aujdLMn1WJGmXQe/oXQYvHtnmgKuVX2qlkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N6DxSawc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N6DxSawc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5N2Pdkz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:24 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1834627b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775862; x=1752380662; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+TNVR+2IFzAtjBiWC0iEjjaf81G6DZHJX+L9O53iPU=;
        b=N6DxSawcPqD4wd8zLISspzViwbxH9xn9XEPhStpq3RCFYGSGMOCJkkWGxGy2cLWh5E
         TsM69jKoanYrlc4URfjW4uxhJx3qgjq7fdHa4ed5hwsVwcegObtYcE5TJ0YeiMcrWLJ3
         XfizPgTU1swJ7nhS01+Rdxlbl9f6PDMuGIBfgg55igDC/sTjAiGImEwwSiHpPMOdSiwT
         b6v7eL+CbxRiLX83aWEv3WFYTjtnlGFsWqBSnmEgu4BJpuuaVTBFwG6UcLvD2/sekUBv
         O3GkbtECs3rjDGzRH/A/RqBYn1bJrAdm6PhNHOMjMGTZNtZON+3lEjJuQV1Ot+3NJy2Y
         Miag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775862; x=1752380662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+TNVR+2IFzAtjBiWC0iEjjaf81G6DZHJX+L9O53iPU=;
        b=OQSIlUk/7sPj15zEpZuG6JIOGqBfqx+PgoGUfhhpXAOzX2PgyuAkvrwiI/gAMK0uiC
         JkqyKE8yLuULjFUKE5GaIPh+tVyZdHuqF5AXBv5QXMWr6So3RDUChFlaEOha6L+jyeE4
         3SIxjD0IfOcP6GXwFTqOVjDoaqR+n4g7s8dVtz+QgKUh2N3dFIhVoZ0tlNY+LEQKGLTC
         60uADNrI1Kuu8BSvyMrFsDRzWjyiglpuFseY8+gC3fDEI+DLp1sfO4AMLYYsZSoS5x0q
         tSgzfqRuPghRngnsh2XeKo+EA1tUgPJiGqFWTNA+yINAlixZxpiVRLSmKrSkIUA/W3yR
         ENWA==
X-Forwarded-Encrypted: i=1; AJvYcCXepV8GbbXCS8nEmZzLtVL2SMKLWiUBtPJtORnXHWturrHcLbF3GpyJ2RRWVzLhvjjiLfAhq3Xhj8n0G9U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YztjJAgWVbj0VHPqvhMywaB5SQWNtpXz19yDHfhf9hiSCQSjb+J
	08FxVlJdRYi4KwpGSNB+lHJq+mSHQ3NxapuG1OTTRebLNw5/f/bQiWCv
X-Gm-Gg: ASbGncvWt56e/f04+HcaiM0nhVgAbB2XRyifv4Neez3aVfKgGsr6jQqBJHWAOjNlTi9
	GmELRItr85L3+6jhlfPJJyZVmJZtoBMgPrGw3Vutq+mR4o/np3sOHMpfdVJ1KVSNkfb93OvPz8w
	6/VVqgjfvHsJKA/n1x0rvi/snhmvgsIgNqZNjgFCZ54NqKZgImc/aXRBiUcPIgJkQVWxECwiUhx
	nvu7hxHMQ6euUVwvSR8a5tvjWP1zhYa3z5DPs4af3SnHfghH4bAXPhOzlg0MOymb6u4uGL4+VA0
	kLHNmOaS4qPDpwTg9P8zIXITTm2cnczSaBEjdM/sUxc3rlLes0s/vDos6WEwQhmNBMmBELaCLqi
	k7B/sTaU+ci2WBwLSZS/SzN8WdtGaBk5RFla6VMY=
X-Google-Smtp-Source: AGHT+IFzXt71OuScjjUFMjwAfrt7v/tObafbS0wRGH2aMUUWpXXz1uiF0tdrfgd10hdbuTwWyxGqEA==
X-Received: by 2002:a05:6a00:6ca1:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-74cefaf0042mr7755377b3a.5.1751775862296;
        Sat, 05 Jul 2025 21:24:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:21 -0700 (PDT)
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
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 8/9] dt-bindings: arm: aspeed: add Facebook Darwin board
Date: Sat,  5 Jul 2025 21:23:58 -0700
Message-ID: <20250706042404.138128-9-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Darwin board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - None (the patch is introduced in v2).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..dba3d07cba84 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -82,6 +82,7 @@ properties:
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,cloudripper-bmc
+              - facebook,darwin-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
-- 
2.47.1


