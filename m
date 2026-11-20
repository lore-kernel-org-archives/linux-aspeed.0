Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642860A2607
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1kaFqi9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWN6b2sXDz2xwN;
	Sat, 21 Nov 2026 04:45:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795196759;
	cv=none; b=eX97OqmzYrfaRchdEatSwS+ait3N5ip53ACMAZe7gYMrVP7E7vs3/li3EOMCesL1n/DBIOC+bFkgB+aCZvzXs9D1A3P1iGrjNNof0dQGZwL0YXnupuoQ0+wR5iCpJ9tKeB1a6Rh27VjHeOgQ8GKa2Rvfk1egjW3NJpS9OBqBvg7aHKEu8xijFTRnkVrBy1JRLepahC/94zWdEvznMuJk7Y2QiPHjCXiMSLrzErUnuIGkvYQ0op8ySf9LpidRMgByLaAcAqDPrReRBFEzHttSeg/lXqvCcIbGR4CCKla7XbipUIvk9G/dKg3BLVrpX4wlU58QqN3DKbne6eh6Rf6E0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795196759; c=relaxed/relaxed;
	bh=jv3MzpXevrt0l8qTf3owJxVOyRgS/1wt1ixwNzlgoyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3FndQnjERsNYMBXHOpL/lNT1KIqtBbSof5uUYavFdQlW80WuTBxocz8rNWULb2SuEXBvCQ1B4NH3lu4IGt58cBmjkRL/L1utfjZYgyrfrKbfhegsQMRsu1ZKiIuXJQpCGVrhkSW8YrEET2p66kMfCWncV/fGE6oZ8TxnReTYYKbeoL4aDl9UXRY+WXdAPBzscBz0hPVH1CH/VCFVkF7/hKv4JdfEpECMwATCAQqwPVE0ulGelz3GGeAWPae5+OjwQCBzQg0FxEmmpRSM9g5KtgaVK/Rwj5VtHfwzoY8kqChwDY9vDjb+BOPDFxnAYuz1umYe6TCd76LA3hS3WmAHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1kaFqi9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1kaFqi9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWN6Z4f6fz2xpt
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 04:45:58 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3b402824d07so872519a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 09:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795196757; x=1795801557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jv3MzpXevrt0l8qTf3owJxVOyRgS/1wt1ixwNzlgoyg=;
        b=q1kaFqi9MJCrNJ36ePnmxPMtaBfZ/lbK0Wj7LMMtVxsG4BUZCI9Jdknxf9ek+64joS
         fUhmdDkyowWdUt94vJJW1HkYCqH/VT2PCkG672po4JexBF88GeJlcokm5lUdjxkI7tU0
         BxuJXDfTrfrtgeeaRjKjmDKd0NE5qmGzUVAvjK2Z+41kTHhwk+jJLvVAPNNkVDNIB84D
         FNaxtQ/hz6DS5DOa/vO71Kj6Ey7erS5ZBYc3sjXYYExi4bgQLJw4LqWJsyPYK2xm4LoZ
         ioDsHS9wFidMdEgo1VF5ivho62M+/Pyzqe581nUfZEOxYZoNOH4vhaftVwdUAeOPzzBo
         CJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196757; x=1795801557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jv3MzpXevrt0l8qTf3owJxVOyRgS/1wt1ixwNzlgoyg=;
        b=qjKpI3Erarw/aVvjDgP/O27Bft7bg2uiSGus1PsUW3Cumsj8lB7hDg8h0ibUtxoke3
         Vg3rjYj2hgQXBVPDS3cZD4qN5iHmRwLkZ37TwaHa/8vyW6yojxqlA4Yr4YsCf34orzwd
         4w8l3C1wvk/xbEuy/xBqU5iZwPSMhWiNpJDAIDTwXonlGLyjbN0qHTzfc94NqV6Z6nDD
         GmvHDA/HSHCwzl4bOyakruLzY+0Yj2Pn9ChlZ8uLuoR/YZvDYoTD9E7Y1yC3gxAYXfJ9
         ocuTldLiLRd6Nwc6dGKmGfdxjXHyE2lTZMI05Sb3TQss7HuM3+6TPYcHwY85+KrrSN0W
         Gedg==
