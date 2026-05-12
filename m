Return-Path: <linux-aspeed+bounces-4018-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46B2CD343F
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 May 2026 00:06:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFYfR2D1Fz2y8h;
	Wed, 13 May 2026 10:06:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778608237;
	cv=none; b=XmzbdmD/IsJNluyUHHiQJAwqE3M0mITK+uxZGNAefg0jiQxC4V3x7ZnYN9Zdk6BmLHi9oVrcVOhX3bf3WRL2nTtWlZLf4ubak5ukn35r90jB7tf8AfbdU+YbpVeRYJRhYVJsqyKSTS0o998Njd9as6zJ/DwmkOtwEIlfCrr34+02KEhCzyZ3q17T8T8NX/eTCkgS+Az2UinxkRpYqSQVbIwhd02OAjdtPrCJtsEiKETimQqJ68SUChCZWXZAcT0klpRkdDN04u0D/3NHAFL/tpeiFQCLptJSlT+CVlwPAb75a3IxXx/cy/k0wQHgA7OlsmaMPGkL5011z+5L3V5HIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778608237; c=relaxed/relaxed;
	bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESLLuB0CxJRiysgySKsAQPOKdZDeZByWX4uhh8NTLhXaE+kjm3i6iAe1dBFnVeCbHqvu9F/+nqnXKrVCnc/u4M/2Ou0NIZmnuBZMfALJVoq0oMVmp8O8P//GpypYZEXdehsoAXHUiP6SowX7vZZ4mOOzCGcxELNw2KFaAbJqREK6hWfRZQR5G3doQMV6Z1QmcorPGGDCVKqEBM5LAvtOaddUHaljkvkRqXZtRBscxCQfKcFhgkOJIrGojHDRMRX8gmet59heN+zHrXyZp0pPWQklbFxTGEAolddiwSCBzjAOXM3BK4Xacyrmwbr70owo6dQILyJ5kXyanZzVfJzYZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IVdTMSnz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IVdTMSnz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFPJY0Q3Zz2xb3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 03:50:36 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso2869873b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608235; x=1779213035; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
        b=IVdTMSnzwatXvr6TeGKXFuORomc3PFKIS9HwAumI8PWFJO1m4KAdDbww/WMlXGBj+w
         yoZCiMzFIT+FbB5atgHacLDAidXIH1u38pDcxd6nfr/XmNE2X8VsdM2ScdD9/DCCas4D
         Wa0ZrpGmnsRgOY2Pt47eagFpJutxjEib/on649Im1uTT5Mzpg5rAOJI5YAA2XkDgKpqQ
         H6PhaLsmana27/qssTDQJE2AV0AK0of+9WHlsrcvx146WiJaTzrTXXRfkqiPs7DBzB6G
         gUZn8sFtOUe4eue+O7qbDXcB0fb5IdtRyIS2keKBZUwYTPSQqmSM4LTB10U/XDoYktm2
         YIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608235; x=1779213035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
        b=BRSXdi+gL3EeTq9eC7zFi+GXb+8o2zt4Y+DWjwegReYmcsWPn0uV/8AGTWAqk8XBZf
         GkxPqUyzx/j3QrBO1NW5Vs7ON3UNAlMjvOhP9YRofLGs+PPqwG4zeUmRXVbyNr/WoIL9
         Eqqwm1spevnYcG1fkWeqAZbr1O8cceucl1Z7OdK1D8khKDK+PNUDrlzISwwqea1BX/Rb
         hEPmYmUtYFYDxwS6P2wHvwDAf3u06qYKz26Ov1pCK5jKhDnTAYjBvSTDM+XEiVqCwjUT
         9Oik4TOsgHWU43jdbMTzwjxGViQUmIkeGyAyRFeoWvp264gIxNGm5yy6wn+2s1GGKFvr
         ZxuA==
X-Forwarded-Encrypted: i=1; AFNElJ8TEUw2ZEuk+1oNXPNXpigajlDoXhOlQqNcD+Pnnd5kNsMH5cg5tMbZ7F10MlaEXgPKEasy5sbP3L6Q1V0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqH2rzl+B0/9k0Am9IrX+FUWojfosxZcsbbnxZK/gBHH7NbePn
	gJtEbQhyflFp77EMl9PB3DIvCywNbQ8i2XCO0vryJpoIv6mhlK8Dk9D3
X-Gm-Gg: Acq92OFw9PTEBSuZk+rzgDxj00un5yJCz7c3fFGRn0AqrbtHvCiUbUaDyLUMcsrE1eH
	8W2I37gDQS+g/PJyij5QjMldaHJlv04SzR/UvaH8t7pzpks/SJToh/qkbIHxjWVaHO9pyYTaawa
	9MbHa6fu58bQM+nU33P19eBmG5wgkoJPFHRoYjHL/sasErHe+Sv/uTu1nI3t4IveZwyGglZjUnD
	xRi2Z0CZkBpEqFPwnvjQZsr3lFwy1wNNvt+J8l0TkuyzJzmr3X8VvZhtwCcnX0ShtRN1XjXDiPp
	q+hB7Z2wyxFald0RxMiVyp9s4Ym3/o4ED5XZ4bCwjLsJB9pW2WX0jyLhTPijrxR/01tUTb/1un8
	KbzZYKv2R3WceP5Rc7cIxHgqYylZIFVDVw5pEbNBHObzyZI67smMO+1ac65Nvo+fStobmo95zf+
	NxMd6ZooFUWId6/6MMo3jwK3ox8/qYH3EloDh+P1nj
X-Received: by 2002:a05:6a00:4206:b0:81f:4e1c:1d3b with SMTP id d2e1a72fcca58-83f02e579admr34477b3a.23.1778608235020;
        Tue, 12 May 2026 10:50:35 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm24838732b3a.53.2026.05.12.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:50:34 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Tue, 12 May 2026 23:20:18 +0530
Message-ID: <20260512175019.47548-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512175019.47548-1-prasanth.padarthi10@gmail.com>
References: <20260512175019.47548-1-prasanth.padarthi10@gmail.com>
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

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab0..656397850 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -77,6 +77,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asrock,b650d4u-bmc
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
-- 
2.47.3


