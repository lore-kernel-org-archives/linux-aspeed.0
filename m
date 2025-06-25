Return-Path: <linux-aspeed+bounces-1578-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE869C7EE2A
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Jun 2025 01:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSLkG3bsWz2yYJ;
	Thu, 26 Jun 2025 11:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750837139;
	cv=none; b=NodLxOLaJpyAUahRQ99VyVRGiFMeA2TpQUBfYRPHvg8Rre4MiT7x4Gb+SjNTfAAEKthBuZqfzZwc4vsgcp+0CKo3VKnDptuVExWfdqzLF7j5kkAwq09s/iy+KTwqtdQ6SE4kA6NXiTWxjL16C25JEAGMm+BujvBHaXltnaezyQr18/eyRg8NVLstmtDPxW4CRS15rjel0vxYwZlkoxw5xEt0FEhqoNsD1DaOgInQqiFazB4x4SD7HZLwuwoRvX2AEu9DwtbOPOpsB3/puGP/pqCZhFFxmeAJ73nkk9OzWkYTThhOL4TzeO2h73sVVZZm+S9a8pKcCh0QsJFMbVIKog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750837139; c=relaxed/relaxed;
	bh=f2k6QLhMs+Ybe7hFRFwIVvK0vEsmpmU+VkYws59KtZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU1g7RHvdskUqKC2ANj/TXEQ4fLkOYSAHXN42rbtHLKec9pz+IoD/uwxK6g53USSLC3BzEC8riHJWbXPciH50KGRRF0gjPHAJ8exJFD+UG27YkOM1N3yZa+RaANfcpFE/RFTYBmTnROHaMqh70lAK+Ryhbt5w9WQlYZQT6GXIHtr6YA/eCD1EFPVD7YiNCWPbNiKHs9owaFoxQpq/4d/BaTlU983RrprGJ8ldnScl4XzmPULws9SON2nTOmdT63rrQCsBUe4+reNpF/qv0yZ9sUqIOXwrQOfiIX7QEdMJgb+0Oz+IVCWOihh40jPs6RMlvp+2T/OkU16qoaH0dRb/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CNoBWqWl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CNoBWqWl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRtwy2Pbgz307q
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 17:38:58 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-234f17910d8so13812895ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750837136; x=1751441936; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2k6QLhMs+Ybe7hFRFwIVvK0vEsmpmU+VkYws59KtZA=;
        b=CNoBWqWlrFdkbyqg9ILGM/GwAPZC+meWd7hnkmJqil67B6gWZfQQhwCfFLfPZkUjrd
         9mX89x/sobs7DkR4dO+fEOlQD4H06ehCNr5y+iohVdezKGCDeh0nL4xrdWoYDljbZbZ6
         RLI+MjE5R7Y+gvOZZSxXG+sUnXScG4G0S4DAJjj4CzhDb0T8jGkJkZxGjGiPdVjE0Fkk
         NPh8XmR+p+6E0waDUo04C9+viJvd0yYPwRd2UtBk4dEMgXZBho7oJdDbKBxlT6AS7fdt
         cgHdp737x2v2J24i8Bax0tqir72RqduOHsrdSzGfwlUhAiNsgWNYsQPVQjK0Az7q0ueF
         1o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750837136; x=1751441936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2k6QLhMs+Ybe7hFRFwIVvK0vEsmpmU+VkYws59KtZA=;
        b=iPefaPNNbrjj5PBHxK1OV5b4hMlkh9YfUDmra6jGtRsXTfM7WklxROSbDSvBiTHgWl
         5Pa6p6M92/5M7m3ZzjCDIFGlhAyTcoM3/b5R4LdbtdfBZ2kxiRzr/UrZ5jFGmp5xqZA3
         VylWT7mtxeGoRhsnCuvbQF1+51Vo54UGsrVgq8fMp480F9Gfsbgb67xyxosXoJ7tvxLH
         BWOh1rfIdpjmaZb1ICS4IpQzHFXmDdH3ttfbfnPCb5QjauJZalFbTE7bfE3xyRCWWx8O
         ltl/p8ItZPc5A2CWSbPQAlekIOE1mbHo9XlQsECc64udzREPGOid7IA/2gK+ctPks/iJ
         R3mA==
X-Forwarded-Encrypted: i=1; AJvYcCWQdF5Vn8RcsUbXrznEVv5ZsFkEg4z7sYDnEYT3YsDE8+IwWao5czNct2S4B984qdK6esTdjch2mrP+304=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwtgVAvO9oHund5WmlJjBbYn/k4v1lGTIZbCyqfcKj6uKRvJHlv
	vRqoHesZmq3oqvRgsJsyLo2DlUwmPCQDTKcV/VWulEB63lZ1KBmJ9SFg
X-Gm-Gg: ASbGnctiUbEeyNAL4XqgidnPtNLPhLVjHDgBkBsycmQX0Mg2CHNDmDLNLMX60jaijkR
	mL2YMYX20ohS4Gztp4Y7wlQ/Tgd1prLxKrFeFp+JiPkOE1secXg6IdDfXXq2sAWpiPhrGonCMFv
	0Fn55dWBOdRVKsfZHF/3V9W8juD/xDSznnJpaGPJsGPhLW6iKkZWO/e76E5IGranPKPUyOw+2qG
	EugtdPHv997KJTqShUfGAQ72ehmGKxN3aah+1nW1gABlSGjghwCHqf3n8oIh/F2tLIpM9lQMZYx
	/nYksUEKU3QnS5U7J0I3mSiBRLs/L+eDDT1/frY2J7OvDvBORK+2YtEB4CkLd6Ly+xN+pkBmDXJ
	3kZTwbccJe2djHj2k9r61YjBch+EtezeRiDWxOFy3+FxpU5T6/Ug4yTE4bOopFe8tQB21ylFvXZ
	7zXbT+w45GoYFniQ==
X-Google-Smtp-Source: AGHT+IFPhsOEHB0AtL92cnu1eg5DcAJ4zv8O/1nAazjCboc//yT2Vhmq+mZ1KELkj888CHOfjGO1KA==
X-Received: by 2002:a17:903:2308:b0:237:d734:5642 with SMTP id d9443c01a7336-2382436220bmr37350915ad.41.1750837136289;
        Wed, 25 Jun 2025 00:38:56 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e389-b6b2-29b2-bfd3-aa15-d345.emome-ip6.hinet.net. [2001:b400:e389:b6b2:29b2:bfd3:aa15:d345])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86a3083sm125374285ad.195.2025.06.25.00.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:38:55 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta Santabarbara board
Date: Wed, 25 Jun 2025 15:38:37 +0800
Message-ID: <20250625073847.4054971-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
References: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
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

Document the new compatibles used on Facebook Santabarbara.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a965f1a03051 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -87,6 +87,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.49.0