X-Forwarded-Encrypted: i=1; AL+hErEjEgTK/ON7x8NwsUT0N8fXsZ8Jprx+vLkFfXa9ueJ4ybWCbhUlNVfnDHJ8ZZApH+kcLJ0ZoH8rNlzbnPw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9zWaMLmCL/NJjirNVbGnyCzoOH0u4qa7dJuGunV2YhQDvQ/nz2
	0WUPuYA4b95kH7JITnNZhekIWUivmN8obzRj9w/MoLFNXFO1yBzJsXEb
X-Gm-Gg: AZFdTZfHb7WVz7Yt9CPDTCGwF+LnJ+wwkbX49NKlmRgwteUamsemYpV2hixDUY0i31o
	2xEabv3RCt22MozYQMgjTY2D+ximn/XvnL+wM4Hc15M76AXBVjtmxzLFYBApr5IuVo9aPOF+38F
	4S0TjDDbk+90+8DmhkZP/Ls5aP317y4FbDIWZh4hEI++xAGg2ZEEHQ/1xpd/HSSZqlkYffDeH9O
	qKJ9fKr0/jiErPF0BuaEskzJWgmW+W4DuxWEApKQxU+1obYEA9eGGPMmXFUtrM8W99qidH8BXnk
	opRd9twmRXZtpDSrLe76Lbn+e4hpHSfRgsBaOAIyuS7F8USUxNtUMx4yvmjNh/IYMdpIC+DldBt
	rJilShbaiNSEBL8gPFPzUqBxuoQDvOwQl/U9hAQJIXMneiyXDYMhGIKNGPNUENg5u7/5ieZajgJ
	7xPt0tCvEoB4f4i3gk05nxsfnwY3Io1jzaQlWYZkQldILodc1vZIcxWoMywkFWHiZfrtCqZWx9g
	2Q/SrNhIqJ8vgEDlPX8z8uPG16+P1oJY0gsMVyiarSRU4Vfl9r4jtT+q+FngECf6m5d0t2p+iDn
	LlVevTs0E4w2VPuCKPsUYoFBpk0lYo6UQgkRTLjaIuv7UQ==
X-Received: by 2002:a17:90b:3d4d:b0:3b0:9162:948e with SMTP id 98e67ed59e1d1-3b41c905a3dmr3378438a91.27.1795196756648;
        Fri, 20 Nov 2026 09:45:56 -0800 (PST)
Received: from debian.prasanth ([103.177.82.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b703530sm58052a91.1.2026.11.20.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:45:56 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	neal_liu@aspeedtech.com,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
Date: Fri, 20 Nov 2026 23:14:39 +0530
Message-ID: <20261120174440.123487-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120174440.123487-1-prasanth.padarthi10@gmail.com>
References: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
 <20261120174440.123487-1-prasanth.padarthi10@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST2600 secure boot controller also provides access to its OTP data
region. Reference the NVMEM provider schema and use unevaluatedProperties
so common NVMEM properties are accepted while unknown properties remain
rejected. Describe the cell offset address space and extend the example
with the read-only property.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>


---
diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
index b8c5cacb0..d8e19c224 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
@@ -13,7 +13,12 @@ maintainers:
 
 description: |
   The ASPEED SoCs have a register bank for interacting with the secure boot
-  controller.
+  controller. The controller also provides access to the OTP data region
+  through NVMEM. NVMEM cell offsets are byte offsets within the OTP data
+  region, not offsets within the controller register bank.
+
+allOf:
+  - $ref: /schemas/nvmem/nvmem.yaml#
 
 properties:
   compatible:
@@ -27,11 +32,12 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
     sbc: secure-boot-controller@1e6f2000 {
             compatible = "aspeed,ast2600-sbc";
             reg = <0x1e6f2000 0x1000>;
+            read-only;
     };

