Return-Path: <linux-aspeed+bounces-3740-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19DFD58B00
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffXsY3rfRz2xd6;
	Mon, 23 Mar 2026 23:43:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774269825;
	cv=none; b=cj1Ye05s4piKGwld1UaEHVimnljgQQMAKQo9ChDaR/B0lNtHXm8t2NCSGFAkvJa8DwOO0iBg7v8NipNRboalRNpnyE4cPrnYAxYLvTa2Jsp+bf6i+OZeIwAJnAqLAWkdzVny+jJCOEEakbetuu3yBACQaSqi4tLFKhUlLUMFp4HfseN/DAeYCe9uv45bwyA6nkzaaEXh7wVeSeNebJoLIBdSKJ117TeeM6pkeBa35202hRY1r8k/bqVKWdrmxV218o6O0Snt5U1sN8x7lwvBxtz3Ew6xKLSRtCa+Dto2zEufu6AQhbgWlwYAm018U99ENlTMSP7xPt30lsS8artDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774269825; c=relaxed/relaxed;
	bh=CAxjuWc6K1jt8cRne9eiJroow903OnF7+g9JiBxwTFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hG4JlDvJh08X6b0rY8LQkCE0LsB8CUiqLR6XslS70DYpcM2AlGM1V4SpGsJPDaH8TSNKRfQMc8CnwqgpF7Sb0J4tKrPglepnuO/Z2kU046f+24i21giHub9MCO/8uzfRzD+15ccREI+a6ysmQQeVLZ+DLcLCiKhipxlFeBwGoZo+zY/Wqp3n/E4CdJmCu5MS6lGVE3e+hST4ZqxwP4IZCgpteKcGXT+f/0KwYriZhhZnzISbV32IkoXinAC7iGFQWgdZz1lF+u17D0Mqw24dM9uWO8HNjhCCclGFo3ha3qvCj1uWCJImUNr75Rb+9a68Fbd3JpdUvBAJQXkDY8UE1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CVuH/pO8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CVuH/pO8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffXsW5Dqmz2xLt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 23:43:43 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2addb31945aso30224005ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269821; x=1774874621; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAxjuWc6K1jt8cRne9eiJroow903OnF7+g9JiBxwTFk=;
        b=CVuH/pO8gvUTh2HadZQXADcEvQLfOLs4RU7IgUQKgFLpuO1Dt+oHkNlC2aBa5NfJjR
         tym/bJwWUQrJyZb0TrYbEjnpBWOS88nzrhtUk1H8mR13f+QUlxLXlDQwvSKzXgNucCOR
         +yNjgSU9vWHVOCsBmSBsdrTjmT+YL8zp2w70CCRPibERDusxZYuDCZEEu/vHr4ydGM/S
         IPcXetmZfe6s4vCtrw801gk0WUthz/u3d//wQEVogMGaVHbSH6yNwH9Wtl9JWw3jgm+A
         rz9CXgcpGnnZ1udIAoqIWlpHXEA12YaheRIijMo0Xk+0k05L8DSMSgCULl0wN/uMEQ2/
         Z8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269821; x=1774874621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CAxjuWc6K1jt8cRne9eiJroow903OnF7+g9JiBxwTFk=;
        b=LrU4v/f0MVvT/0JxQg7h+WKFTHUSWux7Z2Oq5NYDIcxml3GD2aJyX7giM6MR598enN
         PIEsCS9UMhE7pb3RZNMPJYoiLBiyXiIiLhRqJNcSHtdLzf/uftpbkD5x80KZz3DQX/2I
         TTqs612rvChtD6sXWdOe70Co+D1jgF3Dv48PUBVxDYCVzEitDxoq1/4XQlKp4WLnmKlF
         TjE1Bws3JftGjGjAAixToUnzwwja/xuOB05ZaY/feyyOkSzlfwOr/VgzSOwyl8IXyiA/
         +ELEUnGR4KbPeQ1LHC5T+6bA41+c55QMC5ukwcla2G8y14X6nBpZ6aKfNhSbHWgHKJ2l
         j/JA==
X-Forwarded-Encrypted: i=1; AJvYcCWF3UdbbGnLF5ibEBkGCmXJx+oHIOwqgUOBD/W1SCSR3MYm1LLgwVM2oqETR7IfBuftiMKEdBuUGVX/MwY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyhPA/Y0IA2+KKlcuc8QQL6Tr/8Xp1eLU9ymRiYCe5h5ihnEnf+
	I03u4b7gFhDHZ4EVg2oQ0bJlSvPS4CLGf83hobZXv8CagtCL05s5AA5l
X-Gm-Gg: ATEYQzwzx6J0YcamnAJoMNU7cn0Sc5ndCKPq6fXBpTDqhLqqmylZzqmlIUJ4ohqOsdR
	F1uTMc3kXq2FKkG20+sPDhs3kTn7SO+trUceJa2qGcsE3FjB5Pq6NTvdeZQjWA+GRP8yIvD47Nb
	wweSvIMKGcNYEUJn3owY7Zg4FBIQ428xBhS1/pVt4x6ga2rvbgykjZ/6Nh4/xyxt6GgABBEWsvV
	PpUDe5z9oWOH/sYrR64nXBmMx796aOna/C3S505fSx3S+FdtXG2d1xuyySG9X5gY/FM2wrwjxXS
	OjcDJUbEVDeriy3DPNOq36SuGzNiMv2JWswNE5UToS5aZewOShbvnrJhqAxaCCS35LxPFjsO3BY
	Bxrdxi+iAC8DQmXhK4zt1zA+6C234comOF2tXSeZz8UF3KWf9PRDEMfS9P3hB8tPIdU8m4Q6C97
	NX7Y6mfLW87yjpbJF6AdmRu2BiH3usbB8aB+Yx3i8HU2+RNi6+uFQwfZKw1+27Mpt2EGfu1rauM
	Mw=
X-Received: by 2002:a17:903:244f:b0:2b0:5453:1932 with SMTP id d9443c01a7336-2b0826f785cmr120175515ad.15.1774269821033;
        Mon, 23 Mar 2026 05:43:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ae1sm103668865ad.13.2026.03.23.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:43:40 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 23 Mar 2026 20:41:05 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta SanMiguel BMC
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
Message-Id: <20260323-sanmiguel_init_dts-v4-1-caaa48a7f7be@gmail.com>
References: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
In-Reply-To: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774269813; l=894;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=505A4j1K+3BVyfKFAUJFkb0POt+oWwmpy0RpscQYCVE=;
 b=/AEWcZkBMzMiJuEserz1UgyQ19R7bFmaQav+QptLCQ+XjFP3LFQsldiRbTTS6VLyoBuW+nhVk
 S2JcNJpv5lMA2+UH9ffIMhFTXP8McxfWZVo3RztSa03TuXxovztBu58
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Meta (Facebook) SanMiguel BMC board compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..6c84e6c80978 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,sanmiguel-bmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc

-- 
2.31.1


